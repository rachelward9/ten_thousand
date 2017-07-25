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
        storageBucket: "ten-thousand-dcc16.appspot.com");

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
    }
  }

  void _newPlayer(fb.QueryEvent event) {
    Player p = new Player.fromMap(event.snapshot.val());
    players.add(p);
  }

  String createSessionRef() {
    String sessionRef = _fbRefGameSessions.push().key;
    _fbRefGameSessions.child(sessionRef).onChildAdded.listen(_newPlayer);
    return sessionRef;
  }

  Future signIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
    } catch (error) {
      print("$runtimeType::login() -- $error");
    }
  }

  void signOut() {
    _fbAuth.signOut();
  }

  fb.DatabaseReference get fbRefGameSessions => _fbRefGameSessions;
}
