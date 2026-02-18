import 'package:evac_tracker/flutter_flow/nav/nav.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../flutter_flow/flutter_flow_widgets.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/header_footer/footer_after_login/footer_after_login_widget.dart';
import '/components/header_footer/header_after_login/header_after_login_widget.dart';
import '/components/page_elements/drawer_content/drawer_content_widget.dart';

import '/components/page_elements/return_to_dashboard/return_to_dashboard_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'evacuation_diagram_model.dart';
export 'evacuation_diagram_model.dart';
import 'package:widget_zoom/widget_zoom.dart';

class EvacuationDiagramWidget extends StatefulWidget {
  const EvacuationDiagramWidget({
    super.key,
    required this.imageLocation,
    required this.address,
  });

  final String? imageLocation;
  final String? address;

  @override
  State<EvacuationDiagramWidget> createState() =>
      _EvacuationDiagramWidgetState();
}

class _EvacuationDiagramWidgetState extends State<EvacuationDiagramWidget>
    with TickerProviderStateMixin {
  late EvacuationDiagramModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EvacuationDiagramModel());

    animationsMap.addAll({
      'rowOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 500.0.ms,
            duration: 600.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.1, 1.1),
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Drawer(
          elevation: 16.0,
          child: wrapWithModel(
            model: _model.drawerContentModel,
            updateCallback: () => setState(() {}),
            child: DrawerContentWidget(),
          ),
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      wrapWithModel(
                        model: _model.headerAfterLoginModel,
                        updateCallback: () => setState(() {}),
                        child: HeaderAfterLoginWidget(),
                      ),
                      if (!FFAppState().user.isVisitor)
                        Align(
                          alignment: AlignmentDirectional(1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
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
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ),
                      Align(
                        alignment: AlignmentDirectional(-1.0, 1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 42.0, 0.0, 0.0),
                          child: wrapWithModel(
                            model: _model.returnToDashboardModel,
                            updateCallback: () => setState(() {}),
                            child: ReturnToDashboardWidget(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 60.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                         
                          Expanded(
                            child: Material(
                              color: Colors.transparent,
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 450.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10.0,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        offset: Offset(
                                          0.0,
                                          0.0,
                                        ),
                                        spreadRadius: 0.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          'Evacuation Diagram',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLargeFamily,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLargeFamily),
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            widget.address,
                                            'Click on diagram to zoom',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily),
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        child: (widget.imageLocation ?? "")
                                                .endsWith("pdf")
                                            ? PDF(
                                                onError: (error) {},
                                                onPageError: (page, error) {},
                                                enableSwipe: true,
                                                swipeHorizontal: false,
                                                fitEachPage: true,
                                                fitPolicy: FitPolicy.BOTH,
                                                autoSpacing: true,
                                                pageFling: false,
                                              ).cachedFromUrl(
                                                widget.imageLocation ?? "",
                                                placeholder: (progress) =>
                                                    Center(
                                                        child: Text(
                                                      '$progress %',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                errorWidget: (error) => Center(
                                                    child:
                                                        Text(error.toString())))
                                            : WidgetZoom(
                                                heroAnimationTag: 'tag',
                                                zoomWidget: Image.network(
                                                  widget.imageLocation ?? "",
                                                  //fit: BoxFit.fill,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if ((widget.imageLocation ?? "").endsWith("pdf"))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 1.0, 0.0, 10.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: (widget.imageLocation ?? "")
                                              .endsWith("pdf")
                                          ? PDF(
                                              onError: (error) {},
                                              onPageError: (page, error) {},
                                              enableSwipe: true,
                                              swipeHorizontal: false,
                                              fitEachPage: true,
                                              fitPolicy: FitPolicy.BOTH,
                                              autoSpacing: true,
                                              pageFling: false,
                                            ).cachedFromUrl(
                                              widget.imageLocation ?? "",
                                              placeholder: (progress) => Center(
                                                      child: Text(
                                                    '$progress %',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              errorWidget: (error) => Center(
                                                  child:
                                                      Text(error.toString())))
                                          : WidgetZoom(
                                              heroAnimationTag: 'tag',
                                              zoomWidget: Image.network(
                                                widget.imageLocation ?? "",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    ),
                                  );
                                },
                                text: 'Open Diagram',
                                icon: FaIcon(
                                  FontAwesomeIcons.signInAlt,
                                  size: 20.0,
                                ),
                                options: FFButtonOptions(
                                  width: 200.0,
                                  height: 45.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                      ),
                                  elevation: 5.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                            ),
                          if (FFAppState().activeBuilding.buildingID != 0)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 20.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.result =
                                      await UpdateUserEvacStatusCall().call(
                                    buildingId: FFAppState()
                                        .activeBuilding
                                        .buildingID.toString(), // Building ID from widget
                                    isActive: true, // Mark as active
                                    inBuilding: true, // In building
                                    exitBuilding: true,
                                    authToken: FFAppState()
                                        .userAuthentication
                                        .authorization, // Authentication token
                                  );
                                  _model.resAssyArea =
                                      await EvacProjAfterLoginGroup
                                          .getAssemblyAreaCall
                                          .call(
                                    building:
                                        FFAppState().activeBuilding.buildingID,
                                    authToken: FFAppState()
                                        .userAuthentication
                                        .authorization,
                                  );

                                  if ((_model.resAssyArea?.succeeded ?? true)) {
                                    context.pushNamed(
                                      'assemblyArea',
                                      queryParameters: {
                                        'latLong': serializeParam(
                                          functions.convertStringToLatLng(
                                              EvacProjAfterLoginGroup
                                                  .getAssemblyAreaCall
                                                  .lat(
                                                    (_model.resAssyArea
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!
                                                  .toList(),
                                              EvacProjAfterLoginGroup
                                                  .getAssemblyAreaCall
                                                  .long(
                                                    (_model.resAssyArea
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!
                                                  .toList()),
                                          ParamType.LatLng,
                                          isList: true,
                                        ),
                                        'type': serializeParam(
                                          EvacProjAfterLoginGroup
                                              .getAssemblyAreaCall
                                              .type(
                                            (_model.resAssyArea?.jsonBody ??
                                                ''),
                                          ),
                                          ParamType.String,
                                          isList: true,
                                        ),
                                      }.withoutNulls,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Record does not exist.',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Assembly Area',
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                              ).animateOnPageLoad(
                                  animationsMap['rowOnPageLoadAnimation']!),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.footerAfterLoginModel,
                  updateCallback: () => setState(() {}),
                  child: FooterAfterLoginWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
