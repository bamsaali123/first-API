import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_3/models/recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {
      "limit": "24",
      "start": "0"
    });

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "c4ba94aca9msh5f5f5b0df62a078p154f45jsndf3c4b93e3ba",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> recipesData = data['feed'] ?? [];

      List<Recipe> recipes = Recipe.recipesFromSnapshot(recipesData);
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
