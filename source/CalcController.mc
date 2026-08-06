using Toybox.WatchUi;
using Toybox.Timer;

class CalcController extends WatchUi.InputDelegate {
  const INTERVAL = 250;
  private var buttonsModel;
  private var displayModel;
  private var timer;
  private var timerRunning = false;
  private var direction = 0;
  private var stepCounter = 0;

  function initialize(aButtonsModel, aDisplayModel) {
    InputDelegate.initialize();
    buttonsModel = aButtonsModel;
    displayModel = aDisplayModel;
    timer = new Timer.Timer();
  }

  function onKey(keyEvent) {
    switch (keyEvent.getKey()) {
      case KEY_ENTER:
        displayModel.eval(buttonsModel.selectedItem());
        refresh();
        return true;
      default:
        return false;
    }
  }

  function onKeyPressed(keyEvent) {
    switch (keyEvent.getKey()) {
      case KEY_UP:
        direction = 0;
        startTimer();
        return true;
      case KEY_DOWN:
        direction = 1;
        startTimer();
        return true;
      default:
        return false;
    }
  }

  function onKeyReleased(keyEvent) {
    switch (keyEvent.getKey()) {
      case KEY_UP:
        stopTimer();
        if (stepCounter == 0) {
          buttonsModel.next();
          refresh();
        }
        return true;
      case KEY_DOWN:
        stopTimer();
        if (stepCounter == 0) {
          buttonsModel.previous();
          refresh();
        }
        return true;
      default:
        return false;
    }
  }

  private function startTimer() {
    if (!timerRunning) {
      stepCounter = 0;
      timer.start(method(:step), INTERVAL, true);
      timerRunning = true;
    }
  }

  private function stopTimer() {
    timer.stop();
    timerRunning = false;
  }

  function step() {
    stepCounter += 1;
    if (direction == 0) {
      buttonsModel.next();
    } else {
      buttonsModel.previous();
    }
    refresh();
  }

  private function refresh() {
     WatchUi.requestUpdate();
  }
}
