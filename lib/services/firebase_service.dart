import 'dart:html';
import 'dart:async';

import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;

import '../models/player.dart';


@Injectable()
class FirebaseService {
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Auth _fbAuth;
  fb.Database _fbDatabase;
  fb.DatabaseReference _fbRefPlayers;
  fb.User user;

  List<Player> players;

  FirebaseService() {
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
    _fbRefPlayers = _fbDatabase.ref("players");
  }

  void _authChanged(fb.AuthEvent event) {
    user = event.user;

    if (user != null) {
      players = [];
      _fbRefPlayers.onChildAdded.listen(_newPlayer);
    }
  }

  void _newPlayer(fb.QueryEvent event) {
    Player p = new Player.fromMap(event.snapshot.val());
    players.add(p);
  }

  Future addPlayer(String name) async {
    try {
      Player p = new Player(name);
      await _fbRefPlayers.push(p.toMap());
    }
    catch (error) {
      print("FirebaseService()::addPlayer() -- $error");
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
}