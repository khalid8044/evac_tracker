import 'dart:developer';

import 'package:evac_tracker/firebase_options.dart';
import 'package:evac_tracker/flutter_flow/nav/nav.dart';
import 'package:evac_tracker/pages/assembly_area_all/assembly_area_provider.dart';
import 'package:evac_tracker/pages/dashboard/notification_manager.dart';
import 'package:evac_tracker/pages/emergency_contact_list_all/ecl_provider.dart';
import 'package:evac_tracker/pages/evacuation_diagram_all/evacuation_diagram_provider.dart';
import 'package:evac_tracker/pages/manage_sites/manage_sites_provider.dart';
import 'package:evac_tracker/services/notifications_bg.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/custom_auth/auth_util.dart';
import 'auth/custom_auth/custom_auth_user_provider.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';

import 'pages/dashboard/notification_badge_provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
late GoRouter router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final appState = FFAppState();
  await authManager.initialize();
  

  await appState.initializePersistedState();
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => appState),
        ChangeNotifierProvider(create: (_) => NotificationBadgeProvider()),
        ChangeNotifierProvider(create: (_) => AssemblyAreaProvider()),
        ChangeNotifierProvider(create: (_) => ECLProvider()),
        ChangeNotifierProvider(create: (_) => EvacuationDiagramProvider()),
        ChangeNotifierProvider(create: (_) => ManagerSitesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;
  late AppStateNotifier _appStateNotifier;
  late NotificationPlugin _notificationPlugin;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _appStateNotifier = AppStateNotifier.instance;
    _notificationPlugin = NotificationPlugin();
    router = createRouter(_appStateNotifier);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _notificationPlugin.processPendingNotificationSafely();
    });
    _initializeAsyncDependencies();
  }

  Future<void> _initializeAsyncDependencies() async {
    await _notificationPlugin.init();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _notificationPlugin.requestNotificationPermissions();
    });

    // Fallback: Set default user state if stream doesn't emit within 5 seconds
    Future.delayed(const Duration(seconds: 5), () {

      log('appstate use:${_appStateNotifier.user?.userData}');
      if (_appStateNotifier.user == null) {
        log('User stream timeout: Setting default user state');
        _appStateNotifier.update(EvacTrackerAuthUser(loggedIn: false, uid: ''));
        setState(() {});
      }
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // 🔔 1. Restore badge + notifications
      final badgeProvider = Provider.of<NotificationBadgeProvider>(
        context,
        listen: false,
      );

      final notifications = await NotificationBadgeManager.fetchNotifications();
      final count = await NotificationBadgeManager.getNotificationCount();

      badgeProvider.setFullNotifications(notifications);
      badgeProvider.setNotificationCount(count);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void setLocale(String language) {
    setState(() {
      _locale = createLocale(language);
      log('Locale set to: ${_locale!.languageCode}');
    });
  }

  void setThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EvacTracker',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en')],
      theme: ThemeData(brightness: Brightness.light, useMaterial3: false),
      themeMode: _themeMode,
      routerConfig: router,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isNavigating = false; // Add this flag to prevent multiple navigations

  @override
  void initState() {
    super.initState();
    _checkAndNavigate();
  }

  Future<void> _checkAndNavigate() async {
    if (_isNavigating) return; // Prevent multiple calls
    
    _isNavigating = true;
    log('SplashScreen: Starting check and navigation');

    try {
      // 1. Wait a brief moment for everything to initialize
      await Future.delayed(const Duration(milliseconds: 500));
      
      // 2. Initialize FFAppState and check for saved auth
      final appState = FFAppState();
      await appState.initializePersistedState();
      
      // Debug: Print what's in SharedPreferences
      log('🔍 SharedPreferences keys:');
      appState.prefs.getKeys().forEach((key) {
        if (key.contains('ff_')) {
          log('   $key: ${appState.prefs.getString(key) ?? appState.prefs.getBool(key)?.toString() ?? "null"}');
        }
      });
      
      // 3. Check if we have auth data in FFAppState
      final hasAuthToken = appState.userAuthentication.authorization.isNotEmpty;
      log('📱 FFAppState auth check: hasAuthToken = $hasAuthToken');
      log('📱 Auth token value: "${appState.userAuthentication.authorization}"');
      
      // 4. Also check AppStateNotifier for consistency
      final appStateNotifier = AppStateNotifier.instance;
      log('📱 AppStateNotifier check: loggedIn = ${appStateNotifier.loggedIn}');
      
      // 5. Determine where to navigate
      String route;
      if (hasAuthToken) {
        // We have saved auth, go to dashboard
        route = '/dashboard';
        log('✅ Auto-login detected, navigating to dashboard');
      } else {
        // No saved auth, go to login
        route = '/login';
        log('❌ No auto-login data, navigating to login');
      }
      
      // 6. Wait for the full 3 seconds total (for splash screen UX)
      final elapsed = Duration(milliseconds: 500);
      final remaining = const Duration(seconds: 3) - elapsed;
      if (remaining > Duration.zero) {
        await Future.delayed(remaining);
      }
      
      // 7. Navigate
      log('SplashScreen: Navigating to $route');
      if (mounted) {
        context.go(route);
        log('SplashScreen: Navigation executed');
      } else {
        log('SplashScreen: Widget not mounted, skipping navigation');
      }
      
    } catch (e) {
      log('❌ Error in splash screen navigation: $e');
      
      // Fallback navigation on error
      if (mounted) {
        context.go('/login');
      }
    } finally {
      _isNavigating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash.gif',
          width: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
