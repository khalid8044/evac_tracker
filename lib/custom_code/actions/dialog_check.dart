import 'package:flutter/material.dart';

class DialogManager {
  static final List<BuildContext> _activeDialogs = [];

  static void addDialog(BuildContext context) {
    _activeDialogs.add(context);
  }

  static void removeDialog(BuildContext context) {
    _activeDialogs.remove(context);
  }

  static void disposeAllDialogs() {
    for (var context in _activeDialogs) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
    _activeDialogs.clear();
  }
}
