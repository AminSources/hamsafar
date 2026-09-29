import 'package:hamsafar/features/home/data/models/home_profile_model.dart';
import 'package:hamsafar/features/home/data/models/home_trip_model.dart';
import 'package:hamsafar/features/home/domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  const HomeModel({required super.profile, required super.currentTrip});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    profile: HomeProfileModel.fromJson(json['profile']),
    currentTrip: json['current_trip'] != null
        ? [HomeTripModel.fromJson(json['current_trip'])]
        : [],
  );

  Map<String, dynamic> toJson() => {
    'profile': profile,
    'current_trip': currentTrip,
  };
}
