// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/backend/api_requests/api_interceptor.dart';
import '/backend/api_requests/api_manager.dart';
import 'dart:convert';

class CheckTokens extends FFApiInterceptor {
  @override
  Future<ApiCallOptions> onRequest({
    required ApiCallOptions options,
  }) async {
    String? currentAuthToken = FFAppState().userAuthentication.authorization;
    final isAuthTokenValid = await checkIfAuthTokenValid(currentAuthToken);
    if (!isAuthTokenValid) {
      final newAuthToken = await refreshAuthToken();
      FFAppState().userAuthentication.authorization = newAuthToken;
    }
    options.headers['Authorization'] =
        'Bearer ${FFAppState().userAuthentication.authorization}';
    return options;
  }

  @override
  Future<ApiCallResponse> onResponse({
    required ApiCallResponse response,
    required Future<ApiCallResponse> Function() retryFn,
  }) async {
    return response;
  }
}

Future<bool> checkIfAuthTokenValid(String? authToken) async {
  if (authToken == null) {
    return false;
  }
  final decodedToken = parseJwt(authToken);
  final expiryTime =
      DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
  return DateTime.now().isBefore(expiryTime);
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  final payload = base64Url.decode(base64Url.normalize(parts[1]));
  final payloadMap = json.decode(utf8.decode(payload));
  return payloadMap;
}

Future<String> refreshAuthToken() async {
  // Access the refresh token from the app state variable

  final refreshToken = FFAppState().userAuthentication.refreshToken;

  if (refreshToken.isEmpty) {
    throw Exception('Refresh token not found');
  }

  final response = await ApiManager.makeApiCall(
    callName: 'Refresh Token',
    apiUrl: 'http://gulfdiscoveries.online/api/mobile_refresh',
    callType: ApiCallType.POST,
    headers: {
      'Content-Type': 'application/json',
    },
    params: {},
    body: jsonEncode({
      'token': refreshToken,
    }),
    bodyType: BodyType.JSON,
    returnBody: true,
    encodeBodyUtf8: false,
    decodeUtf8: false,
  );

  if (response.statusCode == 200) {
    // Extract the new auth token from the headers
    final newAuthToken =
        response.headers['authorization']?.replaceFirst('Bearer ', '');
    if (newAuthToken == null) {
      throw Exception('Authorization token not found in response headers');
    }
    //await FlutterFlowSecureStorage().setString('auth_token', newAuthToken);
    return newAuthToken;
  } else {
    throw Exception('Failed to refresh auth token');
  }
}
