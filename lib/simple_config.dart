import 'package:flutter_dotenv/flutter_dotenv.dart';

class SimpleConfig {
  static String baseUrl = dotenv.env['EVOPIA_BASE_URL'] ?? "";
}