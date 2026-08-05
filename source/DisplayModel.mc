class DisplayModel {
  const DIGITS = ["0","1","2","3","4","5","6","7","8","9"];
  private var buffer = "";
  private var calc;

  function initialize(aCalc) {
    calc = aCalc; 
  }

  function eval(token) {
    if (isDigit(token)) {
      buffer += token;
      updateTos();
    } else if (token == :DECIMAL) {
      addDecimalPoint();
    } else if (token == :BACKSPACE) {
      backspace();
      updateTos();
    } else if (token == :ENTER) {
      calc.dup();
      clearBuffer();
    } else if (token == :ADD) {
      calc.add();
      clearBuffer();
    } else if (token == :SUB) {
      calc.sub();
      clearBuffer();
    } else if (token == :MUL) {
      calc.mul();
      clearBuffer();
    } else if (token == :DIV) {
      calc.div();
      clearBuffer();
    }
  }

  private function isDigit(token) {
    return DIGITS.indexOf(token) >= 0;
  }

  private function updateTos() {
    var n = buffer.find(".") != null
      ? buffer.toDouble()
      : buffer.toNumber();
    calc.setRegY(n);
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
    if (buffer.length() > 0) {
      buffer = buffer.substring(0, buffer.length() - 1);
    }  
  }

  private function clearBuffer() {
    buffer = "";
 // TODO remove
    System.println("Stack: " + calc.stack.toString());
  }

  function getRegX() {
    return toStr(calc.getRegX());
  }

  function getRegY() {
    return buffer.length() != 0
      ? buffer
      : toStr(calc.getRegY());
  }

  private function toStr(n) {
    if (n == null) {
      return "0.0000";
    } else if (n instanceof Double
               || n instanceof Float)
    {
      return n.format("%.4f");
    } else {
      return n.toString();
    }
  }
}
