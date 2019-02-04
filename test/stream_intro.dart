import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

void main2() {
  test('Create a Stream and add some values to it', () {
    var controller = new StreamController<String>();

    controller.add("Item1");
  });

  test('Setting the trap ', () async {
    var controller = new StreamController<String>();

    print('1');
    controller.stream.listen((item) => print(item)); // This is the Trap
    print('2');

    controller.add("Item1");
    print('3');
    controller.add("Item2");
    controller.add("Item3");

    print('4');

    // Giving the the Stream a change to get processed before the process is killed
    await Future.delayed(Duration(milliseconds: 500));
  });

  test('Cancelling a subscription', () async {
    var controller = new StreamController<String>();

    var broadcastStream = controller.stream.asBroadcastStream();

    StreamSubscription subscription = broadcastStream.listen((item) => print(item));

    controller.add("Item1");
    controller.add("Item2");
    controller.add("Item3");

    // Giving the the Stream a change to get processed
    await Future.delayed(Duration(milliseconds: 500));

    subscription.cancel();

    controller.add("Item4");

    // Giving the the Stream a change to get processed before the process is killed
    await Future.delayed(Duration(milliseconds: 500));
  });

  test('Map1', () async {
    // var subject = new PublishSubject<String>();

    // var subscription = subject.map((item) => item.toUpperCase()).listen(print);

    // subject.add("Item1");
    // subject.add("Item2");
    // subject.add("Item3");

    // // Giving the the Stream a change to get processed before the process is killed
    // await Future.delayed(Duration(milliseconds: 500));

    // subscription.cancel();


  });
}

class User {
  final String name;
  final String adress;
  final String phoneNumber;
  final int age;

  // In real projects I would recommend some 
  // serializer and not doing that manually
  factory User.fromJson(String jsonString) {
    var jsonMap = json.decode(jsonString);

    return User(jsonMap['name'],jsonMap['adress'],jsonMap['phoneNumber'],jsonMap['age'],
    );
  }

  User(this.name, this.adress, this.phoneNumber, this.age);

  @override
  String toString() {
    return '$name - $adress - $phoneNumber - $age';
  }
}

void main() async {
    asyncApiCall().asStream()
        .map<User>((jsonString) => User.fromJson(jsonString)) // from here on it's User objects
        .listen((user) => print(user.toString()));


    List<String> jsonObjects = await asyncApiCall();

    for(var jsonString in jsonObjects)
    {
      var user = User.fromJson(jsonString);
      print(user.toString());
    }

}

Future asyncApiCall() async
{}


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
//   }); // using tear-off }
