import 'package:rxdart/rxdart.dart';

class DebouncedUserInputModel
{
    PublishSubject<String> _inputSubject = PublishSubject<String>();
    BehaviorSubject<String> _resultSubject = BehaviorSubject<String>();

    Observable<String> get searchResults => _resultSubject;

    onSearchTextChanged(String newTextValue)
    {
      _inputSubject.add(newTextValue);
    }

  DebouncedUserInputModel()
  {
    _inputSubject
      .debounce(Duration(milliseconds: 500))
      .asyncMap( (searchText) => asyncRestApiCall(searchText))
      .listen( (result) => _resultSubject.add(result));       
  }

  Future asyncRestApiCall(String searchString) async
  {
      final observableTwitter = getTwitterStream().map((data) => new MyAppPost.fromTwitter(data));
      final observableFacebook = getFacebookStream().map((data) => new MyAppPost.fromFaceBook(data));
      final postStream = observableTwitter.mergeWith([observableFacebook]);

      postStream.listen((_){});
  }

 
  Observable getTwitterStream()
  {

  }
  Observable getFacebookStream()
  {

  }
}
 class MyAppPost {
    factory MyAppPost.fromTwitter(data){}
    factory MyAppPost.fromFaceBook(data){}
    
  }

