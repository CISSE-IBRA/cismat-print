# Register your models here.
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import *

# Configuration de l'admin personnalisé pour User
class CustomUserAdmin(UserAdmin):
    list_display = ('username', 'email', 'nom_complet', 'role', 'telephone', 'is_active', 'date_joined')
    list_filter = ('role', 'is_active', 'is_staff', 'is_superuser')
    search_fields = ('username', 'email', 'nom_complet', 'telephone')
    ordering = ('-date_joined',)
    
    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        ('Informations personnelles', {'fields': ('nom_complet', 'email', 'telephone', 'role')}),
        ('Permissions', {
            'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions'),
        }),
        ('Dates importantes', {'fields': ('last_login', 'date_joined')}),
    )
    
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'email', 'nom_complet', 'password1', 'password2', 'role', 'telephone'),
        }),
    )

# Enregistrement des modèles avec configurations personnalisées
@admin.register(Categorie)
class CategorieAdmin(admin.ModelAdmin):
    list_display = ('nom', 'ordre_affichage', 'active')
    list_editable = ('ordre_affichage', 'active')
    search_fields = ('nom', 'description')


@admin.register(Service_Model)
class Service_ModelAdmin(admin.ModelAdmin):
    list_display = ('nom', 'prix_unitaire', 'unite_mesure', 'disponible')


class ServiceDetailInline(admin.TabularInline):
    model = Service_ModelDetail
    extra = 1

@admin.register(Service_ModelDetail)
class ServiceDetailAdmin(admin.ModelAdmin):
    list_display = ('service_model', 'nom_option', 'type_option', 'obligatoire', 'prix_supplementaire')
    list_filter = ('service_model', 'type_option', 'obligatoire')
    search_fields = ('service__nom', 'nom_option')

@admin.register(Service)
class ServiceAdmin(admin.ModelAdmin):
    list_display = ('id_categorie', 'titre', 'description', 'ordre_affichage', 'active')
    list_filter = ('id_categorie',)
    search_fields = ('titre',)

    
    
class CommandeItemInline(admin.TabularInline):
    model = CommandeItem
    extra = 0
    readonly_fields = ('prix_total',)
    fields = ('service', 'quantite', 'prix_unitaire', 'prix_total', 'options_selectionnees')

class FichierInline(admin.TabularInline):
    model = Fichier
    extra = 0
    readonly_fields = ('type_mime', 'taille_octets', 'date_upload')

@admin.register(Commande)
class CommandeAdmin(admin.ModelAdmin):
    list_display = ('numero_commande', 'nom_client', 'statut', 'total_ttc', 'date_commande')
    list_filter = ('statut', 'date_commande')
    search_fields = ('numero_commande', 'nom_client', 'email_client')
    readonly_fields = ('numero_commande', 'total_ht', 'total_ttc', 'date_commande')
    inlines = [CommandeItemInline]
    date_hierarchy = 'date_commande'
    actions = ['marquer_comme_confirmee', 'marquer_comme_livree']

    def marquer_comme_confirmee(self, request, queryset):
        queryset.update(statut='CONFIRMEE')
    marquer_comme_confirmee.short_description = "Marquer comme confirmée"

    def marquer_comme_livree(self, request, queryset):
        queryset.update(statut='LIVREE')
    marquer_comme_livree.short_description = "Marquer comme livrée"

@admin.register(CommandeItem)
class CommandeItemAdmin(admin.ModelAdmin):
    list_display = ('commande', 'service', 'quantite', 'prix_unitaire', 'prix_total')
    list_filter = ('commande__statut', 'service')
    search_fields = ('commande__numero_commande', 'service__nom')
    inlines = [FichierInline]

@admin.register(Fichier)
class FichierAdmin(admin.ModelAdmin):
    list_display = ('commande_item', 'nom_original', 'date_upload')
    search_fields = ('nom_original', 'commande_item__commande__numero_commande')
    readonly_fields = ('type_mime', 'taille_octets', 'hash_fichier', 'date_upload')

@admin.register(RDV)
class RDVAdmin(admin.ModelAdmin):
    list_display = ('nom_client', 'type_rdv', 'date_rdv', 'statut')
    list_filter = ('type_rdv', 'statut', 'date_rdv')
    search_fields = ('nom_client', 'email_client', 'telephone_client')
    date_hierarchy = 'date_rdv'
    readonly_fields = ('date_creation',)

@admin.register(Testimonial)
class TestimonialAdmin(admin.ModelAdmin):
    list_display = ('nom_client', 'note', 'approuve', 'affiche_public', 'date_creation')
    list_filter = ('note', 'approuve', 'affiche_public')
    search_fields = ('nom_client', 'commentaire')
    list_editable = ('approuve', 'affiche_public')

@admin.register(Equipe)
class EquipeAdmin(admin.ModelAdmin):
    list_display = ('prenom', 'nom', 'poste', 'affiche_public', 'ordre_affichage')
    list_editable = ('affiche_public', 'ordre_affichage')
    search_fields = ('nom', 'prenom', 'poste')
    list_filter = ('affiche_public',)

@admin.register(Realisation)
class RealisationAdmin(admin.ModelAdmin):
    list_display = ('titre', 'client', 'date_realisation', 'visible_public', 'ordre_affichage')
    list_filter = ('visible_public', 'date_realisation', 'difficulte')
    search_fields = ('titre', 'client', 'description')
    filter_horizontal = ('services_utilises',)
    list_editable = ('visible_public', 'ordre_affichage')
    readonly_fields = ('date_creation', 'date_modification')

@admin.register(Setting)
class SettingAdmin(admin.ModelAdmin):
    list_display = ('cle', 'type_donnee', 'date_modification')
    search_fields = ('cle', 'description')
    readonly_fields = ('date_modification',)

# Enregistrement du modèle User avec l'admin personnalisé
admin.site.register(User, CustomUserAdmin)