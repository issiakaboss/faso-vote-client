import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get apiUrl =>
      dotenv.get('API_URL', fallback: 'http://127.0.0.1:8000/api/');
  static String get appName => dotenv.get('APP_NAME', fallback: 'My App');
  static String get host => dotenv.get('HOST', fallback: '127.0.0.1');
  static String get appKey => dotenv.get('APPKEY', fallback: 'ABCDEFG4');
  static int get wsPort => dotenv.getInt('WSPORT', fallback: 80);
  static int get wssPort => dotenv.getInt('WSSPORT', fallback: 443);
  static bool get encrypted => dotenv.getBool('ENCRYPTED', fallback: false);
  static bool get debugMode => dotenv.getBool('DEBUG_MODE', fallback: false);

  static String get developement => ".env";
  static String get production => ".env.production";
  static bool get isLocal => false;

  static String get orangeMAdress =>
      dotenv.get("ORANGE_MESSAGE_ADRESS", fallback: "");
  static String get moovMAdress =>
      dotenv.get("MOOV_MESSAGE_ADRESS", fallback: "");

  static String get orangeCAdress =>
      dotenv.get("ORANGE_CENTER_ADRESS", fallback: "");
  static String get moovCAdress =>
      dotenv.get("MOOV_CENTER_ADRESS", fallback: "");
}
