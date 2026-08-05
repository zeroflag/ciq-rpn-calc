import Toybox.Test;
import Toybox.WatchUi;

class Key extends WatchUi.KeyEvent {
  var key;
  function initialize(aKey) { key = aKey; }
  function getKey() { return key; }
}

class SUT {
  var stack;
  var calc;
  var buttonsModel;
  var displayModel;
  var ctrl;

  function initialize() {
    stack = new Stack(4);
    calc = new Calc(stack);
    buttonsModel = new ButtonsModel();
    displayModel = new DisplayModel(calc);
    ctrl = new CalcController(buttonsModel, displayModel);
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
  var sut = new SUT();
  sut.select("3");
  sut.select(:ENTER);
  sut.select(:MUL);
  return sut.stackOnlyContains(9);
}

(:test)
function backspaceTest(logger as Logger) {
  var sut = new SUT();
  sut.select("4");
  sut.select("5");
  sut.select("6");
  sut.select(:BACKSPACE);
  sut.select(:BACKSPACE);
  sut.select(:ENTER);
  sut.select(:MUL);
  return sut.stackOnlyContains(16);
}

(:test)
function testStackTest(logger as Logger) { // TODO
  var sut = new SUT();
  sut.select("4");
  sut.select("7");
  sut.select(:ENTER);
  sut.select("2");
  sut.select("3");
  sut.select(:ADD);
  return sut.stackOnlyContains(70);
}

(:test)
function floatTest(logger as Logger) {
  var sut = new SUT();
  sut.select("2");
  sut.select(:DECIMAL);
  sut.select("5");
  sut.select(:ENTER);
  sut.select(:ADD);
  return sut.stackOnlyContains(5);
}

(:test)
function multipleDecimalTest(logger as Logger) {
  var sut = new SUT();
  sut.select("2");
  sut.select(:DECIMAL);
  sut.select(:DECIMAL);
  sut.select("5");
  sut.select(:DECIMAL);
  sut.select(:ENTER);
  sut.select(:ADD);
  return sut.stackOnlyContains(5);
}

(:test)
function enteringNewNumberOnTopOfExistingResult(logger as Logger) {
  var sut = new SUT();
  sut.select("1");
  sut.select("2");
  sut.select(:ENTER);
  sut.select(:ADD);
  sut.select("6");
  sut.select(:ADD);
  return sut.stackOnlyContains(30);
}

(:test)
function backspaceOnExistingResult(logger as Logger) {
  var sut = new SUT();
  sut.select("1");
  sut.select(:ENTER);
  sut.select(:MUL);
  sut.select("2");
  sut.select(:ENTER);
  sut.select(:MUL);
  sut.select(:BACKSPACE);
  return sut.stackContains([1, 0]);
}
