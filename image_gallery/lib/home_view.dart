import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // List of image paths (local assets)
  final List<String> images = const [
    "assets/random1.jpg",
    "assets/random2.jpg",
    "assets/random3.jpg",
    "assets/random4.jpg",
    "assets/random5.jpg",
    "assets/random6.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Gallery")),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // two images per row
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    imagePath: images[index],
                    tag: index.toString(),
                  ),
                ),
              );
            },
            child: Hero(
              tag: index.toString(),
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String imagePath;
  final String tag;

  const DetailPage({super.key, required this.imagePath, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Image Detail"),
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}