class PredictedPlacesModel {
  String? placeId;
  String? mainText;
  String? secondaryText;
  String? imageLink;
  double? distanceInMeters;
  String? vicinity;
  double? latitude;
  double? longitude;

  PredictedPlacesModel({
    this.placeId,
    this.mainText,
    this.imageLink,
    this.secondaryText,
    this.distanceInMeters,
    this.vicinity,
    this.latitude,
    this.longitude,
  });

  factory PredictedPlacesModel.fromJson(Map<String, dynamic> json) {
    return PredictedPlacesModel(
      placeId: json['place_id'],
      mainText: json['name'],
      secondaryText: json['vicinity'],
      latitude: json['geometry']?['location']?['lat']?.toDouble(),
      longitude: json['geometry']?['location']?['lng']?.toDouble(),
      vicinity: json['vicinity'],
    );
  }

  PredictedPlacesModel copyWith({
    String? placeId,
    String? mainText,
    String? imageLink,
    String? secondaryText,
    double? distanceInMeters,
    String? vicinity,
    double? latitude,
    double? longitude,
  }) {
    return PredictedPlacesModel(
      placeId: placeId ?? this.placeId,
      mainText: mainText ?? this.mainText,
      secondaryText: secondaryText ?? this.secondaryText,
      distanceInMeters: distanceInMeters ?? this.distanceInMeters,
      vicinity: vicinity ?? this.vicinity,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageLink: imageLink ?? this.imageLink,
    );
  }
}
