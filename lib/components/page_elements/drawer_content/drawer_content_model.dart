import 'package:evac_tracker/backend/api_requests/api_manager.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'drawer_content_widget.dart' show DrawerContentWidget;
import 'package:flutter/material.dart';

class DrawerContentModel extends FlutterFlowModel<DrawerContentWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Switch widget.
  bool? switchValue;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  ApiCallResponse? resUpdatePicture;
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
