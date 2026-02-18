import 'dart:developer';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'flood_emergency_model.dart';
export 'flood_emergency_model.dart';

class FloodEmergencyWidget extends StatefulWidget {
  const FloodEmergencyWidget({super.key});

  @override
  State<FloodEmergencyWidget> createState() => _FloodEmergencyWidgetState();
}

class _FloodEmergencyWidgetState extends State<FloodEmergencyWidget>
    with TickerProviderStateMixin {
  late FloodEmergencyModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FloodEmergencyModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Wrap(
        spacing: 0.0,
        runSpacing: 0.0,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        direction: Axis.horizontal,
        runAlignment: WrapAlignment.start,
        verticalDirection: VerticalDirection.down,
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          10.0,
                          33.0,
                          10.0,
                          0.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x33000000),
                                offset: Offset(0.0, 2.0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        10.0,
                                        0.0,
                                        10.0,
                                      ),
                                      child: Text(
                                        'Flood Emergency',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(
                                                context,
                                              ).labelLargeFamily,
                                              fontSize: 22.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelLargeFamily,
                                                      ),
                                            ),
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _model.formKey,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: ListView(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: [
                                        FutureBuilder<ApiCallResponse>(
                                          future: EvacProjAfterLoginGroup
                                              .getAddressesByUserIDCall
                                              .call(
                                                user: FFAppState().user.uid,
                                                authToken: FFAppState()
                                                    .userAuthentication
                                                    .authorization,
                                              ),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child: SpinKitRipple(
                                                    color: FlutterFlowTheme.of(
                                                      context,
                                                    ).primary,
                                                    size: 50.0,
                                                  ),
                                                ),
                                              );
                                            }

                                            final dropDownGetAddressesByUserIDResponse =
                                                snapshot.data!;

                                            // Extract the list of results
                                            List<dynamic>? addressResults =
                                                EvacProjAfterLoginGroup
                                                    .getAddressesByUserIDCall
                                                    .results(
                                                      dropDownGetAddressesByUserIDResponse
                                                          .jsonBody,
                                                    );

                                            if (addressResults == null ||
                                                addressResults.isEmpty) {
                                              return Center(
                                                child: Text(
                                                  "No addresses found",
                                                ),
                                              );
                                            }

                                            // Extract the IDs, buildings, floors, and flats
                                            List<dynamic>?
                                            ids = EvacProjAfterLoginGroup
                                                .getAddressesByUserIDCall
                                                .id(
                                                  dropDownGetAddressesByUserIDResponse
                                                      .jsonBody,
                                                );
                                            List<String>?
                                            buildings = EvacProjAfterLoginGroup
                                                .getAddressesByUserIDCall
                                                .building(
                                                  dropDownGetAddressesByUserIDResponse
                                                      .jsonBody,
                                                );
                                            List<String>?
                                            floors = EvacProjAfterLoginGroup
                                                .getAddressesByUserIDCall
                                                .floor(
                                                  dropDownGetAddressesByUserIDResponse
                                                      .jsonBody,
                                                );
                                            List<String>?
                                            flats = EvacProjAfterLoginGroup
                                                .getAddressesByUserIDCall
                                                .flat(
                                                  dropDownGetAddressesByUserIDResponse
                                                      .jsonBody,
                                                );

                                            // Create a map to store concatenated addresses and corresponding IDs
                                            Map<String, String>
                                            dropdownOptions = {};
                                            for (
                                              var i = 0;
                                              i < addressResults.length;
                                              i++
                                            ) {
                                              // Safely extract building, floor, flat, and id
                                              String building =
                                                  buildings != null &&
                                                      i < buildings.length
                                                  ? buildings[i]
                                                  : 'Unknown Building';
                                              String floor =
                                                  floors != null &&
                                                      i < floors.length
                                                  ? floors[i]
                                                  : 'Unknown Floor';
                                              String flat =
                                                  flats != null &&
                                                      i < flats.length
                                                  ? flats[i]
                                                  : 'Unknown Flat';
                                              String id =
                                                  ids != null && i < ids.length
                                                  ? ids[i]
                                                        .toString() // Convert int ID to String
                                                  : '';

                                              // Create concatenated string for the dropdown and store with corresponding ID
                                              dropdownOptions['$building, Floor: $floor, Flat: $flat'] =
                                                  id;
                                            }

                                            return FlutterFlowDropDown<String>(
                                              controller:
                                                  _model.dropDownValueController ??=
                                                      FormFieldController<
                                                        String
                                                      >(null),
                                              options: dropdownOptions.keys
                                                  .toList(), // Use concatenated values for display
                                              onChanged: (val) {
                                                setState(() {
                                                  _model.dropDownValue = val;
                                                  _model.selectedId =
                                                      dropdownOptions[val]; // Get the corresponding ID
                                                  // Now you can use selectedId as needed
                                                  log('Selected ID:');
                                                  log(
                                                    '${_model.selectedId}',
                                                  ); // Or store it in a variable
                                                });
                                              },
                                              searchHintTextStyle:
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).labelMedium.override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).labelMediumFamily,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).labelMediumFamily,
                                                            ),
                                                  ),
                                              searchTextStyle:
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).bodyMedium.override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).bodyMediumFamily,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).bodyMediumFamily,
                                                            ),
                                                  ),
                                              textStyle:
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).bodyMedium.override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).bodyMediumFamily,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).bodyMediumFamily,
                                                            ),
                                                  ),
                                              hintText:
                                                  'Please select address...',
                                              searchHintText:
                                                  'Search for an item...',
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryText,
                                                size: 24.0,
                                              ),
                                              fillColor: FlutterFlowTheme.of(
                                                context,
                                              ).secondaryBackground,
                                              elevation: 2.0,
                                              borderColor: FlutterFlowTheme.of(
                                                context,
                                              ).primaryBackground,
                                              borderWidth: 2.0,
                                              borderRadius: 20.0,
                                              margin:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    16.0,
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              hidesUnderline: true,
                                              isOverButton: true,
                                              isSearchable: true,
                                              isMultiSelect: false,
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                0.0,
                                                10.0,
                                                0.0,
                                              ),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              final selectedMedia =
                                                  await selectMediaWithSourceBottomSheet(
                                                    context: context,
                                                    imageQuality: 100,
                                                    allowPhoto: true,
                                                  );
                                              if (selectedMedia != null &&
                                                  selectedMedia.every(
                                                    (m) => validateFileFormat(
                                                      m.storagePath,
                                                      context,
                                                    ),
                                                  )) {
                                                setState(
                                                  () => _model.isDataUploading =
                                                      true,
                                                );
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                try {
                                                  selectedUploadedFiles =
                                                      selectedMedia
                                                          .map(
                                                            (
                                                              m,
                                                            ) => FFUploadedFile(
                                                              name: m
                                                                  .storagePath
                                                                  .split('/')
                                                                  .last,
                                                              bytes: m.bytes,
                                                              height: m
                                                                  .dimensions
                                                                  ?.height,
                                                              width: m
                                                                  .dimensions
                                                                  ?.width,
                                                              blurHash:
                                                                  m.blurHash,
                                                            ),
                                                          )
                                                          .toList();
                                                } finally {
                                                  _model.isDataUploading =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                        .length ==
                                                    selectedMedia.length) {
                                                  setState(() {
                                                    _model.uploadedLocalFile =
                                                        selectedUploadedFiles
                                                            .first;
                                                  });
                                                } else {
                                                  setState(() {});
                                                  return;
                                                }
                                              }

                                              if (!_model.isDataUploading) {
                                                _model.imageVisible = true;
                                                setState(() {});
                                              }
                                            },
                                            text: 'Upload Picture',
                                            icon: Icon(
                                              Icons.camera_alt,
                                              size: 30.0,
                                            ),
                                            options: FFButtonOptions(
                                              height: 40.0,
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    24.0,
                                                    0.0,
                                                    24.0,
                                                    0.0,
                                                  ),
                                              iconPadding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).secondaryBackground,
                                              textStyle:
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).bodyLarge.override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).bodyLargeFamily,
                                                    color: FlutterFlowTheme.of(
                                                      context,
                                                    ).secondaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                              FlutterFlowTheme.of(
                                                                context,
                                                              ).bodyLargeFamily,
                                                            ),
                                                  ),
                                              elevation: 3.0,
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                  context,
                                                ).primaryBackground,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                          ),
                                        ),
                                        if (_model.imageVisible)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                            child: Image.memory(
                                              _model.uploadedLocalFile.bytes ??
                                                  Uint8List.fromList([]),
                                              width: double.infinity,
                                              height: 200.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        10.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          _model.apiResult9z9 =
                                              await EvacProjAfterLoginGroup
                                                  .floodAlarmCall
                                                  .call(
                                                    userFlat: _model.selectedId,
                                                    floodImage: _model
                                                        .uploadedLocalFile,
                                                    createdBy:
                                                        FFAppState().user.uid,
                                                    authToken: FFAppState()
                                                        .userAuthentication
                                                        .authorization,
                                                  );

                                          if ((_model.apiResult9z9?.succeeded ??
                                              true)) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Flood emergency declared.',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                      context,
                                                    ).primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                  milliseconds: 4000,
                                                ),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(
                                                      context,
                                                    ).secondary,
                                              ),
                                            );
                                          }

                                          setState(() {});
                                        },
                                        text: 'Submit',
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 30.0,
                                        ),
                                        options: FFButtonOptions(
                                          width: 200.0,
                                          height: 45.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                              ),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                              ),
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).secondaryText,
                                          textStyle:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).titleSmall.override(
                                                fontFamily: FlutterFlowTheme.of(
                                                  context,
                                                ).titleSmallFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey(
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).titleSmallFamily,
                                                        ),
                                              ),
                                          elevation: 5.0,
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).secondaryText,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1.0, -1.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          10.0,
                          30.0,
                          0.0,
                          0.0,
                        ),
                        child: FlutterFlowIconButton(
                          borderRadius: 20.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.cancel,
                            color: FlutterFlowTheme.of(context).error,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Icon(
                        Icons.water_drop_outlined,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 60.0,
                      ),
                    ),
                  ],
                ),
              ),
            ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
          ),
        ],
      ),
    );
  }
}
