(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner(0);
    
    
    // Initiate the wowjs
    new WOW().init();

    // Sticky Navbar
    $(window).scroll(function () {
        if ($(this).scrollTop() > 45) {
            $('.navbar').addClass('sticky-top shadow-sm');
        } else {
            $('.navbar').removeClass('sticky-top shadow-sm');
        }
    });


    // Hero Header carousel
    $(".header-carousel").owlCarousel({
        animateOut: 'fadeOut',
        items: 1,
        margin: 0,
        stagePadding: 0,
        autoplay: true,
        smartSpeed: 500,
        dots: true,
        loop: true,
        nav : true,
        navText : [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
    });


    // attractions carousel
    $(".blog-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: false,
        loop: true,
        margin: 25,
        nav : true,
        navText : [
            '<i class="fa fa-angle-right"></i>',
            '<i class="fa fa-angle-left"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0:{
                items:1
            },
            576:{
                items:1
            },
            768:{
                items:2
            },
            992:{
                items:2
            },
            1200:{
                items:3
            }
        }
    });


    // testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav : true,
        navText : [
            '<i class="fa fa-angle-right"></i>',
            '<i class="fa fa-angle-left"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0:{
                items:1
            },
            576:{
                items:1
            },
            768:{
                items:2
            },
            992:{
                items:2
            },
            1200:{
                items:3
            }
        }
    });


    // Facts counter
    $('[data-toggle="counter-up"]').counterUp({
        delay: 5,
        time: 2000
    });


   // Back to top button
   $(window).scroll(function () {
    if ($(this).scrollTop() > 300) {
        $('.back-to-top').fadeIn('slow');
    } else {
        $('.back-to-top').fadeOut('slow');
    }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
        return false;
    });


})(jQuery);

// Configuration de Toastr
toastr.options = {
  "closeButton": true,
  "debug": false,
  "newestOnTop": true,
  "progressBar": true,
  "positionClass": "toast-top-right",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
};

// Variables globales
let selectedService = '';
let bookingDateTime = '';
let uploadedFiles = [];

// Initialisation Flatpickr
function initFlatpickr() {
    flatpickr("#booking-date", {
        locale: "fr",
        minDate: "today",
        maxDate: new Date().fp_incr(30), // 30 jours à partir d'aujourd'hui
        enableTime: true,
        time_24hr: true,
        minuteIncrement: 15,
        disable: [
            function(date) {
                // Désactiver les weekends
                return (date.getDay() === 0 || date.getDay() === 6);
            },
            {
                from: "12:00",
                to: "13:30"
            },
            {
                from: "18:00",
                to: "24:00"
            },
            {
                from: "00:00",
                to: "08:00"
            }
        ],
        onChange: function(selectedDates, dateStr, instance) {
            if (selectedDates.length) {
                const date = selectedDates[0];
                bookingDateTime = date;
                // Formatage correct
                const options = { 
                    weekday: 'long', 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric'
                };
                const datePart = date.toLocaleDateString('fr-FR', options);
                const timePart = date.toLocaleTimeString('fr-FR', {hour: '2-digit', minute: '2-digit'});
                // Mise à jour des champs
                setText('confirm-date', datePart);
                setText('confirm-time', timePart);
                setText('final-date', datePart);
                setText('final-time', timePart);
            }
        }
    });
}

// Utilitaire pour éviter les erreurs si l'élément n'existe pas
function setText(id, value) {
    const el = document.getElementById(id);
    if (el) el.textContent = value;
}

// Gestion des étapes avec validation
function nextStep(step) {
    window.scrollTo({ top: 0, behavior: 'smooth' });
    // Validation des champs avant de passer à l'étape suivante
    if (!validateStep(step - 1)) {
        return false;
    }

    const prev = document.querySelector(`#step-${step-1}`);
    const curr = document.querySelector(`#step-${step}`);
    if (prev) prev.classList.add('d-none');
    if (curr) curr.classList.remove('d-none');
    
    // Si étape 2, capturer le service sélectionné
    if (step === 2) {
        const activeCard = document.querySelector('.print-service-card.active');
        selectedService = activeCard?.dataset.service || '';
        setText('confirm-service', activeCard?.querySelector('h5')?.textContent || '--');
    }
    // Si étape 3, capturer la durée et le mode
    if (step === 3) {
        const duration = document.querySelector('input[name="duration"]:checked')?.nextElementSibling?.textContent || '--';
        const mode = document.querySelector('input[name="meetingType"]:checked')?.nextElementSibling?.textContent || '--';
        setText('confirm-duration', duration);
        setText('confirm-mode', mode);
        setText('final-mode', mode);
        
        // Récupérer aussi la date et l'heure
        const dateTime = document.getElementById('booking-date').value;
        if (dateTime) {
            const [date, time] = dateTime.split(' ');
            setText('confirm-date', date);
            setText('confirm-time', time);
            setText('final-date', date);
            setText('final-time', time);
        }
    }
    updateProgress(step);
}

function prevStep(step) {
    const next = document.querySelector(`#step-${step+1}`);
    const curr = document.querySelector(`#step-${step}`);
    if (next) next.classList.add('d-none');
    if (curr) curr.classList.remove('d-none');
    updateProgress(step);
}

// Fonction de validation des étapes
function validateStep(step) {
    let isValid = true;
    
    // Validation de l'étape 1 (Type de projet)
    if (step === 1) {
        const selectedService = document.querySelector('.print-service-card.active');
        if (!selectedService) {
            toastr.error('Veuillez sélectionner un type de projet avant de continuer', 'Champ requis');
            isValid = false;
        }
    }
    
    // Validation de l'étape 2 (Créneau)
    if (step === 2) {
        const dateTime = document.getElementById('booking-date').value;
        if (!dateTime) {
            toastr.error('Veuillez sélectionner une date et une heure pour votre rendez-vous', 'Champ requis');
            isValid = false;
        }
        
        const meetingType = document.querySelector('input[name="meetingType"]:checked');
        if (!meetingType) {
            toastr.error('Veuillez sélectionner un mode de rendez-vous', 'Champ requis');
            isValid = false;
        }
        
        const duration = document.querySelector('input[name="duration"]:checked');
        if (!duration) {
            toastr.error('Veuillez sélectionner une durée pour votre rendez-vous', 'Champ requis');
            isValid = false;
        }
    }
    
    // Validation de l'étape 3 (Confirmation)
    if (step === 3) {
        const fullname = document.getElementById('fullname').value;
        const email = document.getElementById('email').value;
        const phone = document.getElementById('phone').value;
        const consent = document.getElementById('consent').checked;
        
        if (!fullname) {
            toastr.error('Veuillez entrer votre nom complet', 'Champ requis');
            isValid = false;
        }
        
        if (!email) {
            toastr.error('Veuillez entrer votre adresse email', 'Champ requis');
            isValid = false;
        } else if (!validateEmail(email)) {
            toastr.error('Veuillez entrer une adresse email valide', 'Format invalide');
            isValid = false;
        }
        
        if (!phone) {
            toastr.error('Veuillez entrer votre numéro de téléphone', 'Champ requis');
            isValid = false;
        }
        
        if (!consent) {
            toastr.warning('Veuillez accepter la politique de confidentialité', 'Autorisation requise');
            isValid = false;
        }
    }
    
    return isValid;
}

// Fonction pour valider l'email
function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

// Fonction utilitaire pour mettre à jour le texte
function setText(id, text) {
    const element = document.getElementById(id);
    if (element) {
        element.textContent = text;
    }
}

// Gestion des services
function setupServiceCards() {
    document.querySelectorAll('.print-service-card').forEach(card => {
        card.addEventListener('click', function() {
            document.querySelectorAll('.print-service-card').forEach(c => c.classList.remove('active'));
            this.classList.add('active');
        });
    });
}

// Gestion du drag & drop
function setupFileUpload() {
    const fileDropArea = document.getElementById('file-drop-area');
    const fileInput = document.getElementById('file-upload');
    if (!fileDropArea || !fileInput) return;

    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        fileDropArea.addEventListener(eventName, preventDefaults, false);
    });

    function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
    }

    ['dragenter', 'dragover'].forEach(eventName => {
        fileDropArea.addEventListener(eventName, highlight, false);
    });

    ['dragleave', 'drop'].forEach(eventName => {
        fileDropArea.addEventListener(eventName, unhighlight, false);
    });

    function highlight() {
        fileDropArea.classList.add('dragover');
    }

    function unhighlight() {
        fileDropArea.classList.remove('dragover');
    }

    fileDropArea.addEventListener('drop', handleDrop, false);

    function handleDrop(e) {
        const dt = e.dataTransfer;
        const files = dt.files;
        fileInput.files = files;
        handleFiles(files);
    }

    fileInput.addEventListener('change', function(e) {
        handleFiles(e.target.files);
    });
}

function handleFiles(files) {
    uploadedFiles = Array.from(files);
    const previewContainer = document.getElementById('file-previews');
    setText('confirm-files', files.length);
    if (!previewContainer) return;
    previewContainer.innerHTML = '';
    Array.from(files).forEach(file => {
        const reader = new FileReader();
        reader.onload = function(e) {
            const preview = document.createElement('div');
            preview.className = 'position-relative';
            preview.innerHTML = `
                <img src="${e.target.result}" class="print-preview-thumbnail" alt="${file.name}">
                <button class="btn btn-sm btn-danger position-absolute top-0 end-0" onclick="removeFile('${file.name}')">
                    <i class="fas fa-times"></i>
                </button>
                <div class="small text-truncate mt-1" style="width: 100px;">${file.name}</div>
            `;
            previewContainer.appendChild(preview);
        };
        if (file.type.startsWith('image/')) {
            reader.readAsDataURL(file);
        } else {
            const preview = document.createElement('div');
            preview.className = 'position-relative';
            preview.innerHTML = `
                <div class="print-preview-thumbnail bg-light d-flex align-items-center justify-content-center">
                    <i class="fas fa-file-alt fa-2x text-muted"></i>
                </div>
                <button class="btn btn-sm btn-danger position-absolute top-0 end-0" onclick="removeFile('${file.name}')">
                    <i class="fas fa-times"></i>
                </button>
                <div class="small text-truncate mt-1" style="width: 100px;">${file.name}</div>
            `;
            previewContainer.appendChild(preview);
        }
    });
}

function removeFile(filename) {
    uploadedFiles = uploadedFiles.filter(file => file.name !== filename);
    setText('confirm-files', uploadedFiles.length);
    // Réafficher les previews restantes
    const dataTransfer = new DataTransfer();
    uploadedFiles.forEach(file => dataTransfer.items.add(file));
    document.getElementById('file-upload').files = dataTransfer.files;
    handleFiles(dataTransfer.files);
}

// Soumission du formulaire
function submitBooking() {
    // Validation simple
    const fullname = document.getElementById('fullname')?.value;
    const email = document.getElementById('email')?.value;
    const phone = document.getElementById('phone')?.value;
    if (!fullname || !email || !phone || !document.getElementById('consent')?.checked) {
        toastr.error('Veuillez remplir tous les champs obligatoires', 'Champ requis');
        return;
    }
    // Générer une référence aléatoire
    const ref = Math.floor(1000 + Math.random() * 9000);
    setText('booking-ref', ref);
    // Configurer le lien "Ajouter à l'agenda"
    const calendarLink = generateCalendarLink();
    const addToCalendar = document.getElementById('add-to-calendar');
    if (addToCalendar) addToCalendar.setAttribute('href', calendarLink);
    // Afficher la confirmation
    document.querySelector('#step-3').classList.add('d-none');
    document.querySelector('#step-confirmation').classList.remove('d-none');
    // Lancer les confettis
    if (typeof JSConfetti !== "undefined") launchConfetti();
    // Scroll vers le haut
    window.scrollTo({ top: 0, behavior: 'smooth' });
    // Ici, vous ajouteriez l'appel AJAX pour envoyer les données au serveur
    console.log('Rendez-vous soumis', {
        reference: `PRINT-${ref}`,
        service: selectedService,
        dateTime: bookingDateTime,
        duration: document.querySelector('input[name="duration"]:checked')?.id,
        mode: document.querySelector('input[name="meetingType"]:checked')?.id,
        files: uploadedFiles,
        contact: { 
            fullname, 
            email, 
            phone,
            company: document.getElementById('company')?.value
        }
    });
}

function generateCalendarLink() {
    if (!bookingDateTime) return '#';
    const startDate = new Date(bookingDateTime);
    const endDate = new Date(startDate);
    const duration = document.querySelector('input[name="duration"]:checked')?.id === '30min' ? 30 : 60;
    endDate.setMinutes(startDate.getMinutes() + duration);
    // Format pour les liens de calendrier (ISO sans timezone)
    const formatDate = (date) => {
        return date.toISOString().replace(/-|:|\.\d\d\d/g,'');
    };
    const title = "Consultation Imprimerie Pro";
    const details = `Discussion de votre projet ${selectedService}`;
    const location = document.querySelector('input[name="meetingType"]:checked')?.id === 'presentiel' 
        ? "Imprimerie Pro, Yopougon, Abidjan" 
        : "Visioconférence (lien envoyé par email)";
    return [
        'https://calendar.google.com/calendar/render?action=TEMPLATE',
        `&dates=${formatDate(startDate)}/${formatDate(endDate)}`,
        `&text=${encodeURIComponent(title)}`,
        `&details=${encodeURIComponent(details)}`,
        `&location=${encodeURIComponent(location)}`
    ].join('');
}

function launchConfetti() {
    const jsConfetti = new JSConfetti();
    jsConfetti.addConfetti({
        confettiColors: [
            '#2A5C8B', '#4E8BBF', '#FF7D33', '#ffffff'
        ],
        confettiRadius: 5,
        confettiNumber: 300,
    });
}

function updateProgress(step) {
    for (let i = 1; i <= 3; i++) {
        const el = document.getElementById(`progress-step-${i}`);
        if (!el) continue;
        el.classList.remove('active', 'completed');
        if (i < step) el.classList.add('completed');
        else if (i === step) el.classList.add('active');
    }
}

// Initialisation
document.addEventListener('DOMContentLoaded', function() {
    initFlatpickr();
    setupServiceCards();
    setupFileUpload();
    // Sélectionner automatiquement le premier service
    const firstCard = document.querySelector('.print-service-card');
    if (firstCard) firstCard.click();
    // Sélectionner la durée par défaut
    const minRadio = document.getElementById('30min');
    if (minRadio) minRadio.checked = true;
    // Sélectionner le mode par défaut
    const visioRadio = document.getElementById('visio');
    if (visioRadio) visioRadio.checked = true;
});

// Dynamisation des éléments de la navbar
// Animation sur hover pour chaque nav-link
const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
navLinks.forEach(link => {
  link.addEventListener('mouseenter', () => {
    link.classList.add('animate__animated', 'animate__rubberBand');
  });
  link.addEventListener('mouseleave', () => {
    link.classList.remove('animate__animated', 'animate__rubberBand');
  });
});
// Animation sur le bouton RDV
const btnRdv = document.getElementById('btn-rdv');
if(btnRdv) {
  btnRdv.addEventListener('mouseenter', () => {
    btnRdv.classList.add('animate__pulse');
  });
  btnRdv.addEventListener('mouseleave', () => {
    btnRdv.classList.remove('animate__pulse');
  });
}
// Animation sur le panier
const btnPanier = document.getElementById('btn-panier');
if(btnPanier) {
  btnPanier.addEventListener('mouseenter', () => {
    btnPanier.classList.add('animate__tada');
  });
  btnPanier.addEventListener('mouseleave', () => {
    btnPanier.classList.remove('animate__tada');
  });
}
// Animation sur l'icône inscription
const btnInscription = document.getElementById('btn-inscription');
if(btnInscription) {
  btnInscription.addEventListener('mouseenter', () => {
    btnInscription.classList.add('animate__tada');
  });
  btnInscription.addEventListener('mouseleave', () => {
    btnInscription.classList.remove('animate__tada');
  });
}
