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

}