import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final _removeFav = BehaviorSubject<bool>.seeded(false);

  //streams
  Stream<bool> get removeFav => _removeFav.stream;

  //sink
  Function(bool) get changeRemoveFav => _removeFav.sink.add;

  dispose() {
    _removeFav.close();
  }
}
