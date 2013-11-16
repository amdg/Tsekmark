com = {
  tsekmark : {
    util    : {},
    views   : {},
    widgets : {},
    lib : {},
    init: function() {
      $("abbr.timeago").timeago();
      $('textarea').autosize();
      $('.tooltip').tooltipster({
        theme: '.tooltipster-light'
      });
      $(function () {
        $('.checkall').on('click', function () {
          $(this).closest('form').find(':checkbox').prop('checked', this.checked);
        });
      });
    }
  }
};

// stub for innerShiv for non-IE browsers - http://bit.ly/ishiv
if(window.innerShiv === undefined) {
  window.innerShiv = function(html){
    return html;
  };
}