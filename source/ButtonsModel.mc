class ButtonsModel {
  const OPERATORS = [ "0", "1", "2", "3", "4",
                      "5", "6", "7", "8", "9",
                      :BACKSPACE, :ENTER,
                      :ADD, :SUB, :MUL, :DIV,
                      :DECIMAL ];

  private var selected = 0;

  function initialize() {
    selected = 0;
  }

  function next() {
    selected--;
    if (selected < 0) {
      selected = size() - 1;
    }
  }

  function previous() {
    selected = (selected + 1) % size();
  }
  
  function at(n) {
    return OPERATORS[n];
  }

  function select(n) {
    selected = n;
  }

  function selectedIndex() {
    return selected;
  }

  function selectedItem() {
    return OPERATORS[selected];
  }
  
  function size() {
    return OPERATORS.size();
  }
}
