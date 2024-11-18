import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.afterFilteredMeals});

  final List<Meal> afterFilteredMeals;

  void _selectCategory(BuildContext context, Category category) {
    final List<Meal> filteredMeals = afterFilteredMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              title: category.title,
              mealsList: filteredMeals,
            )));
  }

  @override
  Widget build(context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final data in availableCategories)
          CategoryGridItem(
              category: data,
              onSelectCategory: () {
                _selectCategory(context, data);
              })
      ],
    );
  }
}
