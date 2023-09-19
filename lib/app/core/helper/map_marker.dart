import 'package:fluster/fluster.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker extends Clusterable {
  final String? id;
  final LatLng? position;
  BitmapDescriptor? icon;
  final Function? onTapMarker;
  final String? trainerId;
  MapMarker({
    this.id,
    this.position,
    this.icon,
    isCluster = false,
    clusterId,
    pointsSize,
    this.onTapMarker,
    childMarkerId,
    this.trainerId,
  }) : super(
          markerId: id,
          latitude: position!.latitude,
          longitude: position.longitude,
          isCluster: isCluster,
          clusterId: clusterId,
          pointsSize: pointsSize,
          childMarkerId: childMarkerId,
        );

  Marker toMarker() => Marker(
      markerId: MarkerId(id!),
      position: LatLng(
        position!.latitude,
        position!.longitude,
      ),
      icon: icon!,
      onTap: () {
        if (isCluster == false) {
          onTapMarker!();
        }
      });
}