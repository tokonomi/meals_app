import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/main_drawer.dart';
import 'package:meals/screens/meals.dart';

Map<Filter, bool> kDefaultFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedTabIndex = 0;

  void setSelectedTab(tab) {
    setState(() {
      _selectedTabIndex = tab;
    });
  }

  void _setCurrentScreen(String screen) async {
    Navigator.of(context).pop();
    if (screen == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = ref.watch(filteredMealsProvider);
    Widget content = CategoryScreen(afterFilteredMeals: filteredData);
    String activeAppBar = 'Meals Categories';

    if (_selectedTabIndex == 1) {
      final favoriteMeal = ref.watch(favoritesProvider);
      content = MealsScreen(mealsList: favoriteMeal);
      activeAppBar = 'Your favorit meals';
    }
    return Scaffold(
      appBar: AppBar(title: Text(activeAppBar)),
      drawer: MainDrawer(
        onSelectScreen: _setCurrentScreen,
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: setSelectedTab,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Meals Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites')
        ],
      ),
    );
  }
}
