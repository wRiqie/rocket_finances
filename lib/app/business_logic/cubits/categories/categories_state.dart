import 'package:rocket_finances/app/data/models/category_model.dart';
import 'package:rocket_finances/app/data/models/error_model.dart';

enum CategoriesStatus {
  idle,
  loading,
  success,
  error;

  bool get isLoading => this == CategoriesStatus.loading;
  bool get isSuccess => this == CategoriesStatus.success;
  bool get isError => this == CategoriesStatus.error;
}

class CategoriesState {
  final List<CategoryModel> categories;
  final CategoriesStatus status;
  final ErrorModel? error;

  CategoriesState({
    this.status = CategoriesStatus.idle,
    this.error,
    this.categories = const [],
  });

  CategoriesState copyWith({
    List<CategoryModel>? categories,
    CategoriesStatus? status,
    ErrorModel? error,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
