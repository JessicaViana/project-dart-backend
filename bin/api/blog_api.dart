import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BlogApi {
  String responseBody(String title) => '<h1>$title</h1>';
  Map<String, String> reponseHeaders = {'content-type': 'text/html'};

  Handler get blog {
    final Router router = Router();
    Response responseOk(Request req) => Response.ok(
          responseBody(req.url.pathSegments.last),
          headers: reponseHeaders,
        );

    router.get('/blog/inicial', (Request req) {
      return responseOk(req);
    });
    router.get('/blog/noticias', (Request req) {
      return responseOk(req);
    });
    router.get('/blog/novidades', (Request req) {
      return responseOk(req);
    });
    router.get('/blog/eventos', (Request req) {
      return responseOk(req);
    });

    return router;
  }
}
