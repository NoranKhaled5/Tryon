import 'package:flutter/material.dart';
import 'package:untitled15/category/watch.dart';
import 'category/accessories.dart';
import 'category/bag.dart';
import 'category/clothespage.dart';
import 'category/shoes.dart';
import 'category/glasses.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"name": "Shoes", "image": "assets/shoes/sho1.jpg"},
    {"name": "Watch", "image": "assets/watch/wha1.jpg"},
    {"name": "Bags", "image": "assets/bags/bagone.jpg"},
    {"name": "Glasses", "image": "assets/glasses/gl1.jpg"},
    {"name": "Accessories", "image": "assets/accessories/acone.jpg"},
    {"name": "Clothes", "image": "assets/clothes/cloone.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF4B2A5F),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(12),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Widget screen;

              switch (category["name"]) {
                case "Shoes":
                  screen = ShoesScreen();
                  break;
                case "Watch":
                  screen = WatchScreen();
                  break;
                case "Bags":
                  screen = BagsScreen();
                  break;
                case "Glasses":
                  screen = GlassesScreen();
                  break;
                case "Accessories":
                  screen = AccessoriesScreen();
                  break;
                case "Clothes":
                  screen = ClothesScreen();
                  break;
                default:
                  screen = Scaffold(
                    appBar: AppBar(title: const Text("Unknown")),
                    body: const Center(child: Text("No screen available")),
                  );
              }

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screen),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(category["image"]!),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                child: Text(
                  category["name"]!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
