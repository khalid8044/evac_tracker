import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'forgot_password_widget.dart' show ForgotPasswordWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class ForgotPasswordModel extends FlutterFlowModel<ForgotPasswordWidget> {
  ///  Local state fields for this component.

  bool emailSent = false;

  bool codeResend = false;

  String? emailError;

  String? cfmPasswordError;

  String? passwordError;

  // Controllers for each text field
  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

  //final formKey = GlobalKey<FormState>();

  // Focus nodes for each text field
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  ///  State fields for stateful widgets in this component.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for emailForgotPassword widget.
  FocusNode? emailForgotPasswordFocusNode;
  TextEditingController? emailForgotPasswordTextController;
  String? Function(BuildContext, String?)?
      emailForgotPasswordTextControllerValidator;
  String? _emailForgotPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // Stores action output result for [Backend Call - API (passwordResetRequest)] action in Button widget.
  ApiCallResponse? resEmail;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 600000;
  int timerMilliseconds = 600000;
  String timerValue = StopWatchTimer.getDisplayTime(
    600000,
    hours: false,
    milliSecond: false,
  );

  String getCombinedCode() {
    return controllers.map((controller) => controller.text).join();
  }

  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Backend Call - API (passwordResetRequest)] action in Row widget.
  ApiCallResponse? apiResultiiu;
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

  // State field(s) for newPassword widget.
  FocusNode? newPasswordFocusNode;
  TextEditingController? newPasswordTextController;
  late bool newPasswordVisibility;
  String? Function(BuildContext, String?)? newPasswordTextControllerValidator;
  String? _newPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for confirmPassword widget.
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordTextController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)?
      confirmPasswordTextControllerValidator;
  String? _confirmPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (confirmPasswordReset)] action in Button widget.
  ApiCallResponse? apiResultz3c;

  @override
  void initState(BuildContext context) {
    emailForgotPasswordTextControllerValidator =
        _emailForgotPasswordTextControllerValidator;
    codeTextControllerValidator = _codeTextControllerValidator;
    newPasswordVisibility = false;
    newPasswordTextControllerValidator = _newPasswordTextControllerValidator;
    confirmPasswordVisibility = false;
    confirmPasswordTextControllerValidator =
        _confirmPasswordTextControllerValidator;
  }

  @override
  void dispose() {
    emailForgotPasswordFocusNode?.dispose();
    emailForgotPasswordTextController?.dispose();

    timerController.dispose();
    codeFocusNode?.dispose();
    codeTextController?.dispose();

    newPasswordFocusNode?.dispose();
    newPasswordTextController?.dispose();

    confirmPasswordFocusNode?.dispose();
    confirmPasswordTextController?.dispose();
  }
}
