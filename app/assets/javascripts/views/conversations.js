com.tsekmark.views.conversations = {
  init: function(){
    this.bindBehaviors();
  },

  bindBehaviors: function(){
    $('#follower-typeahead').typeahead({
      name: 'term',
      remote: '/follower_list?term=%QUERY',
      limit: 10,
      rateLimitWait: 2000
    });

    $('#follower-typeahead').on("typeahead:selected typeahead:autocompleted", function(e,datum) {
      $('#message_recipient_id').prop('value',datum.id);
      $('#message_recipient_type').prop('value',datum.type);
    });

  }
}