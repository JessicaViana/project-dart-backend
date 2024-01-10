abstract class DbConnection {
  Future<dynamic> get connection;
  Future<dynamic> createConnection();
}
