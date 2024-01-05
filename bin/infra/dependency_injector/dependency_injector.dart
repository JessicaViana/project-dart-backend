// ignore_for_file: prefer_final_fields

typedef InstanceCreator<T> = Function();

// * Posso chamar o get do DependencyInjector sempre que quiser pois ele só retorna UMA instância
class DependencyInjector {
  DependencyInjector._();

  static final _singleton = DependencyInjector._();

  factory DependencyInjector() => _singleton;

  final _instanceMap = <Type, _InstanceGenerator<Object>>{};

  //* register

  void register<T>(
    InstanceCreator<T> instance, {
    bool isSingleton = true,
  }) {
    _instanceMap[T] = _InstanceGenerator(instance, isSingleton);
  }

  //* get

  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) return instance;
    throw Exception('[ERROR] -> Instance ${T.toString()} not found');
  }

  call<T extends Object>() => get<T>();
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;

  final InstanceCreator<T> _instanceCreator;

  _InstanceGenerator(this._instanceCreator, bool isSingleton)
      : _isFirstGet = isSingleton; // se nao for singleton então é factory

  T? getInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }
    return _instance ?? _instanceCreator();
  }
}
