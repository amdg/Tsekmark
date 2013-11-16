com.tsekmark.views.locations = {
  map: null,
  marker: null,

  init: function(){
    this.resizeWindow();
    this.bindBehaviors();
    com.tsekmark.views.cities.init();
    com.tsekmark.views.blasts.init();
  },

  bindBehaviors: function(){
  },

  resizeWindow: function(){
    // for google maps' sake
    if(!$('#map-canvas').length){
      return;
    }
    $(window).resize(function () {
      var h = $(window).height(),
        offsetTop = 60; // Calculate the top offset
      $('#map-canvas').css('height', (h - offsetTop));
    }).resize();

  },

  loadMap: function() {
    var $mapCanvas = $('#map-canvas');
    var self = com.tsekmark.views.locations;
    if(!$mapCanvas.length) {
      return false;
    }
    var city = new google.maps.LatLng($mapCanvas.data('lat'), $mapCanvas.data('long'));
    var mapOptions = {
      zoom: 7,
      center: city,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    self.map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    self.marker = new google.maps.Marker({
      map: self.map,
      draggable:true,
      animation: google.maps.Animation.DROP,
      position: city
    });

    google.maps.event.addListener(self.marker, 'click', self.toggleBounce);
  },

  toggleBounce: function(){
    var self = com.tsekmark.views.locations;
    if (self.marker.getAnimation() != null) {
      self.marker.setAnimation(null);
    } else {
      self.marker.setAnimation(google.maps.Animation.BOUNCE);
    }
  }
}

