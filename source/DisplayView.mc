class DisplayView {
  const TEXT_COLOR = Graphics.COLOR_BLACK;
  const PENDING_TEXT_COLOR = Graphics.COLOR_DK_GRAY;
  const MAX_LEN = 9;
  const FONT = Graphics.FONT_MEDIUM;
  const FONT_HEIGHT = Graphics.getFontHeight(FONT);
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

    var xy = displayModel.xy();

    dc.drawText(
        x,
        y + (cellHeight - FONT_HEIGHT) / 2,
        FONT,
        trim(xy[0]), // NOS
        Graphics.TEXT_JUSTIFY_LEFT);

    var color = displayModel.hasPendingValue()
      ? PENDING_TEXT_COLOR
      : TEXT_COLOR;
    dc.setColor(color, Graphics.COLOR_WHITE);
    
    dc.drawText(
        x,
        y + cellHeight + (cellHeight - FONT_HEIGHT) / 2,
        FONT,
        trim(xy[1]), // TOS
        Graphics.TEXT_JUSTIFY_LEFT);
  }

  function trim(s) {
    if (s.length() > MAX_LEN) {
      return s.substring(0, MAX_LEN);
    }
    return s;
  }
}
