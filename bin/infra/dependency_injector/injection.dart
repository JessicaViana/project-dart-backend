import '../../apis/blog_api.dart';
import '../../apis/login_api.dart';
import '../../models/news_model.dart';
import '../../services/generic_service.dart';
import '../../services/news_service.dart';
import '../security/security_service.dart';
import '../security/security_service_impl.dart';
import 'dependency_injector.dart';

class Injection {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<SecurityService>(() => SecurityServiceImpl());
    di.register<LoginApi>(() => LoginApi(di.get()));
    di.register<GenericService<NewsModel>>(() => NewsService());
    di.register<BlogApi>(() => BlogApi(di.get()));

    return di;
  }
}