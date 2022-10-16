import 'dart:io';

import 'string_helper.dart';

class CustomEnvHelper {
  static Future<String> _loadEnvFile() async {
    return await File('.env').readAsString();
  }

  static Map<String, String> _envFileDecoded = {};

  static Future<void> _readEnvFile() async {
    final String envFile = await _loadEnvFile();
    final List<String> lines =
        envFile.replaceAll(String.fromCharCode(13), '').split("\n");
    _envFileDecoded = {for (var l in lines) l.split('=')[0]: l.split('=')[1]};
  }

  static Future<Type> get<Type>({required String key}) async {
    if (_envFileDecoded.isEmpty) await _readEnvFile();
    return _envFileDecoded[key]!.parseToType(Type);
  }
}
