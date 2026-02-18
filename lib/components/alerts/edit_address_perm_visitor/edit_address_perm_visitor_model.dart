import '../../../flutter_flow/form_field_controller.dart';
import '/backend/api_requests/api_calls.dart';

import '/flutter_flow/flutter_flow_util.dart';



import 'edit_address_perm_visitor_widget.dart'
    show EditAddressPermVisitorWidget;

import 'package:flutter/material.dart';



class EditAddressPermVisitorModel
    extends FlutterFlowModel<EditAddressPermVisitorWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (getAddressByID)] action in editAddressPermVisitor widget.
  ApiCallResponse? apiResultg53;
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
  // Stores action output result for [Backend Call - API (updateAddressByID)] action in btnRegisterVisitor widget.
  ApiCallResponse? apiResultpjl;

  @override
  void initState(BuildContext context) {
    arrivalTimeTextControllerValidator = _arrivalTimeTextControllerValidator;
    departureTimeTextControllerValidator =
        _departureTimeTextControllerValidator;
  }

  @override
  void dispose() {
    arrivalTimeFocusNode?.dispose();
    arrivalTimeTextController?.dispose();

    departureTimeFocusNode?.dispose();
    departureTimeTextController?.dispose();
  }
}
