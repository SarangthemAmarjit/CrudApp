// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../Authflow/auth_flow.dart' as _i1;
import '../pages/department.dart' as _i4;
import '../pages/designation.dart' as _i5;
import '../pages/employee.dart' as _i3;
import '../pages/employeedetail.dart' as _i6;
import '../pages/homepage.dart' as _i8;
import '../pages/signinpage.dart' as _i7;
import '../pages/signupPage.dart' as _i2;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AuthFlowRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthFlowPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterPage(),
      );
    },
    EmployeesRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.EmployeesPage(),
      );
    },
    DepartmentRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.DepartmentPage(),
      );
    },
    DesignatioRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.DesignatioPage(),
      );
    },
    EmployeeDetailRoute.name: (routeData) {
      final args = routeData.argsAs<EmployeeDetailRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.EmployeeDetailPage(
          key: args.key,
          name: args.name,
          dob: args.dob,
          desingnation: args.desingnation,
          department: args.department,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.LoginPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.HomePage(),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'auto',
          fullMatch: true,
        ),
        _i9.RouteConfig(
          AuthFlowRoute.name,
          path: 'auto',
          children: [
            _i9.RouteConfig(
              LoginRoute.name,
              path: 'login-page',
              parent: AuthFlowRoute.name,
            ),
            _i9.RouteConfig(
              HomeRoute.name,
              path: 'home-page',
              parent: AuthFlowRoute.name,
            ),
          ],
        ),
        _i9.RouteConfig(
          RegisterRoute.name,
          path: '/register-page',
        ),
        _i9.RouteConfig(
          EmployeesRoute.name,
          path: '/employees-page',
        ),
        _i9.RouteConfig(
          DepartmentRoute.name,
          path: '/department-page',
        ),
        _i9.RouteConfig(
          DesignatioRoute.name,
          path: '/designatio-page',
        ),
        _i9.RouteConfig(
          EmployeeDetailRoute.name,
          path: '/employee-detail-page',
        ),
      ];
}

/// generated route for
/// [_i1.AuthFlowPage]
class AuthFlowRoute extends _i9.PageRouteInfo<void> {
  const AuthFlowRoute({List<_i9.PageRouteInfo>? children})
      : super(
          AuthFlowRoute.name,
          path: 'auto',
          initialChildren: children,
        );

  static const String name = 'AuthFlowRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterRoute extends _i9.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i3.EmployeesPage]
class EmployeesRoute extends _i9.PageRouteInfo<void> {
  const EmployeesRoute()
      : super(
          EmployeesRoute.name,
          path: '/employees-page',
        );

  static const String name = 'EmployeesRoute';
}

/// generated route for
/// [_i4.DepartmentPage]
class DepartmentRoute extends _i9.PageRouteInfo<void> {
  const DepartmentRoute()
      : super(
          DepartmentRoute.name,
          path: '/department-page',
        );

  static const String name = 'DepartmentRoute';
}

/// generated route for
/// [_i5.DesignatioPage]
class DesignatioRoute extends _i9.PageRouteInfo<void> {
  const DesignatioRoute()
      : super(
          DesignatioRoute.name,
          path: '/designatio-page',
        );

  static const String name = 'DesignatioRoute';
}

/// generated route for
/// [_i6.EmployeeDetailPage]
class EmployeeDetailRoute extends _i9.PageRouteInfo<EmployeeDetailRouteArgs> {
  EmployeeDetailRoute({
    _i10.Key? key,
    required String name,
    required String dob,
    required String desingnation,
    required String department,
  }) : super(
          EmployeeDetailRoute.name,
          path: '/employee-detail-page',
          args: EmployeeDetailRouteArgs(
            key: key,
            name: name,
            dob: dob,
            desingnation: desingnation,
            department: department,
          ),
        );

  static const String name = 'EmployeeDetailRoute';
}

class EmployeeDetailRouteArgs {
  const EmployeeDetailRouteArgs({
    this.key,
    required this.name,
    required this.dob,
    required this.desingnation,
    required this.department,
  });

  final _i10.Key? key;

  final String name;

  final String dob;

  final String desingnation;

  final String department;

  @override
  String toString() {
    return 'EmployeeDetailRouteArgs{key: $key, name: $name, dob: $dob, desingnation: $desingnation, department: $department}';
  }
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i8.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-page',
        );

  static const String name = 'HomeRoute';
}
