import '../../apis/blog_api.dart';
import '../../apis/login_api.dart';
import '../../apis/user_api.dart';
import '../../dao/user_dao.dart';
import '../../models/news_model.dart';
import '../../services/generic_service.dart';
import '../../services/login_service.dart';
import '../../services/news_service.dart';
import '../../services/user_service.dart';
import '../database/db_connection.dart';
import '../database/db_connection_impl.dart';
import '../security/security_service.dart';
import '../security/security_service_impl.dart';
import 'dependency_injector.dart';

class Injection {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<SecurityService>(() => SecurityServiceImpl());
    di.register<GenericService<NewsModel>>(() => NewsService());
    di.register<BlogApi>(() => BlogApi(di.get()));
    di.register<DbConnection>(() => DbConnectionImpl());

    //* User
    di.register<UserDAO>(() => UserDAO(di.get<DbConnection>()));
    di.register<UserService>(() => UserService(di.get<UserDAO>()));
    di.register<UserApi>(() => UserApi(di.get<UserService>()));

    //* Login
    di.register<LoginApi>(() => LoginApi(di.get(), di.get()));
    di.register<LoginService>(() => LoginService(di.get<UserService>()));

    return di;
  }
}
