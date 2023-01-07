import 'package:albaraka_management/src/modules/authenticaion/data_layer/data_sources/auth_remote_data_sources.dart';
import 'package:albaraka_management/src/modules/authenticaion/data_layer/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';

import '../../modules/authenticaion/domain_layer/repsitories/base_auth_repository.dart';


final sl = GetIt.instance;

class ServiceLocator {
  void init() async {
    /// auth
    BaseAuthRemoteDataSource baseAuthRemoteDataSource = AuthRemoteDataSource();
    sl.registerLazySingleton(() => baseAuthRemoteDataSource);

    BaseAuthRepository baseAuthRepository = AuthRepository(sl());
    sl.registerLazySingleton(() => baseAuthRepository);

  }
}

