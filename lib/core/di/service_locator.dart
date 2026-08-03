import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:simak_mobile/core/network/dio_client.dart';
import 'package:simak_mobile/core/storage/app_storage.dart';
import 'package:simak_mobile/core/storage/secure_storage.dart';

// Auth
import 'package:simak_mobile/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:simak_mobile/features/authentication/domain/repositories/auth_repository.dart';
import 'package:simak_mobile/features/authentication/domain/usecases/get_session_usecase.dart';
import 'package:simak_mobile/features/authentication/domain/usecases/login_usecase.dart';
import 'package:simak_mobile/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:simak_mobile/features/authentication/presentation/bloc/auth_bloc.dart';

// Portal
import 'package:simak_mobile/features/portal/data/repositories/portal_repository_impl.dart';
import 'package:simak_mobile/features/portal/domain/repositories/portal_repository.dart';
import 'package:simak_mobile/features/portal/domain/usecases/get_portal_info_usecase.dart';
import 'package:simak_mobile/features/portal/presentation/bloc/portal_bloc.dart';

// Dashboard
import 'package:simak_mobile/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:simak_mobile/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:simak_mobile/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:simak_mobile/features/dashboard/presentation/bloc/dashboard_bloc.dart';

// Schedule
import 'package:simak_mobile/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:simak_mobile/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:simak_mobile/features/schedule/domain/usecases/get_schedule_usecase.dart';
import 'package:simak_mobile/features/schedule/presentation/bloc/schedule_bloc.dart';

// Grade / KHS
import 'package:simak_mobile/features/grade/data/repositories/grade_repository_impl.dart';
import 'package:simak_mobile/features/grade/domain/repositories/grade_repository.dart';
import 'package:simak_mobile/features/grade/domain/usecases/get_khs_usecase.dart';
import 'package:simak_mobile/features/grade/presentation/bloc/grade_bloc.dart';

// KRS
import 'package:simak_mobile/features/krs/data/repositories/krs_repository_impl.dart';
import 'package:simak_mobile/features/krs/domain/repositories/krs_repository.dart';
import 'package:simak_mobile/features/krs/domain/usecases/get_krs_usecase.dart';
import 'package:simak_mobile/features/krs/presentation/bloc/krs_bloc.dart';

// Attendance
import 'package:simak_mobile/features/attendance/data/repositories/attendance_repository_impl.dart';
import 'package:simak_mobile/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:simak_mobile/features/attendance/domain/usecases/get_attendance_usecase.dart';
import 'package:simak_mobile/features/attendance/presentation/bloc/attendance_bloc.dart';

// Billing
import 'package:simak_mobile/features/billing/data/repositories/billing_repository_impl.dart';
import 'package:simak_mobile/features/billing/domain/repositories/billing_repository.dart';
import 'package:simak_mobile/features/billing/domain/usecases/get_billing_usecase.dart';
import 'package:simak_mobile/features/billing/presentation/bloc/billing_bloc.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // 1. External & Core Storage
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPrefs);
  sl.registerSingleton<AppStorage>(AppStorage(sl()));

  const secureStorage = FlutterSecureStorage();
  sl.registerSingleton<FlutterSecureStorage>(secureStorage);
  sl.registerSingleton<SecureStorage>(SecureStorage(sl()));

  // 2. Network Client
  sl.registerSingleton<DioClient>(DioClient(sl()));

  // 3. Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl(sl()));
  sl.registerLazySingleton<ScheduleRepository>(() => ScheduleRepositoryImpl(sl()));
  sl.registerLazySingleton<GradeRepository>(() => GradeRepositoryImpl(sl()));
  sl.registerLazySingleton<KrsRepository>(() => KrsRepositoryImpl(sl()));
  sl.registerLazySingleton<AttendanceRepository>(() => AttendanceRepositoryImpl(sl()));
  sl.registerLazySingleton<BillingRepository>(() => BillingRepositoryImpl(sl()));
  sl.registerLazySingleton<PortalRepository>(() => PortalRepositoryImpl(sl()));

  // 4. UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetSessionUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetDashboardDataUseCase(sl()));
  sl.registerLazySingleton(() => GetScheduleUseCase(sl()));
  sl.registerLazySingleton(() => GetKhsUseCase(sl()));
  sl.registerLazySingleton(() => GetKrsUseCase(sl()));
  sl.registerLazySingleton(() => GetAttendanceUseCase(sl()));
  sl.registerLazySingleton(() => GetBillingUseCase(sl()));
  sl.registerLazySingleton(() => GetPortalInfoUseCase(sl()));

  // 5. BLoCs
  sl.registerFactory(() => AuthBloc(
        loginUseCase: sl(),
        getSessionUseCase: sl(),
        logoutUseCase: sl(),
      ));
  sl.registerFactory(() => DashboardBloc(useCase: sl()));
  sl.registerFactory(() => ScheduleBloc(useCase: sl()));
  sl.registerFactory(() => GradeBloc(getKhsUseCase: sl()));
  sl.registerFactory(() => KrsBloc(getKrsUseCase: sl()));
  sl.registerFactory(() => AttendanceBloc(useCase: sl()));
  sl.registerFactory(() => BillingBloc(useCase: sl()));
  sl.registerFactory(() => PortalBloc(useCase: sl()));
}
