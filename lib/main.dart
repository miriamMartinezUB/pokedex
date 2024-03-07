import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_pokedex/common/common_setup.dart';
import 'package:flutter_pokedex/common/language_service.dart';
import 'package:flutter_pokedex/common/navigation/navigation_service.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CommonSetup commonSetup = CommonSetup();

  await commonSetup.initializeSetupServices();

  final delegate = commonSetup.languageService.delegate;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(
      LocalizedApp(
        delegate,
        MyApp(
          commonSetup,
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  final CommonSetup commonSetup;

  const MyApp(
    this.commonSetup, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LanguageService languageService = commonSetup.languageService;
    NavigationService navigationService = commonSetup.navigationService;
    return MultiProvider(
      providers: commonSetup.getProviders(context),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: translate('app_name'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          languageService.delegate,
        ],
        supportedLocales: languageService.supportedLocales,
        locale: languageService.currentLocale,
        theme: ThemeData(
          useMaterial3: true,
        ),
        routerConfig: navigationService.router,
      ),
    );
  }
}
