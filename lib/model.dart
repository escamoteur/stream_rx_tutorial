import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rx_command/rx_command.dart';

class Model
{
    int _counter = 0;
    RxCommand<int,int> addCommand;

    Model()
    {
      addCommand = RxCommand.createAsync3<int,int>((_) async => await Future.delayed(Duration(milliseconds: 200),()=>_counter++));
    }

    Stream<int> get counterUpdates => addCommand.results;

}