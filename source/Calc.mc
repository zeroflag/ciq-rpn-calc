class Calc {
  var stack;

  function initialize(aStack) {
    stack = aStack; 
  }

  function push(n) {
    stack.push(n);
  }
  
  function add() {
    stack.push(stack.pop() + stack.pop());
  }

  function sub() {
    var a = stack.pop(); 
    var b = stack.pop(); 
    stack.push(b - a);
  }

  function mul() {
    stack.push(stack.pop() * stack.pop());
  }

  function div() {
    var a = stack.pop(); 
    var b = stack.pop(); 
    stack.push(a == 0 ? 0 : b / a);
  }

  function enter() {
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
}
