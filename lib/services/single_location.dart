class SingleLocation {
  double latitude;
  double longitude;
  String name;
  bool autoDetected;

  SingleLocation(
      {required this.latitude,
      required this.longitude,
      required this.name,
      this.autoDetected = false});
}
