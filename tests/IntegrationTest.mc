import Toybox.Test;
import Toybox.WatchUi;

class Key extends WatchUi.KeyEvent {
  var key;
  function initialize(aKey) { key = aKey; }
  function getKey() { return key; }
}

class TestApp extends CalcApp {
  function initialize() {
    CalcApp.initialize();
  }

  function select(operator) {
    while (!buttonsModel.selectedItem().equals(operator)) {
      ctrl.onKey(new Key(WatchUi.KEY_UP));
    }
    ctrl.onKey(new Key(WatchUi.KEY_ENTER));
  }

  function stackOnlyContains(n) {
    Test.assert(stack.size() == 1 && stack.tos() == n);
    return true;
  }

  function stackContains(anArray) {
    Test.assert(stack.size() == anArray.size());
    for (var i = 0; i < stack.size(); i++) {
      Test.assert(stack.at(i) == anArray[i]);
    }
    return true;
  }
}
  
(:test)
function smokeTest(logger as Logger) {
  var app = new TestApp();
  app.select("3");
  app.select(:ENTER);
  app.select(:MUL);
  return app.stackOnlyContains(9);
}

(:test)
function backspaceTest(logger as Logger) {
  var app = new TestApp();
  app.select("4");
  app.select("5");
  app.select("6");
  app.select(:BACKSPACE);
  app.select(:BACKSPACE);
  app.select(:ENTER);
  app.select(:MUL);
  return app.stackOnlyContains(16);
}

(:test)
function testStackTest(logger as Logger) { // TODO
  var app = new TestApp();
  app.select("4");
  app.select("7");
  app.select(:ENTER);
  app.select("2");
  app.select("3");
  app.select(:ADD);
  return app.stackOnlyContains(70);
}

(:test)
function testUnderflow(logger as Logger) {
  var app = new TestApp();
  app.select("4");
  app.select(:ADD);
  return app.stackOnlyContains(4);
}

(:test)
function floatTest(logger as Logger) {
  var app = new TestApp();
  app.select("2");
  app.select(:DECIMAL);
  app.select("5");
  app.select(:ENTER);
  app.select(:ADD);
  return app.stackOnlyContains(5);
}

(:test)
function multipleDecimalTest(logger as Logger) {
  var app = new TestApp();
  app.select("2");
  app.select(:DECIMAL);
  app.select(:DECIMAL);
  app.select("5");
  app.select(:DECIMAL);
  app.select(:ENTER);
  app.select(:ADD);
  return app.stackOnlyContains(5);
}

(:test)
function enteringNewNumberOnTopOfExistingResult(logger as Logger) {
  var app = new TestApp();
  app.select("1");
  app.select("2");
  app.select(:ENTER);
  app.select(:ADD);
  app.select("6");
  app.select(:ADD);
  return app.stackOnlyContains(30);
}

(:test)
function backspaceOnExistingResult(logger as Logger) {
  var app = new TestApp();
  app.select("1");
  app.select(:ENTER);
  app.select(:MUL);
  app.select("2");
  app.select(:ENTER);
  app.select(:MUL);
  app.select(:BACKSPACE);
  return app.stackContains([1, 0]);
}
