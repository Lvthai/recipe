import 'package:flutter/material.dart';
import 'package:recipe_app/sqlite/database_helper.dart';
import 'package:recipe_app/models/recipe.dart';

class BreakfastScreen extends StatefulWidget {
  const BreakfastScreen({super.key});

  @override
  _BreakfastScreenState createState() => _BreakfastScreenState();
}

class _BreakfastScreenState extends State<BreakfastScreen> {
  String sortOption = "Alphabetical";
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final data = await DatabaseHelper.instance.readAllRecipes();
    setState(() {
      recipes = data.where((recipe) => recipe.category == 'Breakfast').toList();
      sortRecipes();
    });
  }

  void sortRecipes() {
    if (sortOption == "Alphabetical") {
      recipes.sort((a, b) => a.name.compareTo(b.name));
    } else {
      recipes.sort((a, b) => b.name.compareTo(a.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breakfast Recipes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: sortOption,
              items: <String>['Alphabetical', 'Reverse Alphabetical']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    sortOption = newValue;
                    sortRecipes();
                  });
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(recipes[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
