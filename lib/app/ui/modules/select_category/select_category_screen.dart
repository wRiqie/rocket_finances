import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_finances/app/business_logic/cubits/categories/categories_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/categories/categories_state.dart';
import 'package:rocket_finances/app/data/models/results/select_category_result.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({super.key});

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(_loadCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status.isError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Não foi possível carregar as categorias'),
                  TextButton(
                    onPressed: _loadCategories,
                    child: Text('Recarregar'),
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
                child: Column(
                  children: state.categories
                      .map((e) => ListTile(
                            title: Text(e.name),
                            onTap: () {
                              Navigator.pop(context, SelectCategoryResult(e));
                            },
                          ))
                      .toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _loadCategories() {
    BlocProvider.of<CategoriesCubit>(context).getAll();
  }
}
