// ignore_for_file: unnecessary_getters_setters

import '../../../flutter_flow/nav/serialization_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AuthenticationStruct extends BaseStruct {
  AuthenticationStruct({
    String? authorization,
    String? csrfToken,
    String? refreshToken,
  })  : _authorization = authorization,
        _csrfToken = csrfToken,
        _refreshToken = refreshToken;

  // "authorization" field.
  String? _authorization;
  String get authorization => _authorization ?? '';
  set authorization(String? val) => _authorization = val;

  bool hasAuthorization() => _authorization != null;

  // "csrfToken" field.
  String? _csrfToken;
  String get csrfToken => _csrfToken ?? '';
  set csrfToken(String? val) => _csrfToken = val;

  bool hasCsrfToken() => _csrfToken != null;

  // "refreshToken" field.
  String? _refreshToken;
  String get refreshToken => _refreshToken ?? '';
  set refreshToken(String? val) => _refreshToken = val;

  bool hasRefreshToken() => _refreshToken != null;

  static AuthenticationStruct fromMap(Map<String, dynamic> data) =>
      AuthenticationStruct(
        authorization: data['authorization'] as String?,
        csrfToken: data['csrfToken'] as String?,
        refreshToken: data['refreshToken'] as String?,
      );

  static AuthenticationStruct? maybeFromMap(dynamic data) => data is Map
      ? AuthenticationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'authorization': _authorization,
        'csrfToken': _csrfToken,
        'refreshToken': _refreshToken,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'authorization': serializeParam(
          _authorization,
          ParamType.String,
        ),
        'csrfToken': serializeParam(
          _csrfToken,
          ParamType.String,
        ),
        'refreshToken': serializeParam(
          _refreshToken,
          ParamType.String,
        ),
      }.withoutNulls;

  static AuthenticationStruct fromSerializableMap(Map<String, dynamic> data) =>
      AuthenticationStruct(
        authorization: deserializeParam(
          data['authorization'],
          ParamType.String,
          false,
        ),
        csrfToken: deserializeParam(
          data['csrfToken'],
          ParamType.String,
          false,
        ),
        refreshToken: deserializeParam(
          data['refreshToken'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AuthenticationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AuthenticationStruct &&
        authorization == other.authorization &&
        csrfToken == other.csrfToken &&
        refreshToken == other.refreshToken;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([authorization, csrfToken, refreshToken]);
}

AuthenticationStruct createAuthenticationStruct({
  String? authorization,
  String? csrfToken,
  String? refreshToken,
}) =>
    AuthenticationStruct(
      authorization: authorization,
      csrfToken: csrfToken,
      refreshToken: refreshToken,
    );
