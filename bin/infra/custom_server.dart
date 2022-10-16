import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

class CustomServer {
  Future<void> inicialize(Handler handler) async {
    final String address = 'localhost';
    final int port = 8080;

    await io.serve(
      handler,
      address,
      port,
    );
  }
}
