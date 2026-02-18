import '/backend/api_requests/api_calls.dart';
import '/components/header_footer/footer_after_login/footer_after_login_widget.dart';
import '/components/header_footer/header_after_login/header_after_login_widget.dart';
import '/components/page_elements/drawer_content/drawer_content_widget.dart';
import '/components/page_elements/emergency_call/emergency_call_widget.dart';
import '/components/page_elements/return_to_dashboard/return_to_dashboard_widget.dart';

import '/flutter_flow/flutter_flow_util.dart';

import 'plumbing_diagram_widget.dart' show PlumbingDiagramWidget;

import 'package:flutter/material.dart';

class PlumbingDiagramModel extends FlutterFlowModel<PlumbingDiagramWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for drawerContent component.
  late DrawerContentModel drawerContentModel;
  // Model for HeaderAfterLogin component.
  late HeaderAfterLoginModel headerAfterLoginModel;
  // Model for returnToDashboard component.
  late ReturnToDashboardModel returnToDashboardModel;
  // Stores action output result for [Backend Call - API (getAssemblyArea)] action in Row widget.
  ApiCallResponse? resAssyArea;
  // Model for EmergencyCall component.
  late EmergencyCallModel emergencyCallModel;
  // Model for FooterAfterLogin component.
  late FooterAfterLoginModel footerAfterLoginModel;

  @override
  void initState(BuildContext context) {
    drawerContentModel = createModel(context, () => DrawerContentModel());
    headerAfterLoginModel = createModel(context, () => HeaderAfterLoginModel());
    returnToDashboardModel =
        createModel(context, () => ReturnToDashboardModel());
    emergencyCallModel = createModel(context, () => EmergencyCallModel());
    footerAfterLoginModel = createModel(context, () => FooterAfterLoginModel());
  }

  @override
  void dispose() {
    drawerContentModel.dispose();
    headerAfterLoginModel.dispose();
    returnToDashboardModel.dispose();
    emergencyCallModel.dispose();
    footerAfterLoginModel.dispose();
  }
}
