import 'package:go_router/go_router.dart';
import 'package:simak_mobile/features/attendance/presentation/pages/lecturer_attendance_page.dart';
import 'package:simak_mobile/features/attendance/presentation/pages/student_attendance_page.dart';
import 'package:simak_mobile/features/authentication/presentation/pages/login_page.dart';
import 'package:simak_mobile/features/authentication/presentation/pages/portal_page.dart';
import 'package:simak_mobile/features/authentication/presentation/pages/splash_page.dart';
import 'package:simak_mobile/features/billing/presentation/pages/billing_page.dart';
import 'package:simak_mobile/features/grade/presentation/pages/khs_page.dart';
import 'package:simak_mobile/features/krs/presentation/pages/krs_page.dart';
import 'package:simak_mobile/features/lecturer_grade/presentation/pages/lecturer_grade_input_page.dart';
import 'package:simak_mobile/features/leave/presentation/pages/leave_page.dart';
import 'package:simak_mobile/features/notification/presentation/pages/notifications_page.dart';
import 'package:simak_mobile/features/profile/presentation/pages/profile_page.dart';
import 'package:simak_mobile/features/schedule/presentation/pages/schedule_page.dart';
import 'package:simak_mobile/features/system/presentation/pages/force_update_page.dart';
import 'package:simak_mobile/features/system/presentation/pages/maintenance_page.dart';
import 'package:simak_mobile/shared/widgets/main_navigation_page.dart';
import 'package:simak_mobile/features/academic_calendar/presentation/pages/academic_calendar_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/portal',
        builder: (context, state) => const PortalPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          final role = state.uri.queryParameters['role'] ?? 'mahasiswa';
          return LoginPage(role: role);
        },
      ),
      GoRoute(
        path: '/student-dashboard',
        builder: (context, state) => const MainNavigationPage(initialIndex: 0),
      ),
      GoRoute(
        path: '/lecturer-dashboard',
        builder: (context, state) => const MainNavigationPage(initialIndex: 0),
      ),
      GoRoute(
        path: '/schedule',
        builder: (context, state) => const SchedulePage(),
      ),
      GoRoute(
        path: '/khs',
        builder: (context, state) => const KhsPage(),
      ),
      GoRoute(
        path: '/krs',
        builder: (context, state) => const KrsPage(),
      ),
      GoRoute(
        path: '/attendance',
        builder: (context, state) => const StudentAttendancePage(),
      ),
      GoRoute(
        path: '/lecturer-attendance',
        builder: (context, state) => const LecturerAttendancePage(),
      ),
      GoRoute(
        path: '/billing',
        builder: (context, state) => const BillingPage(),
      ),
      GoRoute(
        path: '/lecturer-grade',
        builder: (context, state) => const LecturerGradeInputPage(),
      ),
      GoRoute(
        path: '/leave',
        builder: (context, state) => const LeavePage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/force-update',
        builder: (context, state) => const ForceUpdatePage(),
      ),
      GoRoute(
        path: '/maintenance',
        builder: (context, state) => const MaintenancePage(),
      ),
      GoRoute(
        path: '/academic-calendar',
        builder: (context, state) => const AcademicCalendarPage(),
      ),
    ],
  );
}
