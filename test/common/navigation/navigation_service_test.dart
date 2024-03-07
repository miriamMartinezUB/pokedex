import 'package:flutter_pokedex/common/navigation/navigation_service.dart';
import 'package:go_router/src/router.dart';
import 'package:mockito/mockito.dart';

class MockNavigationService extends Mock implements NavigationService {
  @override
  // TODO: implement canGoBack
  bool get canGoBack => throw UnimplementedError();

  @override
  void close() {
    // TODO: implement close
  }

  @override
  // TODO: implement currentRoute
  String get currentRoute => throw UnimplementedError();

  @override
  void goBack() {
    // TODO: implement goBack
  }

  @override
  void navigateTo(String routeName, {Object? arguments}) {
    // TODO: implement navigateTo
  }

  @override
  Future replace(String routeName, {Object? arguments}) {
    // TODO: implement replace
    throw UnimplementedError();
  }

  @override
  // TODO: implement router
  GoRouter get router => throw UnimplementedError();
}
