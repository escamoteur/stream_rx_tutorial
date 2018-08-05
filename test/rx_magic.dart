import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

void main() {
  test('Create Timer Observable', () async{

      var timerObservable = Observable.periodic(Duration(seconds: 1), (x)=>x);
 
      timerObservable.listen(print);

          // this is only to prevent the testing framework to kill this process before all items on the Stream are processed
    await Future.delayed(Duration(seconds: 5));

  });

}