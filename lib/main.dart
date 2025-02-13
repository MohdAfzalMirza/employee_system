import 'package:demo/constants/app_strings.dart';
import 'package:demo/ui/home_page/home_page.dart';
import 'package:demo/utils/navigate_routes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'data/hive/employee_data_model.dart';
final GlobalKey<NavigatorState> appNavigatorKey =
GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeDBEntryAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.kDemo,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        onGenerateRoute: Routes.generateRoute,
        initialRoute: HomePage.routeName,
        navigatorKey: appNavigatorKey,
        routes: {
          HomePage.routeName: (context) => const HomePage()
        },
        onGenerateInitialRoutes: (route) {
          return [
            MaterialPageRoute(
                builder: (_) => const HomePage(),
                settings:
                const RouteSettings(name: HomePage.routeName))
          ];
        },
      // home: const HomePage(),
    );
  }
}
