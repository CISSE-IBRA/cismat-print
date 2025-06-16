# Create your models here.
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.validators import MinValueValidator, MaxValueValidator
from django.utils import timezone
import uuid
import os


def upload_service_image(instance, filename):
    """Génère le chemin pour les images de Service_Models"""
    ext = filename.split('.')[-1]
    filename = f"{uuid.uuid4()}.{ext}"
    return os.path.join('web_site/static/services', filename)


def upload_realisation_image(instance, filename):
    """Génère le chemin pour les images de réalisations"""
    ext = filename.split('.')[-1]
    filename = f"{uuid.uuid4()}.{ext}"
    return os.path.join('web_site/static/realisations', filename)


def upload_equipe_photo(instance, filename):
    """Génère le chemin pour les photos d'équipe"""
    ext = filename.split('.')[-1]
    filename = f"{uuid.uuid4()}.{ext}"
    return os.path.join('web_site/static/equipe', filename)


def upload_client_file(instance, filename):
    """Génère le chemin pour les fichiers clients"""
    ext = filename.split('.')[-1]
    filename = f"{uuid.uuid4()}.{ext}"
    return os.path.join('web_site/static/commandes', str(instance.commande_item.commande.id), filename)


class User(AbstractUser):
    """Modèle utilisateur personnalisé"""
    ROLE_CHOICES = [
        ('CLIENT', 'Client'),
        ('ADMIN', 'Administrateur'),
    ]
    
    nom_complet = models.CharField(max_length=200, blank=True)
    telephone = models.CharField(max_length=20, blank=True)
    role = models.CharField(max_length=10, choices=ROLE_CHOICES, default='CLIENT')
    date_creation = models.DateTimeField(auto_now_add=True)
    derniere_connexion = models.DateTimeField(null=True, blank=True)
    actif = models.BooleanField(default=True)
    
    class Meta:
        # Assurez-vous d'avoir ceci si vous substituez le modèle User par défaut
        swappable = 'AUTH_USER_MODEL'
    
    # Modifiez la ligne suivante :
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        verbose_name='user permissions',
        blank=True,
        help_text='Specific permissions for this user.',
        related_name='web_site_user_set',  # <- Nom personnalisé ici
        related_query_name='user',
    )
    
    def __str__(self):
        return self.nom_complet or self.username


class Categorie(models.Model):
    """Catégories de services"""
    nom = models.CharField(max_length=100, unique=True)
    description = models.TextField(blank=True)
    image = models.ImageField(upload_to='web_site/static/categories/', blank=True, null=True)
    ordre_affichage = models.PositiveIntegerField(default=0)
    active = models.BooleanField(default=True)
    
    class Meta:
        ordering = ['ordre_affichage', 'nom']
        verbose_name = 'Catégorie'
        verbose_name_plural = 'Catégories'
    
    def __str__(self):
        return self.nom

# modele pour pourvoir ajouter des services
class Service(models.Model):
    id_categorie = models.ForeignKey(Categorie, on_delete=models.CASCADE)
    titre = models.CharField(max_length=200)
    image = models.ImageField(upload_to=upload_service_image, blank=True, null=True)
    description = models.TextField()
    ordre_affichage = models.PositiveIntegerField(default=0)
    active = models.BooleanField(default=True)
    
    class Meta:
        ordering = ['ordre_affichage', 'titre']
        verbose_name = 'Service'
        verbose_name_plural = 'Services'
        
    def __str__(self):
        return self.titre    

class Service_Model(models.Model):
    """Services d'imprimerie proposés"""
    id_service = models.ForeignKey(Service, on_delete=models.CASCADE)
    nom = models.CharField(max_length=200)
    description = models.TextField()
    prix_unitaire = models.DecimalField(max_digits=10, decimal_places=2)
    unite_mesure = models.CharField(max_length=50, help_text="A4, A3, m², pièce, etc.")
    specifications_techniques = models.TextField(blank=True)
    disponible = models.BooleanField(default=True)
    image = models.ImageField(upload_to=upload_service_image, blank=True, null=True)
    date_creation = models.DateTimeField(auto_now_add=True)
    date_modification = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['nom']
        verbose_name = 'Service model'
        verbose_name_plural = 'Services models'
    
    def __str__(self):
        return f"{self.nom} - {self.prix_unitaire}fcfa/{self.unite_mesure}"


class Service_ModelDetail(models.Model):
    """Options et détails configurables pour les services"""
    TYPE_CHOICES = [
        ('SELECT', 'Liste déroulante'),
        ('CHECKBOX', 'Case à cocher'),
        ('TEXT', 'Champ texte'),
        ('NUMBER', 'Nombre'),
        ('RADIO', 'Bouton radio'),
    ]
    
    service_model = models.ForeignKey(Service_Model, on_delete=models.CASCADE, related_name='details')
    nom_option = models.CharField(max_length=100, help_text="couleur, format, qualité, etc.")
    type_option = models.CharField(max_length=10, choices=TYPE_CHOICES)
    valeurs_possibles = models.JSONField(
        blank=True, 
        null=True,
        help_text="Format JSON: {'options': ['Rouge', 'Bleu', 'Vert']}"
    )
    obligatoire = models.BooleanField(default=False)
    prix_supplementaire = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    
    class Meta:
        verbose_name = 'Détail de service'
        verbose_name_plural = 'Détails de services'
        unique_together = ['service_model', 'nom_option']
    
    def __str__(self):
        return f"{self.service.nom} - {self.nom_option}"


class Commande(models.Model):
    """Commandes passées (avec ou sans compte)"""
    STATUT_CHOICES = [
        ('EN_ATTENTE', 'En attente'),
        ('CONFIRMEE', 'Confirmée'),
        ('EN_PRODUCTION', 'En production'),
        ('PRETE', 'Prête'),
        ('LIVREE', 'Livrée'),
        ('ANNULEE', 'Annulée'),
    ]
    
    numero_commande = models.CharField(max_length=50, unique=True, editable=False)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='commandes')
    
    # Informations client (obligatoires même avec compte)
    nom_client = models.CharField(max_length=200)
    email_client = models.EmailField()
    telephone_client = models.CharField(max_length=20)
    adresse_livraison = models.TextField()
    
    statut = models.CharField(max_length=15, choices=STATUT_CHOICES, default='EN_ATTENTE')
    total_ht = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    total_ttc = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    taux_tva = models.DecimalField(max_digits=5, decimal_places=2, default=20.00)
    
    date_commande = models.DateTimeField(auto_now_add=True)
    date_livraison_prevue = models.DateTimeField(null=True, blank=True)
    date_livraison_reelle = models.DateTimeField(null=True, blank=True)
    
    notes_client = models.TextField(blank=True)
    notes_admin = models.TextField(blank=True)
    
    class Meta:
        ordering = ['-date_commande']
        verbose_name = 'Commande'
        verbose_name_plural = 'Commandes'
    
    def save(self, *args, **kwargs):
        if not self.numero_commande:
            # Génère un numéro de commande unique
            self.numero_commande = f"CMD{timezone.now().strftime('%Y%m%d')}{uuid.uuid4().hex[:8].upper()}"
        super().save(*args, **kwargs)
    
    def __str__(self):
        return f"Commande {self.numero_commande} - {self.nom_client}"


class CommandeItem(models.Model):
    """Lignes de commande - détail des services commandés"""
    commande = models.ForeignKey(Commande, on_delete=models.CASCADE, related_name='items')
    service = models.ForeignKey(Service_Model, on_delete=models.CASCADE)
    quantite = models.PositiveIntegerField(validators=[MinValueValidator(1)])
    prix_unitaire = models.DecimalField(max_digits=10, decimal_places=2)
    prix_total = models.DecimalField(max_digits=10, decimal_places=2)
    options_selectionnees = models.JSONField(
        blank=True, 
        null=True,
        help_text="Options choisies par le client"
    )
    instructions_speciales = models.TextField(blank=True)
    
    class Meta:
        verbose_name = 'Article de commande'
        verbose_name_plural = 'Articles de commande'
    
    def save(self, *args, **kwargs):
        self.prix_total = self.quantite * self.prix_unitaire
        super().save(*args, **kwargs)
    
    def __str__(self):
        return f"{self.service.nom} x{self.quantite}"


class Fichier(models.Model):
    """Fichiers joints aux commandes"""
    commande_item = models.ForeignKey(CommandeItem, on_delete=models.CASCADE, related_name='fichiers')
    nom_original = models.CharField(max_length=255)
    fichier = models.FileField(upload_to=upload_client_file)
    type_mime = models.CharField(max_length=100)
    taille_octets = models.BigIntegerField()
    hash_fichier = models.CharField(max_length=64, blank=True)
    date_upload = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        verbose_name = 'Fichier'
        verbose_name_plural = 'Fichiers'
    
    def __str__(self):
        return self.nom_original


class RDV(models.Model):
    """Rendez-vous clients"""
    TYPE_CHOICES = [
        ('CONSULTATION', 'Consultation'),
        ('DEVIS', 'Devis'),
        ('FORMATION', 'Formation'),
        ('AUTRE', 'Autre'),
    ]
    
    STATUT_CHOICES = [
        ('PROGRAMME', 'Programmé'),
        ('CONFIRME', 'Confirmé'),
        ('REPORTE', 'Reporté'),
        ('ANNULE', 'Annulé'),
        ('TERMINE', 'Terminé'),
    ]
    
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='rdvs')
    nom_client = models.CharField(max_length=200)
    telephone_client = models.CharField(max_length=20)
    email_client = models.EmailField()
    
    date_rdv = models.DateTimeField()
    duree_minutes = models.PositiveIntegerField(default=30)
    type_rdv = models.CharField(max_length=15, choices=TYPE_CHOICES)
    motif = models.TextField()
    statut = models.CharField(max_length=10, choices=STATUT_CHOICES, default='PROGRAMME')
    notes_admin = models.TextField(blank=True)
    date_creation = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        ordering = ['date_rdv']
        verbose_name = 'Rendez-vous'
        verbose_name_plural = 'Rendez-vous'
    
    def __str__(self):
        return f"RDV {self.nom_client} - {self.date_rdv.strftime('%d/%m/%Y %H:%M')}"


class Testimonial(models.Model):
    """Témoignages clients"""
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    nom_client = models.CharField(max_length=200)
    email_client = models.EmailField(blank=True)
    note = models.PositiveIntegerField(validators=[MinValueValidator(1), MaxValueValidator(5)])
    commentaire = models.TextField()
    approuve = models.BooleanField(default=False)
    affiche_public = models.BooleanField(default=False)
    date_creation = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        ordering = ['-date_creation']
        verbose_name = 'Témoignage'
        verbose_name_plural = 'Témoignages'
    
    def __str__(self):
        return f"{self.nom_client} - {self.note}/5"


class Equipe(models.Model):
    """Membres de l'équipe"""
    nom = models.CharField(max_length=100)
    prenom = models.CharField(max_length=100)
    poste = models.CharField(max_length=150)
    bio = models.TextField(blank=True)
    photo = models.ImageField(upload_to=upload_equipe_photo, blank=True, null=True)
    email = models.EmailField(blank=True)
    telephone = models.CharField(max_length=20, blank=True)
    affiche_public = models.BooleanField(default=True)
    ordre_affichage = models.PositiveIntegerField(default=0)
    
    class Meta:
        ordering = ['ordre_affichage', 'nom']
        verbose_name = 'Membre équipe'
        verbose_name_plural = 'Équipe'
    
    def __str__(self):
        return f"{self.prenom} {self.nom} - {self.poste}"


class Realisation(models.Model):
    """Projets réalisés par l'imprimerie"""
    titre = models.CharField(max_length=200)
    description = models.TextField()
    client = models.CharField(max_length=200, blank=True, help_text="Nom du client (optionnel)")
    services_utilises = models.ManyToManyField(Service_Model, related_name='realisations', blank=True)
    image_principale = models.ImageField(upload_to=upload_realisation_image)
    images_galerie = models.JSONField(
        blank=True,
        null=True,
        help_text="URLs des images supplémentaires de la galerie"
    )
    date_realisation = models.DateField()
    duree_projet = models.CharField(max_length=100, blank=True, help_text="Ex: 3 jours, 1 semaine")
    cout_projet = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    difficulte = models.CharField(
        max_length=20, 
        choices=[
            ('FACILE', 'Facile'),
            ('MOYEN', 'Moyen'),
            ('DIFFICILE', 'Difficile'),
            ('EXPERT', 'Expert')
        ],
        default='MOYEN'
    )
    technologies_utilisees = models.TextField(blank=True, help_text="Matériaux, techniques utilisées")
    visible_public = models.BooleanField(default=True)
    ordre_affichage = models.PositiveIntegerField(default=0)
    date_creation = models.DateTimeField(auto_now_add=True)
    date_modification = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['ordre_affichage', '-date_realisation']
        verbose_name = 'Réalisation'
        verbose_name_plural = 'Réalisations'
    
    def __str__(self):
        return f"{self.titre} - {self.date_realisation.strftime('%Y')}"


class Setting(models.Model):
    """Paramètres système configurables"""
    TYPE_CHOICES = [
        ('STRING', 'Texte'),
        ('NUMBER', 'Nombre'),
        ('BOOLEAN', 'Booléen'),
        ('JSON', 'JSON'),
        ('EMAIL', 'Email'),
        ('URL', 'URL'),
    ]
    
    cle = models.CharField(max_length=100, unique=True)
    valeur = models.TextField()
    type_donnee = models.CharField(max_length=10, choices=TYPE_CHOICES, default='STRING')
    description = models.TextField(blank=True)
    date_modification = models.DateTimeField(auto_now=True)
    
    class Meta:
        verbose_name = 'Paramètre'
        verbose_name_plural = 'Paramètres'
    
    def __str__(self):
        return f"{self.cle}: {self.valeur[:50]}"
    
    def get_valeur(self):
        """Retourne la valeur convertie selon son type"""
        if self.type_donnee == 'BOOLEAN':
            return self.valeur.lower() in ['true', '1', 'yes', 'on']
        elif self.type_donnee == 'NUMBER':
            try:
                return float(self.valeur)
            except ValueError:
                return 0
        elif self.type_donnee == 'JSON':
            try:
                import json
                return json.loads(self.valeur)
            except json.JSONDecodeError:
                return {}
        return self.valeur