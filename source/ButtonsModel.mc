class ButtonsModel {
  const SELECTED = 2;
  const OPERATORS = [ "0", "1", "2", "3", "4",
                      "5", "6", "7", "8", "9",
                      :BACKSPACE, :ENTER,
                      :DIV, :MUL, :SUB, :ADD, 
                      :DECIMAL ];

  private var index = 0;

  function initialize() {
    next();
  }

  function next() {
    index--;
    if (index < 0) {
      index = size() - 1;
    }
  }

  function previous() {
    index = (index + 1) % size();
  }
  
  function at(n) {
    return OPERATORS[(index + n) % size()];
  }

  function selectedIndex() {
    return SELECTED;
  }

  function selectedItem() {
    return at(SELECTED);
  }
  
  function size() {
    return OPERATORS.size();
  }
}
