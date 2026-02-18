import 'dart:developer';

import 'package:evac_tracker/backend/api_requests/api_calls.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;
import '../../flutter_flow/nav/nav.dart';
import '/components/header_footer/footer_after_login/footer_after_login_widget.dart';
import '/components/header_footer/header_after_login/header_after_login_widget.dart';
import '/components/page_elements/drawer_content/drawer_content_widget.dart';
import '/components/page_elements/return_to_dashboard/return_to_dashboard_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'assembly_area_model.dart';
export 'assembly_area_model.dart';


class AssemblyAreaWidget extends StatefulWidget {
  const AssemblyAreaWidget({
    super.key,
    required this.latLong,
    required this.type,
  });

  final List<LatLng>? latLong;
  final List<String>? type;

  @override
  State<AssemblyAreaWidget> createState() => _AssemblyAreaWidgetState();
}

class _AssemblyAreaWidgetState extends State<AssemblyAreaWidget> {
  late AssemblyAreaModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  loc.Location location = loc.Location();
  LatLng? _userLocation;
  Set<gmaps.Polyline> _polylinePoints = {};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AssemblyAreaModel());
    _startLocationUpdates();
  }

 

  Future<void> _startLocationUpdates() async {
    bool serviceEnabled;
    loc.PermissionStatus permission;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        _showErrorSnackBar('Location service is disabled');
        return;
      }
    }

    permission = await location.hasPermission();
    if (permission == loc.PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != loc.PermissionStatus.granted) {
        _showErrorSnackBar('Location permission denied');
        return;
      }
    }

    // Get initial location
    _updateUserLocation();

    // Listen for location updates
    location.onLocationChanged.listen((loc.LocationData locationData) {
   if(mounted) {
     setState(() {
        _userLocation = LatLng(locationData.latitude!, locationData.longitude!);
        if (widget.latLong?.isNotEmpty ?? false) {
          _fetchRoute();
        }
      });
   }
    });
  }

  Future<void> _updateUserLocation() async {
    try {
      final locationData = await location.getLocation();
      setState(() {
        _userLocation = LatLng(locationData.latitude!, locationData.longitude!);
        if (widget.latLong?.isNotEmpty ?? false) {
          _fetchRoute();
        }
      });
    } catch (e) {
      log('Error getting location: $e');
      _showErrorSnackBar('Failed to get location');
    }
  }

  Future<void> _fetchRoute() async {
    if (_userLocation == null) return;

    setState(() {
    });

    final origin = _userLocation!;
    final destination = widget.latLong!.first;
   final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    final url = 'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${origin.latitude},${origin.longitude}&'
        'destination=${destination.latitude},${destination.longitude}&'
        'key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK') {
          final points = data['routes'][0]['overview_polyline']['points'];
          final decodedPoints = _decodePolyline(points);
          setState(() {
            _polylinePoints = {
              gmaps.Polyline(
                polylineId: const gmaps.PolylineId('route'),
                points: decodedPoints,
                color: Colors.blue,
                width: 5,
              ),
            };
          });
        } else {
          debugPrint('Directions API error: ${data['status']}');
        
          setState(() {
          });
        }
      } else {
        debugPrint('HTTP error: ${response.statusCode}');
        _showErrorSnackBar('Failed to fetch route: HTTP ${response.statusCode}');
        setState(() {
        });
      }
    } catch (e) {
      debugPrint('Error fetching route: $e');
      _showErrorSnackBar('Error fetching route');
      setState(() {
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  List<gmaps.LatLng> _decodePolyline(String encoded) {
    List<gmaps.LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(gmaps.LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
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
        resizeToAvoidBottomInset: false,
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
                                  scaffoldKey.currentState?.openDrawer();
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
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Assembly Area',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelLargeFamily,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .labelLargeFamily),
                                          ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.6,
                                  decoration: BoxDecoration(),
                                  clipBehavior: Clip.antiAlias,
                                  child: FlutterFlowGoogleMap(polylines: _polylinePoints,
                                    controller: _model.googleMapsController,
                                    onCameraIdle: (latLng) =>
                                        _model.googleMapsCenter = latLng,
                                    initialLocation: _model.googleMapsCenter ??=
                                        ((widget.latLong ?? []).isNotEmpty)
                                            ? (widget.latLong ?? []).first
                                            : LatLng(0, 0),
                                    markers: (widget.latLong ?? [])
                                        .map(
                                          (marker) => FlutterFlowMarker(
                                            marker.serialize(),
                                            marker,
                                          ),
                                        )
                                        .toList(),
                                    markerColor: GoogleMarkerColor.violet,
                                    markerImage: MarkerImage(
                                      imagePath:
                                          'assets/images/map-pin-red.png',
                                      isAssetImage: true,
                                      size: 30.0,
                                    ),
                                    mapType: MapType.normal,
                                    style: GoogleMapStyle.standard,
                                    initialZoom: 16.0,
                                    allowInteraction: true,
                                    allowZoom: true,
                                    showZoomControls: true,
                                    showLocation: true,
                                    showCompass: true,
                                    showMapToolbar: true,
                                    showTraffic: false,
                                    centerMapOnMarkerTap: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                if (FFAppState().activeBuilding.buildingID != 0)
                                  FFButtonWidget(
                                    onPressed: () async {
                                      _model.result =
                                          await UpdateUserEvacStatusCall().call(
                                        buildingId: FFAppState()
                                            .activeBuilding
                                            .buildingID.toString(), // Building ID from widget
                                        isActive: true, // Mark as active
                                        inBuilding: true, // In building
                                        exitBuilding: true,
                                        reachedAssemblyArea: true,
                                        authToken: FFAppState()
                                            .userAuthentication
                                            .authorization, // Authentication token
                                      );

                                      setState(() {
                                        FFAppState().activeBuilding.buildingID =
                                            0;
                                        FFAppState().activeBuilding.floorID = 0;
                                        FFAppState().activeBuilding.roomID = 0;
                                      });
                                      context.pushNamed(
                                        'dashboard',
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
                                    },
                                    text: 'Reached Assembly Area',
                                    icon: Icon(
                                      Icons.run_circle_outlined,
                                      size: 24.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              wrapWithModel(
                model: _model.footerAfterLoginModel,
                updateCallback: () => setState(() {}),
                child: FooterAfterLoginWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

