import 'package:flutter_dotenv/flutter_dotenv.dart';

class SimpleConfig {
  static String baseUrl = dotenv.get('EVOPIA_BASE_URL',
      fallback: const String.fromEnvironment('EVOPIA_BASE_URL'));
}
