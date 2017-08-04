class Session {
  final String name;
  final String sessionID;

  Session(String this.name, String this.sessionID);

  Map toMap() => {"_name" : name};

  String toString() => "Session name: $name ID: $sessionID";
}