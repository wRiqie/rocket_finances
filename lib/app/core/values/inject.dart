import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/app/data/data_sources/ai_analysis_data_source.dart';
import 'package:rocket_finances/app/data/data_sources/auth_data_source.dart';
import 'package:rocket_finances/app/data/data_sources/bills_data_source.dart';
import 'package:rocket_finances/app/data/data_sources/budgets_data_source.dart';
import 'package:rocket_finances/app/data/data_sources/category_data_source.dart';
import 'package:rocket_finances/app/data/data_sources/receipts_data_source.dart';
import 'package:rocket_finances/app/data/repositories/ai_analysis_repository.dart';
import 'package:rocket_finances/app/data/repositories/auth_repository.dart';
import 'package:rocket_finances/app/data/repositories/bills_repository.dart';
import 'package:rocket_finances/app/data/repositories/budget_repository.dart';
import 'package:rocket_finances/app/data/repositories/category_repository.dart';
import 'package:rocket_finances/app/data/repositories/receipts_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

sealed class Inject {
  static void init() {
    final getIt = GetIt.I;

    // Supabase
    getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

    // datasources
    getIt.registerLazySingleton<AuthDataSource>(
        () => AuthDataSourceSupaImp(getIt()));
    getIt.registerLazySingleton<BillsDataSource>(
        () => BillsDataSourceSupaImp(getIt()));
    getIt.registerLazySingleton<ReceiptsDataSource>(
        () => ReceiptsDataSourceSupaImp(getIt()));
    getIt.registerLazySingleton<CategoryDataSource>(
        () => CategoryDataSourceSupaImp(getIt()));
    getIt.registerLazySingleton<BudgetsDataSource>(
        () => BudgetsDataSourceSupaImp(getIt()));
    getIt.registerLazySingleton<AiAnalysisDataSource>(
        () => AiAnalysisDataSourceSupaImp(getIt()));

    // repositories
    getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImp(getIt()));
    getIt.registerLazySingleton<BillsRepository>(
        () => BillsRepositoryImp(getIt()));
    getIt.registerLazySingleton<ReceiptsRepository>(
        () => ReceiptsRepositoryImp(getIt()));
    getIt.registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImp(getIt()));
    getIt.registerLazySingleton<BudgetRepository>(
        () => BudgetRepositoryImp(getIt()));
    getIt.registerLazySingleton<AiAnalysisRepository>(
        () => AiAnalysisRepositoryImp(getIt()));

    // helpers
    getIt.registerLazySingleton<SessionHelper>(() => SessionHelper(getIt()));

    // services
  }
}
