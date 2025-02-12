part of 'project_cubit.dart';

class ProjectState extends Equatable {
  const ProjectState({
    this.id,
    this.name = '',
    this.description = '',
    this.diaryIds = const [],
  });

  final int? id;
  final String name;
  final String description;
  final List<int> diaryIds;

  factory ProjectState.fromIsarModel(Project project) {
    return ProjectState(
      id: project.id,
      name: project.name ?? '',
      description: project.description ?? '',
      diaryIds: project.diaryIds ?? [],
    );
  }

  @override
  List<Object?> get props => [id, name, description, diaryIds];

  ProjectState copyWith({
    int? id,
    String? name,
    String? description,
    List<int>? diaryIds,
  }) {
    return ProjectState(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      diaryIds: diaryIds ?? this.diaryIds,
    );
  }

  Project toIsarModel() {
    return Project()
      ..name = name
      ..description = description
      ..diaryIds = diaryIds;
  }
}
