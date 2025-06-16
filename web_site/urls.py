from django.urls import path
from .views import accueil, about,  contact, service, rdv, grand_format, autre_format, petit_format, all_service, detail_service, contact_ajax
from . import views

urlpatterns = [
    path('', accueil, name='accueil'),
    path('about.html', about, name='about'),
    path('contact.html', contact, name='contact'),
    path('realisations.html', service, name='service'),
    path('rdv.html', rdv, name='rdv'),
    path('grand_format.html/<int:id>/', grand_format, name='grand_format'),
    path('petit_format.html/<int:id>/', petit_format, name='petit_format'),
    path('autre_format.html/<int:id>/', autre_format, name='autre_format'),
    
    path('all_service', all_service, name='all_service'),
    path('all_service/<int:id>/', detail_service, name='detail_service'),
    path('contact_ajax/', contact_ajax, name='contact_ajax'),
    path('savoir_plus/<int:id>/', detail_service, name='savoir_plus'),
    
    path('commande/<int:id>/', detail_service, name='commande_detail_service'),
    path('rdv_ajax/', views.rdv_ajax, name='rdv_ajax'),
    path('commande_ajax/', views.commande_ajax, name='commande_ajax'),
]
