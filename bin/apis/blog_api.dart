import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../services/generic_service.dart';

class BlogApi {
  final GenericService _service;

  BlogApi(this._service);

  String responseBody(String title) => '<h1>$title</h1>';
  Map<String, String> reponseHeaders = {'content-type': 'text/html'};

  Handler get blog {
    final Router router = Router();
    Response responseOk(Request req) => Response.ok(
          responseBody(req.url.pathSegments.last),
          headers: reponseHeaders,
        );

    router.get('/blog/inicial', (Request req) {
      _service.findAll();
      return responseOk(req);
    });
    router.post('/blog/noticias', (Request req) {
      _service.save('');
      return responseOk(req);
    });
    router.put('/blog/novidades', (Request req) {
      String? id = req.url.queryParameters['id'];
      _service.save('');
      return responseOk(req);
    });
    router.delete('/blog/eventos', (Request req) {
      _service.delete(1);
      String? id = req.url.queryParameters['id'];
      return responseOk(req);
    });

    return router;
  }
}
