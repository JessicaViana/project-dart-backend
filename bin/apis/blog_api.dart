import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/news_model.dart';
import '../services/generic_service.dart';

class BlogApi {
  final GenericService<NewsModel> _service;

  BlogApi(this._service);

  String responseBody(String title) => '<h1>$title</h1>';
  //Map<String, String> responseHeaders = {'content-type': 'text/html'};

  Handler get blog {
    final Router router = Router();
    Response responseOk(Request req) => Response.ok(
          responseBody(req.url.pathSegments.last),
        );

    router.get(
      '/blog/news',
      (Request req) {
        List<NewsModel> news = _service.findAll();
        List<Map> newsMap = news.map((e) => e.toJson()).toList();
        return Response.ok(jsonEncode(newsMap));
      },
    );
    router.post(
      '/blog/news',
      (Request req) async {
        String reqBody = await req.readAsString();
        await _service.saveOrUpdate(NewsModel.fromJson(jsonDecode(reqBody)));
        return responseOk(req);
      },
    );
    router.put(
      '/blog/novidades',
      (Request req) async {
        String? id = req.url.queryParameters['id'];
        String reqBody = await req.readAsString();
        await _service.saveOrUpdate(NewsModel.fromJson(jsonDecode(reqBody)));

        return responseOk(req);
      },
    );
    router.delete(
      '/blog/eventos',
      (Request req) {
        _service.delete(1);
        String? id = req.url.queryParameters['id'];
        return responseOk(req);
      },
    );

    return router;
  }
}
