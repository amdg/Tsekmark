com.tsekmark.views.blasts = {
  init: function(){
    this.bindBehaviors();
  },

  bindBehaviors: function(){
    $('.list-comments').on('click',function(e){
      e.preventDefault();
      var $blast = $(this).closest('div.blast');
      $blast.find('div.comments-list').slideToggle();
    });

    var area = document.getElementById('blast_body');
    var $ctr = $('span#chr_counter');
    var remaining_chars = 240;
    var btn_disabled = false;

    Countable.live(area, function (counter) {
      remaining_chars = 240 - counter.all;
      btn_disabled = (remaining_chars <= 0) ? true : false;
      $('#post-blast').prop('disabled', btn_disabled);
      $ctr.html(remaining_chars);
    });
  }
};