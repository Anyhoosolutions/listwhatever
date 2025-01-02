import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationCubit extends Cubit<LatLng?> {
  CurrentLocationCubit() : super(null) {
    _startLocationUpdates();
  }

  StreamSubscription<void>? _locationSubscription;

  void _startLocationUpdates() {
    _locationSubscription = Stream<void>.periodic(const Duration(seconds: 5)).listen((_) {
      _getCurrentLocation();
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        // TODO: Fix
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );
      emit(LatLng(position.latitude, position.longitude));
    } catch (e) {
      // handle exception
    }
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
