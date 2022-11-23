// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AuthControllerRouter(AuthController service) {
  final router = Router();
  router.add(
    'POST',
    r'/login',
    service.login,
  );
  router.add(
    'POST',
    r'/refresh',
    service.refreshToken,
  );
  return router;
}
