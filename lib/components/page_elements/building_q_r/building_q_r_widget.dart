import 'package:evac_tracker/backend/api_requests/api_calls.dart';


import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'building_q_r_model.dart';
export 'building_q_r_model.dart';
//import 'package:smart_search_dropdown/smart_search_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'mobile_scanner_page.dart';

class BuildingQRWidget extends StatefulWidget {
  //const BuildingQRWidget({super.key});
  final bool showDropdown;
  const BuildingQRWidget({super.key, required this.showDropdown});
  @override
  State<BuildingQRWidget> createState() => _BuildingQRWidgetState();
}

class KeyValueModel {
  String itemName;
  String itemId;
  KeyValueModel({required this.itemName, required this.itemId});
}

class _BuildingQRWidgetState extends State<BuildingQRWidget>
    with TickerProviderStateMixin {
  late BuildingQRModel _model;
  List<KeyValueModel> dropdownItems = [];
  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => BuildingQRModel());

    animationsMap.addAll({
      'iconButtonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShakeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            hz: 10,
            offset: const Offset(0.0, 0.0),
            rotation: 0.087,
          ),
        ],
      ),
    });
  }

  Future<void> _fetchDropdownItems(int floorId) async {
    final apiCall = GetFlatByFloorCall();
    final response =
        await apiCall.call(floor: floorId); // Pass the desired floor number
    print(response.jsonBody);
    // Extract value and description from the response
    final List<String>? ids = apiCall.value(response);
    final List<String>? descriptions = apiCall.description(response);

    if (ids != null && descriptions != null) {
      setState(() {
        dropdownItems = List.generate(ids.length, (index) {
          return KeyValueModel(
            itemId: ids[index],
            itemName: descriptions[index],
          );
        });
        _model.isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.sizeOf(context).width * 0.70,
                    child: Text(
                      valueOrDefault<String>(
                        _model.address,
                        'Scan QR of Building/ Floor',
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      //minFontSize: 8.0,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  if (widget.showDropdown)
                    Visibility(
                      visible: _model.validAddress,
                      //visible: true,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.70,
                        child: DropdownSearch<String>(
                          items: (String? filter, LoadProps? loadProps) {
                            // Return the list of apartment names
                            return dropdownItems
                                .map((apartment) => apartment.itemName)
                                .toList();
                          },
                          //compareFn: (i, s) => i.isEqual(s),
                          popupProps: const PopupProps.menu(
                            fit: FlexFit.loose,
                            showSearchBox: true,
                            //itemBuilder: userModelPopupItem,
                          ),
                          onChanged: (selectedName) {
                            // Find the selected apartment's ID
                            final selectedApartment = dropdownItems.firstWhere(
                                (apartment) =>
                                    apartment.itemName == selectedName);
                            final selectedId = selectedApartment.itemId;
                            FFAppState().qrBuilding.roomID =
                                int.parse(selectedId);
                            FFAppState().qrBuilding.roomName = selectedName;

                            //print("Selected Apartment ID: $selectedId");
                          },
                          decoratorProps: DropDownDecoratorProps(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: 'Select Apartment',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText),
                            ),
                          ),
                        ),
                        // child: SmartSearchDropdown(
                        //   controller: TextEditingController(),
                        //   backgroundColor:
                        //       FlutterFlowTheme.of(context).secondaryBackground,
                        //   borderRadius: 30,
                        //   labelText: 'Apartment',
                        //   enableSearching: true,
                        //   isLoading: _model.isLoading,
                        //   items: _model.dropdownItems,
                        //   selectedItem: 'apartment',
                        //   onItemSelected: (item) {
                        //     FFAppState().qrBuilding.roomID =
                        //         int.parse(item.value);
                        //     FFAppState().qrBuilding.roomName = item.description;
                        //     print(
                        //         'Selected item: ${FFAppState().qrBuilding.roomName}');
                        //   },
                        //),
                      ),
                    ),
                ],
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).secondaryText,
                  borderRadius: 50.0,
                  borderWidth: 1.0,
                  buttonSize: 50.0,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  icon: Icon(
                    Icons.qr_code_2,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 35.0,
                  ),
                  onPressed: () async {
                    _model.btnClick = !_model.btnClick;
                    setState(() {});
                  },
                ).animateOnPageLoad(
                    animationsMap['iconButtonOnPageLoadAnimation']!),
              ),
            ],
          ),
        ),
        if (_model.btnClick)
          Opacity(
            opacity: 0.9,
            child: Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Container(
                width: 300.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryText,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        _model.buildingQRData = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const MobileScanScreen(),
  ),
);

                        _model.btnClick = !_model.btnClick;
                        setState(() {});
                        FFAppState().qrCodeJson = functions
                            .convertStringtoJSON(_model.buildingQRData)!;
                        setState(() {});
                        FFAppState().qrBuilding = BuildingStruct(
                          buildingID: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.building''',
                          ),
                          buildingName: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.building_name''',
                          ).toString(),
                          roomID: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.flat''',
                          ),
                          roomName: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.flat_no''',
                          ).toString(),
                          floorID: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.floor''',
                          ),
                          floorName: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.floor_no''',
                          ).toString(),
                        );
                        setState(() {});
                        if ((FFAppState().qrBuilding.buildingID == 0) ||
                            (FFAppState().qrBuilding.floorID == 0)) {
                          _model.address = 'Invalid QR Code';
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Invalid QR Code',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: const Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        } else {
                          _model.address = functions.generateAddress(
                              FFAppState().qrBuilding.buildingName,
                              FFAppState().qrBuilding.floorName,
                              FFAppState().qrBuilding.roomName);
                          _model.validAddress = true;
                          _fetchDropdownItems(FFAppState().qrBuilding.floorID);
                          setState(() {});
                        }

                        setState(() {});
                      },
                      text: 'Scan',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .titleSmallFamily),
                            ),
                        elevation: 3.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        _model.qRString = await actions.scanQRCodeFromGallery(
                          context,
                        );
                        _model.btnClick = !_model.btnClick;
                        setState(() {});
                        FFAppState().qrCodeJson =
                            functions.convertStringtoJSON(_model.qRString) ??
                                '';
                        setState(() {});
                        FFAppState().qrBuilding = BuildingStruct(
                          buildingID: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.building''',
                          ),
                          buildingName: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.building_name''',
                          ).toString(),
                          roomID: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.flat''',
                          ),
                          roomName: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.flat_no''',
                          ).toString(),
                          floorID: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.floor''',
                          ),
                          floorName: getJsonField(
                            FFAppState().qrCodeJson,
                            r'''$.floor_no''',
                          ).toString(),
                        );
                        setState(() {});
                        if ((FFAppState().qrBuilding.buildingID == 0) ||
                            (FFAppState().qrBuilding.floorID == 0)) {
                          _model.address = 'Invalid QR Code';
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Invalid QR code',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: const Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        } else {
                          _model.address = functions.generateAddress(
                              FFAppState().qrBuilding.buildingName,
                              FFAppState().qrBuilding.floorName,
                              FFAppState().qrBuilding.roomName);
                          _model.validAddress = true;
                          _fetchDropdownItems(FFAppState().qrBuilding.floorID);
                          setState(() {});
                        }

                        setState(() {});
                      },
                      text: 'Image',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .titleSmallFamily),
                            ),
                        elevation: 3.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
