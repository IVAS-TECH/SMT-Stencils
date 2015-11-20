// Generated by CoffeeScript 1.10.0
var gerberToSvg, identify;

gerberToSvg = require("gerber-to-svg");

identify = require("pcb-stackup/lib/layer-types").identify;

module.exports = function(files) {
  var bot, figs, file, i, len, out, outline, parse, top;
  top = bot = out = {};
  parse = function(gerber) {
    var svg, type;
    type = identify(gerber.path);
    svg = gerberToSvg(gerber.content, {
      object: true,
      drill: type === "drl"
    });
    if (type === "tsp") {
      top = svg;
    }
    if (type === "bsp") {
      bot = svg;
    }
    if (type === "out") {
      return out = svg;
    }
  };
  for (i = 0, len = files.length; i < len; i++) {
    file = files[i];
    parse(file);
  }
  top.svg.viewBox = out.svg.viewBox;
  top.svg.width = "80%";
  top.svg.height = "90%";
  outline = out.svg._[0].g._[0];
  figs = top.svg._[1].g._;
  top.svg["ng-class"] = "[(vm.stencil.position.side.toLowerCase().replace(' ', '-') || 'pcb-side'), (vm.stencil.style.lay ? 'stencil-layout' : 'stencil-centered')]";
  outline.path["ng-class"] = "vm.stencil.style.out ? 'stencil-outline' : 'stencil-no-outline'";
  figs.push(outline);
  return {
    top: gerberToSvg(top)
  };
};
