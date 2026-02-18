import '/components/header_footer/footer_after_login/footer_after_login_widget.dart';
import '/components/header_footer/header_after_login/header_after_login_widget.dart';
import '/components/page_elements/drawer_content/drawer_content_widget.dart';
import '/components/page_elements/return_to_dashboard/return_to_dashboard_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'manage_sites_widget.dart' show ManageSitesWidget;
import 'package:flutter/material.dart';

class ManageSitesModel extends FlutterFlowModel<ManageSitesWidget> {
  ///  Local state fields for this page.

  dynamic jsonQRCode;

  ///  State fields for stateful widgets in this page.

  // Model for drawerContent component.
  late DrawerContentModel drawerContentModel;
  // Model for HeaderAfterLogin component.
  late HeaderAfterLoginModel headerAfterLoginModel;
  // Model for returnToDashboard component.
  late ReturnToDashboardModel returnToDashboardModel;
  // Model for FooterAfterLogin component.
  late FooterAfterLoginModel footerAfterLoginModel;

  @override
  void initState(BuildContext context) {
    drawerContentModel = createModel(context, () => DrawerContentModel());
    headerAfterLoginModel = createModel(context, () => HeaderAfterLoginModel());
    returnToDashboardModel =
        createModel(context, () => ReturnToDashboardModel());
    footerAfterLoginModel = createModel(context, () => FooterAfterLoginModel());
  }

  @override
  void dispose() {
    drawerContentModel.dispose();
    headerAfterLoginModel.dispose();
    returnToDashboardModel.dispose();
    footerAfterLoginModel.dispose();
  }
}
