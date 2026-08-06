class DisplayModel {
  const DIGITS = ["0","1","2","3","4","5","6","7","8","9"];
  private var buffer = "";
  private var calc;

  function initialize(aCalc) {
    calc = aCalc; 
  }

  function eval(token) {
    if (isDigit(token)) {
      append(token);
    } else if (token == :DECIMAL) {
      addDecimalPoint();
    } else if (token == :BACKSPACE) {
      backspace();
    } else if (token == :ENTER) {
      enter();
    } else if (token == :ADD) {
      consume();
      calc.add();
    } else if (token == :SUB) {
      consume();
      calc.sub();
    } else if (token == :MUL) {
      consume();
      calc.mul();
    } else if (token == :DIV) {
      consume();
      calc.div();
    }
  }

  private function isDigit(token) {
    return DIGITS.indexOf(token) >= 0;
  }

  private function append(token) {
    if (buffer.equals("0")) {
      buffer = token;
    } else {
      buffer += token;
    }
  }

  private function enter() {
    if (buffer.length() == 0) {
      calc.dup();
    } else {
      consume();
    }
  }

  private function consume() {
    if (buffer.length() != 0) {
      calc.push(bufferValue());
      buffer = "";
    }
  }

  private function bufferValue() {
    var val = buffer.find(".") != null
      ? buffer.toDouble()
      : buffer.toLong();
    return val == null ? 0 : val;
  }

  private function addDecimalPoint() {
    var len = buffer.length();
    if (len == 0) {
      buffer = "0.";
    } else if (buffer.find(".") == null) {
      buffer += ".";
    }
  }

  private function backspace() {
    if (buffer.length() > 1) {
      buffer = buffer.substring(0, buffer.length() - 1);
    } else if (buffer.length() == 1 ) {
      buffer = "0";
    } else {
      calc.clearY();
    } 
  }

  function getRegY() {
    return calc.getRegY();
  }

  function getRegX() {
    return calc.getRegX();
  }

  function hasPendingValue() {
    return buffer.length() > 0;
  }

  function pendingValue() {
    return buffer;
  }
}
