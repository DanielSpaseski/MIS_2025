import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_detail.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;
  const MealDetailScreen({super.key, required this.mealId});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService _api = ApiService();
  late Future<MealDetail> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.lookupMeal(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<MealDetail>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          final meal = snap.data!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (meal.thumbnail.isNotEmpty)
                  Image.network(meal.thumbnail, width: double.infinity, height: 220, fit: BoxFit.cover),
                SizedBox(height: 12),
                Text(meal.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Category: ${meal.category} • Area: ${meal.area}'),
                SizedBox(height: 12),
                Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                ...meal.ingredients.map((m) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text('- ${m.keys.first} : ${m.values.first}'),
                )),
                const SizedBox(height: 12),
                const Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(meal.instructions),
                if (meal.youtube != null && meal.youtube!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () async {
                      final url = meal.youtube!;
                    },
                    child: Text(
                      meal.youtube!,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
