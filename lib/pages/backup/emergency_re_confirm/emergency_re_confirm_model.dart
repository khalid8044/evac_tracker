import '/components/header_footer/footer_after_login/footer_after_login_widget.dart';
import '/components/header_footer/header_without_user_info/header_without_user_info_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'emergency_re_confirm_widget.dart' show EmergencyReConfirmWidget;
import 'package:flutter/material.dart';

class EmergencyReConfirmModel
    extends FlutterFlowModel<EmergencyReConfirmWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for headerWithoutUserInfo component.
  late HeaderWithoutUserInfoModel headerWithoutUserInfoModel;
  // Model for FooterAfterLogin component.
  late FooterAfterLoginModel footerAfterLoginModel;

  @override
  void initState(BuildContext context) {
    headerWithoutUserInfoModel =
        createModel(context, () => HeaderWithoutUserInfoModel());
    footerAfterLoginModel = createModel(context, () => FooterAfterLoginModel());
  }

  @override
  void dispose() {
    headerWithoutUserInfoModel.dispose();
    footerAfterLoginModel.dispose();
  }
}
