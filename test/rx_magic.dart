import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

void main() {
  test('Create Observable from Stream', () async {
    var controller = new StreamController<String>();

    var streamObservable = new Observable(controller.stream);

    streamObservable.listen(print);

    controller.add("Item1");
    controller.add("Item2");
    controller.add("Item3");

    // this is only to prevent the testing framework to kill this process before all items on the Stream are processed
    await Future.delayed(Duration(seconds: 5));
  });

  test('Create Timer Observable', () async {
    var timerObservable = Observable.periodic(Duration(seconds: 1), (x) => x.toString());

    timerObservable.listen(print);

    // this is only to prevent the testing framework to kill this process before all items on the Stream are processed
    await Future.delayed(Duration(seconds: 5));
  });

  Future<String> asyncFunction() async {
    return Future.delayed(const Duration(seconds: 1), () => "AsyncRsult");
  }

  test('Create Observable from Future', () async {
    print('start');

    var fromFutureObservable = Observable.fromFuture(asyncFunction());

    fromFutureObservable.listen(print);

    // this is only to prevent the testing framework to kill this process before all items on the Stream are processed
    await Future.delayed(Duration(seconds: 5));
  });

  test('PublishSubject', () async {
    var subject = new PublishSubject<String>();

    subject.listen((item) => print(item));

    subject.add("Item1");

    subject.listen((item) => print(item.toUpperCase()));

    subject.add("Item2");
    subject.add("Item3");

    // this is only to prevent the testing framework to kill this process before all items on the Stream are processed
    await Future.delayed(Duration(seconds: 5));

    // This will cancel all Subscriptions
    subject.close;
  });

  test('BehaviourSubject', () async {
    var subject = new BehaviorSubject<String>();

    subject.listen((item) => print(item));

    subject.add("Item1");

    subject.add("Item2");

    subject.listen((item) => print(item.toUpperCase()));

    subject.add("Item3");

    // this is only to prevent the testing framework to kill this process before all items on the Stream are processed
    await Future.delayed(Duration(seconds: 5));

    // This will cancel all Subscriptions
    subject.close;
  });

  test('Map toUpper', () async {
    var subject = new PublishSubject<String>();

    subject.map((item) => item.toUpperCase()).listen(print);

    subject.add("Item1");
    subject.add("Item2");
    subject.add("Item3");

    // this is only to prevent the testing framework to kill this process before all items on the Stream are processed
    await Future.delayed(Duration(seconds: 5));

    // This will cancel all Subscriptions
    subject.close;
  });

  test('Map toUpper from int', () async {
    var subject = new PublishSubject<int>();

    subject.map((intValue) => intValue.toString())
      .map((item) => item.toUpperCase())
        .listen(print);

    subject.add(1);
    subject.add(2);
    subject.add(3);

    // this is only to prevent the testing framework to kill this process before all items on the Stream are processed
    await Future.delayed(Duration(seconds: 5));

    // This will cancel all Subscriptions
    subject.close;
  });
}
