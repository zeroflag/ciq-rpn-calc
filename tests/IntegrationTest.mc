import Toybox.Test;
import Toybox.WatchUi;
import Toybox.System;

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
      ctrl.onKeyPressed(new Key(WatchUi.KEY_UP));
      ctrl.onKeyReleased(new Key(WatchUi.KEY_UP));
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

  function stackIsEmpty() {
    Test.assert(stack.size() == 0);
    return true;
  }

  function printStack() {
    System.println("Stack: " + stack);
  }

  function typeNumber(str) {
    for (var i = 0; i < str.length(); i++) {
      select(str.substring(i, i+1));
    }
  }
}
  
(:test)
function testSmoke(logger as Logger) {
  var app = new TestApp();
  app.select("3");
  app.select(:ENTER);
  app.select("3");
  app.select(:MUL);
  return app.stackOnlyContains(9);
}

(:test)
function testBackspace(logger as Logger) {
  var app = new TestApp();
  app.select("4");
  app.select("5");
  app.select("6");
  app.select(:BACKSPACE);
  app.select(:BACKSPACE);
  app.select(:ENTER);
  return app.stackOnlyContains(4);
}

(:test)
function testEmptyBackspace(logger as Logger) {
  var app = new TestApp();
  app.select(:BACKSPACE);
  app.select(:BACKSPACE);
  return app.stackIsEmpty();
}

(:test)
function testBinaryOp(logger as Logger) {
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
function testDecimalMany(logger as Logger) {
  var app = new TestApp();
  app.select("2");
  app.select(:DECIMAL);
  app.select(:DECIMAL);
  app.select("5");
  app.select(:DECIMAL);
  app.select(:ENTER);
  return app.stackOnlyContains(2.5);
}

(:test)
function testBackspaceOnTOS(logger as Logger) {
  var app = new TestApp();
  app.select("1");
  app.select(:ENTER);
  app.select("2");
  app.select(:ENTER);
  app.select(:BACKSPACE);
  return app.stackContains([1, 0]);
}

(:test)
function testMaxDepth(logger as Logger) {
  var app = new TestApp();
  app.select("2");
  app.select(:ENTER);
  app.select("3");
  app.select(:ENTER);
  app.select("4");
  app.select(:ENTER);
  app.select("5");
  app.select(:ENTER);
  app.printStack();
  for (var i = 0; i < 4; i++) {
    app.select(:ADD);
  }
  return app.stackOnlyContains(14);
}

(:test)
function testDiscardOnOverflow(logger as Logger) {
  var app = new TestApp();
  app.select("2");
  app.select(:ENTER);
  app.select("3");
  app.select(:ENTER);
  app.select("4");
  app.select(:ENTER);
  app.select("5");
  app.select(:ENTER);
  app.select("6");
  app.printStack();
  for (var i = 0; i < 4; i++) {
    app.select(:ADD);
  }
  return app.stackOnlyContains(18);
}

(:test)
function testFloatingPoint(logger as Logger) {
  var app = new TestApp();
  app.select("5");
  app.select(:ENTER);
  app.select("2");
  app.select(:DIV);
  app.printStack();
  return app.stackOnlyContains(2.5);
}

(:test)
function testMultipleEnterAsDup(logger as Logger) {
  var app = new TestApp();
  app.select("5");
  app.select(:ENTER);
  app.select(:ENTER);
  return app.stackContains([5, 5]);
}

(:test)
function testBignum(logger as Logger) {
  var app = new TestApp();
  app.typeNumber("65536");
  app.select(:ENTER);
  app.select(:ENTER);
  app.select(:MUL);
  return app.stackOnlyContains(4294967296L);
}

(:test)
function testEnterBigNum(logger as Logger) {
  var app = new TestApp();
  app.typeNumber("4294967296");
  app.select(:ENTER);
  return app.stackOnlyContains(4294967296L);
}

(:test)
function testEnterOutOfRangeNumber(logger as Logger) {
  var app = new TestApp();
  app.typeNumber("18446744073709551616");
  app.select(:ENTER);
  return app.stackOnlyContains(0);
}
