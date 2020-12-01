import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final _removeFav = BehaviorSubject<bool>.seeded(false);
  final _removeOwnQuote = BehaviorSubject<bool>.seeded(false);
  final _theme = BehaviorSubject<String>();
  final _themeTextStyle = BehaviorSubject<TextStyle>();

  //streams
  Stream<bool> get removeFav => _removeFav.stream;
  Stream<bool> get removeOwnQuote => _removeOwnQuote.stream;
  Stream<String> get apptheme => _theme.stream;
  Stream<TextStyle> get appthemeText => _themeTextStyle.stream;

  //sink
  Function(bool) get changeRemoveFav => _removeFav.sink.add;
  Function(String) get changeTheme => _theme.sink.add;
  Function(TextStyle) get changeThemeText => _themeTextStyle.sink.add;
  Function(bool) get changeRemoveOwnQuote => _removeOwnQuote.sink.add;

  dispose() {
    _themeTextStyle.close();
    _theme.close();
    _removeFav.close();
    _removeOwnQuote.close();
  }
}
