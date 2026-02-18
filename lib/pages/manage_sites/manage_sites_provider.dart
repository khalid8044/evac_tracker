
import 'package:flutter/material.dart';
import '../../components/alerts/delete_confirm/delete_confirm_widget.dart';
import '../../services/notifications_bg.dart';
import '../../services/shared_preference/shared_preference.dart';
import '../../app_state.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../models/flat_api_response_model.dart';
import '../../models/flat_api_response_model_permanenet_contractor.dart';



class ManagerSitesProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<ResultResident> _addressesResident = [];
  List<PermanentContractorResult> _addressesPermContractor = [];
  SharedPreference sharedPreference = SharedPreference();

  bool get isLoading => _isLoading;
  List<ResultResident> get addressesResident => _addressesResident;
  List<PermanentContractorResult> get addressesPermContractor =>
      _addressesPermContractor;

  Future<void> showDialogLeaveResidentBuilding(
      BuildContext context, ResultResident result) async {
    try {
      await showDialog(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            alignment: const AlignmentDirectional(0.0, 0.0)
                .resolve(Directionality.of(context)),
            child: GestureDetector(
              onTap: () => FocusScope.of(dialogContext).unfocus(),
              child: DeleteConfirmWidget(
                flat: result.id,
                onDelete: () async {
                  await _deleteResidentAddress(dialogContext, result);
                },
              ),
            ),
          );
        },
      );
    } catch (error) {
      // Handle any errors
      _showErrorSnackBar(context, 'Failed to leave building.');
    }
  }

  Future<void> showDialogLeaveContractorBuilding(
      BuildContext context, PermanentContractorResult result) async {
    try {
      await showDialog(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            alignment: const AlignmentDirectional(0.0, 0.0)
                .resolve(Directionality.of(context)),
            child: GestureDetector(
              onTap: () => FocusScope.of(dialogContext).unfocus(),
              child: DeleteConfirmWidget(
                flat: result.id,
                onDelete: () async {
                  await _deletePermanentAddress(dialogContext, result);
                },
              ),
            ),
          );
        },
      );
    } catch (error) {
      // Handle any errors
      _showErrorSnackBar(context, 'Failed to leave building.');
    }
  }

  Future<void> _deleteResidentAddress(
      BuildContext context, ResultResident result) async {
    try {
      _setResultLoading(result, true);
      final deleteResponse =
          await EvacProjAfterLoginGroup.deleteAddressCall.call(
        id: result.id,
        authToken: FFAppState().userAuthentication.authorization,
      );

      if (deleteResponse.succeeded) {
        List<String> ids = await sharedPreference.readStringList("buildingIds");

        NotificationPlugin firebaseMessaging = NotificationPlugin();
        firebaseMessaging.unSubScribeToBuilding(ids);
        await sharedPreference.removeBuildingId(
            "buildingIds", result.id.toString());

        List<String> updatedIds =
            await sharedPreference.readStringList("buildingIds");
        firebaseMessaging.subScribeToBuilding(updatedIds);

        FFAppState().update(() {});

        // Reload the resident buildings
        await fetchAddressesResident(FFAppState().user.uid,
            FFAppState().userAuthentication.authorization);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Address deleted successfully.',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: const Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Address could not be deleted.',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: const Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error deleting address. Please contact system adminstrator.',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          duration: const Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    } finally {
      Navigator.pop(context);
      _setResultLoading(result, false);
    }
  }

  Future<void> _deletePermanentAddress(
      BuildContext context, PermanentContractorResult result) async {
    try {
      _setContractorLoading(result, true);
      final deleteResponse =
          await EvacProjAfterLoginGroup.deleteAddressCall.call(
        id: result.id,
        authToken: FFAppState().userAuthentication.authorization,
      );

      if (deleteResponse.succeeded) {
        List<String> ids = await sharedPreference.readStringList("buildingIds");

        NotificationPlugin firebaseMessaging = NotificationPlugin();
        firebaseMessaging.unSubScribeToBuilding(ids);
        await sharedPreference.removeBuildingId(
            "buildingIds", result.id.toString());

        List<String> updatedIds =
            await sharedPreference.readStringList("buildingIds");
        firebaseMessaging.subScribeToBuilding(updatedIds);

        FFAppState().update(() {});

        // Reload the resident buildings
        await fetchAddressesPermContractor(FFAppState().user.uid,
            FFAppState().userAuthentication.authorization);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Address deleted successfully.',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: const Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Address could not be deleted.',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: const Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error occurred while deleting the address.',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          duration: const Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    } finally {
      Navigator.pop(context);
      _setContractorLoading(result, false);
    }
  }

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

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setResultLoading(ResultResident result, bool isLoading) {
    final index = _addressesResident.indexWhere((r) => r.id == result.id);
    if (index != -1) {
      _addressesResident[index] =
          _addressesResident[index].copyWith(isLoading: isLoading);
      notifyListeners();
    }
  }

  void _setContractorLoading(PermanentContractorResult result, bool isLoading) {
    final index = _addressesPermContractor.indexWhere((r) => r.id == result.id);
    if (index != -1) {
      _addressesPermContractor[index] =
          _addressesPermContractor[index].copyWith(isLoading: isLoading);
      notifyListeners();
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            style: TextStyle(color: FlutterFlowTheme.of(context).primaryText)),
        duration: const Duration(milliseconds: 4000),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
      ),
    );
  }
}
