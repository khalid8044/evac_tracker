import '/backend/api_requests/api_calls.dart';
import '/components/page_elements/building_q_r/building_q_r_widget.dart';
import '/components/page_elements/emergency_call/emergency_call_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'login_widget.dart' show LoginWidget;
import 'package:flutter/material.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  Local state fields for this page.

  bool isContractor = false;
  bool isTempContractor = false;
  bool isFloodContractor = false;

  ///  State fields for stateful widgets in this page.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // Model for EmergencyCall component.
  late EmergencyCallModel emergencyCallModel;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  String? _emailAddressTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 9) {
      return 'Minimum 9 digits required';
    }
    if (val.length > 10) {
      return 'Max 10 digits allowed';
    }

    return null;
  }

  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 8) {
      return 'Minimum 8 characters required';
    }
    if (val.length > 30) {
      return 'Maximum 30 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (login)] action in btnSignIn widget.
  ApiCallResponse? loginResult;
  ApiCallResponse? resUserAddress;
  // Model for buildingQR component.
  late BuildingQRModel buildingQRModel;
  // State field(s) for fullName_visitor widget.
  FocusNode? fullNameVisitorFocusNode;
  TextEditingController? fullNameVisitorTextController;
  String? Function(BuildContext, String?)?
      fullNameVisitorTextControllerValidator;
  String? _fullNameVisitorTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for emailAddressVisitor widget.
  FocusNode? emailAddressVisitorFocusNode;
  TextEditingController? emailAddressVisitorTextController;
  String? Function(BuildContext, String?)?
      emailAddressVisitorTextControllerValidator;
  // State field(s) for mobileNumberVisitor widget.
  FocusNode? mobileNumberVisitorFocusNode;
  TextEditingController? mobileNumberVisitorTextController;
  String? Function(BuildContext, String?)?
      mobileNumberVisitorTextControllerValidator;
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

  DateTime? datePicked;
  // Stores action output result for [Backend Call - API (registerVisitor)] action in btnRegisterVisitor widget.
  ApiCallResponse? apiResultVisitor;

  @override
  void initState(BuildContext context) {
    emergencyCallModel = createModel(context, () => EmergencyCallModel());
    emailAddressTextControllerValidator = _emailAddressTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
    buildingQRModel = createModel(context, () => BuildingQRModel());
    fullNameVisitorTextControllerValidator =
        _fullNameVisitorTextControllerValidator;
    timeOutVisitorTextControllerValidator =
        _timeOutVisitorTextControllerValidator;
  }

  @override
  void dispose() {
    emergencyCallModel.dispose();
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    buildingQRModel.dispose();
    fullNameVisitorFocusNode?.dispose();
    fullNameVisitorTextController?.dispose();

    emailAddressVisitorFocusNode?.dispose();
    emailAddressVisitorTextController?.dispose();

    mobileNumberVisitorFocusNode?.dispose();
    mobileNumberVisitorTextController?.dispose();

    timeOutVisitorFocusNode?.dispose();
    timeOutVisitorTextController?.dispose();
  }

  /// Action blocks.
  Future hideUserInfo(BuildContext context) async {}
}
