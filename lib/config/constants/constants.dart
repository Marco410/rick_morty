const String baseUrl = "rickandmortyapi.com";
const String route = "/api/";

const String getCharacters = "${route}character";
const String getLocation = "${route}location";

const String databaseName = 'rick.db';

const String tableLastViews = 'last_view_characters';

const String createLastViewTable = '''
    create table $tableLastViews (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      character_id INTEGER,
      name TEXT,
      status TEXT,
      species TEXT,
      gender TEXT,
      type TEXT,
      image TEXT,
      originName TEXT,
      originUrl TEXT,
      locationName TEXT,
      locationUrl TEXT
    )
''';
