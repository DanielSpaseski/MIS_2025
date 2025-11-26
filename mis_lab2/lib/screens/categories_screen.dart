import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/api_service.dart';
import '../widgets/category_card.dart';
import 'meals_by_category_screen.dart';
import 'meal_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ApiService _api = ApiService();
  late Future<List<Category>> _future;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _future = _api.fetchCategories();
  }

  void _openRandom() async {
    final meal = await _api.randomMeal();
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => MealDetailScreen(mealId: meal.id)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(onPressed: _openRandom, icon: Icon(Icons.shuffle)),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(hintText: 'Search categories', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
              onChanged: (v) => setState(() => _search = v.trim().toLowerCase()),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Category>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          final cats = snap.data ?? [];
          final filtered = _search.isEmpty ? cats : cats.where((c) => c.name.toLowerCase().contains(_search)).toList();
          return GridView.builder(
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.85, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final cat = filtered[index];
              return CategoryCard(
                category: cat,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MealsByCategoryScreen(category: cat.name)));
                },
              );
            },
          );
        },
      ),
    );
  }
}
