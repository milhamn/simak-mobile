import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'core/env/env_config.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/attendance/presentation/bloc/attendance_bloc.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/billing/presentation/bloc/billing_bloc.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/grade/presentation/bloc/grade_bloc.dart';
import 'features/krs/presentation/bloc/krs_bloc.dart';
import 'features/schedule/presentation/bloc/schedule_bloc.dart';

import 'features/portal/presentation/bloc/portal_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await EnvConfig.init();

  // Initialize dependency injection service locator
  await initServiceLocator();

  runApp(const SimakApp());
}

class SimakApp extends StatelessWidget {
  const SimakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<DashboardBloc>(create: (_) => sl<DashboardBloc>()),
        BlocProvider<ScheduleBloc>(create: (_) => sl<ScheduleBloc>()),
        BlocProvider<GradeBloc>(create: (_) => sl<GradeBloc>()),
        BlocProvider<KrsBloc>(create: (_) => sl<KrsBloc>()),
        BlocProvider<AttendanceBloc>(create: (_) => sl<AttendanceBloc>()),
        BlocProvider<BillingBloc>(create: (_) => sl<BillingBloc>()),
        BlocProvider<PortalBloc>(create: (_) => sl<PortalBloc>()),
      ],
      child: MaterialApp.router(
        title: EnvConfig.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
