// ignore_for_file: prefer_final_fields

import 'dart:developer';

import '/actions/actions.dart' as action_blocks;
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallOptions, ApiCallResponse;

abstract class FFApiInterceptor {
  Future<ApiCallOptions> onRequest({
    required ApiCallOptions options,
  }) async =>
      options;

  Future<ApiCallResponse> onResponse({
    required ApiCallResponse response,
    required Future<ApiCallResponse> Function() retryFn,
  }) async =>
      response;

  static Future<ApiCallResponse> makeApiCall(
      ApiCallOptions options,
      List<FFApiInterceptor> interceptors, {
        int retryCount = 0,
      }) async {
    final initialOptions = options.clone();
    log("calling ${options.callName}");

    // Update the options for each interceptor.
    for (final interceptor in interceptors) {
      try {
        options = await interceptor.onRequest(options: options);
      } catch (apiException) {
        // Log the error and return a failed response.
        log('Error in onRequest interceptor: $apiException');
        return ApiCallResponse(
          '',
          <String, String>{},
          400,
          exception: apiException.toString(),
        );
      }
    }

    log('Final API URL: ${options.apiUrl}');

    ApiCallResponse response;

    try {
      // Make the API call.
      response = await ApiManager.instance.call(options);
      log("API call response: ${response.jsonBody}");
    } catch (apiException) {
      // Log the error if API call fails.
      log('Error making API call: $apiException');
      return ApiCallResponse(
        '',
        <String, String>{},
        400,
        exception: apiException.toString(),
      );
    }

    log("options.callName: ${options.callName}");

    // Check if the response status is 401 or 403 and retry token refresh
    if ((response.statusCode == 401 || response.statusCode == 403) &&
        retryCount < 1 &&
        options.callName != "tokenRefresh") {
      log("Received 401/403 status. Attempting to refresh token...");

      var tokenResponse = await action_blocks.updateTokens();

      if (tokenResponse["isUpdated"]) {
        log("Token refreshed successfully. Updating options with new token and retrying API call...");

        // Update options with the new token
        var updatedHeaders = Map<String, String>.from(options.headers);
        updatedHeaders['Authorization'] = '${tokenResponse["newToken"]}';

        // Create a new ApiCallOptions with updated headers
        options = initialOptions.clone().copyWith(headers: updatedHeaders);

        // Retry the API call with the updated options
        return await makeApiCall(options, interceptors, retryCount: retryCount + 1);
      } else {
        log("Token refresh failed. Logging out...");

        // Handle token refresh failure, e.g., logging out the user
        // await performLogout(context); // Uncomment this if you need to log out the user
        return ApiCallResponse(
          '',
          <String, String>{},
          401, // Or use the original response's status code
          exception: 'Failed to refresh token',
        );
      }
    }

    // Update the response for each interceptor, applied in reverse order.
    for (final interceptor in interceptors.reversed) {
      try {
        response = await interceptor.onResponse(
          response: response,
          retryFn: () => makeApiCall(options, interceptors, retryCount: retryCount),
        );
      } catch (apiException) {
        log('Error in onResponse interceptor: $apiException');
        return ApiCallResponse(
          '',
          <String, String>{},
          400,
          exception: apiException.toString(),
        );
      }
    }

    log("API call completed successfully.");
    return response;
  }
}
extension ApiCallOptionsExtension on ApiCallOptions {
  ApiCallOptions copyWith({
    String? callName,
    ApiCallType? callType,
    String? apiUrl,
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    BodyType? bodyType,
    String? body,
    bool? returnBody,
    bool? encodeBodyUtf8,
    bool? decodeUtf8,
    bool? alwaysAllowBody,
    bool? cache,
    bool? isStreamingApi,
  }) {
    return ApiCallOptions(
      callName: callName ?? this.callName,
      callType: callType ?? this.callType,
      apiUrl: apiUrl ?? this.apiUrl,
      headers: headers ?? this.headers,
      params: params ?? this.params,
      bodyType: bodyType ?? this.bodyType,
      body: body ?? this.body,
      returnBody: returnBody ?? this.returnBody,
      encodeBodyUtf8: encodeBodyUtf8 ?? this.encodeBodyUtf8,
      decodeUtf8: decodeUtf8 ?? this.decodeUtf8,
      alwaysAllowBody: alwaysAllowBody ?? this.alwaysAllowBody,
      cache: cache ?? this.cache,
      isStreamingApi: isStreamingApi ?? this.isStreamingApi,
    );
  }
}


