import 'dart:async';

import 'package:test/test.dart';

void main() {
  test('Create a Stream and add some values to it', () {
    var controller = new StreamController<String>();

    controller.add("Item1");
  });

  test('Setting the trap ', () async {
    var controller = new StreamController<String>();

    controller.stream.listen((item) => print(item)); // This is the Trap

    controller.add("Item1");
    controller.add("Item2");
    controller.add("Item3");

    // this is only to prevent the testing framework to kill this process before all items on the Stream are processed
    await Future.delayed(Duration(milliseconds: 500));
  });

  test('Cancelling a subscription', () async {
    var controller = new StreamController<String>();

    StreamSubscription subscription =
        controller.stream.listen((item) => print(item)); // This is the Trap

    controller.add("Item1");
    controller.add("Item2");
    controller.add("Item3");

    // this is only to prevent the testing framework to kill this process before all items on the Stream are processed
    await Future.delayed(Duration(milliseconds: 500));

    subscription.cancel;
  });
}

// void myPrint(String message) {
//   print(message);
// }

// void listenExample1() {
//   var controller = new StreamController<String>();

// //    StreamSubscription subscription = controller.stream.listen((item) => print(item)); // using a lambda function

// //    StreamSubscription subscription = controller.stream.listen((item) => myPrint(item)); // using a lambda function

// //    StreamSubscription subscription = controller.stream.listen(myPrint); // using tear-off

//   StreamSubscription subscription = controller.stream.listen((item) {
//     print(item);
//     print(item.toUpperCase);
//   }); // using tear-off
// }
