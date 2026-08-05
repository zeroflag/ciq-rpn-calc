using Toybox.Application as App;

// BUGS:
//  - multiple decimal
//  - entering digit when a result is available on TOS overwrites it instead of shifting it

class CalcApp extends App.AppBase {
  const MAX_DEPTH = 4;
  private var calc;
  private var buttonsModel;
  private var displayModel;

  function initialize() {
    AppBase.initialize();
    calc = new Calc(new Stack(MAX_DEPTH));
    buttonsModel = new ButtonsModel();
    displayModel = new DisplayModel(calc);
  }

  function getInitialView() {
    return [ new CalcView([new ButtonsView(buttonsModel),
                           new DisplayView(displayModel)]),
             new CalcController(buttonsModel, displayModel) ];
  }

}
