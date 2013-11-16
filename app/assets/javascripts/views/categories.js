com.tsekmark.views.categories = {
  init: function(){
    this.bindBehaviors();
  },

  bindBehaviors: function(){
    $('#category-typeahead').typeahead({
      name: 'term',
      remote: '/business_categories?term=%QUERY',
      limit: 10,
      rateLimitWait: 2000
    });

    $('#category-typeahead').on("typeahead:selected typeahead:autocompleted", function(e,datum) {
      $('#category_id').prop('value',datum.id);
    });
  }
}