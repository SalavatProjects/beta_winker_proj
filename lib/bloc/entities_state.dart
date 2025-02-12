part of 'entities_cubit.dart';

class EntitiesState extends Equatable {
  const EntitiesState({
    this.diaries = const [],
    this.projects = const [],
    this.locations = const [],
    this.marks = const [],
    this.categories = const [],
  });

  final List<DiaryState> diaries;
  final List<ProjectState> projects;
  final List<LocationState> locations;
  final List<MarkState> marks;
  final List<CategoryState> categories;

  @override
  List<Object?> get props => [diaries, projects, locations, marks, categories];

  EntitiesState copyWith({
    List<DiaryState>? diaries,
    List<ProjectState>? projects,
    List<LocationState>? locations,
    List<MarkState>? marks,
    List<CategoryState>? categories,
  }) {
    return EntitiesState(
      diaries: diaries ?? this.diaries,
      projects: projects ?? this.projects,
      locations: locations ?? this.locations,
      marks: marks ?? this.marks,
      categories: categories?? this.categories,
    );
  }
}
