
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'delete_account_widget.dart' show DeleteAccountWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
class DeleteAccountModel extends FlutterFlowModel<DeleteAccountWidget> {
  ///  Local state fields for this component.

  bool error = false;

  bool deleteConfirm = false;

  bool resendCode = false;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 300000;
  int timerMilliseconds = 300000;
  String timerValue = StopWatchTimer.getDisplayTime(
    300000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Backend Call - API (passwordResetRequest)] action in Row widget.
  ApiCallResponse? apiResultrva;
  // State field(s) for code widget.
  FocusNode? codeFocusNode;
  TextEditingController? codeTextController;
  String? Function(BuildContext, String?)? codeTextControllerValidator;
  String? _codeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (deleteUser)] action in Button widget.
  ApiCallResponse? apiResult745;
  // Stores action output result for [Backend Call - API (passwordResetRequest)] action in Button widget.
  ApiCallResponse? apiResultmyn;

  @override
  void initState(BuildContext context) {
    codeTextControllerValidator = _codeTextControllerValidator;
  }

  @override
  void dispose() {
    timerController.dispose();
    codeFocusNode?.dispose();
    codeTextController?.dispose();
  }
}
