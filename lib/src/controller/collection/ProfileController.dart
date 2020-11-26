import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final _removeFav = BehaviorSubject<bool>.seeded(false);
  final _removeOwnQuote = BehaviorSubject<bool>.seeded(false);

  //streams
  Stream<bool> get removeFav => _removeFav.stream;
  Stream<bool> get removeOwnQuote => _removeOwnQuote.stream;

  //sink
  Function(bool) get changeRemoveFav => _removeFav.sink.add;
  Function(bool) get changeRemoveOwnQuote => _removeOwnQuote.sink.add;

  dispose() {
    _removeFav.close();
    _removeOwnQuote.close();
  }
}
