import 'dart:async';
import 'dart:developer';

import 'package:mysql1/mysql1.dart';

import '../utils/custom_env_helper.dart';
import 'db_connection.dart';

class DbConnectionImpl implements DbConnection {
  MySqlConnection? _connection;

  @override
  Future<MySqlConnection?> createConnection() async {
    _connection = await MySqlConnection.connect(
      ConnectionSettings(
        host: await CustomEnvHelper.get<String>(key: 'SERVER_ADDRESS'),
        port: await CustomEnvHelper.get<int>(key: 'DB_PORT'),
        db: await CustomEnvHelper.get<String>(key: 'DB_SCHEMA'),
        user: await CustomEnvHelper.get<String>(key: 'DB_USER'),
        password: await CustomEnvHelper.get<String>(key: 'DB_PASS'),
      ),
    );
    log('Conexão com MySQL');
    return _connection;
  }

  @override
  Future<MySqlConnection> get connection async {
    if (_connection == null) {
      try {
        await createConnection();
      } catch (e) {
        log('[ERROR/DB] Failed created connection', error: e);
      }
    }
    return _connection!;
  }
}
