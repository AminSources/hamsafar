import 'package:equatable/equatable.dart';
import 'package:hamsafar/features/home/domain/entities/home_activity_entity.dart';
import 'package:hamsafar/features/home/domain/entities/home_profile_entity.dart';
import 'package:hamsafar/features/home/domain/entities/home_trip_entity.dart';

class HomeEntity extends Equatable {
  final HomeProfileEntity profile;
  final List<HomeTripEntity> currentTrip;
  final List<HomeActivityEntity> activities;

  const HomeEntity({
    required this.profile,
    required this.currentTrip,
    this.activities = const [],
  });

  @override
  List<Object?> get props => [profile, currentTrip, activities];
}
