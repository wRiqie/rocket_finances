import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/categories/categories_cubit.dart';
import 'package:rocket_finances/app/ui/modules/select_category/select_category_screen.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit(GetIt.I()),
      child: SelectCategoryScreen(),
    );
  }
}
