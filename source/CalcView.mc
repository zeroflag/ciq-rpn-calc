using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Math;

class CalcView extends WatchUi.View {
  private var views;
  private var palette;

  function initialize(aPalette, viewsArray) {
    View.initialize();
    palette = aPalette;
    views = viewsArray;
  }

  function onLayout(dc) {
    setLayout(Rez.Layouts.MainLayout(dc));
  }

  function onUpdate(dc) {
    View.onUpdate(dc);
    dc.setColor(palette.displayFgColor, palette.displayBgColor);
    dc.clear();
    for (var i = 0; i < views.size(); i++) {
      views[i].draw(dc);
    }
  }
}
