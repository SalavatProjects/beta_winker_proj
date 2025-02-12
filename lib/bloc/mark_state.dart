part of 'mark_cubit.dart';

class MarkState extends Equatable {
  const MarkState({
    this.id,
    this.name = '',
  });

  final int? id;
  final String name;

  factory MarkState.fromIsarModel(Mark mark) {
    return MarkState(
      id: mark.id,
      name: mark.name ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name];

  MarkState copyWith({
    int? id,
    String? name,
  }) {
    return MarkState(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Mark toIsarModel() {
    return Mark()..name = name;
  }
}

