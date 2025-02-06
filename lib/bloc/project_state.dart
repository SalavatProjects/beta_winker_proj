part of 'project_cubit.dart';


class ProjectState extends Equatable{

  const ProjectState({
    this.id,
    this.name = '',
    this.description = '',
    this.diaries = const [],
  });

  final int? id;
  final String name;
  final String description;
  final List<DiaryState> diaries;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  Future<ProjectState> fromIsarModel(Project project) async {
    final diaries = project.diaries;
    return ProjectState(
      id: project.id,
      name: project.name ?? '',
      description: project.description ?? '',
      // diaries:
    );
  }
}

