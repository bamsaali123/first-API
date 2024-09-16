import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/recipe.api.dart';
import 'package:flutter_application_3/models/recipe.dart';
import 'package:flutter_application_3/screens/widgets/recipe_card.dart';
import 'package:shimmer/shimmer.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe>? _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    try {
      final recipes = await RecipeApi.getRecipe();
      setState(() {
        _recipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Food Recipe')
          ],
        ),
      ),
     /* body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _recipes?.length ?? 0,
              itemBuilder: (context, index) {
                final recipe = _recipes![index];
                return RecipeCard(
                  title: recipe.name,
                  cookTime: recipe.totalTime,
                  rating: recipe.rating.toString(),
                  thumbnailUrl: recipe.imageUrl,
                );
              },
            ),*/body: _isLoading
    ? ListView.builder(
        itemCount: 5, // عدد العناصر لتأثير shimmer (أي عدد تجريبي)
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          );
        },
      )
    : ListView.builder(
        itemCount: _recipes?.length ?? 0,
        itemBuilder: (context, index) {
          final recipe = _recipes![index];
          return RecipeCard(
            title: recipe.name,
            cookTime: recipe.totalTime,
            rating: recipe.rating.toString(),
            thumbnailUrl: recipe.imageUrl,
          );
        },
      ),
    );
  }
}
