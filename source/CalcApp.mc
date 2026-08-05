using Toybox.Application as App;

class CalcApp extends App.AppBase {
  const MAX_DEPTH = 4;
  protected var calc;
  protected var buttonsModel;
  protected var displayModel;
  protected var stack;
  protected var ctrl;
  protected var view;

  function initialize() {
    AppBase.initialize();
    stack = new Stack(MAX_DEPTH);
    calc = new Calc(stack);
    buttonsModel = new ButtonsModel();
    displayModel = new DisplayModel(calc);
    ctrl = new CalcController(buttonsModel, displayModel);
    view = new CalcView([new ButtonsView(buttonsModel),
                         new DisplayView(displayModel)]);
  }

  function getInitialView() {
    return [ view, ctrl ];
  }

}
