class Marker {
  final String id;
  final String title;
  final String description;

  final double latitude;
  final double longitude;

  final int titleX;
  final int titleY;
  final String categoryId;

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
    required this.categoryId,
  });

  factory Marker.fromJson(Map<Object?, Object?> item) {
    var verifiedAt = item['verifiedAt'] as Map<Object?, Object?>;
    var se = verifiedAt['_seconds'] as int;

    return Marker(
        id: item['id'] as String,
        title: item['title'] as String,
        description: item['description'] as String,
        latitude: double.tryParse(item['latitude'].toString())!,
        longitude: double.tryParse(item['longitude'].toString())!,
        titleX: item['titleX'] as int,
        titleY: item['titleY'] as int,
        categoryId: item['categoryId'] as String,
        verifiedAt: DateTime.fromMillisecondsSinceEpoch(se * 1000));
  }
}
