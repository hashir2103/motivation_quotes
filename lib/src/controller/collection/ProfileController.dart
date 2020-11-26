import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final _removeFav = BehaviorSubject<bool>.seeded(false);
  final _removeOwnQuote = BehaviorSubject<bool>.seeded(false);
  final _theme = BehaviorSubject<String>();

  //streams
  Stream<bool> get removeFav => _removeFav.stream;
  Stream<bool> get removeOwnQuote => _removeOwnQuote.stream;
  Stream<String> get apptheme => _theme.stream;

  //sink
  Function(bool) get changeRemoveFav => _removeFav.sink.add;
  Function(String) get changeTheme => _theme.sink.add;
  Function(bool) get changeRemoveOwnQuote => _removeOwnQuote.sink.add;

  dispose() {
    _theme.close();
    _removeFav.close();
    _removeOwnQuote.close();
  }
}
