part of 'diary_cubit.dart';

class DiaryState extends Equatable {
  const DiaryState({
    this.id,
    this.subject = '',
    this.date,
    this.description = '',
    this.mark = '',
    this.category = '',
    this.videoPath = '',
    this.imagePath = '',
    this.projectIds = const [],
  });

  final int? id;
  final String subject;
  final DateTime? date;
  final String description;
  final String mark;
  final String category;
  final String videoPath;
  final String imagePath;
  final List<int> projectIds;

  factory DiaryState.fromIsarModel(Diary diary) {
    return DiaryState(
      id: diary.id,
      subject: diary.subject ?? '',
      date: diary.date,
      description: diary.description ?? '',
      mark: diary.mark ?? '',
      category: diary.category ?? '',
      videoPath: diary.videoPath ?? '',
      imagePath: diary.imagePath ?? '',
      projectIds: List<int>.from(diary.projectIds ?? []),
    );
  }

  @override
  List<Object?> get props => [
    id,
    subject,
    date,
    description,
    mark,
    category,
    videoPath,
    imagePath,
    projectIds,
  ];

  DiaryState copyWith({
    int? id,
    String? subject,
    DateTime? date,
    String? description,
    String? mark,
    String? category,
    String? videoPath,
    String? imagePath,
    List<int>? projectIds,
  }) {
    return DiaryState(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      date: date ?? this.date,
      description: description ?? this.description,
      mark: mark ?? this.mark,
      category: category ?? this.category,
      videoPath: videoPath ?? this.videoPath,
      imagePath: imagePath ?? this.imagePath,
      projectIds: projectIds ?? this.projectIds,
    );
  }

  Diary toIsarModel() {
    return Diary()
      ..subject = subject
      ..date = date
      ..description = description
      ..mark = mark
      ..category = category
      ..videoPath = videoPath
      ..imagePath = imagePath
      ..projectIds = projectIds;
  }
}
