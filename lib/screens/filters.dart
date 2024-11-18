import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
// import 'package:meals/screens/main_drawer.dart';
// import 'package:meals/screens/tabs.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProvider = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          _switchOption('Gluten-free', Filter.glutenFree,
              activeProvider[Filter.glutenFree]!, ref, context),
          _switchOption('Lactose-free', Filter.lactoseFree,
              activeProvider[Filter.lactoseFree]!, ref, context),
          _switchOption('Vegetarian', Filter.vegetarian,
              activeProvider[Filter.vegetarian]!, ref, context),
          _switchOption('Vegan', Filter.vegan, activeProvider[Filter.vegan]!,
              ref, context),
        ],
      ),
    );
  }
}

Widget _switchOption(String title, Filter type, bool value, WidgetRef ref,
    BuildContext context) {
  return SwitchListTile(
    value: value,
    onChanged: (value) {
      ref.read(filtersProvider.notifier).setFilter(type, value);
    },
    title: Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
    ),
    subtitle: Text(
      'Only includes gluten free meals',
      style: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
    ),
    activeColor: Theme.of(context).colorScheme.tertiary,
  );
}
