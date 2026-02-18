import '/backend/api_requests/api_calls.dart';
import '/components/page_elements/building_q_r/building_q_r_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'register_widget.dart' show RegisterWidget;

import 'package:flutter/material.dart';


class RegisterModel extends FlutterFlowModel<RegisterWidget> {
  ///  Local state fields for this component.

  bool pwdMatch = false;

  bool qrValid = false;

  late String error = '';

  ///  State fields for stateful widgets in this component.

  final formKey3 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // State field(s) for swPermContractor widget.
  bool? swPermContractorValue;
  // State field(s) for swPeep widget.
  bool? swPeepValue;
  // Model for buildingQR component.
  late BuildingQRModel buildingQRModel;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for fullName widget.
  FocusNode? fullNameFocusNode;
  TextEditingController? fullNameTextController;
  String? Function(BuildContext, String?)? fullNameTextControllerValidator;
  String? _fullNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }
    if (val.length > 16) {
      return 'Maximum 30 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // State field(s) for emailAddressRegister widget.
  FocusNode? emailAddressRegisterFocusNode;
  TextEditingController? emailAddressRegisterTextController;
  String? Function(BuildContext, String?)?
      emailAddressRegisterTextControllerValidator;
  String? _emailAddressRegisterTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for mobileNumber widget.
  FocusNode? mobileNumberFocusNode;
  TextEditingController? mobileNumberTextController;
  String? Function(BuildContext, String?)? mobileNumberTextControllerValidator;
  String? _mobileNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for passwordResident widget.
  FocusNode? passwordResidentFocusNode;
  TextEditingController? passwordResidentTextController;
  late bool passwordResidentVisibility;
  String? Function(BuildContext, String?)?
      passwordResidentTextControllerValidator;
  String? _passwordResidentTextControllerValidator(
      BuildContext context, String? val) {
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

  // State field(s) for cfmPasswordResident widget.
  FocusNode? cfmPasswordResidentFocusNode;
  TextEditingController? cfmPasswordResidentTextController;
  late bool cfmPasswordResidentVisibility;
  String? Function(BuildContext, String?)?
      cfmPasswordResidentTextControllerValidator;
  String? _cfmPasswordResidentTextControllerValidator(
      BuildContext context, String? val) {
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
  // State field(s) for dob widget.
  FocusNode? dobFocusNode;
  TextEditingController? dobTextController;
  String? Function(BuildContext, String?)? dobTextControllerValidator;
  DateTime? datePicked3;
  // State field(s) for nomineeName widget.
  FocusNode? nomineeNameFocusNode;
  TextEditingController? nomineeNameTextController;
  String? Function(BuildContext, String?)? nomineeNameTextControllerValidator;
  String? _nomineeNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for nomineeContact widget.
  FocusNode? nomineeContactFocusNode;
  TextEditingController? nomineeContactTextController;
  String? Function(BuildContext, String?)?
      nomineeContactTextControllerValidator;
  String? _nomineeContactTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for peepType widget.
  String? peepTypeValue;
  FormFieldController<String>? peepTypeValueController;
  // State field(s) for expirationDate widget.
  FocusNode? expirationDateFocusNode;
  TextEditingController? expirationDateTextController;
  String? Function(BuildContext, String?)?
      expirationDateTextControllerValidator;
  DateTime? datePicked4;
  // State field(s) for reviewDate widget.
  FocusNode? reviewDateFocusNode;
  TextEditingController? reviewDateTextController;
  String? Function(BuildContext, String?)? reviewDateTextControllerValidator;
  DateTime? datePicked5;
  // State field(s) for assistanceType widget.
  String? assistanceTypeValue;
  FormFieldController<String>? assistanceTypeValueController;
  // State field(s) for evacMethod widget.
  String? evacMethodValue;
  FormFieldController<String>? evacMethodValueController;
  // Stores action output result for [Backend Call - API (registerVisitor)] action in btnRegisterVisitor widget.
  ApiCallResponse? resVisitor;
  // Stores action output result for [Backend Call - API (registerVisitor)] action in btnRegisterVisitor widget.
  ApiCallResponse? resVisitorNoPeep;
  // Stores action output result for [Backend Call - API (registerResident)] action in btnRegisterVisitor widget.
  ApiCallResponse? resRes;
  // Stores action output result for [Backend Call - API (registerResident)] action in btnRegisterVisitor widget.
  ApiCallResponse? resResNoPeep;

  @override
  void initState(BuildContext context) {
    buildingQRModel = createModel(context, () => BuildingQRModel());
    fullNameTextControllerValidator = _fullNameTextControllerValidator;
    emailAddressRegisterTextControllerValidator =
        _emailAddressRegisterTextControllerValidator;
    mobileNumberTextControllerValidator = _mobileNumberTextControllerValidator;
    passwordResidentVisibility = false;
    passwordResidentTextControllerValidator =
        _passwordResidentTextControllerValidator;
    cfmPasswordResidentVisibility = false;
    cfmPasswordResidentTextControllerValidator =
        _cfmPasswordResidentTextControllerValidator;
    arrivalTimeTextControllerValidator = _arrivalTimeTextControllerValidator;
    departureTimeTextControllerValidator =
        _departureTimeTextControllerValidator;
    nomineeNameTextControllerValidator = _nomineeNameTextControllerValidator;
    nomineeContactTextControllerValidator =
        _nomineeContactTextControllerValidator;
  }

  @override
  void dispose() {
    buildingQRModel.dispose();
    fullNameFocusNode?.dispose();
    fullNameTextController?.dispose();

    emailAddressRegisterFocusNode?.dispose();
    emailAddressRegisterTextController?.dispose();

    mobileNumberFocusNode?.dispose();
    mobileNumberTextController?.dispose();

    passwordResidentFocusNode?.dispose();
    passwordResidentTextController?.dispose();

    cfmPasswordResidentFocusNode?.dispose();
    cfmPasswordResidentTextController?.dispose();

    arrivalTimeFocusNode?.dispose();
    arrivalTimeTextController?.dispose();

    departureTimeFocusNode?.dispose();
    departureTimeTextController?.dispose();

    dobFocusNode?.dispose();
    dobTextController?.dispose();

    nomineeNameFocusNode?.dispose();
    nomineeNameTextController?.dispose();

    nomineeContactFocusNode?.dispose();
    nomineeContactTextController?.dispose();

    expirationDateFocusNode?.dispose();
    expirationDateTextController?.dispose();

    reviewDateFocusNode?.dispose();
    reviewDateTextController?.dispose();
  }
}
