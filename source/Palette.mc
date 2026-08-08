class Palette {
  var btnDigitsColor;
  var btnEnterColor;
  var btnClearColor;
  var btnOpsColor;
  var displayFgColor;
  var displayBgColor;
  var pendingTextColor;

  function initialize(app) {
    btnDigitsColor   = color(app.getProperty("btnDigitsColor"));
    btnEnterColor    = color(app.getProperty("btnEnterColor"));
    btnClearColor    = color(app.getProperty("btnClearColor"));
    btnOpsColor      = color(app.getProperty("btnOpsColor"));
    displayFgColor   = color(app.getProperty("displayFgColor"));
    displayBgColor   = color(app.getProperty("displayBgColor"));
    pendingTextColor = color(app.getProperty("pendingTextColor"));
  }

  private function color(value) {
    switch (value) {
      case 1:
        return Graphics.COLOR_WHITE;
      case 2:
        return Graphics.COLOR_LT_GRAY;
      case 3:
        return Graphics.COLOR_DK_GRAY;
      case 4:
        return Graphics.COLOR_BLACK;
      case 5:
        return Graphics.COLOR_RED;
      case 6:
        return Graphics.COLOR_DK_RED;
      case 7:
        return Graphics.COLOR_ORANGE;
      case 8:
        return Graphics.COLOR_YELLOW;
      case 9:
        return Graphics.COLOR_GREEN;
      case 10:
        return Graphics.COLOR_DK_GREEN;
      case 11:
        return Graphics.COLOR_BLUE;
      case 12:
        return Graphics.COLOR_DK_BLUE;
      case 13:
        return Graphics.COLOR_PURPLE;
      default:
        throw new InvalidOptionsException("Invalid color value: " + value);
    }
  }
}
