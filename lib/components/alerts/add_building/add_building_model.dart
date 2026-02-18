import '/backend/api_requests/api_calls.dart';
import '/components/page_elements/building_q_r/building_q_r_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';



import 'add_building_widget.dart' show AddBuildingWidget;

import 'package:flutter/material.dart';


class AddBuildingModel extends FlutterFlowModel<AddBuildingWidget> {
  ///  State fields for stateful widgets in this component.

  bool qrError = false;

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // Model for buildingQR component.
  late BuildingQRModel buildingQRModel;
  // State field(s) for swContractor widget.
  bool? swContractorValue;
  // State field(s) for swPermTemp widget.
  bool? swPermTempValue;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue;
  FormFieldController<List<String>>? dropDownValueController;
  // State field(s) for arrivalTime widget.
  FocusNode? arrivalTimeFocusNode;
  TextEditingController? arrivalTimeTextController;
  String? Function(BuildContext, String?)? arrivalTimeTextControllerValidator;
  String? _arrivalTimeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  DateTime? datePicked;
  DateTime? datePicked1;
  // State field(s) for departureTime widget.
  FocusNode? departureTimeFocusNode;
  TextEditingController? departureTimeTextController;
  String? Function(BuildContext, String?)? departureTimeTextControllerValidator;
  String? _departureTimeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  DateTime? datePicked2;
  // State field(s) for timeOutVisitor widget.
  FocusNode? timeOutVisitorFocusNode;
  TextEditingController? timeOutVisitorTextController;
  String? Function(BuildContext, String?)?
      timeOutVisitorTextControllerValidator;
  String? _timeOutVisitorTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  DateTime? datePicked3;
  // Stores action output result for [Backend Call - API (addAddressTempContractor)] action in btnRegisterVisitor widget.
  ApiCallResponse? apiResultog2;
  // Stores action output result for [Backend Call - API (addAddressPermContractor)] action in btnRegisterVisitor widget.
  ApiCallResponse? apiResultf6h;
  // Stores action output result for [Backend Call - API (addAddressResident)] action in btnRegisterVisitor widget.
  ApiCallResponse? apiResult3zc;

  @override
  void initState(BuildContext context) {
    buildingQRModel = createModel(context, () => BuildingQRModel());
    arrivalTimeTextControllerValidator = _arrivalTimeTextControllerValidator;
    departureTimeTextControllerValidator =
        _departureTimeTextControllerValidator;
    timeOutVisitorTextControllerValidator =
        _timeOutVisitorTextControllerValidator;
  }

  @override
  void dispose() {
    buildingQRModel.dispose();
    arrivalTimeFocusNode?.dispose();
    arrivalTimeTextController?.dispose();

    departureTimeFocusNode?.dispose();
    departureTimeTextController?.dispose();

    timeOutVisitorFocusNode?.dispose();
    timeOutVisitorTextController?.dispose();
  }
}
