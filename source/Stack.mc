class Stack {
  var stack = [];
  var capacity;
  var sp = 0;

  function initialize(n) {
    capacity = n;
    for (var i = 0; i < capacity; i++) {
      stack.add(0);
    }
  }

  function push(v) {
    if (isFull()) {
      discard();
      sp--;
    }
    stack[sp] = v;
    sp++;
  }

  private function discard() {
    for (var i = 1; i < sp; i++) {
      stack[i-1] = stack[i];
    }
  }

  function pop() {
    if (isEmpty()) {
      return null;
    }
    sp--;
    return stack[sp];
  }

  function isEmpty() {
    return sp == 0;
  }

  function isFull() {
    return sp >= capacity;
  }

  function tos() {
    return isEmpty() ? null : stack[sp - 1];
  }

  function nos() {
    return size() < 2 ? null : stack[sp - 2];
  }

  function setTos(v) {
    if (isEmpty()) {
      push(v);
    } else {
      stack[sp -1] = v;
    }
  }

  function size() {
    return sp;
  }

  function at(i) {
    return stack[i];
  }

  function toString() {
    var s = "";
    for (var i = 0; i < size(); i++) {
      s += stack[i];
      s += " ";
    }
    return s;
  }
}
