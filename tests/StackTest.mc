import Toybox.Test;

function createStack(size) {
  return new Stack(size, null);
}

(:test)
function stackCreatedAsEmpty(logger as Logger) {
  var stack = createStack(4);
  return stack.isEmpty();
}

(:test)
function stackSizeAfterPush(logger as Logger) {
  var stack = createStack(4);
  stack.push(2);
  Test.assert(stack.size() == 1);
  stack.push(3);
  return stack.size() == 2;
}

(:test)
function stackSizeAfterPop(logger as Logger) {
  var stack = createStack(4);
  stack.push(2);
  stack.push(3);
  Test.assert(stack.size() == 2);
  stack.pop();
  return stack.size() == 1;
}

(:test)
function stackFull(logger as Logger) {
  var stack = createStack(2);
  stack.push(2);
  Test.assert(!stack.isEmpty());
  Test.assert(!stack.isFull());
  stack.push(3);
  return stack.isFull();
}

(:test)
function stackTos(logger as Logger) {
  var stack = createStack(4);
  Test.assert(stack.tos() == null);
  stack.push(123);
  Test.assert(stack.tos() == 123);
  stack.push(456);
  Test.assert(stack.tos() == 456);
  stack.pop();
  Test.assert(stack.tos() == 123);
  return true;
}

(:test)
function stackNos(logger as Logger) {
  var stack = createStack(4);
  Test.assert(stack.nos() == null);
  stack.push(123);
  Test.assert(stack.nos() == null);
  stack.push(456);
  Test.assert(stack.nos() == 123);
  stack.push(789);
  Test.assert(stack.nos() == 456);
  stack.pop();
  Test.assert(stack.nos() == 123);
  stack.pop();
  Test.assert(stack.nos() == null);
  return true;
}

(:test)
function stackPop(logger as Logger) {
  var stack = createStack(4);
  Test.assert(stack.pop() == null);
  stack.push(1);
  Test.assert(stack.pop() == 1);
  stack.push(2);
  stack.push(3);
  Test.assert(stack.pop() == 3);
  Test.assert(stack.pop() == 2);
  Test.assert(stack.pop() == null);
  return stack.isEmpty();
}

(:test)
function stackDiscardWhenOverflow(logger as Logger) {
  var stack = createStack(3);
  stack.push(1);
  stack.push(2);
  stack.push(3);
  Test.assert(stack.isFull());
  stack.push(4);
  Test.assert(stack.isFull());
  Test.assert(stack.size() == 3);
  Test.assert(stack.pop() == 4);
  Test.assert(stack.pop() == 3);
  Test.assert(stack.pop() == 2);
  Test.assert(stack.pop() == null);
  return stack.isEmpty();
}
