from django.shortcuts import render, get_object_or_404, redirect
from .models import *
from django.db.models import Count
import random
from django.core.mail import send_mail
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib import messages
from django.views.decorators.http import require_http_methods
import json
import hashlib
from decimal import Decimal

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
            'services': services, 
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


# Page detail et commande pour les modèles de service
def model_detail(request, model_id):
    """
    Vue pour afficher le détail d'un modèle avec ses options de personnalisation
    """
    model = get_object_or_404(Service_Model, id=model_id)
    service = model.id_service
    
    # Récupérer tous les détails/options pour ce modèle
    model_details = Service_ModelDetail.objects.filter(service_model=model).order_by('nom_option')
    
    # Préparer les options pour le template
    for detail in model_details:
        if detail.valeurs_possibles and isinstance(detail.valeurs_possibles, dict):
            if 'options' not in detail.valeurs_possibles:
                detail.valeurs_possibles = {'options': []}
    
    # Modèles similaires (même service)
    similar_models = Service_Model.objects.filter(
        id_service=service, 
        disponible=True
    ).exclude(id=model_id)[:4]
    
    context = {
        'model': model,
        'service': service,
        'model_details': model_details,
        'similar_models': similar_models,
        'NavNosServices': RecuperationService(), 
    }
    
    return render(request, 'web_site/model_detail.html', context)

@csrf_exempt
@require_http_methods(["POST"])
def process_model_customization(request):
    """
    Traiter la personnalisation d'un modèle, créer la commande et le commandeItem (soumission classique)
    """
    try:
        model_id = request.POST.get('model_id')
        quantity = int(request.POST.get('quantity', 1))
        special_instructions = request.POST.get('special_instructions', '')
        model = get_object_or_404(Service_Model, id=model_id)
        selected_options = {}
        total_additional_cost = Decimal('0')
        for detail in Service_ModelDetail.objects.filter(service_model=model):
            option_key = f'option_{detail.id}'
            prix_supp = Decimal(str(detail.prix_supplementaire))
            if detail.type_option == 'CHECKBOX':
                selected_values = request.POST.getlist(option_key)
                if selected_values:
                    selected_options[detail.nom_option] = selected_values
                    total_additional_cost += prix_supp * Decimal(len(selected_values))
            else:
                selected_value = request.POST.get(option_key)
                if selected_value:
                    selected_options[detail.nom_option] = selected_value
                    total_additional_cost += prix_supp
            if detail.obligatoire and not selected_options.get(detail.nom_option):
                messages.error(request, f'L\'option "{detail.nom_option}" est obligatoire.')
                return redirect('customize_service_model', model_id=model.id)
        base_price = Decimal(str(model.prix_unitaire))
        total_price = (base_price + total_additional_cost) * Decimal(quantity)
        # Récupération des infos personnelles
        nom_client = request.POST.get('nom_client', request.user.nom_complet if request.user.is_authenticated else '')
        email_client = request.POST.get('email_client', request.user.email if request.user.is_authenticated else '')
        telephone_client = request.POST.get('telephone_client', request.user.telephone if request.user.is_authenticated else '')
        adresse_livraison = request.POST.get('adresse_livraison', '')
        # Création de la commande
        commande = Commande.objects.create(
            user=request.user if request.user.is_authenticated else None,
            nom_client=nom_client,
            email_client=email_client,
            telephone_client=telephone_client,
            adresse_livraison=adresse_livraison,
            total_ht=total_price,
            total_ttc=total_price,
            notes_client=request.POST.get('custom_text', ''),
        )
        # Envoi d'un mail à l'admin
        try:
            send_mail(
                subject=f"[Nouvelle commande] {commande.nom_client}",
                message=f"Nouvelle commande créée par {commande.nom_client} (Email: {commande.email_client}, Tel: {commande.telephone_client})\n\nModèle: {model.nom}\nQuantité: {quantity}\nPrix total: {total_price} Fcfa\nOptions: {selected_options}\nInstructions: {special_instructions}",
                from_email=None,
                recipient_list=['cismatprint123@gmail.com', 'brahimacisse59@gmail.com'],
                fail_silently=True,
            )
        except Exception as e:
            pass
        commande_item = CommandeItem.objects.create(
            commande=commande,
            service=model,
            quantite=quantity,
            prix_unitaire=(base_price + total_additional_cost),
            prix_total=total_price,
            options_selectionnees=selected_options,
            instructions_speciales=special_instructions,
        )
        # Stocker l'ID du commandeItem pour rattacher un fichier plus tard si besoin
        request.session['commande_item_id'] = commande_item.id
        messages.success(request, "Votre commande a été enregistrée avec succès !")
        return redirect('order_confirmation')
    except Exception as e:
        messages.error(request, f'Erreur lors du traitement : {str(e)}')
        return redirect('customize_service_model', model_id=request.POST.get('model_id'))

def order_confirmation(request):
    """
    Page de confirmation de commande avec récapitulatif
    """
    temp_order = request.session.get('temp_order')
    
    if not temp_order:
        messages.error(request, 'Aucune commande en cours.')
        return redirect('all_service')
    
    model = get_object_or_404(Service_Model, id=temp_order['model_id'])
    
    context = {
        'temp_order': temp_order,
        'model': model,
        'NavNosServices': RecuperationService(),
    }
    
    return render(request, 'web_site/order_confirmation.html', context)

# Vues AJAX utiles

@csrf_exempt
def get_model_price(request):
    """
    API pour calculer le prix en temps réel selon les options sélectionnées
    """
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            model_id = data.get('model_id')
            selected_options = data.get('selected_options', {})
            quantity = int(data.get('quantity', 1))
            
            model = get_object_or_404(Service_Model, id=model_id)
            base_price = float(model.prix_unitaire)
            additional_cost = 0
            
            # Calculer les coûts supplémentaires
            for detail in Service_ModelDetail.objects.filter(service_model=model):
                option_key = str(detail.id)
                if option_key in selected_options:
                    if detail.type_option == 'CHECKBOX':
                        # Pour les checkboxes multiples
                        selected_count = len(selected_options[option_key]) if isinstance(selected_options[option_key], list) else 1
                        additional_cost += detail.prix_supplementaire * selected_count
                    else:
                        additional_cost += detail.prix_supplementaire
            
            total_price = (base_price + additional_cost) * quantity
            
            return JsonResponse({
                'success': True,
                'base_price': base_price,
                'additional_cost': additional_cost,
                'total_price': total_price,
                'unit_price': base_price + additional_cost
            })
            
        except Exception as e:
            return JsonResponse({
                'success': False,
                'error': str(e)
            })
    
    return JsonResponse({'success': False, 'error': 'Méthode non autorisée'})

@csrf_exempt
def check_model_availability(request, model_id):
    """
    Vérifier la disponibilité d'un modèle en temps réel
    """
    try:
        model = get_object_or_404(Service_Model, id=model_id)
        return JsonResponse({
            'available': model.disponible,
            'message': 'Disponible' if model.disponible else 'Temporairement indisponible'
        })
    except:
        return JsonResponse({
            'available': False,
            'message': 'Modèle introuvable'
        })

# Fonction utilitaire pour la recherche de modèles
def search_models(request):
    """
    Recherche de modèles par nom ou service
    """
    query = request.GET.get('q', '')
    service_id = request.GET.get('service_id')
    
    models = Service_Model.objects.filter(disponible=True)
    
    if query:
        models = models.filter(
            nom__icontains=query
        ).distinct()
    
    if service_id:
        models = models.filter(id_service_id=service_id)
    
    models = models.select_related('id_service')[:20]  # Limiter les résultats
    
    results = []
    for model in models:
        results.append({
            'id': model.id,
            'name': model.nom,
            'service': model.id_service.titre,
            'price': float(model.prix_unitaire),
            'unit': model.unite_mesure,
            'image_url': model.image.url if model.image else None,
            'url': f'/model/{model.id}/'  # Adapter selon votre configuration d'URL
        })
    
    return JsonResponse({
        'success': True,
        'results': results,
        'count': len(results)
    })
    
def customize_service_model(request, model_id):
    """
    Affiche la page de personnalisation pour un modèle de service spécifique et gère la soumission du formulaire.
    """
    model = get_object_or_404(Service_Model, id=model_id)
    
    if not model.disponible:
        messages.error(request, "Ce modèle n'est pas disponible pour la personnalisation.")
        return redirect('detail_service_model', model_id=model.id)
    
    if request.method == 'POST':
        # Initialiser les données de personnalisation
        customization_data = {
            'quantity': request.POST.get('quantity', 1),
            'options': {},
            'special_instructions': request.POST.get('special_instructions', ''),
            'custom_text': request.POST.get('custom_text', ''),
            'total': float(model.prix_unitaire),
        }
        
        # Valider les champs obligatoires
        required_fields = [f'option_{detail.id}' for detail in model.details.all() if detail.obligatoire]
        required_fields.append('quantity')  # La quantité est toujours requise
        is_valid = True
        
        for field in required_fields:
            if not request.POST.get(field) or request.POST.get(field).strip() == '':
                is_valid = False
                messages.error(request, f"Le champ {field} est obligatoire.")
        
        if not is_valid:
            return render(request, 'web_site/customization.html', {
                'model': model,
                'NavNosServices': RecuperationService(),
                'errors': messages.get_messages(request),
            })
        
        # Collecter les options sélectionnées
        for detail in model.details.all():
            option_value = request.POST.get(f'option_{detail.id}')
            if option_value:
                customization_data['options'][detail.nom_option] = (
                    request.POST.getlist(f'option_{detail.id}') if detail.type_option == 'CHECKBOX' else option_value
                )
                if detail.prix_supplementaire:
                    customization_data['total'] += float(detail.prix_supplementaire) * (
                        len(customization_data['options'][detail.nom_option]) if detail.type_option == 'CHECKBOX' else 1
                    )
        
        # Valider la quantité
        try:
            quantity = int(customization_data['quantity'])
            if quantity < 1:
                raise ValueError
        except ValueError:
            messages.error(request, "La quantité doit être un nombre entier positif.")
            return render(request, 'web_site/customization.html', {
                'model': model,
                'NavNosServices': RecuperationService(),
                'errors': messages.get_messages(request),
            })
        
        # Calculer le prix total
        customization_data['total'] *= quantity
        
        # Stocker dans la session
        request.session['customization_data'] = customization_data
        
        # Rediriger vers la page d'upload
        return redirect('upload_design', model_id=model.id)
    
    context = {
        'model': model,
        'NavNosServices': RecuperationService(),
    }
    return render(request, 'web_site/customization.html', context)

def process_customization(request):
    """
    Traite le formulaire de personnalisation et enregistre la commande (avec ou sans upload de design).
    """
    if request.method == 'POST':
        model_id = request.POST.get('model_id')
        model = get_object_or_404(Service_Model, id=model_id)
        # Vérification de la disponibilité
        if not model.disponible:
            messages.error(request, "Ce modèle n'est pas disponible pour la commande.")
            return redirect('detail_service_model', model_id=model.id)
        # Récupération des données du formulaire
        quantity = request.POST.get('quantity')
        special_instructions = request.POST.get('special_instructions', '')
        custom_text = request.POST.get('custom_text', '')
        # Validation de la quantité
        try:
            quantity = int(quantity)
            if quantity < 1:
                messages.error(request, "La quantité doit être supérieure ou égale à 1.")
                return redirect('customize_service_model', model_id=model.id)
        except (ValueError, TypeError):
            messages.error(request, "Veuillez entrer une quantité valide.")
            return redirect('customize_service_model', model_id=model.id)
        # Calcul du prix total
        total_price = Decimal(str(model.prix_unitaire))
        selected_options = {}
        for detail in model.details.all():
            option_value = request.POST.get(f'option_{detail.id}')
            if detail.obligatoire and not option_value:
                messages.error(request, f"L'option {detail.nom_option} est obligatoire.")
                return redirect('customize_service_model', model_id=model.id)
            if option_value:
                if detail.type_option == 'CHECKBOX':
                    option_values = request.POST.getlist(f'option_{detail.id}')
                    valid_values = detail.valeurs_possibles.values_list('valeur', flat=True)
                    selected_options[detail.nom_option] = [val for val in option_values if val in valid_values]
                    total_price += Decimal(str(detail.prix_supplementaire)) * len(selected_options[detail.nom_option])
                else:
                    if detail.type_option in ['SELECT', 'RADIO']:
                        valid_values = detail.valeurs_possibles.values_list('valeur', flat=True)
                        if option_value not in valid_values:
                            messages.error(request, f"Valeur non valide pour l'option {detail.nom_option}.")
                            return redirect('customize_service_model', model_id=model.id)
                    selected_options[detail.nom_option] = option_value
                    total_price += Decimal(str(detail.prix_supplementaire))
        total_price *= quantity
        # Création de la commande
        commande = Commande.objects.create(
            user=request.user if request.user.is_authenticated else None,
            nom_client=request.POST.get('nom_client', request.user.nom_complet if request.user.is_authenticated else ''),
            email_client=request.POST.get('email_client', request.user.email if request.user.is_authenticated else ''),
            telephone_client=request.POST.get('telephone_client', request.user.telephone if request.user.is_authenticated else ''),
            adresse_livraison=request.POST.get('adresse_livraison', ''),
            total_ht=total_price,
            total_ttc=total_price,
            notes_client=custom_text,
        )
        commande_item = CommandeItem.objects.create(
            commande=commande,
            service=model,
            quantite=quantity,
            prix_unitaire=total_price/quantity,
            prix_total=total_price,
            options_selectionnees=selected_options,
            instructions_speciales=special_instructions,
        )
        # Envoi d'un mail à l'admin
        try:
            send_mail(
                subject=f"[Nouvelle commande] {commande.nom_client}",
                message=f"Nouvelle commande créée par {commande.nom_client} (Email: {commande.email_client}, Tel: {commande.telephone_client})\n\nModèle: {model.nom}\nQuantité: {quantity}\nPrix total: {total_price} Fcfa\nOptions: {selected_options}\nInstructions: {special_instructions}",
                from_email=None,
                recipient_list=['cismatprint123@gmail.com', 'brahimacisse59@gmail.com'],
                fail_silently=True,
            )
        except Exception as e:
            pass
        # Nettoyer la session
        if 'customization_data' in request.session:
            del request.session['customization_data']
        messages.success(request, "Votre commande a été enregistrée avec succès !")
        return redirect('order_confirmation')
    # Si la méthode n'est pas POST, rediriger vers la page de personnalisation
    messages.error(request, "Méthode de requête non valide.")
    return redirect('all_service')

def upload_design(request, model_id):
    """
    Vue pour permettre à l'utilisateur d'uploader son design personnalisé et rattacher le fichier à la commande existante OU créer la commande si besoin.
    """
    model = get_object_or_404(Service_Model, id=model_id)
    if request.method == 'POST':
        design_file = request.FILES.get('design_file')
        if not design_file:
            messages.error(request, "Veuillez sélectionner un fichier.")
            return render(request, 'web_site/upload_design.html', {
                'model': model,
                'NavNosServices': RecuperationService(),
                'customization_data': request.session.get('customization_data', {}),
            })
        max_size = 10 * 1024 * 1024  # 10MB
        valid_types = ['application/pdf', 'image/jpeg', 'image/png', 'application/postscript', 'image/vnd.adobe.photoshop']
        if design_file.size > max_size:
            messages.error(request, "Le fichier dépasse la taille maximale de 10MB.")
            return render(request, 'web_site/upload_design.html', {
                'model': model,
                'NavNosServices': RecuperationService(),
                'customization_data': request.session.get('customization_data', {}),
            })
        if design_file.content_type not in valid_types:
            messages.error(request, "Format de fichier non supporté. Utilisez PDF, JPG, PNG, AI ou PSD.")
            return render(request, 'web_site/upload_design.html', {
                'model': model,
                'NavNosServices': RecuperationService(),
                'customization_data': request.session.get('customization_data', {}),
            })
        commande_item_id = request.session.get('commande_item_id')
        if commande_item_id:
            commande_item = get_object_or_404(CommandeItem, id=commande_item_id)
        else:
            # Création de la commande et du commandeItem si accès direct à l'upload
            nom_client = request.POST.get('nom_client', '')
            email_client = request.POST.get('email_client', '')
            telephone_client = request.POST.get('telephone_client', '')
            adresse_livraison = request.POST.get('adresse_livraison', '')
            quantity = int(request.POST.get('quantity', 1))
            total_price = Decimal(str(model.prix_unitaire)) * quantity
            commande = Commande.objects.create(
                user=request.user if request.user.is_authenticated else None,
                nom_client=nom_client,
                email_client=email_client,
                telephone_client=telephone_client,
                adresse_livraison=adresse_livraison,
                total_ht=total_price,
                total_ttc=total_price,
                notes_client=request.POST.get('custom_text', ''),
            )
            commande_item = CommandeItem.objects.create(
                commande=commande,
                service=model,
                quantite=quantity,
                prix_unitaire=Decimal(str(model.prix_unitaire)),
                prix_total=total_price,
                options_selectionnees={},
                instructions_speciales=request.POST.get('instructions_speciales', ''),
            )
            # Envoi d'un mail à l'admin
            try:
                send_mail(
                    subject=f"[Nouvelle commande] {commande.nom_client}",
                    message=f"Nouvelle commande créée par {commande.nom_client} (Email: {commande.email_client}, Tel: {commande.telephone_client})\n\nModèle: {model.nom}\nQuantité: {quantity}\nPrix total: {total_price} Fcfa\nInstructions: {request.POST.get('instructions_speciales', '')}",
                    from_email=None,
                    recipient_list=['cismatprint123@gmail.com', 'brahimacisse59@gmail.com'],
                    fail_silently=True,
                )
            except Exception as e:
                pass
        # Calculer le hash du fichier
        sha256_hash = hashlib.sha256()
        for chunk in design_file.chunks():
            sha256_hash.update(chunk)
        file_hash = sha256_hash.hexdigest()
        # Enregistrer le fichier
        fichier = Fichier.objects.create(
            commande_item=commande_item,
            nom_original=design_file.name,
            fichier=design_file,
            type_mime=design_file.content_type,
            taille_octets=design_file.size,
            hash_fichier=file_hash,
        )
        messages.success(request, "Votre design a bien été envoyé et rattaché à votre commande !")
        if 'customization_data' in request.session:
            del request.session['customization_data']
        if 'commande_item_id' in request.session:
            del request.session['commande_item_id']
        return redirect('order_confirmation')
    return render(request, 'web_site/upload_design.html', {
        'model': model,
        'NavNosServices': RecuperationService(),
        'customization_data': request.session.get('customization_data', {}),
    })
