import '/components/header_footer/footer_after_login/footer_after_login_widget.dart';
import '/components/header_footer/header_after_login/header_after_login_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'emergency_decleration_widget.dart' show EmergencyDeclerationWidget;
import 'package:flutter/material.dart';

class EmergencyDeclerationModel
    extends FlutterFlowModel<EmergencyDeclerationWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for HeaderAfterLogin component.
  late HeaderAfterLoginModel headerAfterLoginModel;
  // Model for FooterAfterLogin component.
  late FooterAfterLoginModel footerAfterLoginModel;

  @override
  void initState(BuildContext context) {
    headerAfterLoginModel = createModel(context, () => HeaderAfterLoginModel());
    footerAfterLoginModel = createModel(context, () => FooterAfterLoginModel());
  }

  @override
  void dispose() {
    headerAfterLoginModel.dispose();
    footerAfterLoginModel.dispose();
  }
}
