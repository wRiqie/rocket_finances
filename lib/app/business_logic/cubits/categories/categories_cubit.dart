import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_finances/app/business_logic/cubits/categories/categories_state.dart';
import 'package:rocket_finances/app/data/repositories/category_repository.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoryRepository _categoryRepository;
  CategoriesCubit(this._categoryRepository) : super(CategoriesState());

  void getAll() async {
    emit(state.copyWith(status: CategoriesStatus.loading));

    final response = await _categoryRepository.getAllCategories();

    if (response.isSuccess) {
      emit(state.copyWith(
        status: CategoriesStatus.success,
        categories: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: CategoriesStatus.error,
        error: response.error,
      ));
    }
  }
}
