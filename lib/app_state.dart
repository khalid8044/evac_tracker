

import 'dart:developer';

import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
   
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_userAuthentication')) {
        try {
          
          final serializedData =
              prefs.getString('ff_userAuthentication') ?? '{}';
              log(serializedData);
          _userAuthentication = AuthenticationStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          log("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_userData')) {
        try {
          _userData = jsonDecode(prefs.getString('ff_userData') ?? '');
        } catch (e) {
          log("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _loginHeader = prefs.getString('ff_loginHeader') ?? _loginHeader;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_activeBuilding')) {
        try {
          final serializedData = prefs.getString('ff_activeBuilding') ?? '{}';
          _activeBuilding =
              BuildingStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          log("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_user')) {
        try {
          final serializedData = prefs.getString('ff_user') ?? '{}';
          _user = UserStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          log("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _isTempVisitor = prefs.getBool('ff_isTempVisitor') ?? _isTempVisitor;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_visitorBuilding')) {
        try {
          final serializedData = prefs.getString('ff_visitorBuilding') ?? '{}';
          _visitorBuilding =
              BuildingStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          log("Can't decode persisted data type. Error: $e.");
        }
      }
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  AuthenticationStruct _userAuthentication =
    AuthenticationStruct.fromSerializableMap(jsonDecode('{}'));
AuthenticationStruct get userAuthentication => _userAuthentication;

// FIXED SETTER:
set userAuthentication(AuthenticationStruct value) {
  _userAuthentication = value;
  prefs.setString('ff_userAuthentication', value.serialize()); // ✅ CORRECT KEY
}

// FIXED UPDATE METHOD:
void updateUserAuthenticationStruct(Function(AuthenticationStruct) updateFn) {
  updateFn(_userAuthentication);
  prefs.setString('ff_userAuthentication', _userAuthentication.serialize()); // ✅ CORRECT KEY
}

  

  BuildingStruct qrBuilding = BuildingStruct.fromSerializableMap(
      jsonDecode('{\"buildingID\":\"0\",\"FloorID\":\"0\",\"roomID\":\"0\"}'));

  void updateQrBuildingStruct(Function(BuildingStruct) updateFn) {
    updateFn(qrBuilding);
  }

  dynamic _userData;
  dynamic get userData => _userData;
  set userData(dynamic value) {
    _userData = value;
    prefs.setString('ff_userData', jsonEncode(value));
  }

  dynamic qrCodeJson;

  bool isQR = false;

  bool passwordMatch = false;

  String _loginHeader = '';
  String get loginHeader => _loginHeader;
  set loginHeader(String value) {
    _loginHeader = value;
    prefs.setString('ff_loginHeader', value);
  }

  BuildingStruct _activeBuilding =
      BuildingStruct.fromSerializableMap(jsonDecode('{}'));
  BuildingStruct get activeBuilding => _activeBuilding;
  set activeBuilding(BuildingStruct value) {
    _activeBuilding = value;
    prefs.setString('ff_activeBuilding', value.serialize());
  }

  void updateActiveBuildingStruct(Function(BuildingStruct) updateFn) {
    updateFn(_activeBuilding);
    prefs.setString('ff_activeBuilding', _activeBuilding.serialize());
  }

  bool emergencyType = false;

  bool flashlight = false;

  UserStruct _user = UserStruct();
  UserStruct get user => _user;
  set user(UserStruct value) {
    _user = value;
    prefs.setString('ff_user', value.serialize());
  }

  void updateUserStruct(Function(UserStruct) updateFn) {
    updateFn(_user);
    prefs.setString('ff_user', _user.serialize());
  }

  bool _isTempVisitor = false;
  bool get isTempVisitor => _isTempVisitor;
  set isTempVisitor(bool value) {
    _isTempVisitor = value;
    prefs.setBool('ff_isTempVisitor', value);
  }

  bool _isFloodVisitor = false;
  bool get isFloodVisitor => _isFloodVisitor;
  set isFloodVisitor(bool value) {
    _isFloodVisitor = value;
    prefs.setBool('ff_isFloodVisitor', value);
  }

  bool _isNotification = false;
  bool get isNotification => _isNotification;
  set isNotification(bool value) {
    _isNotification = value;
    prefs.setBool('ff_isNotification', value);
  }

  BuildingStruct _visitorBuilding = BuildingStruct();
  BuildingStruct get visitorBuilding => _visitorBuilding;
  set visitorBuilding(BuildingStruct value) {
    _visitorBuilding = value;
    prefs.setString('ff_visitorBuilding', value.serialize());
  }

  void updateVisitorBuildingStruct(Function(BuildingStruct) updateFn) {
    updateFn(_visitorBuilding);
    prefs.setString('ff_visitorBuilding', _visitorBuilding.serialize());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (e) {
    debugPrint('Initialization failed: $e');
  }
}


