

import '/backend/api_requests/api_interceptor.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class MyHttpOverrides extends FFApiInterceptor {
  MyHttpOverrides() {
    CustomHttpOverrides.initialize();
  }
  @override
  Future<ApiCallOptions> onRequest({
    required ApiCallOptions options,
  }) async {
    // Perform any necessary calls or modifications to the [options] before
    // the API call is made.
    CustomHttpOverrides.initialize();
    return options;
  }

  @override
  Future<ApiCallResponse> onResponse({
    required ApiCallResponse response,
    required Future<ApiCallResponse> Function() retryFn,
  }) async {
    // Perform any necessary calls or modifications to the [response] prior
    // to returning it.
    return response;
  }
}

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  static Future<void> initialize() async {
  
        await rootBundle.load('assets/u5ayxxt5clg5/6362d808e0b15941.pem');
    //context.setTrustedCertificatesBytes(data.buffer.asUint8List());
    HttpOverrides.global = CustomHttpOverrides();
  }
}
