using Toybox.WatchUi;

class CalcController extends WatchUi.InputDelegate {
  private var buttonsModel;
  private var displayModel;

  function initialize(aButtonsModel, aDisplayModel) {
    InputDelegate.initialize();
    buttonsModel = aButtonsModel;
    displayModel = aDisplayModel;
  }

  function onKey(keyEvent) {
    switch (keyEvent.getKey()) {
      case KEY_UP:
        buttonsModel.next();
        refresh();
        return true;
      case KEY_DOWN:
        buttonsModel.previous();
        refresh();
        return true;
      case KEY_ENTER:
        displayModel.eval(buttonsModel.selectedItem());
        refresh();
        return true;
      default:
        return false;
    }
  }

  private function refresh() {
     WatchUi.requestUpdate();
  }
}
