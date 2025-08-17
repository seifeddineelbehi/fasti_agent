import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_info_model.freezed.dart';
part 'vehicle_info_model.g.dart';

@freezed
class VehicleInfoModel with _$VehicleInfoModel {
  const factory VehicleInfoModel({
    required String type,
    required String color,
    required String numberPlate,
    required String vehiclePhotos,
    required String registrationCertificateFront,
    required String registrationCertificateBack,
    required String insurancePhoto,
    @Default('') String travelClass,
  }) = _VehicleInfoModel;

  factory VehicleInfoModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleInfoModelFromJson(json);
}

extension VehicleInfoModelFirestore on VehicleInfoModel {
  Map<String, dynamic> toJsonForFirestore() {
    return {
      'type': type,
      'color': color,
      'numberPlate': numberPlate,
      'vehiclePhotos': vehiclePhotos,
      'registrationCertificateFront': registrationCertificateFront,
      'registrationCertificateBack': registrationCertificateBack,
      'travelClass': travelClass,
      'insurancePhoto': insurancePhoto,
    };
  }
}
