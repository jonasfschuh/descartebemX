// ignore_for_file: public_member_api_docs, sort_constructors_first
// flutter_map: ^6.1.0
// latlong2: ^0.9.0
// <uses-permission android:name="android.permission.INTERNET"/>
// build gradle app minSdkVersion 20

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Maps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(-26.906216108234815, -49.07795013011656),
        initialZoom: 18,
        interactionOptions:
            InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
      ),
      children: [
        openStreetMapTileLayer,
        const FlutterMapZoomButtons(
          minZoom: 4,
          maxZoom: 19,
          mini: true,
          padding: 10,
          alignment: Alignment.bottomRight,
        ),
        MarkerLayer(markers: [
          Marker(
            point: LatLng(-26.906216108234815, -49.07795013011656),
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.location_pin,
              size: 60,
              color: Colors.red,
            ),
          ),
          Marker(
            point: LatLng(-26.907216108234815, -49.0775013011656),
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.location_pin,
              size: 60,
              color: Colors.red,
            ),
          ),
          Marker(
            point: LatLng(-26.908216108234815, -49.0775013011656),
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                //
              },
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.red,
              ),
            ),
          ),
        ])
      ],
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );

class FlutterMapZoomButtons extends StatelessWidget {
  final double minZoom;
  final double maxZoom;
  final bool mini;
  final double padding;
  final Alignment alignment;
  final Color? zoomInColor;
  final Color? zoomInColorIcon;
  final Color? zoomOutColor;
  final Color? zoomOutColorIcon;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;

  static const _fitBoundsPadding = EdgeInsets.all(12);

  const FlutterMapZoomButtons({
    super.key,
    this.minZoom = 1,
    this.maxZoom = 18,
    this.mini = true,
    this.padding = 2.0,
    this.alignment = Alignment.topRight,
    this.zoomInColor,
    this.zoomInColorIcon,
    this.zoomInIcon = Icons.zoom_in,
    this.zoomOutColor,
    this.zoomOutColorIcon,
    this.zoomOutIcon = Icons.zoom_out,
  });

  @override
  Widget build(BuildContext context) {
    final controller = MapController.of(context);
    final camera = MapCamera.of(context);
    final theme = Theme.of(context);

    return Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(left: padding, top: padding, right: padding),
            child: FloatingActionButton(
              heroTag: 'zoomInButton',
              mini: mini,
              backgroundColor: zoomInColor ?? theme.primaryColor,
              onPressed: () {
                final paddedMapCamera = CameraFit.bounds(
                  bounds: camera.visibleBounds,
                  padding: _fitBoundsPadding,
                ).fit(camera);
                final zoom = min(paddedMapCamera.zoom + 1, maxZoom);
                controller.move(paddedMapCamera.center, zoom);
              },
              child: Icon(zoomInIcon,
                  color: zoomInColorIcon ?? theme.iconTheme.color),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: FloatingActionButton(
              heroTag: 'zoomOutButton',
              mini: mini,
              backgroundColor: zoomOutColor ?? theme.primaryColor,
              onPressed: () {
                final paddedMapCamera = CameraFit.bounds(
                  bounds: camera.visibleBounds,
                  padding: _fitBoundsPadding,
                ).fit(camera);
                var zoom = paddedMapCamera.zoom - 1;
                if (zoom < minZoom) {
                  zoom = minZoom;
                }
                controller.move(paddedMapCamera.center, zoom);
              },
              child: Icon(zoomOutIcon,
                  color: zoomOutColorIcon ?? theme.iconTheme.color),
            ),
          ),
        ],
      ),
    );
  }
}
