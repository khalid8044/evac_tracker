import 'package:evac_tracker/custom_code/actions/dialog_check.dart';
import 'package:evac_tracker/pages/dashboard/notification_badge_provider.dart';
import 'package:evac_tracker/services/notifications_bg.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:upgrader/upgrader.dart';

import '../../flutter_flow/nav/nav.dart';

import '../../services/shared_preference/shared_preference.dart';
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';

import '/components/header_footer/footer_after_login/footer_after_login_widget.dart';
import '/components/header_footer/header_after_login/header_after_login_widget.dart';
import '/components/page_elements/drawer_content/drawer_content_widget.dart';
import '/components/page_elements/emergency_call/emergency_call_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:sticky_headers/sticky_headers.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dashboard_model.dart';
export 'dashboard_model.dart';
//import 'package:new_version/new_version.dart';

class DashboardWidget extends StatefulWidget {
  final bool initNotifications;
  const DashboardWidget({super.key, this.initNotifications = true});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late DashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreference sharedPreference = SharedPreference();
  final animationsMap = <String, AnimationInfo>{};

  NotificationPlugin firebaseMessaging = NotificationPlugin();
  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => DashboardModel());

    fetchBuildingIds(context);
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().isTempVisitor || FFAppState().isFloodVisitor) {
        _model.timerController.timer.setPresetTime(
          mSec: functions.calculateLogoutTimeInMS(
              getCurrentTimestamp, FFAppState().user.departureTime!),
          add: false,
        );
        _model.timerController.onResetTimer();

        _model.timerController.onStartTimer();
      }
    });

    animationsMap.addAll({
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(1.2, 1.2),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));

    // Add observer to listen for app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _model.dispose();
// Remove the observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // Adding a short delay to ensure the state is fully updated
      Future.delayed(const Duration(milliseconds: 100), () {
        // App has been brought from the background to the foreground
        print('App is in the foreground');
        // _model.triggerNotificationOnResume(context);
      });
    } else if (state == AppLifecycleState.paused) {
      // App is in the background
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: UpgradeAlert(
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            drawer: Drawer(
              elevation: 16.0,
              child: wrapWithModel(
                model: _model.drawerContentModel,
                updateCallback: () => setState(() {}),
                child: const DrawerContentWidget(),
              ),
            ),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, -1.0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        StickyHeader(
                          overlapHeaders: false,
                          header: Stack(
                            children: [
                              wrapWithModel(
                                model: _model.headerAfterLoginModel,
                                updateCallback: () => setState(() {}),
                                child: const HeaderAfterLoginWidget(),
                              ),
                              if (!FFAppState().user.isVisitor)
                                Align(
                                  alignment:
                                      const AlignmentDirectional(1.0, -1.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        scaffoldKey.currentState!.openDrawer();
                                      },
                                      child: Icon(
                                        Icons.menu,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (!FFAppState().isTempVisitor &&
                                  !FFAppState().isFloodVisitor)
                                Align(
                                  alignment:
                                      const AlignmentDirectional(0.0, 0.0),
                                  child: wrapWithModel(
                                    model: _model.emergencyCallModel,
                                    updateCallback: () => setState(() {}),
                                    child: const EmergencyCallWidget(),
                                  ),
                                ),
                              if (FFAppState().isTempVisitor ||
                                  FFAppState().isFloodVisitor)
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 10.0),
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 10.0, 0.0),
                                          child: Text(
                                            'You will be logged out in',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                ),
                                          ),
                                        ),
                                        FlutterFlowTimer(
                                          initialTime:
                                              _model.timerInitialTimeMs,
                                          getDisplayTime: (value) =>
                                              StopWatchTimer.getDisplayTime(
                                            value,
                                            hours: false,
                                            milliSecond: false,
                                          ),
                                          controller: _model.timerController,
                                          updateStateInterval: const Duration(
                                              milliseconds: 1000),
                                          onChanged: (value, displayTime,
                                              shouldUpdate) {
                                            _model.timerMilliseconds = value;
                                            _model.timerValue = displayTime;
                                            if (shouldUpdate) setState(() {});
                                          },
                                          onEnded: () async {
                                            navigate() {}
                                            if (FFAppState().user.userType ==
                                                'Resident') {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text('Message'),
                                                    content: const Text(
                                                        'Building Channel Unsubscribed'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext),
                                                        child: const Text('Ok'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              performLogout(context);
                                            }

                                            navigate();
                                          },
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(FlutterFlowTheme
                                                            .of(context)
                                                        .headlineSmallFamily),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 60.0),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: SafeArea(
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.95,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 10.0,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            offset: const Offset(
                                              0.0,
                                              0.0,
                                            ),
                                            spreadRadius: 0.0,
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Align(
                                        alignment: const AlignmentDirectional(
                                            0.0, 0.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text(
                                                  'DASHBOARD',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 5.0,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Wrap(
                                                spacing: () {
                                                  if (MediaQuery.sizeOf(context)
                                                          .width <
                                                      kBreakpointSmall) {
                                                    return 10.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      kBreakpointMedium) {
                                                    return 15.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      kBreakpointLarge) {
                                                    return 20.0;
                                                  } else {
                                                    return 10.0;
                                                  }
                                                }(),
                                                runSpacing: () {
                                                  if (MediaQuery.sizeOf(context)
                                                          .width <
                                                      kBreakpointSmall) {
                                                    return 10.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      kBreakpointMedium) {
                                                    return 15.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      kBreakpointLarge) {
                                                    return 20.0;
                                                  } else {
                                                    return 10.0;
                                                  }
                                                }(),
                                                alignment: WrapAlignment.start,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.start,
                                                direction: Axis.horizontal,
                                                runAlignment:
                                                    WrapAlignment.start,
                                                verticalDirection:
                                                    VerticalDirection.down,
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Consumer<
                                                      NotificationBadgeProvider>(
                                                    builder: (context, provider,
                                                        child) {
                                                      return InkWell(
                                                        onTap: () {
                                                          //provider.setNotificationCount(0);
                                                          context.pushNamed(
                                                              'inAppNotification');
                                                        },
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 3.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minWidth: 100.0,
                                                              minHeight: 80.0,
                                                              maxWidth: 120.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .accent4,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                width: 3.0,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                         38.0),
                                                                  child: badges
                                                                      .Badge(
                                                                    badgeContent:
                                                                        Text(
                                                                      provider
                                                                          .notificationCount
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).labelSmallFamily,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey(
                                                                              FlutterFlowTheme.of(context).labelSmallFamily,
                                                                            ),
                                                                          ),
                                                                    ),
                                                                    showBadge:
                                                                        true,
                                                                    // shape: badges
                                                                    //     .BadgeShape
                                                                    //     .circle,
                                                                    // badgeColor:
                                                                    //     FlutterFlowTheme.of(context)
                                                                    //         .primary,
                                                                    // elevation:
                                                                    //     5.0,
                                                                    // padding:
                                                                    //     const EdgeInsets
                                                                    //         .all(
                                                                    //         10.0),
                                                                    position: badges
                                                                            .BadgePosition
                                                                        .topEnd(),
                                                                    // animationType: badges
                                                                    //     .BadgeAnimationType
                                                                    //     .scale,
                                                                    // toAnimate:
                                                                    //     true,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional
                                                                              .center,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .notifications_none_rounded,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        size:
                                                                            50.0,
                                                                      ).animateOnActionTrigger(
                                                                        animationsMap[
                                                                            'iconOnActionTriggerAnimation']!,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  thickness:
                                                                      3.0,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                                Flexible(
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional
                                                                            .topCenter,
                                                                    child:
                                                                        AutoSizeText(
                                                                      'Alerts',
                                                                      maxLines:
                                                                          1,
                                                                      minFontSize:
                                                                          8.0,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).labelSmallFamily,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      if (FFAppState()
                                                          .user
                                                          .isVisitor) {
                                                        _model.eclRes =
                                                            await EvacProjAfterLoginGroup
                                                                .getECLCall
                                                                .call(
                                                          building: FFAppState()
                                                              .visitorBuilding
                                                              .buildingID,
                                                          authToken: FFAppState()
                                                              .userAuthentication
                                                              .authorization,
                                                        );

                                                        if ((_model.eclRes
                                                                ?.succeeded ??
                                                            true)) {
                                                          context.pushNamed(
                                                            'emergencyContactList',
                                                            queryParameters: {
                                                              'emergencyContact':
                                                                  serializeParam(
                                                                EvacProjAfterLoginGroup
                                                                    .getECLCall
                                                                    .result(
                                                                  (_model.eclRes
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                ),
                                                                ParamType.JSON,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Emergency contact list not found',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }
                                                      } else {
                                                        context.pushNamed(
                                                          'emergencyContactListAll',
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                const TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .fade,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      1000),
                                                            ),
                                                          },
                                                        );
                                                      }

                                                      setState(() {});
                                                    },
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 3.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Container(
                                                        constraints:
                                                            const BoxConstraints(
                                                          minWidth: 100.0,
                                                          minHeight: 80.0,
                                                          maxWidth: 120.0,
                                                          maxHeight: 100.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent4,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            width: 3.0,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .info_outline,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 50.0,
                                                            ),
                                                            Divider(
                                                              thickness: 3.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                            ),
                                                            Flexible(
                                                              child: Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  'ECL',
                                                                  maxLines: 1,
                                                                  minFontSize:
                                                                      8.0,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).labelSmallFamily,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelSmallFamily),
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      if (FFAppState()
                                                              .isFloodVisitor ||
                                                          FFAppState()
                                                              .isTempVisitor) {
                                                        _model.apiResultfeu =
                                                            await EvacProjAfterLoginGroup
                                                                .evacDiagramByIDCall
                                                                .call(
                                                          floor: FFAppState()
                                                              .visitorBuilding
                                                              .floorID,
                                                          authToken: FFAppState()
                                                              .userAuthentication
                                                              .authorization,
                                                        );

                                                        if ((_model.apiResultfeu
                                                                ?.succeeded ??
                                                            true)) {
                                                          context.pushNamed(
                                                            'evacuationDiagram',
                                                            queryParameters: {
                                                              'imageLocation':
                                                                  serializeParam(
                                                                EvacProjAfterLoginGroup
                                                                    .evacDiagramByIDCall
                                                                    .evacDiagramPath(
                                                                  (_model.apiResultfeu
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                ),
                                                                ParamType
                                                                    .String,
                                                              ),
                                                              'address':
                                                                  serializeParam(
                                                                functions
                                                                    .generateAddress(
                                                                        EvacProjAfterLoginGroup
                                                                            .evacDiagramByIDCall
                                                                            .siteName(
                                                                          (_model.apiResultfeu?.jsonBody ??
                                                                              ''),
                                                                        ),
                                                                        EvacProjAfterLoginGroup
                                                                            .evacDiagramByIDCall
                                                                            .buildingName(
                                                                          (_model.apiResultfeu?.jsonBody ??
                                                                              ''),
                                                                        ),
                                                                        EvacProjAfterLoginGroup
                                                                            .evacDiagramByIDCall
                                                                            .floorName(
                                                                          (_model.apiResultfeu?.jsonBody ??
                                                                              ''),
                                                                        )),
                                                                ParamType
                                                                    .String,
                                                              ),
                                                            }.withoutNulls,
                                                            extra: <String,
                                                                dynamic>{
                                                              kTransitionInfoKey:
                                                                  const TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        600),
                                                              ),
                                                            },
                                                          );
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Evacuation Diagram not found.',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }
                                                      } else {
                                                        context.pushNamed(
                                                          'evacuationDiagramAll',
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                const TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .fade,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      1000),
                                                            ),
                                                          },
                                                        );
                                                      }

                                                      setState(() {});
                                                    },
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 3.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Container(
                                                        constraints:
                                                            const BoxConstraints(
                                                          minWidth: 100.0,
                                                          minHeight: 80.0,
                                                          maxWidth: 120.0,
                                                          maxHeight: 100.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent4,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 3.0,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .task_outlined,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 50.0,
                                                            ),
                                                            const Divider(
                                                              thickness: 3.0,
                                                              color: Color(
                                                                  0xFFFF0000),
                                                            ),
                                                            Flexible(
                                                              child: Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  'Evac Diagram',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 1,
                                                                  minFontSize:
                                                                      8.0,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).labelSmallFamily,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelSmallFamily),
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      if (FFAppState()
                                                          .user
                                                          .isVisitor) {
                                                        _model.apiResultxkn =
                                                            await EvacProjAfterLoginGroup
                                                                .getAssemblyAreaCall
                                                                .call(
                                                          building: FFAppState()
                                                              .visitorBuilding
                                                              .buildingID,
                                                          authToken: FFAppState()
                                                              .userAuthentication
                                                              .authorization,
                                                        );

                                                        if ((_model.apiResultxkn
                                                                ?.succeeded ??
                                                            true)) {
                                                          context.pushNamed(
                                                            'assemblyArea',
                                                            queryParameters: {
                                                              'latLong':
                                                                  serializeParam(
                                                                functions.convertStringToLatLng(
                                                                    EvacProjAfterLoginGroup.getAssemblyAreaCall
                                                                        .lat(
                                                                          (_model.apiResultxkn?.jsonBody ??
                                                                              ''),
                                                                        )!
                                                                        .toList(),
                                                                    EvacProjAfterLoginGroup.getAssemblyAreaCall
                                                                        .long(
                                                                          (_model.apiResultxkn?.jsonBody ??
                                                                              ''),
                                                                        )!
                                                                        .toList()),
                                                                ParamType
                                                                    .LatLng,
                                                                isList: true,
                                                              ),
                                                              'type':
                                                                  serializeParam(
                                                                EvacProjAfterLoginGroup
                                                                    .getAssemblyAreaCall
                                                                    .type(
                                                                  (_model.apiResultxkn
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                ),
                                                                ParamType
                                                                    .String,
                                                                isList: true,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        }
                                                      } else {
                                                        context.pushNamed(
                                                          'assemblyAreaAll',
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                const TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .fade,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      1000),
                                                            ),
                                                          },
                                                        );
                                                      }

                                                      setState(() {});
                                                    },
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 3.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Container(
                                                        width: 120.0,
                                                        height: 100.0,
                                                        constraints:
                                                            const BoxConstraints(
                                                          minWidth: 100.0,
                                                          minHeight: 80.0,
                                                          maxWidth: 120.0,
                                                          maxHeight: 100.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent4,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiary,
                                                            width: 3.0,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .location_on_outlined,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 50.0,
                                                            ),
                                                            Divider(
                                                              thickness: 3.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiary,
                                                            ),
                                                            Flexible(
                                                              child: Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  'Assembly Area',
                                                                  maxLines: 1,
                                                                  minFontSize:
                                                                      8.0,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).labelSmallFamily,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelSmallFamily),
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (FFAppState()
                                                      .isFloodVisitor)
                                                    Builder(
                                                      builder: (context) =>
                                                          InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            const Color
                                                                .fromRGBO(
                                                                0, 0, 0, 0),
                                                        onTap: () async {
                                                          _model.apiResultfeu =
                                                              await EvacProjAfterLoginGroup
                                                                  .evacDiagramByIDCall
                                                                  .call(
                                                            floor: FFAppState()
                                                                .visitorBuilding
                                                                .floorID,
                                                            authToken: FFAppState()
                                                                .userAuthentication
                                                                .authorization,
                                                          );

                                                          if ((_model
                                                                  .apiResultfeu
                                                                  ?.succeeded ??
                                                              true)) {
                                                            context.pushNamed(
                                                              'plumbingDiagram',
                                                              queryParameters: {
                                                                'imageLocation':
                                                                    serializeParam(
                                                                  EvacProjAfterLoginGroup
                                                                      .evacDiagramByIDCall
                                                                      .evacDiagramPath(
                                                                    (_model.apiResultfeu
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ),
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'address':
                                                                    serializeParam(
                                                                  functions
                                                                      .generateAddress(
                                                                          EvacProjAfterLoginGroup
                                                                              .evacDiagramByIDCall
                                                                              .siteName(
                                                                            (_model.apiResultfeu?.jsonBody ??
                                                                                ''),
                                                                          ),
                                                                          EvacProjAfterLoginGroup
                                                                              .evacDiagramByIDCall
                                                                              .buildingName(
                                                                            (_model.apiResultfeu?.jsonBody ??
                                                                                ''),
                                                                          ),
                                                                          EvacProjAfterLoginGroup
                                                                              .evacDiagramByIDCall
                                                                              .floorName(
                                                                            (_model.apiResultfeu?.jsonBody ??
                                                                                ''),
                                                                          )),
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                              extra: <String,
                                                                  dynamic>{
                                                                kTransitionInfoKey:
                                                                    const TransitionInfo(
                                                                  hasTransition:
                                                                      true,
                                                                  transitionType:
                                                                      PageTransitionType
                                                                          .fade,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          600),
                                                                ),
                                                              },
                                                            );
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Plumbing diagram not found.',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: const Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 3.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minWidth: 100.0,
                                                              minHeight: 80.0,
                                                              maxWidth: 120.0,
                                                              maxHeight: 100.0,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .accent4,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                width: 3.0,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .plumbing,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  size: 50.0,
                                                                ),
                                                                Divider(
                                                                  thickness:
                                                                      3.0,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                                Flexible(
                                                                  child: Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      'Plumbing Plan',
                                                                      maxLines:
                                                                          8,
                                                                      minFontSize:
                                                                          8.0,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).labelSmallFamily,
                                                                            fontWeight:
                                                                                FontWeight.normal,
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
                                                  if (!FFAppState()
                                                      .user
                                                      .isVisitor)
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed(
                                                          'manageSites',
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                const TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .fade,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      1000),
                                                            ),
                                                          },
                                                        );
                                                      },
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 3.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minWidth: 100.0,
                                                            minHeight: 80.0,
                                                            maxWidth: 120.0,
                                                            maxHeight: 100.0,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .accent4,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 3.0,
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_city,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                size: 50.0,
                                                              ),
                                                              Divider(
                                                                thickness: 3.0,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                              Flexible(
                                                                child: Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          0.0,
                                                                          -1.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    'Manage Sites',
                                                                    maxLines: 1,
                                                                    minFontSize:
                                                                        8.0,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).labelSmallFamily,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelSmallFamily),
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: wrapWithModel(
                      model: _model.footerAfterLoginModel,
                      updateCallback: () => setState(() {}),
                      child: const FooterAfterLoginWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> performLogout(BuildContext context) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    if (mounted) {
      GoRouter.of(context).prepareAuthEvent();
      await authManager.signOut();
      GoRouter.of(context).clearRedirectLocation();
      FFAppState().userData = null;
      FFAppState().qrCodeJson = null;
      FFAppState().isQR = false;
      FFAppState().userAuthentication =
          AuthenticationStruct.fromSerializableMap(jsonDecode('{}'));
      FFAppState().loginHeader = '';
      FFAppState().qrBuilding = BuildingStruct.fromSerializableMap(
          jsonDecode('{\"buildingID\":\"0\"}'));
      FFAppState().activeBuilding = BuildingStruct.fromSerializableMap(
          jsonDecode(
              '{\"buildingID\":\"0\",\"FloorID\":\"0\",\"roomID\":\"0\"}'));
      FFAppState().passwordMatch = false;
      FFAppState().user = UserStruct();
      FFAppState().emergencyType = false;
      FFAppState().isTempVisitor = false;
      FFAppState().isFloodVisitor = false;
      FFAppState().visitorBuilding = BuildingStruct();
      List<String> ids = await sharedPreference.readStringList("buildingIds");
      NotificationPlugin firebaseMessaging = NotificationPlugin();
      firebaseMessaging.unSubScribeToBuilding(ids);
      sharedPreference.clearAll();
      DialogManager.disposeAllDialogs();
      setState(() {});
      context.goNamedAuth('login', context.mounted);
      await flutterLocalNotificationsPlugin.cancelAll();
      FFAppState.reset();
    }
  }

  Future<ApiCallResponse> _makeApiCall(String userType) async {
    ApiCallResponse response =
        await EvacProjAfterLoginGroup.getAddressesByUserTypeCall.call(
      user: FFAppState().user.uid,
      userType: userType,
      authToken: FFAppState().userAuthentication.authorization,
    );

    return response;
  }

  Future<void> fetchBuildingIds(BuildContext context) async {
    await sharedPreference.saveBool("isPeep", FFAppState().user.isPeep);
    List<String> uniqueBuildingIds1 = [];
    List<String> uniqueBuildingIds2 = [];
    List<String> uniqueBuildingIds3 = [];

    // Function to make the API call and handle token refresh if needed

    // Fetch data for Resident
    ApiCallResponse response = await _makeApiCall('Resident');
    if (response.jsonBody != null && response.jsonBody["results"] != null) {
      List<dynamic> results = response.jsonBody["results"];
      if (results.isNotEmpty) {
        Set<int> buildingIdSet = {}; // Use a Set to ensure uniqueness

        for (var result in results) {
          if (result["building_data"] != null &&
              result["building_data"]["id"] != null) {
            int buildingId = result["building_data"]["id"];
            buildingIdSet.add(buildingId);
          }
        }

        // Convert Set to List of Strings
        uniqueBuildingIds1 = buildingIdSet.map((id) => id.toString()).toList();
        print("1: ${uniqueBuildingIds1.length}");
      }
    } else {
      print('No results found for resident ${response.jsonBody}');
    }

    // Fetch data for Permanent Contractor
    ApiCallResponse response2 = await _makeApiCall('Permanent Contractor');
    if (response2.jsonBody != null && response2.jsonBody["results"] != null) {
      List<dynamic> results2 = response2.jsonBody["results"];
      if (results2.isNotEmpty) {
        Set<int> buildingIdSet = {}; // Use a Set to ensure uniqueness

        for (var result in results2) {
          if (result["building_data"] != null &&
              result["building_data"]["id"] != null) {
            int buildingId = result["building_data"]["id"];
            buildingIdSet.add(buildingId); // Add to Set
          }
        }

        // Convert Set to List of Strings
        uniqueBuildingIds2 = buildingIdSet.map((id) => id.toString()).toList();
        print("2: ${uniqueBuildingIds2.length}");
      }
    } else {
      print('No results found for visitor ${response2.jsonBody}');
    }

    // Fetch data for Temporary Contractor
    ApiCallResponse response3 = await _makeApiCall('Temporary Contractor');
    if (response3.jsonBody != null && response3.jsonBody["results"] != null) {
      List<dynamic> results3 = response3.jsonBody["results"];
      if (results3.isNotEmpty) {
        Set<int> buildingIdSet = {}; // Use a Set to ensure uniqueness

        for (var result in results3) {
          if (result["building_data"] != null &&
              result["building_data"]["id"] != null) {
            int buildingId = result["building_data"]["id"];
            buildingIdSet.add(buildingId); // Add to Set
            setState(() {
              FFAppState().loginHeader = functions.generateAddress(
                  result["building_data"]["name"],
                  result["floor_data"]["name"],
                  result["flat_data"]?["name"]);
            });
          }
        }

        // Convert Set to List of Strings
        uniqueBuildingIds3 = buildingIdSet.map((id) => id.toString()).toList();
        print("3: ${uniqueBuildingIds3.length}");
      }
    } else {
      print('No results found for visitor ${response2.jsonBody}');
    }

    // Save building IDs and initialize notifications
    if ([...uniqueBuildingIds1, ...uniqueBuildingIds2, ...uniqueBuildingIds3]
        .isNotEmpty) {
      await sharedPreference.saveStringList('buildingIds', [
        ...uniqueBuildingIds1,
        ...uniqueBuildingIds2,
        ...uniqueBuildingIds3
      ]);
      await firebaseMessaging.setupToken([
        ...uniqueBuildingIds1,
        ...uniqueBuildingIds2,
        ...uniqueBuildingIds3
      ].toList());
      firebaseMessaging.selectNotificationStream.stream
          .listen((String payload) async {});
    }
  }
}
