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

class Product {
  final String name;
  final double price;

  factory Product.fromJson(String jsonString) {
    var jsonMap = json.decode(jsonString);

    return Product(
      jsonMap['name'],
      jsonMap['price'],
    );
  }

  Product(this.name, this.price);

  @override
  String toString() {
    return '$name - $price';
  }
}

class Invoice {
  final User user;
  final Product product;

  Invoice(this.user, this.product);

  printInvoice() {
    print(user.toString());
    print(product.toString());
  }
}

/// Simulating an HTTP call to an REST API returning a Product as JSON string
Future<String> getProduct() async {
  print("Started getting product");
  await Future.delayed(Duration(seconds: 2));
  print("Finished getting product");
  return '{"name": "Flux compensator", "price": 99999.99}';
}

/// Simulating an HTTP call to an REST API returning a User as JSON string
Future<String> getUser() async {
  print("Started getting User");
  await Future.delayed(Duration(seconds: 4));
  print("Finished getting User");
  return '{"name": "Jon Doe", "adress": "New York", "phoneNumber":"424242","age": 42 }';
}

void main() {
  test('zipWidth', () async {
   
    var userObservable =
        Observable.fromFuture(getUser()).map<User>((jsonString) => User.fromJson(jsonString));

    var productObservable = Observable.fromFuture(getProduct())
        .map<Product>((jsonString) => Product.fromJson(jsonString));

    Observable<Invoice> invoiceObservable = userObservable.zipWith<Product, Invoice>(
        productObservable, (user, product) => Invoice(user, product));


    print("Start listening for invoices");
    invoiceObservable.listen((invoice) => invoice.printInvoice());

    // this is only to prevent the testing framework to kill this process before all items on the Stream are processed
    await Future.delayed(Duration(seconds: 5));
  });
}
