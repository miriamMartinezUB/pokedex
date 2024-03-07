import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_pokedex/common/common_setup.dart';
import 'package:flutter_pokedex/common/language_service.dart';
import 'package:flutter_pokedex/common/locale_storage_service.dart';
import 'package:flutter_pokedex/common/navigation/navigation_service.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:mockito/mockito.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'language_service_test.dart';
import 'locale_storage_service_test.dart';
import 'navigation/navigation_service_test.dart';
import 'theme_service_test.dart';

class MockCommonSetup extends Mock implements CommonSetup {
  @override
  LanguageService languageService = MockLanguageService();

  @override
  LocaleStorageService localeStorageService = MockLocaleStorageService();

  @override
  NavigationService navigationService = MockNavigationService();

  @override
  ThemeService themeService = MockThemeService();

  @override
  List<SingleChildWidget> getProviders(BuildContext context) => [
        Provider<LocaleStorageService>(
          create: (context) => localeStorageService,
        ),
        Provider<LanguageService>(
          create: (context) => languageService,
        ),
        Provider<ThemeService>(
          create: (context) => themeService,
        ),
        Provider<NavigationService>(
          create: (context) => navigationService,
        ),
      ];

  @override
  Future<void> initializeSetupServices() async {
    await localeStorageService.init();
    await languageService.initDelegate(localeStorageService);
    themeService.init();
  }
}
