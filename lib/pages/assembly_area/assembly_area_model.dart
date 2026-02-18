import 'package:evac_tracker/backend/api_requests/api_manager.dart';

import '/components/header_footer/footer_after_login/footer_after_login_widget.dart';
import '/components/header_footer/header_after_login/header_after_login_widget.dart';
import '/components/page_elements/drawer_content/drawer_content_widget.dart';
import '/components/page_elements/return_to_dashboard/return_to_dashboard_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'assembly_area_widget.dart' show AssemblyAreaWidget;
import 'package:flutter/material.dart';

class AssemblyAreaModel extends FlutterFlowModel<AssemblyAreaWidget> {
  ///  Local state fields for this page.

  dynamic jsonQRCode;
  ApiCallResponse? result;

  ///  State fields for stateful widgets in this page.

  // Model for drawerContent component.
  late DrawerContentModel drawerContentModel;
  // Model for HeaderAfterLogin component.
  late HeaderAfterLoginModel headerAfterLoginModel;
  // Model for returnToDashboard component.
  late ReturnToDashboardModel returnToDashboardModel;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
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
