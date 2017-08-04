import 'dart:html';
import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;

import 'logger_service.dart';

import '../models/player.dart';
import '../models/session.dart';

@Injectable()
class FirebaseService {
  final LoggerService _log;

  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Auth _fbAuth;
  fb.Database _fbDatabase;
  fb.DatabaseReference _fbRefGameSessions;
  fb.User user;

  List<Player> players;
  List<Session> sessions = [];

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
    fbRefGameSessions.onChildAdded.listen(_newSession);
    fbRefGameSessions.onChildRemoved.listen(_removeSession);
  }

  void _authChanged(fb.AuthEvent event) {
    user = event.user;

    if (user != null) {
      players = [];
    }
  }

  void _newSession(fb.QueryEvent event) {
    String name = event.snapshot.child("_name")?.val();

    sessions.add(new Session(name, event.snapshot.key));
  }

  void _removeSession(fb.QueryEvent event) {
    _log.info("$runtimeType()::_removeSession() BEFORE -- ${sessions}");

    for (int i = 0; i <= sessions.length; i++) {
      if (sessions[i].sessionID == event.snapshot.key) {
        sessions.removeAt(i);
      }
    }

    _log.info("$runtimeType()::_removeSession() AFTER -- ${sessions}");
  }

  void _newPlayer(fb.QueryEvent event) {
    if(event.snapshot.key == "name") {
      return;
    }

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
