import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

class User {
  final String name;
  final String adress;
  final String phoneNumber;
  final int age;

  factory User.fromJson(String jsonString) {
    var jsonMap = json.decode(jsonString);

    return User(
      jsonMap['name'],
      jsonMap['adress'],
      jsonMap['phoneNumber'],
      jsonMap['age'],
    );
  }

  User(this.name, this.adress, this.phoneNumber, this.age);

  @override
  String toString() {
    return '$name - $adress - $phoneNumber - $age';
  }
}

void main() {
  test('Map', () {
    var jsonStrings = [
      '{"name": "Jon Doe", "adress": "New York", "phoneNumber":"424242","age": 42 }',
      '{"name": "Stephen King", "adress": "Castle Rock", "phoneNumber":"123456","age": 71 }',
      '{"name": "Jon F. Kennedy", "adress": "Washington", "phoneNumber":"111111","age": 66 }',
    ];

    /// We simulate a Stream of json strings that we get from some API/Database with a Subject
    /// In reality this migh look more like some `asyncWebCallFcuntion().asStream()`
    var dataStreamFromAPI = new PublishSubject<String>();

    dataStreamFromAPI
        .map<User>((jsonString) => User.fromJson(jsonString))
        .distinctUnique()
        .listen((user) => print(user.toString()));

    /// Simulate incoming data
    dataStreamFromAPI.add(jsonStrings[0]);
    dataStreamFromAPI.add(jsonStrings[1]);
    dataStreamFromAPI.add(jsonStrings[2]);
  });
}


