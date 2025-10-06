import 'package:appointment_management/appRouter.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp(appRouter: AppRouter()));
}

class MainApp extends StatelessWidget {
  final AppRouter appRouter;
  const MainApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return AppView(appRouter: appRouter);
  }
}

class AppView extends StatefulWidget {
  final AppRouter appRouter;
  const AppView({super.key, required this.appRouter});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'Appointment Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      onGenerateRoute: widget.appRouter.generateRoute,
      initialRoute: 'login',
    );
  }
}
