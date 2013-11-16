com.tsekmark.views.projects = {
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

    d3.json("flare.json", function(error, root) {
      var node = div.datum(root).selectAll(".node")
        .data(treemap.nodes)
        .enter().append("div")
        .attr("class", "node")
        .attr("title", function(d) { return d.children ? null : d.name; })
        .call(com.tsekmark.views.projects.position)
        .style("background", function(d) { return d.children ? color(d.name) : null; })
        .text(function(d) { return d.children ? null : d.name; });

      d3.selectAll("input").on("change", function change() {
        var value = this.value === "count"
          ? function() { return 1; }
          : function(d) { return d.size; };

        node
          .data(treemap.value(value).nodes)
          .transition()
          .duration(1500)
          .call(com.tsekmark.views.projects.position);


      });
    });

  },

  position: function(){
    this.style("left", function(d) { return d.x + "px"; })
      .style("top", function(d) { return d.y + "px"; })
      .style("width", function(d) { return Math.max(0, d.dx - 1) + "px"; })
      .style("height", function(d) { return Math.max(0, d.dy - 1) + "px"; });
    $('.node').tooltipster({
      theme: '.tooltipster-light'
    });
  },

  slabText: function(){
    $("div.box span").slabText({

    });
  },

  textFill: function(){
    $('.box').textfill({ maxFontPixels: 72 });
  },

  mason: function(){
    $("#collage").mason({
      itemSelector: ".box",
      ratio: 1.5,
      sizes: [
        [1,1],
        [1,2],
        [2,2]
      ],
      columns: [
        [0,480,1],
        [480,780,2],
        [780,1080,3],
        [1080,1320,4],
        [1320,1680,5]
      ],
      promoted: [
        [2,2,'promoted']
      ]
    },function(){
      com.tsekmark.views.projects.textFill();
    });
  }
}