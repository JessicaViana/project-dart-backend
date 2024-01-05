import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

class CustomServer {
  Future<void> inicialize({
    required String address,
    required int port,
    required Handler handler,
  }) async {
    log('Starts Server');
    await io.serve(
      handler,
      address,
      port,
    );
  }
}
