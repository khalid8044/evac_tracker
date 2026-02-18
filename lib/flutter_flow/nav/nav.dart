import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:evac_tracker/index.dart';
import 'package:evac_tracker/main.dart'; // Import for SplashScreen, LoginWidget, DashboardWidget
import 'package:evac_tracker/pages/plumbing_diagram/plumbing_diagram_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evac_tracker/pages/in_app_notifications/in_app_notifications_widget.dart';
import '/backend/schema/structs/index.dart';
import '/auth/custom_auth/custom_auth_user_provider.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'nav.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

// ADDED: Global codec for GoRouter to handle complex data types
class GlobalGoRouterCodec extends Codec<Object?, Object?> {
  const GlobalGoRouterCodec();

  @override
  Converter<Object?, Object?> get encoder => const _GlobalGoRouterEncoder();
  
  @override
  Converter<Object?, Object?> get decoder => const _GlobalGoRouterDecoder();
}

class _GlobalGoRouterEncoder extends Converter<Object?, Object?> {
  const _GlobalGoRouterEncoder();

  @override
  Object? convert(Object? input) {
    if (input == null) return null;
    
    // Check if this is a TransitionInfo object or contains one
    if (_containsTransitionInfo(input)) {
      // Return a simple marker instead of trying to encode TransitionInfo
      return _encodeWithoutTransitionInfo(input);
    }
    
    // For regular encoding
    return _encodeValue(input);
  }

  bool _containsTransitionInfo(dynamic value) {
    if (value == null) return false;
    
    if (value is TransitionInfo) return true;
    
    if (value is Map) {
      for (var v in value.values) {
        if (_containsTransitionInfo(v)) return true;
      }
    }
    
    if (value is List) {
      for (var v in value) {
        if (_containsTransitionInfo(v)) return true;
      }
    }
    
    return false;
  }

  dynamic _encodeWithoutTransitionInfo(dynamic value) {
    if (value == null) return null;
    
    if (value is TransitionInfo) {
      // Return a simple marker for TransitionInfo
      return {'__type': 'TransitionInfo'};
    }
    
    if (value is Map) {
      final Map<String, dynamic> result = {};
      value.forEach((key, val) {
        if (val is! TransitionInfo) {
          result[key.toString()] = _encodeWithoutTransitionInfo(val);
        } else {
          result[key.toString()] = {'__type': 'TransitionInfo'};
        }
      });
      return result;
    }
    
    if (value is List) {
      return value.map(_encodeWithoutTransitionInfo).toList();
    }
    
    return _encodeValue(value);
  }

  dynamic _encodeValue(dynamic value) {
    if (value == null) return null;
    
    if (value is Map<String, dynamic>) {
      try {
        return jsonEncode(value);
      } catch (e) {
        // If encoding fails, try to clean the map
        return jsonEncode(_cleanMap(value));
      }
    }
    
    if (value is List) {
      try {
        return jsonEncode(value);
      } catch (e) {
        // If encoding fails, try to clean the list
        return jsonEncode(_cleanList(value));
      }
    }
    
    if (value is DateTime) {
      return value.millisecondsSinceEpoch.toString();
    }
    
    if (value is Color) {
      return value.value.toString();
    }
    
    if (value is LatLng) {
      return '${value.latitude},${value.longitude}';
    }
    
    if (value is BaseStruct) {
      return jsonEncode(value.serialize());
    }
    
    // For primitive types, return as-is
    return value;
  }

  Map<String, dynamic> _cleanMap(Map<String, dynamic> map) {
    final cleaned = <String, dynamic>{};
    map.forEach((key, value) {
      if (value is TransitionInfo) {
        cleaned[key] = {'__type': 'TransitionInfo'};
      } else if (value is Map<String, dynamic>) {
        cleaned[key] = _cleanMap(value);
      } else if (value is List) {
        cleaned[key] = _cleanList(value);
      } else if (value is! Function) {
        // Skip functions and other non-serializable types
        cleaned[key] = value;
      }
    });
    return cleaned;
  }

  List<dynamic> _cleanList(List list) {
    return list.map((item) {
      if (item is TransitionInfo) {
        return {'__type': 'TransitionInfo'};
      } else if (item is Map<String, dynamic>) {
        return _cleanMap(item);
      } else if (item is List) {
        return _cleanList(item);
      } else if (item is! Function) {
        return item;
      }
      return null;
    }).where((item) => item != null).toList();
  }
}

class _GlobalGoRouterDecoder extends Converter<Object?, Object?> {
  const _GlobalGoRouterDecoder();

  @override
  Object? convert(Object? input) {
    if (input == null) return null;
    
    // Decode value
    return _decodeValue(input);
  }

  dynamic _decodeValue(dynamic value) {
    if (value == null) return null;
    
    // If it's a string, check if it's JSON
    if (value is String) {
      // Check if it's a JSON string
      if ((value.trim().startsWith('{') && value.trim().endsWith('}')) ||
          (value.trim().startsWith('[') && value.trim().endsWith(']'))) {
        try {
          return jsonDecode(value);
        } catch (e) {
          debugPrint('Failed to decode JSON: $e');
          return value;
        }
      }
      
      // Check if it's a LatLng string
      if (value.contains(',') && RegExp(r'^-?\d+\.?\d*,-?\d+\.?\d*$').hasMatch(value)) {
        final parts = value.split(',');
        return LatLng(double.parse(parts[0]), double.parse(parts[1]));
      }
      
      // Check if it's a timestamp
      if (RegExp(r'^\d+$').hasMatch(value)) {
        return DateTime.fromMillisecondsSinceEpoch(int.parse(value));
      }
      
      return value;
    }
    
    // If it's already a Map, check for TransitionInfo marker
    if (value is Map) {
      if (value['__type'] == 'TransitionInfo') {
        // Return a default TransitionInfo
        return TransitionInfo.appDefault();
      }
      
      // Decode map values recursively
      final Map<String, dynamic> result = {};
      value.forEach((key, val) {
        if (key is String) {
          result[key] = _decodeValue(val);
        }
      });
      return result;
    }
    
    // If it's already a List, decode each item
    if (value is List) {
      return value.map(_decodeValue).toList();
    }
    
    return value;
  }
}
// END OF ADDED CODE

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  EvacTrackerAuthUser? initialUser;
  EvacTrackerAuthUser? user;
  String? _redirectLocation;
  bool notifyOnAuthChange = true;

  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String get redirectLocation => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(EvacTrackerAuthUser newUser) {
    final shouldUpdate = user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    log('AppStateNotifier: Updated user - loggedIn = ${newUser.loggedIn}, uid = ${newUser.uid}');
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    updateNotifyOnAuthChange(true);
  }
  
}

GoRouter createRouter(AppStateNotifier appStateNotifier) {
  log('createRouter: loggedIn = ${appStateNotifier.loggedIn}');
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    refreshListenable: appStateNotifier,
    // ADDED: Codec to handle complex data types
    extraCodec: const GlobalGoRouterCodec(),
    errorBuilder: (context, state) {
      log('Router: Error route - ${state.error}');
      return const LoginWidget();
    },
    routes: [
      FFRoute(
        name: 'splash',
        path: '/splash',
        builder: (context, params) {
          log('Router: Building /splash route');
          return const SplashScreen();
        },
      ),
      FFRoute(
        name: '_initialize',
        path: '/',
        builder: (context, params) => appStateNotifier.loggedIn
            ? const DashboardWidget(initNotifications: true)
            : const LoginWidget(),
      ),
      FFRoute(
        name: 'dashboard',
        path: '/dashboard',
        builder: (context, params) => DashboardWidget(
          initNotifications: params.getParam('initNotifications', ParamType.bool) ?? false,
        ),
      ),
      FFRoute(
        name: 'login',
        path: '/login',
        builder: (context, params) => const LoginWidget(),
      ),
      FFRoute(
        name: 'emergency',
        path: '/emergency',
        builder: (context, params) => const EmergencyWidget(),
      ),
      FFRoute(
        name: 'emergencyReConfirm',
        path: '/emergencyReConfirm',
        builder: (context, params) => const EmergencyReConfirmWidget(),
      ),
      FFRoute(
        name: 'emergencyDeclaration',
        path: '/emergencyDeclaration',
        builder: (context, params) => const EmergencyDeclerationWidget(),
      ),
      FFRoute(
        name: 'evacuationDiagram',
        path: '/evacuationDiagram',
        builder: (context, params) => EvacuationDiagramWidget(
          imageLocation: params.getParam('imageLocation', ParamType.String),
          address: params.getParam('address', ParamType.String),
        ),
      ),
      FFRoute(
        name: 'plumbingDiagram',
        path: '/plumbingDiagram',
        builder: (context, params) => PlumbingDiagramWidget(
          imageLocation: params.getParam('imageLocation', ParamType.String),
          address: params.getParam('address', ParamType.String),
        ),
      ),
      FFRoute(
        name: 'emergencyContactList',
        path: '/emergencyContactList',
        builder: (context, params) => EmergencyContactListWidget(
          emergencyContact: params.getParam('emergencyContact', ParamType.JSON),
        ),
      ),
      FFRoute(
        name: 'inAppNotification',
        path: '/inAppNotification',
        builder: (context, params) => const InAppNotificationWidget(),
      ),
      FFRoute(
        name: 'manageSites',
        path: '/manageSites',
        builder: (context, params) => const ManageSitesWidget(),
      ),
      FFRoute(
        name: 'assemblyArea',
        path: '/assemblyArea',
        builder: (context, params) => AssemblyAreaWidget(
          latLong: params.getParam<LatLng>('latLong', ParamType.LatLng, isList: true),
          type: params.getParam<String>('type', ParamType.String, isList: true),
        ),
      ),
      FFRoute(
        name: 'evacuationDiagramAll',
        path: '/evacuationDiagramAll',
        builder: (context, params) => const EvacuationDiagramAllWidget(),
      ),
      FFRoute(
        name: 'assemblyAreaAll',
        path: '/assemblyAreaAll',
        builder: (context, params) => const AssemblyAreaAllWidget(),
      ),
      FFRoute(
        name: 'emergencyContactListAll',
        path: '/emergencyContactListAll',
        builder: (context, params) => const EmergencyContactListAllWidget(),
      ),
    ].map((r) => r.toRoute(appStateNotifier)).toList(),
    observers: [
      // NavigatorObserver with NavigationLogger(),
    ],
  );
}

class NavigationLogger extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('Navigation: Pushed ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('Navigation: Popped ${route.settings.name}');
  }
}

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => {for (var e in entries) if (e.value != null) e.key: e.value!};
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
    bool ignoreRedirect = false,
  }) {
    if (mounted && !GoRouter.of(this).shouldRedirect(ignoreRedirect)) {
      goNamed(name, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
    }
  }

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const {},
    Map<String, String> queryParameters = const {},
    Object? extra,
    bool ignoreRedirect = false,
  }) {
    if (mounted && !GoRouter.of(this).shouldRedirect(ignoreRedirect)) {
      pushNamed(name, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
    }
  }

  void safePop() => canPop() ? pop() : go('/');
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) {
    if (!appState.hasRedirect() || ignoreRedirect) appState.updateNotifyOnAuthChange(false);
  }
  bool shouldRedirect(bool ignoreRedirect) => !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) => appState.setRedirectLocationIfUnset(location);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap => extra is Map<String, dynamic> ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => {...pathParameters, ...uri.queryParameters, ...extraMap};
  TransitionInfo get transitionInfo =>
      extraMap.containsKey(kTransitionInfoKey) ? extraMap[kTransitionInfoKey] as TransitionInfo : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Map<String, dynamic> futureParamValues = {};

  bool get isEmpty => state.allParams.isEmpty || (state.allParams.length == 1 && state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) => asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);

  Future<bool> completeFutures() async {
    final futures = state.allParams.entries.where(isAsyncParam).map((param) async {
      try {
        final doc = await asyncParams[param.key]!(param.value);
        if (doc != null) {
          futureParamValues[param.key] = doc;
          return true;
        }
      } catch (_) {}
      return false;
    });
    return (await Future.wait(futures)).every((e) => e);
  }

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) return futureParamValues[paramName];
    if (!state.allParams.containsKey(paramName)) return null;
    final param = state.allParams[paramName];
    if (param is! String) return param;
    return deserializeParam<T>(param, type, isList, structBuilder: structBuilder);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.redirectLocation;
            appStateNotifier.clearRedirectLocation();
            log('Router: Redirecting to $redirectLocation');
            return redirectLocation;
          }
          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            log('Router: Require auth, redirecting to /login');
            return '/login';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder<bool>(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: page,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                      PageTransition(
                        type: transitionInfo.transitionType,
                        duration: transitionInfo.duration,
                        reverseDuration: transitionInfo.duration,
                        alignment: transitionInfo.alignment,
                        child: child,
                      ).buildTransitions(context, animation, secondaryAnimation, child),
                )
              : MaterialPage(key: state.pageKey, child: page);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage && location != '/' && location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) =>
      Provider.value(value: RootPageContext(true, errorRoute), child: child);
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final lastMatch = routerDelegate.currentConfiguration.last;
    final matchList = lastMatch is ImperativeRouteMatch ? lastMatch.matches : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}