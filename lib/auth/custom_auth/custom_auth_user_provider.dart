import 'package:rxdart/rxdart.dart';

import '/backend/schema/structs/index.dart';
import 'custom_auth_manager.dart';

class EvacTrackerAuthUser {
  EvacTrackerAuthUser({
    required this.loggedIn,
    this.uid,
    this.userData,
  });

  bool loggedIn;
  String? uid;
  UserStruct? userData;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<EvacTrackerAuthUser> evacTrackerAuthUserSubject =
    BehaviorSubject.seeded(EvacTrackerAuthUser(loggedIn: false));
Stream<EvacTrackerAuthUser> evacTrackerAuthUserStream() =>
    evacTrackerAuthUserSubject
        .asBroadcastStream()
        .map((user) => currentUser = user);
