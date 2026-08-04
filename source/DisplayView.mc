class DisplayView {
  const FONT = Graphics.FONT_MEDIUM;
  const FONT_HEIGHT = Graphics.getFontHeight(FONT);
  private var displayModel;

  public function initialize(aDisplayModel) {
    displayModel = aDisplayModel;
  }
  
  public function draw(dc) {
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    
    var displayWidth = dc.getWidth() / 2;
    var displayHeight = dc.getHeight() / 2;

    var x = (dc.getWidth()  - displayWidth) / 2;
    var y = (dc.getHeight() - displayHeight) / 2;

    var cellWidth = displayWidth;
    var cellHeight = displayHeight / 2;

    dc.drawLine(x, y + cellHeight, x + displayWidth, y + cellHeight);

    dc.drawText(
        x,
        y + (cellHeight - FONT_HEIGHT) / 2,
        FONT,
        "X: " + displayModel.getRegX(), // NOS
        Graphics.TEXT_JUSTIFY_LEFT);

    dc.drawText(
        x,
        y + cellHeight + (cellHeight - FONT_HEIGHT) / 2,
        FONT,
        "Y: " + displayModel.getRegY(), // TOS
        Graphics.TEXT_JUSTIFY_LEFT);
  }
}
