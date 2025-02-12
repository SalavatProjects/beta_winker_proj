part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState({
    this.id,
    this.name = '',
    this.mark = '',
    this.category = '',
  });

  final int? id;
  final String name;
  final String mark;
  final String category;

  @override
  List<Object?> get props => [id, name, mark, category];

  factory LocationState.fromIsarModel(Location location) {
    return LocationState(
      id: location.id,
      name: location.name ?? '',
      mark: location.mark ?? '',
      category: location.category ?? '',
    );
  }

  LocationState copyWith({
    int? id,
    String? name,
    String? mark,
    String? category,
  }) {
    return LocationState(
      id: id ?? this.id,
      name: name ?? this.name,
      mark: mark ?? this.mark,
      category: category ?? this.category,
    );
  }

  Location toIsarModel() {
    return Location()
      ..name = name
      ..mark = mark
      ..category = category;
  }
}
