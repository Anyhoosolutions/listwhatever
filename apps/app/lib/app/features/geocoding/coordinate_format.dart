String formatLatitude(double latitude) {
  final direction = latitude >= 0 ? 'N' : 'S';
  return '${latitude.abs().toStringAsFixed(4)}° $direction';
}

String formatLongitude(double longitude) {
  final direction = longitude >= 0 ? 'E' : 'W';
  return '${longitude.abs().toStringAsFixed(4)}° $direction';
}
