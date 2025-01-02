import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:listwhatever/helpers/current_location_cubit.dart';
import 'package:listwhatever/pages/list/components/custom_marker.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';

class MapView extends HookWidget {
  const MapView({required this.items, super.key});
  final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    final currentLocation = context.watch<CurrentLocationCubit>().state;

    return FlutterMap(
      mapController: MapController(),
      options: getMapOptions([]),
      children: [
        openStreetMapTileLayer,
        MarkerLayer(
          markers: [
            ...getMarkers(items),
            if (currentLocation != null) getCurrentLocationMarker(currentLocation),
          ],
        ),
      ],
    );
  }

  MapOptions getMapOptions(List<ListItem> items) {
    const flags = InteractiveFlag.drag |
        InteractiveFlag.pinchZoom |
        InteractiveFlag.doubleTapZoom |
        InteractiveFlag.scrollWheelZoom;

    final initialCenter = getCenter(items);
    return MapOptions(
      initialCenter: initialCenter,
      initialZoom: 8,
      interactionOptions: const InteractionOptions(
        flags: flags,
      ),
    );
  }

  (LatLng, LatLng) getBounds(List<ListItem> items) {
    final latLngList =
        items.where((e) => e.latLong != null).map((e) => LatLng(e.latLong!.latitude, e.latLong!.longitude)).toList();

    if (latLngList.isEmpty) {
      return (const LatLng(56, 11), const LatLng(58, 13));
    }

    double? x0;
    double? x1;
    double? y0;
    double? y1;
    for (final latLng in latLngList) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return (LatLng(x1!, y1!), LatLng(x0!, y0!));
  }

  LatLng getCenter(List<ListItem> items) {
    final bounds = getBounds(items);
    return LatLng(
      (bounds.$1.latitude - bounds.$2.latitude) / 2 + bounds.$2.latitude,
      (bounds.$1.longitude - bounds.$2.longitude) / 2 + bounds.$2.longitude,
    );
  }

  TileLayer get openStreetMapTileLayer {
    return TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.anyhoostudios.listwhatever',
      // Use the recommended flutter_map_cancellable_tile_provider package to
      // support the cancellation of loading tiles.
      tileProvider: CancellableNetworkTileProvider(),
    );
  }

  List<Marker> getMarkers(List<ListItem> items) {
    final markers = <Marker>[];
    for (final item in items) {
      if (item.latLong != null) {
        markers.add(
          Marker(
            point: LatLng(
              item.latLong!.latitude,
              item.latLong!.longitude,
            ),
            child: CustomMarker(
              color: Colors.red,
              onPressed: () {
                // widget.onTap(item.id!);
              },
            ),
          ),
        );
      }
    }
    return markers;
  }

  Marker getCurrentLocationMarker(LatLng currentLocation) {
    return Marker(
      point: LatLng(
        currentLocation.latitude,
        currentLocation.longitude,
      ),
      child: CustomMarker(
        color: Colors.blue,
        onPressed: () {},
      ),
    );
  }
}
