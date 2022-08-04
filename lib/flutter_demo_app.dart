import 'package:flutter/material.dart';
import 'package:flutter_demo/dependency_injection/app_component.dart';
import 'package:flutter_demo/features/app_init/app_init_initial_params.dart';
import 'package:flutter_demo/features/app_init/app_init_page.dart';
import 'package:flutter_demo/navigation/app_navigator.dart';
import 'package:flutter_demo/utils/locale_resolution.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class FlutterDemoApp extends StatefulWidget {
  const FlutterDemoApp({super.key});

  @override
  State<FlutterDemoApp> createState() => _FlutterDemoAppState();
}

class _FlutterDemoAppState extends State<FlutterDemoApp> {
  late AppInitPage page;

  @override
  void initState() {
    page = getIt<AppInitPage>(param1: const AppInitInitialParams());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: page,
      debugShowCheckedModeBanner: false,
      navigatorKey: AppNavigator.navigatorKey,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeListResolutionCallback: localeResolution,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child!,
      ),
    );
  }
}
