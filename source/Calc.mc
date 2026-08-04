class Calc {
  var stack;

  function initialize(aStack) {
    stack = aStack; 
  }

  function add() {
    if (!hasItems(2)) { return; }
    stack.push(stack.pop() + stack.pop());
  }

  function sub() {
    if (!hasItems(2)) { return; }
    var a = stack.pop(); 
    var b = stack.pop(); 
    stack.push(b - a);
  }

  function mul() {
    if (!hasItems(2)) { return; }
    stack.push(stack.pop() * stack.pop());
  }

  function div() {
    if (!hasItems(2)) { return; }
    var a = stack.pop(); 
    var b = stack.pop(); 
    stack.push(a == 0 ? 0 : b / a);
  }

  function dup() {
    stack.push(stack.tos());
  }

  function setRegY(n) {
    if (!stack.isEmpty()) {
      stack.pop(); 
    }
    stack.push(n);
  }

  function getRegY() {
    return stack.tos();
  }

  function getRegX() {
    return stack.nos();
  }

  private function hasItems(n) {
    return stack.size() >= n;
  }
}
