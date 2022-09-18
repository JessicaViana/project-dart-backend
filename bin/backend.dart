import 'dart:async';

import 'package:backend/service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf;

void main(List<String> arguments) async {
  final service = Service();

  final server = await shelf.serve(
    service.handler,
    '0.0.0.0',
    8080,
  );

  print('Online - ${server.address.host}:${server.port}');
}

FutureOr<Response> handler(Request request) {
  final response = Response(200, body: "html");
  return response;
}

Middleware log() {
  return (handler) {
    return (request) async {
      print('solicitado: ${request.url}');
      //antes de executar
      var response = await handler(request);
      //depois de executar
      print('resposta: ${response.statusCode}');

      return response;
    };
  };
}
