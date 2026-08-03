import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> init() async {
    try {
      await dotenv.load(fileName: '.env.dev');
    } catch (_) {
      // Fallback if dotenv file missing
    }
  }

  static String get appName => dotenv.env['APP_NAME'] ?? 'SIMAK Mobile';
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'https://api.simak.ac.id/v1';
  static int get apiTimeout => int.parse(dotenv.env['API_TIMEOUT'] ?? '30000');
  static bool get useDummy => (dotenv.env['USE_DUMMY'] ?? 'true').toLowerCase() == 'true';
  static bool get enableLog => (dotenv.env['ENABLE_LOG'] ?? 'true').toLowerCase() == 'true';
}
