class Marker {
  final String id;
  final String title;
  final String description;
  
  final double latitude;
  final double longitude;

  final int titleX;
  final int titleY;
  
  final DateTime verifiedAt;

  Marker({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.titleX,
    required this.titleY,
    required this.verifiedAt,
  });
}