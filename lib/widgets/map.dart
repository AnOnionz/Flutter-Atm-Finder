import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MyMap extends StatelessWidget {
  final MapType type;
  final Set<Marker> markers;
  final Completer<GoogleMapController> completer;
  final LatLng center;
  final Function onLongPress;
  final double zoom;
  final Set<Polyline> polylines;
  const MyMap({Key key, this.markers, @required this.center, this.completer , this.onLongPress, this.zoom, this.polylines, this.type,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GoogleMap(
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        mapType:type,
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: zoom,
        ),
        markers: markers,
        polylines: polylines,
        onLongPress: onLongPress,
        onMapCreated: (GoogleMapController controller) {
          completer.complete(controller);
        },
      ),
    );
  }

}
