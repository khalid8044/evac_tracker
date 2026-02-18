// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'dart:async';

import 'package:flutter/services.dart';

class CustomGoogleMapsMarkers extends StatefulWidget {
  const CustomGoogleMapsMarkers({
    super.key,
    this.width,
    this.height,
    this.markersLatLng,
    this.markerIconNames,
    this.jsonMapsString,
    this.choosenMarker,
    this.enableZoomGesture,
    this.enableZoomControl,
    this.zoomLevel,
    this.minimumZoom,
    this.maximumZoom,
    this.showMapsCircles,
    this.mapsCirclesDiameter,
    this.mapsCirclesFillColor,
    this.mapsCircleBorderColor,
    this.mapsCircleBorderWidth,
  });

  final double? width;
  final double? height;
  final List<LatLng>? markersLatLng;
  final List<String>? markerIconNames;
  final String? jsonMapsString;
  final Future Function(LatLng? latLng)? choosenMarker;
  final bool? enableZoomGesture;
  final bool? enableZoomControl;
  final double? zoomLevel;
  final double? minimumZoom;
  final double? maximumZoom;
  final bool? showMapsCircles;
  final double? mapsCirclesDiameter;
  final Color? mapsCirclesFillColor;
  final Color? mapsCircleBorderColor;
  final int? mapsCircleBorderWidth;

  @override
  State<CustomGoogleMapsMarkers> createState() =>
      _CustomGoogleMapsMarkersState();
}

class _CustomGoogleMapsMarkersState extends State<CustomGoogleMapsMarkers> {
  Completer<gmaps.GoogleMapController> _controller =
      Completer<gmaps.GoogleMapController>();
  gmaps.BitmapDescriptor markerIcon = gmaps.BitmapDescriptor.defaultMarker;
  Set<gmaps.Marker> markers = {};
  Set<gmaps.Circle> circles = {};

  @override
  void initState() {
    super.initState();
    _controller = Completer<gmaps.GoogleMapController>();
    _createMarkers();
    _createCircles();
  }

  //int randomNumber = random.nextInt(10000); // Change 10000 to any upper limit you desire

  /// marker creation start
  void _createMarkers() async {
    gmaps.BitmapDescriptor markerIconData;
    if (widget.markersLatLng != null && widget.markerIconNames != null) {
      for (int i = 0; i < widget.markersLatLng!.length; i++) {
        if (widget.markerIconNames == null) {
          markerIconData = gmaps.BitmapDescriptor.defaultMarker;
        } else {
          Uint8List imageData =
              await _getBytesFromAsset(widget.markerIconNames![i]);
          markerIconData = gmaps.BitmapDescriptor.fromBytes(imageData);
        }
        ;
        markers.add(
          gmaps.Marker(
            //markerId: gmaps.MarkerId(widget.markerIconNames![i]),
            markerId: gmaps.MarkerId(
                '${widget.markersLatLng![i].latitude.toString()},${widget.markersLatLng![i].longitude.toString()}'),
            position: gmaps.LatLng(widget.markersLatLng![i].latitude,
                widget.markersLatLng![i].longitude),
            icon: markerIconData,
            anchor: Offset(0, 1.0),
            onTap: () {
              widget.choosenMarker!(LatLng(widget.markersLatLng![i].latitude,
                  widget.markersLatLng![i].longitude));
            },
          ),
        );
      }
    }
  }

  void _createCircles() async {
    if (widget.markersLatLng != null &&
        widget.markerIconNames != null &&
        widget.showMapsCircles != null) {
      for (int i = 0; i < widget.markersLatLng!.length; i++) {
        circles.add(gmaps.Circle(
            circleId: gmaps.CircleId(
                'C${widget.markersLatLng![i].latitude.toString()},${widget.markersLatLng![i].longitude.toString()}'),
            center: gmaps.LatLng(widget.markersLatLng![i].latitude,
                widget.markersLatLng![i].longitude),
            fillColor: widget.mapsCirclesFillColor!,
            strokeColor: widget.mapsCircleBorderColor!,
            strokeWidth: widget.mapsCircleBorderWidth!,
            radius: widget.mapsCirclesDiameter! / 2,
            onTap: () {
              widget.choosenMarker!(LatLng(widget.markersLatLng![i].latitude,
                  widget.markersLatLng![i].longitude));
            }));
      }
    }
  }

  /// marker creation end

  /// getting icons start
  Future<Uint8List> _getBytesFromAsset(String assetName) async {
    ByteData data = await rootBundle.load("assets/images/$assetName");
    return data.buffer.asUint8List();
  }

  /// getting icons end
  double? zoomLevelVar;
  late gmaps.MinMaxZoomPreference minMaxZoom;

  @override
  Widget build(BuildContext context) {
    // Function to calculate the average of a list of numbers
    double average(List<double> numbers) {
      return numbers.reduce((value, element) => value + element) /
          numbers.length;
    }

    if (widget.zoomLevel == null) {
      zoomLevelVar = 14;
    } else {
      zoomLevelVar = widget.zoomLevel;
    }

    if (widget.minimumZoom != null && widget.maximumZoom != null) {
      minMaxZoom =
          gmaps.MinMaxZoomPreference(widget.minimumZoom, widget.maximumZoom);
    } else {
      minMaxZoom = gmaps.MinMaxZoomPreference(null, null);
    }

// Extracting all latitudes and longitudes from LatLng list
    List<double> latitudes =
        widget.markersLatLng!.map((latLng) => latLng.latitude).toList();
    List<double> longitudes =
        widget.markersLatLng!.map((latLng) => latLng.longitude).toList();

// Calculating the average latitude and longitude
    double averageLatitude = average(latitudes);
    double averageLongitude = average(longitudes);

// Set the initial position to the average coordinates
    gmaps.LatLng initialPosition =
        gmaps.LatLng(averageLatitude, averageLongitude);

    return gmaps.GoogleMap(
      zoomControlsEnabled: widget.enableZoomControl!,
      zoomGesturesEnabled: widget.enableZoomGesture!,
      initialCameraPosition: gmaps.CameraPosition(
        target: initialPosition,
        zoom: zoomLevelVar!,
      ),
      markers: markers,
      circles: circles,
      minMaxZoomPreference: minMaxZoom,
      onMapCreated: (gmaps.GoogleMapController controller) {
        _controller.complete(controller);
        _controller.future.then((value) {
          value.setMapStyle(
              widget.jsonMapsString!); // Ensure jsonMapsString is not null
        });
      },
    );
  }
}
