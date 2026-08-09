class ButtonsView {
  const PADDING = 15;
  const FONT = Graphics.FONT_MEDIUM;
  const BK_COL = Graphics.COLOR_TRANSPARENT;
  const OPS = { :BACKSPACE => "C",
                :ENTER     => "E",
                :ADD       => "+",
                :SUB       => "–", // dash, not minus (- – —)
                :MUL       => "×",
                :DIV       => ":",
                :DECIMAL   => "." };
  private var model;
  private var palette;

  function initialize(aModel, aPalette) {
    model = aModel;
    palette = aPalette;
  }

  function draw(dc) {
    var degrees = -90.0;
    var step = 360.0 / model.size();
    for (var i = 0; i < model.size(); i++) {
      var centerX = dc.getWidth() / 2;
      var centerY = dc.getHeight() / 2;
      var radius = centerX - PADDING;
      var radian = Math.toRadians(degrees);
      var x = radius * Math.cos(radian) + centerX;
      var y = radius * Math.sin(radian) + centerY;

      drawHighlight(dc, i, x, y);
      drawButton(dc, i, x, y);

      degrees += step;
    }
  }

  private function drawHighlight(dc, i, x, y) {
    if (i == model.selectedIndex()) {
      dc.setColor(palette.displayFgColor, palette.displayBgColor);
      dc.fillCircle(x, y, Graphics.getFontHeight(FONT) / 2);
    }
  }

  private function drawButton(dc, i, x, y) {
    var button = model.at(i);
    chooseColor(i, dc);
    dc.drawText(
      x, y,
      FONT,
      translate(button),
      Graphics.TEXT_JUSTIFY_CENTER
      | Graphics.TEXT_JUSTIFY_VCENTER);
  }

  private function chooseColor(i, dc) {
    var item = model.at(i);
    if (i == model.selectedIndex()) {
      dc.setColor(palette.displayBgColor, BK_COL);
    } else if (item == :ENTER) {
      dc.setColor(palette.btnEnterColor, BK_COL);
    } else if (item == :BACKSPACE) {
      dc.setColor(palette.btnClearColor, BK_COL);
    } else if ([:DIV, :MUL, :SUB, :ADD].indexOf(item) >= 0) {
      dc.setColor(palette.btnOpsColor, BK_COL);
    } else {
      dc.setColor(palette.btnDigitsColor, BK_COL);
    }
  }

  private function translate(token) {
    var symbol = OPS[token];
    return symbol == null ? token : symbol;
  }
}
