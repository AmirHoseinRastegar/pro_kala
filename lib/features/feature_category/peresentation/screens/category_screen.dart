import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_kala/features/feature_category/peresentation/bloc/category_bloc.dart';
import 'package:pro_kala/features/feature_category/repository/category_repository.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(CategoryRepository()),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (BuildContext context, CategoryState state) {
          if (state is CategoryLoading) {}
          if (state is CategorySuccess) {}
          if (state is CategoryError) {}

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
