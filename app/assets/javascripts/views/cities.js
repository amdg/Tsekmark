com.tsekmark.views.cities = {
  init: function(){
    this.bindBehaviors();
  },

  bindBehaviors: function(){
    $('#city-typeahead').typeahead({
      name: 'business[location]',
      remote: '/locations?term=%QUERY',
      limit: 10,
      rateLimitWait: 2000
    });

    $('#city-typeahead').on("typeahead:selected typeahead:autocompleted", function(e,datum) {
      $('#location_id').prop('value',datum.id);
    });
  }
}