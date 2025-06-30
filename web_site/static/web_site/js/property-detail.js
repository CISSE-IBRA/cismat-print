
document.addEventListener('DOMContentLoaded', function() {
  // Sample property data (in a real app, you would fetch this from a server)
  const properties = [
    {
      id: 1,
      title: 'Appartement de luxe avec vue sur la Seine',
      address: '16ème arrondissement, Paris',
      price: 1250000,
      bedrooms: 3,
      bathrooms: 2,
      area: 120,
      yearBuilt: 2010,
      images: [
        'https://images.unsplash.com/photo-1600585152220-90363fe7e115?q=80&w=2070&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?q=80&w=2070&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=2070&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1604014237800-1c9102c219da?q=80&w=1974&auto=format&fit=crop'
      ],
      type: 'Appartement',
      isFeatured: true,
      description: 'Cet appartement de standing vous séduira par ses volumes, sa luminosité et sa vue exceptionnelle sur la Seine. Situé dans un immeuble haussmannien parfaitement entretenu, il se compose d\'un double séjour, d\'une cuisine équipée, de trois chambres dont une suite parentale, et de deux salles de bains. Les prestations haut de gamme incluent parquet en chêne massif, moulures, cheminées en marbre et une climatisation réversible. Une cave complète ce bien d\'exception.',
      details: [
        'Surface: 120 m²',
        'Chambres: 3',
        'Salles de bain: 2',
        'Étage: 4ème avec ascenseur',
        'Chauffage: Central au gaz',
        'Exposition: Sud-Ouest',
        'Charges: 350€/mois',
        'Taxe foncière: 1 800€/an'
      ],
      amenities: [
        'Ascenseur',
        'Balcon',
        'Vue sur la Seine',
        'Parquet en chêne',
        'Cheminée',
        'Climatisation',
        'Double vitrage',
        'Digicode et interphone',
        'Cave',
        'Fibre optique'
      ]
    },
    {
      id: 2,
      title: 'Villa contemporaine avec piscine',
      address: 'Cannes, Côte d\'Azur',
      price: 3750000,
      bedrooms: 5,
      bathrooms: 4,
      area: 280,
      yearBuilt: 2018,
      images: [
        'https://images.unsplash.com/photo-1613977257363-707ba9348227?q=80&w=2070&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?q=80&w=1974&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1605276374104-dee2a0ed3cd6?q=80&w=2070&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1608045742930-48cee9f1a57b?q=80&w=1974&auto=format&fit=crop'
      ],
      type: 'Villa',
      isNew: true,
      description: 'Magnifique villa contemporaine située dans un quartier prisé de Cannes, offrant une vue panoramique sur la mer. Cette propriété d\'exception se déploie sur 280m² habitables et comprend un vaste séjour ouvert sur une terrasse avec piscine à débordement, une cuisine américaine entièrement équipée, cinq chambres dont une suite principale avec salle de bain privative et dressing, et trois autres salles de bain. Le jardin paysager de 1200m² est agrémenté d\'oliviers centenaires et d\'essences méditerranéennes.',
      details: [
        'Surface habitable: 280 m²',
        'Terrain: 1200 m²',
        'Chambres: 5',
        'Salles de bain: 4',
        'Piscine à débordement',
        'Garage double',
        'Système domotique',
        'Année de construction: 2018',
        'Taxe foncière: 8 500€/an'
      ],
      amenities: [
        'Piscine à débordement',
        'Vue mer',
        'Domotique',
        'Climatisation',
        'Volets électriques',
        'Garage double',
        'Portail électrique',
        'Alarme',
        'Vidéosurveillance',
        'Jardin paysager',
        'Arrosage automatique',
        'Terrasse'
      ]
    }
  ];

  // Format price with French locale (euros)
  function formatPrice(price) {
    return new Intl.NumberFormat('fr-FR', {
      style: 'currency',
      currency: 'EUR',
      maximumFractionDigits: 0,
    }).format(price);
  }

  // Get property ID from URL
  function getPropertyIdFromUrl() {
    const urlParams = new URLSearchParams(window.location.search);
    return parseInt(urlParams.get('id'));
  }

  // Load property details
  function loadPropertyDetails() {
    const propertyId = getPropertyIdFromUrl();
    const property = properties.find(p => p.id === propertyId) || properties[0]; // Fallback to first property if ID not found
    
    // Set page title
    document.title = `${property.title} - Immobilier Élégance`;
    
    // Update breadcrumb and page title
    const propertyTitle = document.getElementById('propertyTitle');
    const propertyDetailTitle = document.getElementById('propertyDetailTitle');
    
    if (propertyTitle) propertyTitle.textContent = property.title;
    if (propertyDetailTitle) propertyDetailTitle.textContent = property.title;
    
    // Update property address
    const propertyAddress = document.getElementById('propertyAddress');
    if (propertyAddress) {
      propertyAddress.innerHTML = `<i class="icon-location"></i><span>${property.address}</span>`;
    }
    
    // Update property price
    const propertyPrice = document.getElementById('propertyPrice');
    if (propertyPrice) propertyPrice.textContent = formatPrice(property.price);
    
    // Add badges
    const propertyBadges = document.getElementById('propertyBadges');
    if (propertyBadges) {
      let badgesHtml = '';
      if (property.isNew) badgesHtml += '<span class="badge badge-green">Nouveau</span>';
      if (property.isFeatured) badgesHtml += '<span class="badge">Exclusivité</span>';
      propertyBadges.innerHTML = badgesHtml;
    }
    
    // Update property type
    const propertyType = document.getElementById('propertyType');
    if (propertyType) propertyType.textContent = property.type;
    
    // Update property features
    const propertyBedrooms = document.getElementById('propertyBedrooms');
    const propertyBathrooms = document.getElementById('propertyBathrooms');
    const propertyArea = document.getElementById('propertyArea');
    const propertyYear = document.getElementById('propertyYear');
    
    if (propertyBedrooms) propertyBedrooms.textContent = property.bedrooms;
    if (propertyBathrooms) propertyBathrooms.textContent = property.bathrooms;
    if (propertyArea) propertyArea.textContent = `${property.area} m²`;
    if (propertyYear) propertyYear.textContent = property.yearBuilt;
    
    // Update main image
    const mainPropertyImage = document.getElementById('mainPropertyImage');
    if (mainPropertyImage) {
      mainPropertyImage.src = property.images[0];
      mainPropertyImage.alt = property.title;
    }
    
    // Generate image thumbnails
    const galleryThumbnails = document.getElementById('galleryThumbnails');
    if (galleryThumbnails) {
      let thumbnailsHtml = '';
      property.images.forEach((image, index) => {
        thumbnailsHtml += `
          <div class="gallery-thumbnail ${index === 0 ? 'active' : ''}" data-index="${index}">
            <img src="${image}" alt="${property.title} - Image ${index + 1}">
          </div>
        `;
      });
      galleryThumbnails.innerHTML = thumbnailsHtml;
      
      // Add click event to thumbnails
      const thumbnails = document.querySelectorAll('.gallery-thumbnail');
      thumbnails.forEach(thumbnail => {
        thumbnail.addEventListener('click', function() {
          // Remove active class from all thumbnails
          thumbnails.forEach(t => t.classList.remove('active'));
          
          // Add active class to clicked thumbnail
          this.classList.add('active');
          
          // Update main image
          const imageIndex = parseInt(this.getAttribute('data-index'));
          mainPropertyImage.src = property.images[imageIndex];
        });
      });
    }
    
    // Update property description
    const propertyDescription = document.getElementById('propertyDescription');
    if (propertyDescription) {
      propertyDescription.innerHTML = `<p>${property.description}</p>`;
    }
    
    // Update property details
    const propertyDetails = document.getElementById('propertyDetails');
    if (propertyDetails) {
      let detailsHtml = '';
      property.details.forEach(detail => {
        detailsHtml += `<li><i class="icon-check"></i>${detail}</li>`;
      });
      propertyDetails.innerHTML = detailsHtml;
    }
    
    // Update property amenities
    const propertyAmenities = document.getElementById('propertyAmenities');
    if (propertyAmenities) {
      let amenitiesHtml = '';
      property.amenities.forEach(amenity => {
        amenitiesHtml += `<li><i class="icon-check"></i>${amenity}</li>`;
      });
      propertyAmenities.innerHTML = amenitiesHtml;
    }
    
    // Similar properties (filter out current property and take 2 at most)
    const similarPropertiesContainer = document.getElementById('similarProperties');
    if (similarPropertiesContainer) {
      const similarProps = properties.filter(p => p.id !== property.id).slice(0, 2);
      
      let similarPropsHtml = '';
      similarProps.forEach(prop => {
        similarPropsHtml += `
          <div class="similar-property">
            <div class="similar-property-img">
              <img src="${prop.images[0]}" alt="${prop.title}">
            </div>
            <div class="similar-property-content">
              <h4>${prop.title}</h4>
              <p>${prop.address}</p>
              <div class="similar-property-price">${formatPrice(prop.price)}</div>
              <a href="property-detail.html?id=${prop.id}" class="btn-link">Voir le bien</a>
            </div>
          </div>
        `;
      });
      
      similarPropertiesContainer.innerHTML = similarPropsHtml;
    }
    
    // Favorite button functionality
    const favoriteBtn = document.getElementById('favoriteBtn');
    if (favoriteBtn) {
      favoriteBtn.addEventListener('click', function() {
        this.classList.toggle('active');
        
        // Update icon and text
        if (this.classList.contains('active')) {
          this.innerHTML = '<i class="icon-heart active"></i> Retiré des favoris';
        } else {
          this.innerHTML = '<i class="icon-heart"></i> Ajouter aux favoris';
        }
      });
    }
  }

  // Initialize
  loadPropertyDetails();
});
