import 'package:smart_search_dropdown/smart_search_dropdown.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'building_q_r_widget.dart' show BuildingQRWidget;
import 'package:flutter/material.dart';

class BuildingQRModel extends FlutterFlowModel<BuildingQRWidget> {
  ///  Local state fields for this component.

  String? address = 'Scan QR of Building/ Floor';

  bool btnClick = false;
  bool validAddress = false;
  int floorId = 0;
  List<SmartSearchDropdownItem> dropdownItems = [];
  //List<KeyValueModel> dropdownItemsNew = [];
  bool isLoading = true;

  ///  State fields for stateful widgets in this component.

  var buildingQRData = '';
  // Stores action output result for [Custom Action - scanQRCodeFromGallery] action in Button widget.
  String? qRString;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
