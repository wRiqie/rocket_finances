import 'package:rocket_finances/app/core/values/tables.dart';
import 'package:rocket_finances/app/data/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CategoryDataSource {
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryDataSourceSupaImp implements CategoryDataSource {
  final SupabaseClient _client;

  CategoryDataSourceSupaImp(this._client);

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final response =
        await _client.from(Tables.categories).select('id, name, icon_url');

    return response.isNotEmpty
        ? response.map((e) => CategoryModel.fromMap(e)).toList()
        : [];
  }
}
