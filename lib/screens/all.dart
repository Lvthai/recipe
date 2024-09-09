import 'package:flutter/material.dart';
import 'package:recipe_app/screens/breakfast.dart';
import 'package:recipe_app/screens/lunch.dart';
import 'package:recipe_app/screens/dinner.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  _AllScreenState createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Recipes'),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Breakfast"),
              Tab(text: "Lunch"),
              Tab(text: "Dinner"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BreakfastScreen(),
            LunchScreen(),
            DinnerScreen(),
          ],
        ),
      ),
    );
  }
}
