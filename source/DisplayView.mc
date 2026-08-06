class DisplayView {
  const TEXT_COLOR = Graphics.COLOR_BLACK;
  const PENDING_TEXT_COLOR = Graphics.COLOR_DK_RED;
  private var displayModel;

  public function initialize(aDisplayModel) {
    displayModel = aDisplayModel;
  }
  
  public function draw(dc) {
    var displayWidth = dc.getWidth() / 2;
    var displayHeight = dc.getHeight() / 2;

    var x = (dc.getWidth()  - displayWidth) / 2;
    var y = (dc.getHeight() - displayHeight) / 2;

    var cellWidth = displayWidth;
    var cellHeight = displayHeight / 2;

    dc.setColor(TEXT_COLOR, Graphics.COLOR_WHITE);

    dc.drawLine(x, y + cellHeight, x + displayWidth, y + cellHeight);

    var xy = registers();
    // NOS
    drawRegister(dc, x, y, xy[0], cellWidth, cellHeight);

    var color = displayModel.hasPendingValue()
      ? PENDING_TEXT_COLOR
      : TEXT_COLOR;
    dc.setColor(color, Graphics.COLOR_WHITE);
    // TOS 
    drawRegister(dc, x, y + cellHeight, xy[1], cellWidth, cellHeight);
  }

  function drawRegister(dc, x, y, text, w, h) {
    var font = Graphics.FONT_MEDIUM;
    if (Graphics.fitTextToArea(text, font, w, h, false) == null) {
      font = Graphics.FONT_SMALL; 
      text = Graphics.fitTextToArea(text, font, w, h, true);
    }
    dc.drawText(
      x,
      y + (h - Graphics.getFontHeight(font)) / 2,
      font,
      text,
      Graphics.TEXT_JUSTIFY_LEFT);
  }

  function registers() {
    return displayModel.hasPendingValue()
      ? [toStr(displayModel.getRegY()),
          displayModel.pendingValue()]
      : [toStr(displayModel.getRegX()),
         toStr(displayModel.getRegY())];
  }

  private function toStr(n) {
    if (n == 0) {
      return "0.000000";
    } else if (n instanceof Double
               || n instanceof Float)
    {
      return n.format("%.6f");
    } else {
      return n.toString();
    }
  }
}
