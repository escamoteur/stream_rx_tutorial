import 'dart:async';

class Model
{
    int _counter = 0;
    StreamController _streamController = new StreamController<int>();

    Stream<int> get counterUpdates => _streamController.stream;

    void incrementCounter()
    {
        _counter++;
        _streamController.add(_counter);
    }
}