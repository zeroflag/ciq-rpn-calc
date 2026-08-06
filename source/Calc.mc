class Calc {
  var stack;

  function initialize(aStack) {
    stack = aStack; 
  }

  function add() {
    push(pop() + pop());
  }

  function sub() {
    var a = pop(); 
    var b = pop(); 
    push(b - a);
  }

  function mul() {
    push(pop() * pop());
  }

  function div() {
    var a = pop(); 
    var b = pop(); 
    push(a == 0 ? 0 : b / a.toDouble());
  }

  function push(n) {
    if (n instanceof Number) {
      stack.push(n.toLong());
    } else {
      stack.push(n);
    }
  }

  function pop() {
    return stack.pop();
  }
  
  function dup() {
    push(stack.tos());
  }
  
  function clearY() {
    if (!stack.isEmpty()) {
      pop(); 
      push(0);
    }
  }

  function getRegY() {
    return stack.tos();
  }

  function getRegX() {
    return stack.nos();
  }
}
