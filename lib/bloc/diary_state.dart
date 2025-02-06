part of 'diary_cubit.dart';

class DiaryState extends Equatable{

  const DiaryState({
    this.id,
    this.subject = '',
    this.date,
    this.description = '',
    this.mark = '',
    this.category = '',
    this.videoPaths = const [],
    this.imagePaths = const [],
    this.projects = const [],
  });

  final int? id;
  final String subject;
  final DateTime? date;
  final String description;
  final String mark;
  final String category;
  final List<String> videoPaths;
  final List<String> imagePaths;
  final List<ProjectState> projects;

  @override
  // TODO: implement props
  List<Object?> get props => [id, subject, date, description, mark, category, videoPaths, imagePaths, projects];

  Future<DiaryState> fromIsarModel(Diary diary) async {
    return DiaryState(
      id: diary.id,
      subject: diary.subject ?? '',
      date: diary.date,
      description: diary.description ?? '',
      mark: diary.mark ?? '',
      category: diary.category ?? '',
      videoPaths: diary.videoPaths ?? const [],
      imagePaths: diary.imagePaths ?? const [],
      // projects: diary.projects.filter().findAll();
    );
  }

}

