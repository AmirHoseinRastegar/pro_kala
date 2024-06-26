import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pro_kala/features/feature_bottom_nav/data/models/api_model.dart';

import '../../repository/category_repository.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<CallCategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        final HomeModel homeModel = await categoryRepository.get();
        emit(CategorySuccess(homeModel));
      } catch (e) {
        emit(CategoryError());
      }
    });
  }
}
