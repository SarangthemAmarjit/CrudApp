import 'package:auto_route/auto_route.dart';
import 'package:crudapp/Authflow/auth_flow.dart';
import 'package:crudapp/pages/department.dart';
import 'package:crudapp/pages/designation.dart';
import 'package:crudapp/pages/employee.dart';
import 'package:crudapp/pages/employeedetail.dart';
import 'package:crudapp/pages/homepage.dart';
import 'package:crudapp/pages/signinpage.dart';
import 'package:crudapp/pages/signupPage.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: AuthFlowPage, initial: true, path: '/auto', children: [
      AutoRoute(
        page: LoginPage,
      ),
      AutoRoute(
        page: HomePage,
      ),
    ]),
    AutoRoute(page: RegisterPage),
    AutoRoute(page: EmployeesPage),
    AutoRoute(page: DepartmentPage),
    AutoRoute(page: DesignatioPage),
    AutoRoute(page: EmployeeDetailPage),
  ],
)
class $AppRouter {}
