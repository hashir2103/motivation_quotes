import 'package:motivation_quotes/src/AppConfigurations/constants.dart';
import 'package:motivation_quotes/src/controller/Quotes/quotesModel.dart';
import 'package:rxdart/rxdart.dart';

class CatergoryBloc {
  // streams
  final _general = BehaviorSubject<bool>.seeded(false);
  final _favourite = BehaviorSubject<bool>.seeded(false);
  final _hardtime = BehaviorSubject<bool>.seeded(false);
  final _inspiration = BehaviorSubject<bool>.seeded(false);
  final _love = BehaviorSubject<bool>.seeded(false);
  final _selfesteem = BehaviorSubject<bool>.seeded(false);
  final _productivity = BehaviorSubject<bool>.seeded(false);
  final _saying = BehaviorSubject<bool>.seeded(false);
  final _monday = BehaviorSubject<bool>.seeded(false);
  final _future = BehaviorSubject<bool>.seeded(false);
  final _life = BehaviorSubject<bool>.seeded(false);
  final _workout = BehaviorSubject<bool>.seeded(false);
  final _birthday = BehaviorSubject<bool>.seeded(false);
  final _night = BehaviorSubject<bool>.seeded(false);
  final _travel = BehaviorSubject<bool>.seeded(false);
  final _sport = BehaviorSubject<bool>.seeded(false);
  final _past = BehaviorSubject<bool>.seeded(false);
  final _passion = BehaviorSubject<bool>.seeded(false);
  final _notificationCat = BehaviorSubject<String>.seeded(kLove);
  final _quote = BehaviorSubject<List<Quote>>.seeded([Quote("", "", "", "")]);

  final _addToFav = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get catergoryStreamCombine => CombineLatestStream([
        hardtime,
        inspiration,
        love,
        selfEsteem,
        productivity,
        saying,
        monday,
        future,
        life,
        workout,
        birthday,
        night,
        travel,
        sport,
        past,
        passion
      ], (a) {
        if (a.contains(true)) {
          return true;
        } else {
          changeGeneral(true);
          return false;
        }
      });

  // getter
  Stream<bool> get general => _general.stream;
  Stream<bool> get favourite => _favourite.stream;
  Stream<bool> get hardtime => _hardtime.stream;
  Stream<bool> get inspiration => _inspiration.stream;
  Stream<bool> get love => _love.stream;
  Stream<bool> get selfEsteem => _selfesteem.stream;
  Stream<bool> get productivity => _productivity.stream;
  Stream<bool> get saying => _saying.stream;
  Stream<bool> get monday => _monday.stream;
  Stream<bool> get future => _future.stream;
  Stream<bool> get life => _life.stream;
  Stream<bool> get workout => _workout.stream;
  Stream<bool> get birthday => _birthday.stream;
  Stream<bool> get night => _night.stream;
  Stream<bool> get travel => _travel.stream;
  Stream<bool> get sport => _sport.stream;
  Stream<bool> get past => _past.stream;
  Stream<bool> get passion => _passion.stream;
  Stream<bool> get addToFav => _addToFav.stream;
  Stream<List<Quote>> get quote => _quote.stream;
  Stream<String> get notificationCat => _notificationCat.stream;

  //setter
  Function(bool) get changeGeneral => _general.sink.add;
  Function(bool) get changeFavourite => _favourite.sink.add;
  Function(bool) get changeHardtimes => _hardtime.sink.add;
  Function(bool) get changeInspiration => _inspiration.sink.add;
  Function(bool) get changeLove => _love.sink.add;
  Function(bool) get changeSelfEsteem => _selfesteem.sink.add;
  Function(bool) get changeProductivity => _productivity.sink.add;
  Function(bool) get changeSaying => _saying.sink.add;
  Function(bool) get changeMonday => _monday.sink.add;
  Function(bool) get changeFuture => _future.sink.add;
  Function(bool) get changeLife => _life.sink.add;
  Function(bool) get changeWorkout => _workout.sink.add;
  Function(bool) get changeBirthday => _birthday.sink.add;
  Function(bool) get changeNight => _night.sink.add;
  Function(bool) get changeTravel => _travel.sink.add;
  Function(bool) get changeSport => _sport.sink.add;
  Function(bool) get changePast => _past.sink.add;
  Function(bool) get changePassion => _passion.sink.add;
  Function(bool) get changeaddToFav => _addToFav.sink.add;
  Function(List<Quote>) get changeQuote => _quote.sink.add;
  Function(String) get changeNotificationCat => _notificationCat.sink.add;

  //Func
  List<Quote> get quoteListValue => _quote.value;

  //dispose
  dispose() {
    _notificationCat.close();
    _quote.close();
    _general.close();
    _favourite.close();
    _hardtime.close();
    _inspiration.close();
    _love.close();
    _selfesteem.close();
    _productivity.close();
    _saying.close();
    _monday.close();
    _future.close();
    _life.close();
    _workout.close();
    _birthday.close();
    _night.close();
    _travel.close();
    _sport.close();
    _past.close();
    _passion.close();
    _addToFav.close();
  }
}
