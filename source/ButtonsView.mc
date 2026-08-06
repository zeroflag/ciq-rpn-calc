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

  function initialize(aModel) {
    model = aModel;
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
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    } else if (i <= 9) {
      dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_WHITE);
    } else if (i <= 10) {
      dc.setColor(Graphics.COLOR_DK_RED, Graphics.COLOR_WHITE);
    } else if (i <= 11) {
      dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_WHITE);
    } else {
      dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    }
  }

  private function translate(token) {
    var symbol = OPS[token];
    return symbol == null ? token : symbol;
  }
}
