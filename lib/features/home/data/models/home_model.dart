import 'package:hamsafar/features/home/data/models/home_activity_model.dart';
import 'package:hamsafar/features/home/data/models/home_profile_model.dart';
import 'package:hamsafar/features/home/data/models/home_trip_model.dart';
import 'package:hamsafar/features/home/domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.profile,
    required super.currentTrip,
    required super.recentActivities,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    profile: HomeProfileModel.fromJson(json['profile']),
    currentTrip: json['current_trip'] != null
        ? [HomeTripModel.fromJson(json['current_trip'])]
        : [],
    recentActivities: (json['recent_activities'] as List? ?? [])
        .map((e) => HomeActivityModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'profile': profile,
    'current_trip': currentTrip,
    'recent_activities': recentActivities,
  };
}
