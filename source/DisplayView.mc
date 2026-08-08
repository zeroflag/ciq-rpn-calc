class DisplayView {
  private var displayModel;
  private var palette;

  function initialize(aDisplayModel, aPalette) {
    displayModel = aDisplayModel;
    palette = aPalette;
  }
  
  function draw(dc) {
    var displayWidth = dc.getWidth() / 2;
    var displayHeight = dc.getHeight() / 2;

    var x = (dc.getWidth()  - displayWidth) / 2;
    var y = (dc.getHeight() - displayHeight) / 2;

    var cellWidth = displayWidth;
    var cellHeight = displayHeight / 2;

    dc.setColor(palette.displayFgColor, palette.displayBgColor);
    dc.drawLine(x, y + cellHeight, x + displayWidth, y + cellHeight);

    var xy = registers();
    // NOS
    drawRegister(dc, x, y, xy[0], cellWidth, cellHeight);

    var color = displayModel.hasPendingValue()
      ? palette.pendingTextColor
      : palette.displayFgColor;
    dc.setColor(color, palette.displayBgColor);
    // TOS 
    drawRegister(dc, x, y + cellHeight, xy[1], cellWidth, cellHeight);

    /* dc.drawRectangle(x, y, cellWidth, cellHeight); */
    /* dc.drawRectangle(x, y + cellHeight, cellWidth, cellHeight); */
  }

  private function drawRegister(dc, x, y, text, w, h) {
    var font = Graphics.FONT_MEDIUM;
    if (Graphics.fitTextToArea(text, font, w, h, false) == null) {
      font = Graphics.FONT_SMALL; 
      text = Graphics.fitTextToArea(text, font, w, h, true);
    }
    var d = dc.getTextDimensions(text, font);
    dc.drawText(
      x,
      y + (h - d[1]) / 2,
      font,
      text,
      Graphics.TEXT_JUSTIFY_LEFT);
  }

  private function registers() {
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
