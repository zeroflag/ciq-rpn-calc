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
    } else if (token == :DECIMAL) {
      addDecimalPoint();
    } else if (token == :BACKSPACE) {
      backspace();
    } else if (token == :ENTER) {
      consume();
      calc.enter();
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

  private function consume() {
    if (buffer.length() != 0) {
      var n = buffer.find(".") != null
        ? buffer.toDouble()
        : buffer.toNumber();
      calc.push(n);
      buffer = "";
    }
    // System.println("Stack: " + calc.stack.toString());
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
      calc.setRegY(0);
    } 
  }

  function xy() {
    if (buffer.length() != 0)  {
      return [toStr(calc.getRegY()), buffer];
    } else {
      return [toStr(calc.getRegX()), toStr(calc.getRegY())] ;
    }
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
