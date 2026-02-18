import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../backend/api_requests/api_calls.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/nav/serialization_util.dart';
import '../../models/flat_api_response_model.dart';
import '../../models/flat_api_response_model_permanenet_contractor.dart';

class ECLProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<ResultResident> _addressesResident = [];
  List<PermanentContractorResult> _addressesPermContractor = [];

  bool get isLoading => _isLoading;
  List<ResultResident> get addressesResident => _addressesResident;
  List<PermanentContractorResult> get addressesPermContractor =>
      _addressesPermContractor;

  Future<void> fetchAddressesResident(int userId, String authToken) async {
    _setLoading(true);

    try {
      final response =
          await EvacProjAfterLoginGroup.getAddressesByUserTypeCall.call(
        user: userId,
        userType: 'Resident',
        authToken: authToken,
      );

      if (response.succeeded) {
        FlatApiResponseModel flatApiResponseModel =
            FlatApiResponseModel.fromJson(response.jsonBody);
        _addressesResident = flatApiResponseModel.results;
            } else {
        // Handle API error here
      }
    } catch (error) {
      // Handle the error
    }

    _setLoading(false);
  }

  Future<void> fetchAddressesPermContractor(
      int userId, String authToken) async {
    _setLoading(true);

    try {
      final response =
          await EvacProjAfterLoginGroup.getAddressesByUserTypeCall.call(
        user: userId,
        userType: 'Permanent Contractor',
        authToken: authToken,
      );

      if (response.succeeded) {
        FlatApiResponsePermanentContractorModel flatApiResponseModel =
            FlatApiResponsePermanentContractorModel.fromJson(response.jsonBody);
        _addressesPermContractor = flatApiResponseModel.results;
            } else {
        // Handle API error here
      }
    } catch (error) {
      // Handle the error
    }

    _setLoading(false);
  }

  Future<void> getECLPermanentContractor(
      PermanentContractorResult result, BuildContext context) async {
    // Set the loading state for the specific result
    _setContractorLoading(result, true);

    try {
      final apiResult = await EvacProjAfterLoginGroup.getECLCall.call(
        building: result.buildingData.id,
        authToken: FFAppState().userAuthentication.authorization,
      );

      if (apiResult.succeeded) {
        context.pushNamed(
          'emergencyContactList',
          queryParameters: {
            'emergencyContact': serializeParam(
              EvacProjAfterLoginGroup.getECLCall.result(apiResult.jsonBody),
              ParamType.JSON,
            ),
          }.withoutNulls,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Emergency contact list not found',
              style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    } finally {
      // Reset the loading state for the specific result
      _setContractorLoading(result, false);
    }
  }

  Future<void> getECL(ResultResident result, BuildContext context) async {
    // Set the loading state for the specific result
    _setResultLoading(result, true);

    try {
      final apiResult = await EvacProjAfterLoginGroup.getECLCall.call(
        building: result.buildingData.id,
        authToken: FFAppState().userAuthentication.authorization,
      );

      if (apiResult.succeeded) {
        context.pushNamed(
          'emergencyContactList',
          queryParameters: {
            'emergencyContact': serializeParam(
              EvacProjAfterLoginGroup.getECLCall.result(apiResult.jsonBody),
              ParamType.JSON,
            ),
          }.withoutNulls,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Emergency contact list not found',
              style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    } finally {
      // Reset the loading state for the specific result
      _setResultLoading(result, false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setContractorLoading(PermanentContractorResult result, bool isLoading) {
    final index = _addressesPermContractor.indexWhere((r) => r.id == result.id);
    if (index != -1) {
      _addressesPermContractor[index] =
          _addressesPermContractor[index].copyWith(isLoading: isLoading);
      notifyListeners();
    }
  }

  void _setResultLoading(ResultResident result, bool isLoading) {
    final index = _addressesResident.indexWhere((r) => r.id == result.id);
    if (index != -1) {
      _addressesResident[index] =
          _addressesResident[index].copyWith(isLoading: isLoading);
      notifyListeners();
    }
  }
}
