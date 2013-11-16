com.tsekmark.views.sectors = {
  init: function(){
    this.bindBehaviors();
  },

  bindBehaviors: function(){
//    com.tsekmark.views.projects.mason();
    var margin = {top: 40, right: 10, bottom: 10, left: 10},
      width = 1280,
      height = 550 - margin.top - margin.bottom;

    var color = d3.scale.category20c();

    var treemap = d3.layout.treemap()
      .size([width, height])
      .sticky(true)
      .value(function(d) { return d.size; });

    var div = d3.select("#collage1").append("div")
      .style("position", "relative")
      .style("width", (width + margin.left + margin.right) + "px")
      .style("height", (height + margin.top + margin.bottom) + "px")
      .style("left", margin.left + "px");

    d3.json("sectors/list", function(error, root) {
      var node = div.datum(root).selectAll(".node")
        .data(treemap.nodes)
        .enter().append("div")
        .attr("class", "node")
        .attr("data-id", function(d) { return d.id; })
        .attr("title", function(d) { return d.children ? null : d.name; })
        .call(com.tsekmark.views.sectors.position)
        .style("background", function(d) { return d.children ? color(d.name) : null; })

      node.append("span").text(function(d) { return d.children ? null : d.name; });
      node.append("a").attr("href", function(d) { return "departments/"+ d.id; });

      d3.selectAll("button").on("click", function change() {

        if($(this).hasClass('buzz-filter')) {
          var value = function(d) { return d.buzz; }
        } else if($(this).hasClass('size-filter')) {
          var value = function(d) { return d.size; }
        } else if($(this).hasClass('count-filter')) {
          var value = function() { return 1; }
        } else if($(this).hasClass('upvote-filter')){
          var value = function(d) { return d.upvotes; }
        } else if($(this).hasClass('downvote-filter')){
          var value = function(d) { return d.downvotes; }
        }

        $('h1.header-text').text($(this).data('htext'));
        node
          .data(treemap.value(value).nodes)
          .transition()
          .duration(1500)
          .call(com.tsekmark.views.sectors.position)
          .each("end", _.once(com.tsekmark.views.sectors.textFill) );


      });
      com.tsekmark.views.sectors.textFill();
    });
    $('.btn-lg').tooltipster({
      theme: '.tooltipster-light'
    });
  },

  position: function(){
    this.style("left", function(d) { return d.x + "px"; })
      .style("top", function(d) { return d.y + "px"; })
      .style("width", function(d) { return Math.max(0, d.dx - 1) + "px"; })
      .style("height", function(d) { return Math.max(0, d.dy - 1) + "px"; });
  },

  textFill: function(){
    $('.node').textfill({ maxFontPixels: 72 });
    $('.node').tooltipster({
      theme: '.tooltipster-light'
    });
  }
}