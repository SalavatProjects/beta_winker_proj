import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../storages/models/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({CategoryState? category}) : super(category ?? const CategoryState());

  void updateName(String value) {
    emit(state.copyWith(name: value));
  }

}
