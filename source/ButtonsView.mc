class ButtonsView {
  const PADDING = 15;
  const FONT = Graphics.FONT_MEDIUM;
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
      chooseColor(i, dc);
      drawButton(dc, degrees, i);
      degrees += step;
    }
  }

  private function drawButton(dc, degrees, i) {
    var button = model.at(i);
    var centerX = dc.getWidth() / 2;
    var centerY = dc.getHeight() / 2;
    var radius = centerX - PADDING;
    var radian = Math.toRadians(degrees);
    dc.drawText(
      radius * Math.cos(radian) + centerX,
      radius * Math.sin(radian) + centerY,
      FONT,
      translate(button),
      Graphics.TEXT_JUSTIFY_CENTER
      | Graphics.TEXT_JUSTIFY_VCENTER);
  }

  private function chooseColor(i, dc) {
    if (i == model.selectedIndex()) {
      dc.setColor(palette.displayBgColor, palette.displayFgColor); // invert
    } else if (i <= 9) {
      dc.setColor(palette.btnDigitsColor, palette.displayBgColor);
    } else if (i <= 10) {
      dc.setColor(palette.btnClearColor, palette.displayBgColor);
    } else if (i <= 11) {
      dc.setColor(palette.btnEnterColor, palette.displayBgColor);
    } else {
      dc.setColor(palette.btnOpsColor, palette.displayBgColor);
    }
  }

  private function translate(token) {
    var symbol = OPS[token];
    return symbol == null ? token : symbol;
  }
}
