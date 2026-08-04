using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Math;

class CalcView extends WatchUi.View {
  private var views;

  function initialize(viewsArray) {
    View.initialize();
    views = viewsArray;
  }

  function onLayout(dc) {
    setLayout(Rez.Layouts.MainLayout(dc));
  }

  function onUpdate(dc) {
    View.onUpdate(dc);
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    dc.clear();
    for (var i = 0; i < views.size(); i++) {
      views[i].draw(dc);
    }
  }
}
