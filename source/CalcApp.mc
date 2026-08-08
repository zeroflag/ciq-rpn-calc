using Toybox.Application as App;

class CalcApp extends App.AppBase {
  protected var calc;
  protected var buttonsModel;
  protected var displayModel;
  protected var stack;
  protected var ctrl;
  protected var view;

  function initialize() {
    AppBase.initialize();
    stack = new Stack(getProperty("stackSize"), 0L);
    calc = new Calc(stack);
    buttonsModel = new ButtonsModel();
    displayModel = new DisplayModel(calc);
    var palette = new Palette(self);
    ctrl = new CalcController(buttonsModel, displayModel);
    view = new CalcView(palette,
                        [new ButtonsView(buttonsModel, palette),
                         new DisplayView(displayModel, palette)]);
  }

  function getInitialView() {
    return [ view, ctrl ];
  }
}
