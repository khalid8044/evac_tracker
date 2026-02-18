import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';

Future<Map<String, dynamic>> updateTokens() async {
  ApiCallResponse? apiResult86a;

  apiResult86a = await EvacProjGroup.tokenRefreshCall.call(
    token: currentAuthRefreshToken,
  );

  if ((apiResult86a.succeeded)) {
    FFAppState().updateUserAuthenticationStruct(
      (e) => e
        ..authorization = EvacProjGroup.tokenRefreshCall.authorization(
          (apiResult86a?.jsonBody ?? ''),
        ),
    );
    return {
      "isUpdated": true,
      "newToken": EvacProjGroup.tokenRefreshCall.authorization(
        (apiResult86a.jsonBody ?? ''),
      )
    };
  } else {
    return {"isUpdated": false};
  }
}
