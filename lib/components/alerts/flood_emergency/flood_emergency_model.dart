import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'flood_emergency_widget.dart' show FloodEmergencyWidget;
import 'package:flutter/material.dart';

class FloodEmergencyModel extends FlutterFlowModel<FloodEmergencyWidget> {
  ///  Local state fields for this component.

  bool imageVisible = false;
  String? selectedId = '';

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (floodAlarm)] action in btnRegisterVisitor widget.
  ApiCallResponse? apiResult9z9;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
