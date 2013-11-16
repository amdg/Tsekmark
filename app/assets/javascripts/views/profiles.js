com.tsekmark.views.profiles = {
  init: function(){
    this.bindBehaviors();
  },

  bindBehaviors: function(){
    var $this = com.tsekmark.views.profiles;
    $(":file").filestyle({
      icon: true
    });

    $('#add_work_experience').on('click', $this)
  }
}