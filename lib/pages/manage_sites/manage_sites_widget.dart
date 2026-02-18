import 'package:evac_tracker/pages/manage_sites/manage_sites_provider.dart';
import 'package:flutter/cupertino.dart';

import '../../services/shared_preference/shared_preference.dart';
import '/components/alerts/add_building/add_building_widget.dart';
import '/components/alerts/edit_address_perm_visitor/edit_address_perm_visitor_widget.dart';
import '/components/header_footer/footer_after_login/footer_after_login_widget.dart';
import '/components/header_footer/header_after_login/header_after_login_widget.dart';
import '/components/page_elements/drawer_content/drawer_content_widget.dart';
import '/components/page_elements/no_address/no_address_widget.dart';
import '/components/page_elements/return_to_dashboard/return_to_dashboard_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'manage_sites_model.dart';
export 'manage_sites_model.dart';

class ManageSitesWidget extends StatefulWidget {
  const ManageSitesWidget({super.key});

  @override
  State<ManageSitesWidget> createState() => _ManageSitesWidgetState();
}

class _ManageSitesWidgetState extends State<ManageSitesWidget>
    with TickerProviderStateMixin {
  late ManageSitesModel _model;
  late AnimationController _animationController;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreference sharedPreference = SharedPreference();
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ManageSitesModel());
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );


    // Start the bounce animation when the widget is built
    // _startBounceAnimation();

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final provider =
          Provider.of<ManagerSitesProvider>(context, listen: false);
      provider.fetchAddressesResident(
          FFAppState().user.uid, FFAppState().userAuthentication.authorization);
      provider.fetchAddressesPermContractor(
          FFAppState().user.uid, FFAppState().userAuthentication.authorization);

      // Start bounce animation after loading addresses
      if (provider.addressesResident.isNotEmpty ||
          provider.addressesPermContractor.isNotEmpty) {
        _startBounceAnimation();
      }
    });
  }

  void _startBounceAnimation() async {
    await Future.delayed(const Duration(seconds: 5)); // Initial delay
    _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _animationController.reverse();
    await Future.delayed(const Duration(milliseconds: 300)); // Initial delay
    _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
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
              ListView(
                padding: EdgeInsets.zero,
                primary: false,
                scrollDirection: Axis.vertical,
                children: [
                  StickyHeader(
                    overlapHeaders: false,
                    header: Stack(
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
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
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
                    //Body Container
                    content: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 60.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SafeArea(
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.95,
                            constraints: BoxConstraints(
                              maxWidth: 450.0,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).alternate,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10.0,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  offset: Offset(0.0, 0.0),
                                  spreadRadius: 0.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Consumer<ManagerSitesProvider>(
                              builder: (context, provider, child) {
                                if (provider.isLoading) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.75,
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: SpinKitRipple(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              size: 50.0,
                                            ),
                                          ),
                                          Text(
                                            "Loading Buildings. Please wait...",
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLargeFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w800,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLargeFamily),
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return SingleChildScrollView(
                                  primary: false,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Text(
                                            'Manage Buildings',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLargeFamily,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) => Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              await showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return Dialog(
                                                    elevation: 0,
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        AlignmentDirectional(
                                                                0.0, 0.0)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(
                                                                  dialogContext)
                                                              .unfocus(),
                                                      child:
                                                          AddBuildingWidget(),
                                                    ),
                                                  );
                                                },
                                              ).then((_) {
                                                provider.fetchAddressesResident(
                                                    FFAppState().user.uid,
                                                    FFAppState()
                                                        .userAuthentication
                                                        .authorization);
                                                provider
                                                    .fetchAddressesPermContractor(
                                                        FFAppState().user.uid,
                                                        FFAppState()
                                                            .userAuthentication
                                                            .authorization);
                                              });
                                            },
                                            text: 'Add More Buildings',
                                            icon: Icon(
                                              Icons.qr_code_2,
                                              size: 30.0,
                                            ),
                                            options: FFButtonOptions(
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 24.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                      ),
                                              elevation: 3.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 5.0, 0.0),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                    ),
                                                  ),
                                                  child: provider
                                                          .addressesResident
                                                          .isNotEmpty
                                                      ? ListView.builder(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      12.0,
                                                                      0.0,
                                                                      0.0),
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount: provider
                                                              .addressesResident
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final address =
                                                                provider.addressesResident[
                                                                    index];
                                                            return ListTile(
                                                              leading: Icon(
                                                                Icons.house,
                                                                size: 40.0,
                                                                color: FFAppState()
                                                                            .activeBuilding
                                                                            .buildingID ==
                                                                        address
                                                                            .buildingData
                                                                            .id
                                                                    ? Colors.red
                                                                    : null,
                                                              ),
                                                              title: Text(
                                                                address.flatData
                                                                    .building,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelMediumFamily,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                    ),
                                                              ),
                                                              subtitle: Text(
                                                                '${address.floorData.name}, ${address.flatData.name}',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelSmallFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              trailing: address
                                                                      .isLoading
                                                                  ? CupertinoActivityIndicator()
                                                                  : IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .red,
                                                                        size:
                                                                            30.0,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        await provider.showDialogLeaveResidentBuilding(
                                                                            context,
                                                                            address);
                                                                      },
                                                                    ),
                                                              dense: false,
                                                            );
                                                          },
                                                        )
                                                      : SizedBox(
                                                          height: 100,
                                                          child:
                                                              const NoAddressWidget()),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      15.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 5.0, 0.0),
                                                  child: Text(
                                                    'Resident',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 1.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 5.0, 0.0),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                    ),
                                                  ),
                                                  child: provider
                                                          .addressesPermContractor
                                                          .isNotEmpty
                                                      ? ListView.builder(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      12.0,
                                                                      0.0,
                                                                      0.0),
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount: provider
                                                              .addressesPermContractor
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final address =
                                                                provider.addressesPermContractor[
                                                                    index];
                                                            return ListTile(
                                                              leading: Icon(
                                                                Icons.house,
                                                                size: 40.0,
                                                                color: FFAppState()
                                                                            .activeBuilding
                                                                            .buildingID ==
                                                                        address
                                                                            .buildingData
                                                                            .id
                                                                    ? Colors.red
                                                                    : null,
                                                              ),
                                                              title: Text(
                                                                address
                                                                    .floorData
                                                                    .building,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelMediumFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                    ),
                                                              ),
                                                              subtitle: Text(
                                                                '${address.floorData.name}${address.flatData?.name != null ? ', ${address.flatData?.name}' : ''}',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelSmallFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              trailing: address
                                                                      .isLoading
                                                                  ? CupertinoActivityIndicator()
                                                                  : Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        IconButton(
                                                                          icon:
                                                                              Icon(
                                                                            Icons.edit,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            size:
                                                                                30.0,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            await showDialog(
                                                                              barrierDismissible: false,
                                                                              context: context,
                                                                              builder: (dialogContext) {
                                                                                return Dialog(
                                                                                  elevation: 0,
                                                                                  insetPadding: EdgeInsets.zero,
                                                                                  backgroundColor: Colors.transparent,
                                                                                  alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                  child: GestureDetector(
                                                                                    onTap: () => FocusScope.of(dialogContext).unfocus(),
                                                                                    child: EditAddressPermVisitorWidget(
                                                                                      id: address.id,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ).then((result) {
                                                                              if (result == true) {
                                                                                provider.fetchAddressesPermContractor(
                                                                                  FFAppState().user.uid,
                                                                                  FFAppState().userAuthentication.authorization,
                                                                                );
                                                                              }
                                                                            });
                                                                          },
                                                                        ),
                                                                        IconButton(
                                                                          icon:
                                                                              Icon(
                                                                            Icons.delete,
                                                                            color:
                                                                                Colors.red,
                                                                            size:
                                                                                30.0,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            await provider.showDialogLeaveContractorBuilding(context,
                                                                                address);
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                              dense: false,
                                                            );
                                                          },
                                                        )
                                                      : SizedBox(
                                                          height: 100,
                                                          child:
                                                              const NoAddressWidget()),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      15.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 5.0, 0.0),
                                                  child: Text(
                                                    'Permanent Contractor',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 1.0,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(-1.0, -1.0),
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
