import 'package:albaraka_management/src/modules/authenticaion/data_layer/data_sources/auth_remote_data_sources.dart';
import 'package:albaraka_management/src/modules/authenticaion/data_layer/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';

import '../../modules/authenticaion/domain_layer/repsitories/base_auth_repository.dart';
import '../../modules/menu/data_layer/data_sources/menu_remote_data_source.dart';
import '../../modules/menu/data_layer/repositories/menu_repository.dart';
import '../../modules/menu/domain_layer/repsitories/base_menu_repository.dart';
import '../../modules/staff/data_layer/data_sources/staff_remote_data_source.dart';
import '../../modules/staff/data_layer/repositories/staff_repository.dart';
import '../../modules/staff/domain_layer/repsitories/base_staff_repository.dart';


final sl = GetIt.instance;

class ServiceLocator {
  void init() async {
    /// auth
    BaseAuthRemoteDataSource baseAuthRemoteDataSource = AuthRemoteDataSource();
    sl.registerLazySingleton(() => baseAuthRemoteDataSource);

    BaseAuthRepository baseAuthRepository = AuthRepository(sl());
    sl.registerLazySingleton(() => baseAuthRepository);

    /// staff
    BaseStaffRemoteDataSource baseStaffRemoteDataSource = StaffRemoteDataSource();
    sl.registerLazySingleton(() => baseStaffRemoteDataSource);

    BaseStaffRepository baseStaffRepository = StaffRepository(sl());
    sl.registerLazySingleton(() => baseStaffRepository);

    /// menu
    BaseMenuRemoteDataSource baseMenuRemoteDataSource = MenuRemoteDataSource();
    sl.registerLazySingleton(() => baseMenuRemoteDataSource);

    BaseMenuRepository baseMenuRepository = MenuRepository(sl());
    sl.registerLazySingleton(() => baseMenuRepository);
  }
}

