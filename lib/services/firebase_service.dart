import 'dart:html';
import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;

import 'logger_service.dart';

import '../models/player.dart';


@Injectable()
class FirebaseService {
  final LoggerService _log;

  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Auth _fbAuth;
  fb.Database _fbDatabase;
  fb.DatabaseReference _fbRefGameSessions;
  fb.User user;

  List<Player> players;

  FirebaseService(LoggerService this._log) {
    fb.initializeApp(
        apiKey: "AIzaSyAS7fJVerd-WPWaaJ7ghO8KdDIHzfTXJek",
        authDomain: "ten-thousand-dcc16.firebaseapp.com",
        databaseURL: "https://ten-thousand-dcc16.firebaseio.com",
        storageBucket: "ten-thousand-dcc16.appspot.com"
    );

    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);
    _fbDatabase = fb.database();
    _fbRefGameSessions = _fbDatabase.ref("sessions");
  }

  void _authChanged(fb.AuthEvent event) {
    user = event.user;

    if (user != null) {
      players = [];
      _fbRefGameSessions.onChildAdded.listen(_newPlayer);
    }
  }

  void _newPlayer(fb.QueryEvent event) {
    Player p = new Player.fromMap(event.snapshot.val());
    players.add(p);
  }

//  TODO: stop using push(), so you can use your own keys.
//  TODO: addPlayer() might not need to exist. We should organize by game sessions instead (multiple sessions -- yay!)
//  Each game can have a list of players. They should have unique names though.
  Future addPlayer(String name) async {
    try {
      Player p = new Player(name);
      await _fbRefGameSessions.push(p.toMap());
    }
    catch (error) {
      print("FirebaseService()::addPlayer() -- $error");
    }
  }

  String createSessionRef() => _fbRefGameSessions.push().key;

  void testUpdate(Player p) {
    var playerRef = _fbRefGameSessions.push().key;

    _log.info("$runtimeType()::testUpdate() -- $playerRef");

    var updates = {};
//    updates[playerRef] = new Player("Stan", 500, 500, 0, false, false).toMap();
    updates[playerRef] = p.toMap();

    _fbRefGameSessions.update(updates);
  }

  Future updatePlayer({String name, int score}) async {
    try {
      _fbRefGameSessions.child(name).set({"_score" : score});
    }
    catch (error) {
      print("FBService()::updatePlayer() -- $error}");
    }
  }

//  TODO: Figure out how to access the players' stats and update their scores.

  Future signIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
    }
    catch (error) {
      print("$runtimeType::login() -- $error");
    }
  }

  void signOut() {
    _fbAuth.signOut();
  }

  fb.DatabaseReference get fbRefGameSessions => _fbRefGameSessions;
}