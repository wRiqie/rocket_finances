import 'package:rocket_finances/app/data/data_sources/category_data_source.dart';
import 'package:rocket_finances/app/data/models/category_model.dart';
import 'package:rocket_finances/app/data/models/default_response_model.dart';
import 'package:rocket_finances/app/data/services/execute_service.dart';

abstract class CategoryRepository {
  Future<DefaultResponseModel<List<CategoryModel>>> getAllCategories();
}

class CategoryRepositoryImp implements CategoryRepository {
  final CategoryDataSource _categoryDataSource;

  CategoryRepositoryImp(this._categoryDataSource);

  @override
  Future<DefaultResponseModel<List<CategoryModel>>> getAllCategories() {
    return ExecuteService.tryExecuteAsync(
        () => _categoryDataSource.getAllCategories());
  }
}
