/// You cannot run this part because it requires an connection to firestore
///
///
import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeatherForecast {
  final String forecastText;
  final GeoPoint location;

  factory WeatherForecast.fromMap(Map<String, dynamic> map) {
    return WeatherForecast(map['forecastText'], map['location']);
  }

  WeatherForecast(this.forecastText, this.location);
}

class NewsMessage {
  final String newsText;
  final GeoPoint location;

  factory NewsMessage.fromMap(Map<String, dynamic> map) {
    return NewsMessage(map['newsText'], map['location']);
  }

  NewsMessage(this.newsText, this.location);
}

class CombinedMessage {
  final WeatherForecast forecast;
  final NewsMessage newsMessage;

  CombinedMessage(this.forecast, this.newsMessage);
}

class Model {
  CollectionReference weatherCollection;
  CollectionReference newsCollection;

  Model() {
    weatherCollection = Firestore.instance.collection('weather');
    newsCollection = Firestore.instance.collection('news');
  }

  Observable<CombinedMessage> getCombinedMessages() {
    Observable<WeatherForecast> weatherForecasts = weatherCollection
        .snapshots()
        .expand((snapShot) => snapShot.documents)
        .map<WeatherForecast>((document) => WeatherForecast.fromMap(document.data));

    Observable<NewsMessage> news = newsCollection.snapshots().expand((snapShot) {
      return snapShot.documents;
    }).map<NewsMessage>((document) {
      return NewsMessage.fromMap(document.data);
    });

    return Observable.combineLatest2(
        weatherForecasts, news, (weather, news) => CombinedMessage(weather, news));
  }

  Observable<CombinedMessage> getDependendMessages() {
    
    Observable<NewsMessage> news = newsCollection.snapshots().expand((snapShot) {
      return snapShot.documents;
    }).map<NewsMessage>((document) {
      return NewsMessage.fromMap(document.data);
    });
    
    return news.asyncMap((newsEntry) async {
      var weatherDocuments =
          await weatherCollection.where('location', isEqualTo: newsEntry.location).getDocuments();
      return new CombinedMessage(
          WeatherForecast.fromMap(weatherDocuments.documents.first.data), newsEntry);
    });
  }
}
