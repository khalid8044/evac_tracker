import 'dart:async'; // Add this import for Timer
import 'dart:developer';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/nav/nav.dart';
import '/services/showflutter_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../flutter_flow/flutter_flow_animations.dart';
import '../../../pages/in_app_notifications/model/in_app_notifications_model.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fire_alert_model.dart';
export 'fire_alert_model.dart';

class FireAlertWidget extends StatefulWidget {
  const FireAlertWidget({
    super.key,
    String? buildingName,
    required this.buildingID,
    required this.notificationData,
  }) : buildingName = buildingName ?? '';

  final String buildingName;
  final NotificationData notificationData;
  final int? buildingID;

  @override
  State<FireAlertWidget> createState() => _FireAlertWidgetState();
}

class _FireAlertWidgetState extends State<FireAlertWidget>
    with TickerProviderStateMixin {
  late FireAlertModel _model;
  Timer? _timer; // Timer to run a function every 10 seconds

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    // Load SharedPreferences asynchronously and initialize the timer if the token is valid
    _initializeAsync();

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.5, 1.5),
          ),
        ],
      ),
    });
  }

  Future<void> _initializeAsync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('_auth_authentication_token_');

    if (authToken != null && authToken.isNotEmpty) {
      _model = createModel(context, () => FireAlertModel());

      _timer = Timer.periodic(Duration(seconds: 120), (timer) {
        _runPeriodicFunction();
      });
    } else {
      _timer!.cancel();
    }
  }

  // Function to run every 120 seconds
  void _runPeriodicFunction() {
    ShowflutterNotification.showNotifications(
      widget.notificationData.body,
      widget.notificationData.title,
      int.tryParse(widget.notificationData.buildingId)??0,
     widget.notificationData.name,
        repeatNotification: true);
  }

  @override
  void dispose() {
    _model.maybeDispose();
    _timer?.cancel(); // Cancel the timer when the widget is disposed

    super.dispose();
  }

  void _onButtonPressed() {
    _timer?.cancel();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
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
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 30.0, 10.0, 0.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 400.0,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Fire Alert!',
                                style: FlutterFlowTheme.of(context)
                                    .headlineLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineLargeFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .headlineLargeFamily),
                                    ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 20.0),
                                child: Text(
                                  'Are you in ${widget.buildingName}?',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    _onButtonPressed();
                                    try {
                                      // Make API call to update evacuation status
                                      _model.result =
                                          await UpdateUserEvacStatusCall().call(
                                        buildingId: widget.notificationData
                                            .buildingId, // Building ID from widget
                                        isActive: true, // Mark as active
                                        inBuilding: false, // In building
                                        authToken: FFAppState()
                                            .userAuthentication
                                            .authorization, // Authentication token
                                      );
                                      log(
                                          'Evacuation status updated successfully!');
                                    } catch (e) {
                                      // Handle any errors that occurred during the API call
                                      log(
                                          'Error updating evacuation status: $e');
                                    }
                                  },
                                  text: 'No',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).accent3,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    _timer?.cancel();
                                    FFAppState().updateActiveBuildingStruct(
                                      (e) => e
                                        ..buildingID = widget.buildingID
                                        ..buildingName = widget.buildingName,
                                    );
                                    try {
                                      // Make API call to update evacuation status
                                      _model.result =
                                          await UpdateUserEvacStatusCall().call(
                                        buildingId: widget.notificationData
                                            .buildingId, // Building ID from widget
                                        isActive: true, // Mark as active
                                        inBuilding: true, // In building
                                        authToken: FFAppState()
                                            .userAuthentication
                                            .authorization, // Authentication token
                                      );
                                      if (_model.result?.succeeded ?? true) {
                                        context.pushNamed(
                                          'evacuationDiagramAll',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.scale,
                                              alignment: Alignment.bottomCenter,
                                              duration:
                                                  Duration(milliseconds: 600),
                                            ),
                                          },
                                        );
                                        setState(() {});
                                        Navigator.pop(context);
                                        // Handle success (e.g., show a message, update the UI)
                                        log(
                                            'Evacuation status updated successfully!');
                                      } else {
                                        // Handle null response
                                        log(
                                            'Failed to update evacuation status');
                                      }
                                    } catch (e) {
                                      // Handle any errors that occurred during the API call
                                      log(
                                          'Error updating evacuation status: $e');
                                    }
                                  },
                                  text: 'Yes',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  _onButtonPressed();
                                  //context.pushNamed('manageSites');
                                  // Show confirmation dialog to the user
                                  final bool? confirmed =
                                      await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Remove Address'),
                                        content: Text(
                                            'Are you sure you want to remove the address?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(
                                                  false); // User pressed No
                                            },
                                            child: Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(
                                                  true); // User pressed Yes
                                            },
                                            child: Text('Yes'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  // If the user confirmed, proceed with the API call
                                  if (confirmed == true) {
                                    try {
                                      // Make the API call to update the evacuation status
                                      _model.result =
                                          await UpdateUserEvacStatusCall().call(
                                        buildingId: widget.notificationData
                                            .buildingId, // Building ID from widget
                                        isActive:
                                            false, // Mark as not active (remove)
                                        authToken: FFAppState()
                                            .userAuthentication
                                            .authorization, // Authentication token
                                      );

                                      // Handle the response (e.g., show a success message)
                                      log('Address removed successfully');
                                    } catch (e) {
                                      // Handle errors (e.g., show an error message)
                                      log('Failed to remove address: $e');
                                    }
                                  }
                                },
                                text: 'No More Resident',
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).error,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily),
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Icon(
                    Icons.local_fire_department_outlined,
                    color: FlutterFlowTheme.of(context).error,
                    size: 60.0,
                  ).animateOnPageLoad(
                      animationsMap['iconOnPageLoadAnimation']!),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
