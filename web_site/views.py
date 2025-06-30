from django.shortcuts import render
from .models import *
from django.db.models import Count
import random
from django.core.mail import send_mail
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt

# les fonctions de vue pour l'application web_site
def RecuperationService():
    categories = Categorie.objects.all()
    
    dict = {}
    for category in categories:
        dict[category.nom] = Service.objects.filter(id_categorie=category).order_by('ordre_affichage')

    return dict
# Create your views here.

def accueil(request):
    services = Service.objects.exclude(titre='Tous les Services').order_by('ordre_affichage')
    random_service_models = {}
    counter = 0
    for service in services:
        if counter >= 3:
            break
        models_qs = Service_Model.objects.filter(id_service=service)
        count = models_qs.count()
        if count <= 3:
            random_models = list(models_qs)
        else:
            # Récupère 3 modèles aléatoires
            ids = list(models_qs.values_list('id', flat=True))
            import random
            random_ids = random.sample(ids, 3)
            random_models = list(models_qs.filter(id__in=random_ids))
        random_service_models[service] = random_models
        counter += 1

    # Ajout du QuerySet des réalisations pour la section dynamique
    realisations = Realisation.objects.filter(visible_public=True).order_by('-date_creation')
    equipe = Equipe.objects.filter(affiche_public=True).order_by('ordre_affichage', 'nom')

    return render(
        request,
        'web_site/index.html',
        {
            'NavNosServices': RecuperationService(),
            'service_model': Service_Model.objects.all(),
            'random_service_models': random_service_models,
            'realisations': realisations,  # Passage du contexte pour la section dynamique
            'equipe': equipe,  # Passage de l'équipe pour la section dynamique
        }
    )
    
def about(request):
    service_model = Service_Model.objects.all()
    return render(request, 'web_site/about.html', {'NavNosServices': RecuperationService(), 'service_model': service_model})

def contact(request):
    return render(request, 'web_site/contact.html', {'NavNosServices': RecuperationService()})


def service(request):
    realisations = Realisation.objects.all().order_by('-date_creation')
    return render(request, 'web_site/realisations.html', {'NavNosServices': RecuperationService(), 'realisations': realisations})

def rdv(request):
    return render(request, 'web_site/rdv.html', {'NavNosServices': RecuperationService()})

def grand_format(request, id):
    print(id)
    service = Service.objects.get(id=id) # Récupération du service par son ID
    if service.titre == 'Tous les Services':
        service_model = Service_Model.objects.filter(id_service__id_categorie__nom = "GRAND FORMAT")
    else:
        service_model = Service_Model.objects.filter(id_service = service)

    print(service_model)
    return render(request, 'web_site/grand_format.html', {'NavNosServices': RecuperationService(), 'service_model': service_model})

def petit_format(request, id):
    print(id)
    service = Service.objects.get(id=id) # Récupération du service par son ID
    if service.titre == 'Tous les Services':
        service_model = Service_Model.objects.filter(id_service__id_categorie__nom = "PETIT FORMAT")
    else:
        service_model = Service_Model.objects.filter(id_service = service)

    return render(request, 'web_site/petit_format.html', {'NavNosServices': RecuperationService(), 'service_model': service_model})

def autre_format(request, id):
    print(id)
    service = Service.objects.get(id=id) # Récupération du service par son ID
    if service.titre == 'Tous les Services':
        service_model = Service_Model.objects.filter(id_service__id_categorie__nom = "GADGET ET PUB")
    else:
        service_model = Service_Model.objects.filter(id_service = service)

    return render(request, 'web_site/autre_format.html', {'NavNosServices': RecuperationService(), 'service_model': service_model})


def all_service(request):
    services = Service.objects.exclude(titre='Tous les Services').order_by('ordre_affichage')
    service_models_by_service = {}
    for service in services:
        models_qs = Service_Model.objects.filter(id_service=service)
        service_models_by_service[service] = list(models_qs)

    return render(
        request,
        'web_site/all_service.html',
        {
            'NavNosServices': RecuperationService(),
            'services': services,  # <-- Ajoute cette ligne
            'service_models_by_service': service_models_by_service
        }
    )
    
def detail_service(request, id):
    service = Service.objects.get(id=id)
    models = Service_Model.objects.filter(id_service=service)
    return render(request, 'web_site/savoir_plus.html', {
        'service': service,
        'models': models,
        'NavNosServices': RecuperationService(),
    })

# Détail du modèle pour afficher le detail possible d'un modele
def detail_model(request, id):
    model = Service_Model.objects.get(id=id)
    service = model.id_service
    similaires = Service_Model.objects.filter(id_service=service).exclude(id=id)[:8]  # 8 produits max
    return render(request, 'web_site/detail_article.html', {
        'model': model,
        'service': service,
        'similaires': similaires,
        'NavNosServices': RecuperationService(),
    })


@csrf_exempt  # Pour AJAX, à sécuriser si besoin
def contact_ajax(request):
    if request.method == 'POST':
        nom = request.POST.get('lastname', '').strip()
        prenom = request.POST.get('firstname', '').strip()
        email = request.POST.get('email', '').strip()
        tel = request.POST.get('phone', '').strip()
        sujet = request.POST.get('subject', '').strip()
        message = request.POST.get('message', '').strip()
        honeypot = request.POST.get('honeypot', '')
        if honeypot:
            return JsonResponse({'success': False, 'error': 'Spam détecté.'})
        if not (nom and prenom and email and sujet and message):
            missing_fields = []
            if not nom:
                missing_fields.append('nom')
            if not prenom:
                missing_fields.append('prenom')
            if not email:
                missing_fields.append('email')
            if not sujet:
                missing_fields.append('sujet')
            if not message:
                missing_fields.append('message')
            return JsonResponse({'success': False, 'error': 'Champs obligatoires manquants.', 'missing_fields': missing_fields})
        # Construction du message
        msg = f"""
Nouveau message de contact Cismat Print :

Nom : {nom}
Prénom : {prenom}
Email : {email}
Téléphone : {tel}
Sujet : {sujet}
Message :\n{message}
"""
        try:
            send_mail(
                subject=f"[Contact Cismat Print] {sujet} - {nom} {prenom}",
                message=msg,
                from_email=None,  # Utilise DEFAULT_FROM_EMAIL
                recipient_list=['cismatprint123@gmail.com', 'brahimacisse59@gmail.com'],
                fail_silently=False,
            )
            return JsonResponse({'success': True})
        except Exception as e:
            return JsonResponse({'success': False, 'error': str(e)})
    return JsonResponse({'success': False, 'error': 'Méthode non autorisée.'})

@csrf_exempt
def rdv_ajax(request):
    if request.method == 'POST':
        fullname = request.POST.get('fullname', '').strip()
        email = request.POST.get('email', '').strip()
        phone = request.POST.get('phone', '').strip()
        company = request.POST.get('company', '').strip()
        service = request.POST.get('service', '').strip()
        date = request.POST.get('date', '').strip()
        time = request.POST.get('time', '').strip()
        duration = request.POST.get('duration', '').strip()
        mode = request.POST.get('mode', '').strip()
        infos = request.POST.get('infos', '').strip()
        files_count = request.POST.get('files_count', '0')
        consent = request.POST.get('consent', '')
        honeypot = request.POST.get('honeypot', '')
        if honeypot:
            return JsonResponse({'success': False, 'error': 'Spam détecté.'})
        if not (fullname and email and phone and service and date and time and duration and mode and consent):
            return JsonResponse({'success': False, 'error': 'Champs obligatoires manquants.'})
        msg = f"""
Nouveau rendez-vous Cismat Print :

Nom : {fullname}
Email : {email}
Téléphone : {phone}
Entreprise : {company}
Type de projet : {service}
Date : {date}
Heure : {time}
Durée : {duration}
Mode : {mode}
Infos complémentaires : {infos}
Nombre de fichiers partagés : {files_count}
Consentement : {'Oui' if consent else 'Non'}
"""
        try:
            send_mail(
                subject=f"[RDV Cismat Print] {service} - {fullname}",
                message=msg,
                from_email=None,
                recipient_list=['cismatprint123@gmail.com', 'brahimacisse59@gmail.com', email],
                fail_silently=False,
            )
            return JsonResponse({'success': True})
        except Exception as e:
            return JsonResponse({'success': False, 'error': str(e)})
    return JsonResponse({'success': False, 'error': 'Méthode non autorisée.'})

@csrf_exempt
def commande_ajax(request):
    if request.method == 'POST':
        nom = request.POST.get('clientName', '').strip()
        tel = request.POST.get('clientPhone', '').strip()
        email = request.POST.get('clientEmail', '').strip()
        adresse = request.POST.get('deliveryPlace', '').strip()
        modele = request.POST.get('selectedService', '').strip()
        quantite = request.POST.get('quantity', '').strip()
        paiement = request.POST.get('paymentMethod', '').strip()
        commentaires = request.POST.get('commentaires', '').strip()
        honeypot = request.POST.get('honeypot', '')
        # Récupération des options dynamiques (tous les champs commençant par 'option_')
        options_dynamiques = []
        for key in request.POST:
            if key.startswith('option_'):
                options_dynamiques.append(f"{key}: {request.POST.get(key)}")
        if honeypot:
            return JsonResponse({'success': False, 'error': 'Spam détecté.'})
        if not (nom and tel and email and adresse and modele and quantite and paiement):
            return JsonResponse({'success': False, 'error': 'Champs obligatoires manquants.'})
        msg = f"""
Nouvelle commande Cismat Print :

Nom : {nom}
Téléphone : {tel}
Email : {email}
Adresse de livraison : {adresse}
Modèle : {modele}
Quantité : {quantite}
Moyen de paiement : {paiement}
Commentaires : {commentaires}
"""
        if options_dynamiques:
            msg += "\nOptions personnalisées :\n" + "\n".join(options_dynamiques)
        try:
            send_mail(
                subject=f"[Commande Cismat Print] {modele} - {nom}",
                message=msg,
                from_email=None,
                recipient_list=['cismatprint123@gmail.com', 'brahimacisse59@gmail.com', email],
                fail_silently=False,
            )
            return JsonResponse({'success': True})
        except Exception as e:
            return JsonResponse({'success': False, 'error': str(e)})
    return JsonResponse({'success': False, 'error': 'Méthode non autorisée.'})

def personnaliser_modele(request, id):
    model = Service_Model.objects.get(id=id)
    service = model.id_service
    return render(request, 'web_site/personnaliser_modele.html', {
        'model': model,
        'service': service,
        'NavNosServices': RecuperationService(),
    })