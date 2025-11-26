import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/api_service.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class MealsByCategoryScreen extends StatefulWidget {
  final String category;
  const MealsByCategoryScreen({super.key, required this.category});

  @override
  State<MealsByCategoryScreen> createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  final ApiService _api = ApiService();
  late Future<List<Meal>> _future;
  String _search = '';
  List<Meal> _allMeals = [];

  @override
  void initState() {
    super.initState();
    _future = _api.fetchMealsByCategory(widget.category).then((meals) {
      _allMeals = meals;
      return meals;
    });
  }

  void _onSearchChanged(String q) {
    setState(() => _search = q.trim().toLowerCase());

    if (_search.isEmpty) {
      setState(() => _future = Future.value(_allMeals));
    } else {
      final filtered = _allMeals.where((meal) {
        return meal.name.toLowerCase().contains(_search);
      }).toList();

      setState(() => _future = Future.value(filtered));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(hintText: 'Search meals', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
              onChanged: _onSearchChanged,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Meal>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          final meals = snap.data ?? [];
          if (meals.isEmpty) return Center(child: Text('No results'));
          return GridView.builder(
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.85, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return MealCard(
                meal: meal,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MealDetailScreen(mealId: meal.id))),
              );
            },
          );
        },
      ),
    );
  }
}
