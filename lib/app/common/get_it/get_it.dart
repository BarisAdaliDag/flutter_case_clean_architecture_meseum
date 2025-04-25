import 'package:metropolitan_museum/app/common/service/object_box_service.dart';
import 'package:metropolitan_museum/app/features/data/datasources/remote/home_remote_datasource.dart';
import 'package:metropolitan_museum/app/features/data/repositories/home_repository.dart';
import 'package:metropolitan_museum/app/features/presentation/deppartmant_detail/cubit/departmant_detail_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:metropolitan_museum/app/features/data/datasources/local/test_local_datasource.dart';
import 'package:metropolitan_museum/app/features/data/datasources/local/collection_local_datasource.dart';
import 'package:metropolitan_museum/app/features/data/datasources/remote/test_remote_datasource.dart';
import 'package:metropolitan_museum/app/features/data/datasources/remote/collection_remote_datasource.dart';
import 'package:metropolitan_museum/app/features/data/repositories/test_repository.dart';
import 'package:metropolitan_museum/app/features/data/repositories/collection_repository.dart';
import 'package:metropolitan_museum/app/features/presentation/main/cubit/main_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/test/cubit/test_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:metropolitan_museum/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

final getIt = GetIt.instance;

/// **Service provider class managing all dependencies**
final class ServiceLocator {
  /// **Main method to call to set up dependencies**
  Future<void> setup() async {
    _setupRouter();
    setupLocal();
    await _setupDataSource();
    _setupRepository();
    _setupCubit();
  }

  /// **Router Dependency**
  void _setupRouter() {
    // getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  }
// / **ObjectBox Dependency**
  Future<void> setupLocal() async {
    // ObjectBoxService'i singleton olarak kaydet
    // final objectBoxService = await ObjectBoxService.create();
    // getIt.registerSingleton<ObjectBoxService>(objectBoxService);
  }

  /// **DataSource Dependency**
  Future<void> _setupDataSource() async {
    getIt.registerLazySingletonAsync<Store>(provideStore);

    await getIt.isReady<Store>();
    getIt
      ..registerLazySingleton<TestRemoteDatasource>(
        () => TestRemoteDatasourceImpl(),
      )
      ..registerLazySingleton<TestLocalDatasource>(
        () => TestLocalDatasourceImpl(),
      )
      ..registerLazySingleton<CollectionRemoteDatasource>(
        () => CollectionRemoteDatasourceImpl(),
      )
      ..registerLazySingleton<CollectionLocalDatasource>(
        () => CollectionLocalDatasourceImpl(getIt<Store>()),
      )
      ..registerLazySingleton<HomeRemoteDatasource>(
        () => HomeRemoteDatasourceImpl(),
      );
  }

  /// **Repository Dependency**
  void _setupRepository() {
    getIt.registerLazySingleton<TestRepository>(
      () => TestRepositoryImpl(
        remoteDatasource: getIt<TestRemoteDatasource>(),
        localDatasource: getIt<TestLocalDatasource>(),
      ),
    );
    getIt.registerLazySingleton<CollectionRepository>(
      () => CollectionRepositoryImpl(
        remoteDatasource: getIt<CollectionRemoteDatasource>(),
        localDatasource: getIt<CollectionLocalDatasource>(),
      ),
    );
    getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        remoteDatasource: getIt<HomeRemoteDatasource>(),
      ),
    );
  }

  /// **BLoC, Cubit and ViewModel Dependency**
  void _setupCubit() {
    getIt.registerLazySingleton<TestCubit>(
      () => TestCubit(testRepository: getIt<TestRepository>()),
    );
    getIt.registerLazySingleton<MainCubit>(() => MainCubit());
    getIt.registerLazySingleton<CollectionCubit>(
      () => CollectionCubit(collectionRepository: getIt<CollectionRepository>()),
    );
    getIt.registerLazySingleton<HomeCubit>(
      () => HomeCubit(homeRepository: getIt<HomeRepository>()),
    );
    getIt.registerLazySingleton<DepartmentDetailCubit>(
      () => DepartmentDetailCubit(collectionRepository: getIt<CollectionRepository>()),
    );
  }

  /// **Resets dependencies for Test and Debug**
  Future<void> reset() async {
    await getIt.reset();
    await setup();
  }
}

Future<Store> provideStore() async {
  final dir = await getApplicationDocumentsDirectory();
  return Store(getObjectBoxModel(), directory: '${dir.path}/objectbox');
}
