class Session {
  final String name;
  final String sessionID;

  Session(String this.name, String this.sessionID);

  Map toMap() => {"name" : name};

  Session.fromMap(Map map) : this(map['name'], map['sessionID']);
}