import 'package:flutter/material.dart';


class RecipePreviewPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipePreviewPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          recipe['image'] != null
              ? Stack(
                  children: [
                    Image.file(
                      recipe['image'],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.black.withOpacity(0.5),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.picture_as_pdf,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : const SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Icon(
                    Icons.food_bank,
                    size: 100,
                    color: Colors.orange,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Deskripsi:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(recipe['description']),
                const SizedBox(height: 20),
                if (recipe['pdf'] != null)
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logika untuk membuka PDF
                    },
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Lihat PDF'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
