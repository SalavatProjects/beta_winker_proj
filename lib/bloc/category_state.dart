part of 'category_cubit.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.id,
    this.name = '',
  });

  final int? id;
  final String name;

  factory CategoryState.fromIsarModel(Category category) {
    return CategoryState(
      id: category.id,
      name: category.name ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name];

  CategoryState copyWith({
    int? id,
    String? name,
  }) {
    return CategoryState(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Category toIsarModel() {
    return Category()..name = name;
  }
}
