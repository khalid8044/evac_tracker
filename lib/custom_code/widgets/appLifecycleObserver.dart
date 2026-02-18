import 'package:evac_tracker/services/notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;

  const AppLifecycleObserver({super.key, required this.child});

  @override
  State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Handle app resumed
      _handleAppVisibility();
    }
  }

  Future<void> _handleAppVisibility() async {
    await NotificationManager.handleNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
