import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';
import 'interceptors.dart';

export 'api_manager.dart' show ApiCallResponse;

/// Start evacProj Group Code

class EvacProjGroup {
  static String getBaseUrl() => 'https://evactracker.com.au/api/';
  static Map<String, String> headers = {};
  static LoginCall loginCall = LoginCall();
  static RegisterVisitorCall registerVisitorCall = RegisterVisitorCall();
  static RegisterFloodContractorCall registerFloodContractorCall =
      RegisterFloodContractorCall();
  static RegisterResidentCall registerResidentCall = RegisterResidentCall();
  static TokenRefreshCall tokenRefreshCall = TokenRefreshCall();
  static ConfirmPasswordResetCall confirmPasswordResetCall =
      ConfirmPasswordResetCall();
  static PasswordResetRequestCall passwordResetRequestCall =
      PasswordResetRequestCall();

  static final interceptors = [
    MyHttpOverrides(),
  ];
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) async {
    final baseUrl = EvacProjGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "username": "$username",
  "password": "$password"
}''';
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'login',
        apiUrl: '${baseUrl}mobile_login',
        callType: ApiCallType.POST,
        headers: const {},
        params: const {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjGroup.interceptors,
    );
  }

  String? refreshToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.tokens["refresh-token"]''',
      ));
  String? accessToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.tokens["access-token"]''',
      ));
  String? csrfToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.tokens["csrf-token"]''',
      ));
  int? uid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.user.id''',
      ));
  String? userType(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.status''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.name''',
      ));
  String? profileStatus(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.profile_status''',
      ));
  bool? isPeep(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.user.is_peep''',
      ));
  int? activeFlat(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.user.live_flat''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.email''',
      ));
  String? profileImage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.profile_image''',
      ));
  String? username(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.username''',
      ));
  String? mobileNumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.mobile_number''',
      ));
}

class RegisterVisitorCall {
  Future<ApiCallResponse> call({
    int? building,
    int? floor,
    String? flat = '',
    String? name = '',
    String? email = '',
    String? days = '',
    String? arrivalTime = '',
    String? departureTime = '',
    String? password = '',
    String? mobileNumber = '',
    String? isPeep = 'False',
    String? nomineeName = '',
    String? nomineeContact = '',
    String? peepType = '',
    String? expirationDate = '',
    String? reviewDate = '',
    String? assistanceType = '',
    FFUploadedFile? profileImage,
  }) async {
    final baseUrl = EvacProjGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'registerVisitor',
        apiUrl: '${baseUrl}qr_visitor',
        callType: ApiCallType.POST,
        headers: const {},
        params: {
          'name': name,
          if (email != '') 'email': email!.toLowerCase(),
          'is_peep': isPeep,
          'building': building,
          'floor': floor,
          if (flat != '0') 'flat': flat,
          if (days != '') 'days': days,
          if (arrivalTime != '') 'arrival_time': arrivalTime,
          'departure_time': departureTime,
          if (password != '') 'password': password,
          if (mobileNumber != '') 'mobile_number': mobileNumber,
          if (isPeep == 'True' || isPeep == 'true') ...{
            if (nomineeName != '') 'nominee_name': nomineeName,
            if (nomineeContact != '') 'nominee_contact': nomineeContact,
            if (peepType != '') 'peep_type': peepType,
            if (peepType == 'Temporary') 'expiration_date': expirationDate,
            if (peepType == 'Temporary') 'review_date': reviewDate,
            if (assistanceType != '') 'assistance_type': assistanceType,
          },
          if (profileImage?.name != null) 'profile_image': profileImage,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjGroup.interceptors,
    );
  }

  String? refreshToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.tokens["refresh-token"]''',
      ));
  String? csrfToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.tokens["csrf-token"]''',
      ));
  String? accessToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.tokens["access-token"]''',
      ));
  int? uid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.user.id''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.name''',
      ));
  String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.status''',
      ));
  String? photo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.profile_image''',
      ));
}

class RegisterFloodContractorCall {
  Future<ApiCallResponse> call({
    int? building,
    int? floor,
    String? flat = '',
    String? name = '',
    String? email = '',
    String? days = '',
    String? arrivalTime = '',
    String? departureTime = '',
    String? password = '',
    String? mobileNumber = '',
    String? isPeep = 'False',
    String? nomineeName = '',
    String? nomineeContact = '',
    String? peepType = '',
    String? expirationDate = '',
    String? reviewDate = '',
    String? assistanceType = '',
    FFUploadedFile? profileImage,
  }) async {
    final baseUrl = EvacProjGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'registerFloodContractor',
        apiUrl: '${baseUrl}qr_flood_contractor',
        callType: ApiCallType.POST,
        headers: const {},
        params: {
          'name': name,
          if (email != '') 'email': email!.toLowerCase(),
          'is_peep': isPeep,
          'building': building,
          'floor': floor,
          if (flat != '0') 'flat': flat,
          if (days != '') 'days': days,
          if (arrivalTime != '') 'arrival_time': arrivalTime,
          'departure_time': departureTime,
          if (password != '') 'password': password,
          if (mobileNumber != '') 'mobile_number': mobileNumber,
          if (isPeep == 'True' || isPeep == 'true') ...{
            if (nomineeName != '') 'nominee_name': nomineeName,
            if (nomineeContact != '') 'nominee_contact': nomineeContact,
            if (peepType != '') 'peep_type': peepType,
            if (peepType == 'Temporary') 'expiration_date': expirationDate,
            if (peepType == 'Temporary') 'review_date': reviewDate,
            if (assistanceType != '') 'assistance_type': assistanceType,
          },
          if (profileImage?.name != null) 'profile_image': profileImage,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjGroup.interceptors,
    );
  }

  String? refreshToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.tokens["refresh-token"]''',
      ));
  String? csrfToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.tokens["csrf-token"]''',
      ));
  String? accessToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.tokens["access-token"]''',
      ));
  int? uid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.user.id''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.name''',
      ));
  String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.status''',
      ));
  String? photo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.profile_image''',
      ));
}

class RegisterResidentCall {
  Future<ApiCallResponse> call({
    String? mobileNumber = '',
    String? email = '',
    String? name = '',
    String? password = '',
    int? building,
    int? floor,
    int? flat,
    String? isPeep = 'False',
    String? nomineeName = '',
    String? peepType = '',
    String? nomineeContact = '',
    String? expirationDate = '',
    String? reviewDate = '',
    String? assistanceType = '',
    FFUploadedFile? profileImage,
  }) async {
    final baseUrl = EvacProjGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'registerResident',
        apiUrl: '${baseUrl}qr_resident',
        callType: ApiCallType.POST,
        headers: const {},
        params: {
          'mobile_number': mobileNumber,
          'email': email!.toLowerCase(),
          'name': name,
          'password': password,
          'building': building,
          'floor': floor,
          'flat': flat,
          'is_peep': isPeep,
          if (isPeep == 'True' || isPeep == 'true') ...{
            'nominee_name': nomineeName,
            'peep_type': peepType,
            'nominee_contact ': nomineeContact,
            if (peepType == 'Temporary') 'expiration_date': expirationDate,
            if (peepType == 'Temporary') 'review_date ': reviewDate,
            'assistance_type ': assistanceType,
          },
          if (profileImage?.name != null) 'profile_image': profileImage,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjGroup.interceptors,
    );
  }
}

class TokenRefreshCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = EvacProjGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'tokenRefresh',
        apiUrl: '${baseUrl}mobile_refresh',
        callType: ApiCallType.POST,
        headers: const {},
        params: {
          'refresh_token': token,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjGroup.interceptors,
    );
  }

  String? authorization(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.Authorization''',
      ));
}

class ConfirmPasswordResetCall {
  Future<ApiCallResponse> call({
    String? email = '',
    int? code,
    String? newPassword = '',
    String? confirmNewPassword = '',
  }) async {
    final baseUrl = EvacProjGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'confirmPasswordReset',
        apiUrl: '${baseUrl}password-reset/confirm-reset/',
        callType: ApiCallType.POST,
        headers: const {},
        params: {
          'email': email!.toLowerCase(),
          'code': code,
          'new_password': newPassword,
          'confirm_new_password': confirmNewPassword,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjGroup.interceptors,
    );
  }
}

class PasswordResetRequestCall {
  Future<ApiCallResponse> call({
    String? email = '',
  }) async {
    final baseUrl = EvacProjGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email": "$email"
}''';
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'passwordResetRequest',
        apiUrl: '${baseUrl}password-reset/request-reset/',
        callType: ApiCallType.POST,
        headers: const {},
        params: const {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjGroup.interceptors,
    );
  }
}

/// End evacProj Group Code

/// Start evacProjAfterLogin Group Code

class EvacProjAfterLoginGroup {
  static String getBaseUrl({
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) =>
      'https://evactracker.com.au/api/';
  static Map<String, String> headers = {
    'Authorization': '[authToken]',
    'x-refresh-token': '[refreshToken]',
    'X-CSRFToken': '[csrfToken]',
  };
  static EvacDiagramByIDCall evacDiagramByIDCall = EvacDiagramByIDCall();
  static GetActiveFlatCall getActiveFlatCall = GetActiveFlatCall();
  static VisitCall visitCall = VisitCall();
  static GetECLCall getECLCall = GetECLCall();
  static GetFlatsByUserIDCall getFlatsByUserIDCall = GetFlatsByUserIDCall();
  static ActivateFlatByUserIDCall activateFlatByUserIDCall =
      ActivateFlatByUserIDCall();
  static GetAssemblyAreaCall getAssemblyAreaCall = GetAssemblyAreaCall();
  static GetFlatByFloorCall getFlatByFloorCall = GetFlatByFloorCall();
  static UpdatePeepStatusCall updatePeepStatusCall = UpdatePeepStatusCall();
  static UpdatePasswordCall updatePasswordCall = UpdatePasswordCall();
  static UpdateUserCall updateUserCall = UpdateUserCall();
  static InsertPeepCall insertPeepCall = InsertPeepCall();
  static GetPeepByUserCall getPeepByUserCall = GetPeepByUserCall();
  static UpdatePeepByUserCall updatePeepByUserCall = UpdatePeepByUserCall();
  static DeleteAddressCall deleteAddressCall = DeleteAddressCall();
  static DeleteUserCall deleteUserCall = DeleteUserCall();
  static AddAddressCall addAddressCall = AddAddressCall();
  static AddAddressResidentCall addAddressResidentCall =
      AddAddressResidentCall();
  static AddAddressPermContractorCall addAddressPermContractorCall =
      AddAddressPermContractorCall();
  static AddAddressTempContractorCall addAddressTempContractorCall =
      AddAddressTempContractorCall();
  static GetAddressesByUserTypeCall getAddressesByUserTypeCall =
      GetAddressesByUserTypeCall();
  static GetAddressesByUserIDCall getAddressesByUserIDCall =
      GetAddressesByUserIDCall();
  static UpdateUserEvacStatusCall updateUserEvacStatusCall =
      UpdateUserEvacStatusCall();
  static UpdateAddressByIDCall updateAddressByIDCall = UpdateAddressByIDCall();
  static GetAddressByIDCall getAddressByIDCall = GetAddressByIDCall();
  static FloodAlarmCall floodAlarmCall = FloodAlarmCall();
  static final interceptors = [
    MyHttpOverrides(),
  ];
}

class EvacDiagramByIDCall {
  Future<ApiCallResponse> call({
    int? floor,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'evacDiagramByID',
        apiUrl: '${baseUrl}evacuation_diagram_ddl',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'floor': floor,
        },
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }

  String? floorName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].floor_data.floor_no''',
      ));
  String? buildingName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].building_data.name''',
      ));
  String? siteName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].site_data.name''',
      ));
  String? evacDiagramPath(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].evacuation_diagram''',
      ));
}

class GetActiveFlatCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getActiveFlat',
        apiUrl: '${baseUrl}users/active-flat/',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authToken',
        },
        params: {},
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }

  // Extracting the building, floor, and flat fields from the response
  String? building(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.detail.building''', // Corrected path
      ));

  String? floor(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.detail.floor''', // Corrected path
      ));

  String? flat(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.detail.flat''', // Corrected path
      ));

  int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.detail.id''', // Corrected path
      ));
}

class VisitCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'visit',
        apiUrl: '${baseUrl}visit/$userId',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: const {},
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class GetECLCall {
  Future<ApiCallResponse> call({
    int? building,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getECL',
        apiUrl: '${baseUrl}ecl',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'building': building,
        },
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }

  String? policeFireAmbulance(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results[:].police_fire_ambulance''',
      ));
  String? stateEmergencyService(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results[:].state_emergency_service''',
      ));
  String? poisonsInformationCenter(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results[:].poisons_information_center''',
      ));
  String? crisisSupport(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].crisis_support''',
      ));
  String? medicalCenterName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results[:].nearest_medical_center''',
      ));
  String? medicalCenterNo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].nearest_medical_center_contact''',
      ));
  String? hospital(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].nearest_medical_hospital''',
      ));
  String? hospitalNumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].nearest_medical_hospital_contact''',
      ));
  dynamic result(dynamic response) => getJsonField(
        response,
        r'''$.results[0]''',
      );
}

class GetFlatsByUserIDCall {
  Future<ApiCallResponse> call({
    int? resident,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getFlatsByUserID',
        apiUrl: '${baseUrl}flat',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'resident': resident,
        },
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }

  int? buildingID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.results[:].building_data.id''',
      ));
  String? buildingName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].building_data.name''',
      ));
  int? floorId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.results[:].floor_data.id''',
      ));
  String? floorName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].floor_data.floor_no''',
      ));
  String? flatName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].flat_no''',
      ));
  int? flatId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.results[:].id''',
      ));
  List? results(dynamic response) => getJsonField(
        response,
        r'''$.results''',
        true,
      ) as List?;
}

class ActivateFlatByUserIDCall {
  Future<ApiCallResponse> call({
    int? flatId,
    int? userId,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "live_flat": $flatId
}''';
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'activateFlatByUserID',
        apiUrl: '${baseUrl}users/$userId/',
        callType: ApiCallType.PATCH,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: const {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class GetAssemblyAreaCall {
  Future<ApiCallResponse> call({
    int? building,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getAssemblyArea',
        apiUrl: '${baseUrl}assembly_area',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'building': building,
        },
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }

  List<String>? lat(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].latitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? long(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].longitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].area_type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetFlatByFloorCall {
  Future<ApiCallResponse> call({
    int? floor,
  }) async {
    final baseUrl = EvacProjGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getFlatByFloor',
        apiUrl: '${baseUrl}flat_ddl/',
        callType: ApiCallType.GET,
        headers: {},
        params: {
          'floor': floor,
        },
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjGroup.interceptors,
    );
  }

  // Manually parsing JSON to extract 'id' list
  List<String>? value(dynamic response) {
    // Assuming response is in JSON string format
    try {
      // Parse response manually using jsonDecode
      List<dynamic> data = jsonDecode(response.bodyText.toString());

      // Extract 'id' values
      List<String> ids = data.map((item) => item['id'].toString()).toList();

      return ids;
    } catch (e) {
      log("Error parsing 'id' values: $e");
      return null;
    }
  }

  // Manually parsing JSON to extract 'flat_no' list
  List<String>? description(dynamic response) {
    // Assuming response is in JSON string format
    try {
      // Parse response manually using jsonDecode
      List<dynamic> data = jsonDecode(response.bodyText.toString());

      // Extract 'flat_no' values
      List<String> flatNos =
          data.map((item) => item['flat_no'].toString()).toList();

      return flatNos;
    } catch (e) {
      log("Error parsing 'flat_no' values: $e");
      return null;
    }
  }
}

class UpdatePeepStatusCall {
  Future<ApiCallResponse> call({
    int? userId,
    bool? isPeep,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'updatePeepStatus',
        apiUrl: '${baseUrl}users/$userId/',
        callType: ApiCallType.PATCH,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'is_peep': isPeep,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }

  int? uid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  String? username(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.username''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  String? profileImage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.profile_image''',
      ));
  String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  String? mobileNumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.mobile_number''',
      ));
  bool? isPeep(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.is_peep''',
      ));
  int? liveFlat(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.live_flat''',
      ));
}

class UpdatePasswordCall {
  Future<ApiCallResponse> call({
    String? oldPassword = '',
    String? newPassword = '',
    String? confirmNewPassword = '',
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'updatePassword',
        apiUrl: '${baseUrl}users/change-password/',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'confirm_new_password': confirmNewPassword,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }

  List<String>? oldPasswordError(dynamic response) => (getJsonField(
        response,
        r'''$.old_password''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? newPasswordError(dynamic response) => (getJsonField(
        response,
        r'''$.new_password''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? confirmPasswordError(dynamic response) => (getJsonField(
        response,
        r'''$.confirm_new_password''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class UpdateUserCall {
  Future<ApiCallResponse> call({
    int? userId,
    String? name = '',
    String? email = '',
    String? mobile = '',
    FFUploadedFile? picture,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'updateUser',
        apiUrl: '${baseUrl}users/$userId/',
        callType: ApiCallType.PATCH,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'name': name,
          'email': email!.toLowerCase(),
          'mobile_number': mobile,
          if (picture?.name != null) 'profile_image': picture,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }

  String? fullName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  String? emailAddress(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  String? mobileNumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.mobile_number''',
      ));
  String? profilePicture(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.profile_image''',
      ));
}

class InsertPeepCall {
  Future<ApiCallResponse> call({
    int? uid,
    String? dateOfBirth = '',
    String? nomineeName = '',
    String? nomineeContact = '',
    String? expirationDate = '',
    String? reviewDate = '',
    String? assistanceType = '',
    String? evacuationMethod = '',
    String? peepType = 'Perminent',
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'insertPeep',
        apiUrl: '${baseUrl}peep/',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'user': uid,
          //'date_of_birth': dateOfBirth,
          'nominee_name': nomineeName,
          'nominee_contact': nomineeContact,
          if (expirationDate != '') 'expiration_date': expirationDate,
          if (reviewDate != '') 'review_date': reviewDate,
          'assistance_type': assistanceType,
          //'evacuation_method': evacuationMethod,
          'peep_type': peepType,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class GetPeepByUserCall {
  Future<ApiCallResponse> call({
    int? uid,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getPeepByUser',
        apiUrl: '${baseUrl}peep/',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'user': uid,
        },
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }

  String? dob(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].date_of_birth''',
      ));
  String? peepType(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].peep_type''',
      ));
  String? nomineeContact(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].nominee_contact''',
      ));
  String? reviewDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].review_date''',
      ));
  String? evacMethod(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].evacuation_method''',
      ));
  String? assistanceType(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].assistance_type''',
      ));
  String? expirationDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].expiration_date''',
      ));
  String? nomineeName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].nominee_name''',
      ));
  int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.results[:].id''',
      ));
}

class UpdatePeepByUserCall {
  Future<ApiCallResponse> call({
    int? id,
    String? nomineeName = '',
    String? dateOfBirth = '',
    String? peepType = '',
    String? nomineeContact = '',
    String? expirationDate = '',
    String? reviewDate = '',
    String? assistanceType = '',
    String? evacuationMethod = '',
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'updatePeepByUser',
        apiUrl: '${baseUrl}peep/$id/',
        callType: ApiCallType.PATCH,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'nominee_name': nomineeName,
          'date_of_birth': dateOfBirth,
          'peep_type': peepType,
          'nominee_contact': nomineeContact,
          if (peepType != 'Permanent') 'expiration_date': expirationDate,
          //if (peepType != 'Permanent') 'review_date': reviewDate,
          'review_date': reviewDate,
          'assistance_type': assistanceType,
          'evacuation_method': evacuationMethod,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class DeleteAddressCall {
  Future<ApiCallResponse> call({
    int? id,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'deleteAddress',
        apiUrl: '${baseUrl}user_flat/$id/',
        callType: ApiCallType.DELETE,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: const {},
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class DeleteUserCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? code = '',
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    final bodyVar = jsonEncode({
      'email': '$email',
      'code': code,
    });

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'deleteUser',
        apiUrl: '${baseUrl}user_ios/delete',
        callType: ApiCallType.DELETE,
        headers: {
          'Authorization': '$authToken',
        },
        body: bodyVar,
        bodyType: BodyType.JSON,
        params: const {},
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: true,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class AddAddressCall {
  Future<ApiCallResponse> call({
    int? user,
    int? flat,
    int? floor,
    String? userType = '',
    List<String>? daysList,
    String? arrivalTime = '',
    String? departureTime = '',
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );
    final days = _serializeList(daysList);

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'addAddress',
        apiUrl: '${baseUrl}user_flat/',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'user': user,
          'flat': flat,
          'floor': floor,
          'user_type': userType,
          'days': days,
          'arrival_time': arrivalTime,
          'departure_time': departureTime,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class AddAddressResidentCall {
  Future<ApiCallResponse> call({
    int? user,
    int? flat,
    int? floor,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'addAddressResident',
        apiUrl: '${baseUrl}user_flat/',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'user': user,
          'flat': flat,
          'floor': floor,
          'user_type': "Resident",
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class AddAddressPermContractorCall {
  Future<ApiCallResponse> call({
    int? user,
    int? flat,
    int? floor,
    String? days = '',
    String? arrivalTime = '',
    String? departureTime = '',
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'addAddressPermContractor',
        apiUrl: '${baseUrl}user_flat/',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'user': user,
          if (flat != 0) 'flat': flat,
          'floor': floor,
          'user_type': "Permanent Contractor",
          'days': days,
          'arrival_time': arrivalTime,
          'departure_time': departureTime,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class AddAddressTempContractorCall {
  Future<ApiCallResponse> call({
    int? user,
    int? flat,
    int? floor,
    String? arrivalTime = '',
    String? departureTime = '',
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "user": $user,
  "floor": "$floor",
  "user_type": "Temporary Contractor",
  "departure_time": "$departureTime"
}''';
//"arrival_time": "$arrivalTime",
    log(ffApiRequestBody);
    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'addAddressTempContractor',
        apiUrl: '${baseUrl}user_flat/',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: const {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }

  List<String>? error(dynamic response) => (getJsonField(
        response,
        r'''$.non_field_errors''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetAddressesByUserTypeCall {
  Future<ApiCallResponse> call({
    int? user,
    String? userType = '',
    bool? isApproved = true,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    ApiCallResponse response = await FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getAddressesByUserType',
        apiUrl: '${baseUrl}user_flat/',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'user': user,
          'user_type': userType,
          'is_approved': isApproved,
        },
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
    return response;
  }

  List? results(dynamic response) => getJsonField(
        response,
        r'''$.results''',
        true,
      ) as List?;
}

class GetAddressesByUserIDCall {
  Future<ApiCallResponse> call({
    int? user,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getAddressesByUserID',
        apiUrl: '${baseUrl}user_flat/',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'user': user,
          'is_approved': "True",
        },
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }

  List? results(dynamic response) => getJsonField(
        response,
        r'''$.results''',
        true,
      ) as List?;
  List<String>? flat(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].flat_data.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? floor(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].floor_data.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? building(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].building_data.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? id(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class UpdateAddressByIDCall {
  Future<ApiCallResponse> call({
    int? id,
    String? arrivalTime = '',
    String? departureTime = '',
    String? days = '',
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'updateAddressByID',
        apiUrl: '${baseUrl}user_flat/$id/',
        callType: ApiCallType.PATCH,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: {
          'arrival_time': arrivalTime,
          'departure_time': departureTime,
          'days': days,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class GetAddressByIDCall {
  Future<ApiCallResponse> call({
    int? id,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'getAddressByID',
        apiUrl: '${baseUrl}user_flat/$id',
        callType: ApiCallType.GET,
        headers: {
          'Authorization': '$authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
        },
        params: const {},
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class FloodAlarmCall {
  Future<ApiCallResponse> call({
    String? userFlat = '',
    FFUploadedFile? floodImage,
    int? createdBy,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      authToken: authToken,
    );

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'floodAlarm',
        apiUrl: '${baseUrl}flood_alarm/',
        callType: ApiCallType.POST,
        headers: {
          'Authorization': '$authToken',
        },
        params: {
          'user_flat': userFlat,
          'flood_image': floodImage,
          'created_by': createdBy,
        },
        bodyType: BodyType.MULTIPART,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

class UpdateUserEvacStatusCall {
  Future<ApiCallResponse> call({
    required String buildingId, // The building ID
    bool? isActive,
    bool? inBuilding,
    bool? exitBuilding,
    bool? reachedAssemblyArea,
    String? csrfToken = '',
    String? refreshToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = EvacProjAfterLoginGroup.getBaseUrl(
      csrfToken: csrfToken,
      refreshToken: refreshToken,
      authToken: authToken,
    );

    // Construct API URL using the buildingId
    final apiUrl = '${baseUrl}user_flat/bulk_update/?building_id=$buildingId';

    // Construct the request payload with nullable fields
    final payload = <String, dynamic>{
      if (isActive != null) 'is_active': isActive,
      if (inBuilding != null) 'in_building': inBuilding,
      if (exitBuilding != null) 'exit_building': exitBuilding,
      if (reachedAssemblyArea != null)
        'reached_assembly_area': reachedAssemblyArea,
    };

    return FFApiInterceptor.makeApiCall(
      ApiCallOptions(
        callName: 'updateUserEvacStatus',
        apiUrl: apiUrl,
        callType: ApiCallType.PATCH,
        headers: {
          'Authorization': 'Bearer $authToken',
          'x-refresh-token': '$refreshToken',
          'X-CSRFToken': '$csrfToken',
          'Content-Type': 'application/json', // Set content type to JSON
        },
        body: jsonEncode(payload), // Pass the payload as JSON body
        bodyType: BodyType.JSON,
        params: const {},
        returnBody: true,
        encodeBodyUtf8: true,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: true,
      ),
      EvacProjAfterLoginGroup.interceptors,
    );
  }
}

/// End evacProjAfterLogin Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      log("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

