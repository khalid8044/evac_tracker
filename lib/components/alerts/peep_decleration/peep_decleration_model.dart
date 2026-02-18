import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'peep_decleration_widget.dart' show PeepDeclerationWidget;
import 'package:flutter/material.dart';

class PeepDeclerationModel extends FlutterFlowModel<PeepDeclerationWidget> {
  ///  Local state fields for this component.

  int? id;

  bool editProfile = false;

  bool showForm = false;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (getPeepByUser)] action in peepDecleration widget.
  ApiCallResponse? apiResult5ue;
  // State field(s) for dob widget.
  FocusNode? dobFocusNode;
  TextEditingController? dobTextController;
  String? Function(BuildContext, String?)? dobTextControllerValidator;
  DateTime? datePicked1;
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
  DateTime? datePicked2;
  // State field(s) for reviewDate widget.
  FocusNode? reviewDateFocusNode;
  TextEditingController? reviewDateTextController;
  String? Function(BuildContext, String?)? reviewDateTextControllerValidator;
  DateTime? datePicked3;
  // State field(s) for assistanceType widget.
  String? assistanceTypeValue;
  FormFieldController<String>? assistanceTypeValueController;
  // State field(s) for evacMethod widget.
  String? evacMethodValue;
  FormFieldController<String>? evacMethodValueController;
  // Stores action output result for [Backend Call - API (updatePeepStatus)] action in Button widget.
  ApiCallResponse? resPeepUpdate;
  // Stores action output result for [Backend Call - API (insertPeep)] action in btnSavePeep widget.
  ApiCallResponse? apiResult1sk;
  // Stores action output result for [Backend Call - API (updatePeepStatus)] action in btnSavePeep widget.
  ApiCallResponse? saveUserIsPeep;
  // Stores action output result for [Backend Call - API (updatePeepByUser)] action in btnSavePeep widget.
  ApiCallResponse? apiResultayr;
  // Stores action output result for [Backend Call - API (updatePeepStatus)] action in btnSavePeep widget.
  ApiCallResponse? updateUserIsPeep;

  @override
  void initState(BuildContext context) {
    nomineeNameTextControllerValidator = _nomineeNameTextControllerValidator;
    nomineeContactTextControllerValidator =
        _nomineeContactTextControllerValidator;
  }

  @override
  void dispose() {
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
