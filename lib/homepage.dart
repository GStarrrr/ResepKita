import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coba/history_provider.dart';
import 'history.dart';
import 'favorite.dart';
import 'favorite_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = '';

  final Map<String, List<Map<String, String>>> recipesByCategory = {
    'Gorengan': [
      {'name': 'Mie Goreng', 'image': 'assets/miegoreng.jpg'},
      {'name': 'Nasi Goreng', 'image': 'assets/nasigoreng.jpg'},
      {'name': 'Ayam Goreng', 'image': 'assets/ayamgoreng.jpg'},
    ],
    'Kukus': [
      {'name': 'Ikan Kukus', 'image': 'assets/ikankukus.jpg'},
      {'name': 'Dorayaki', 'image': 'assets/dorayaki.jpg'},
      {'name': 'Sushi', 'image': 'assets/sushi.jpg'},
      {'name': 'Rendang', 'image': 'assets/rendang.jpg'},
    ],
    'Tumis': [
      {'name': 'Sayur Tumis Telur Rebus', 'image': 'assets/tumissayur.jpg'},
      {'name': 'Udang Tumis Bawang Putih', 'image': 'assets/ud runangtumis.jpg'},
      {'name': 'Gado Gado', 'image': 'assets/gadogado.jpg'},
    ],
    'Rebus': [
      {'name': 'Bakso', 'image': 'assets/bakso.jpg'},
      {'name': 'Soto Ayam', 'image': 'assets/sotoayam.jpg'},
    ],
    'Panggang': [
      {'name': 'Kue Panggang', 'image': 'assets/kuepanggang.jpg'},
      {'name': 'Burger', 'image': 'assets/burger.jpg'},
      {'name': 'Pizza', 'image': 'assets/pizza.jpg'},
      {'name': 'Kebab', 'image': 'assets/kebab.jpg'},
    ],
  };

  final List<Map<String, String>> recentRecipes = [
    {'name': 'Dorayaki', 'image': 'assets/dorayaki.jpg'},
    {'name': 'Burger', 'image': 'assets/burger.jpg'},
    {'name': 'Kebab', 'image': 'assets/kebab.jpg'},
    {'name': 'Pizza', 'image': 'assets/pizza.jpg'},
    {'name': 'Sushi', 'image': 'assets/sushi.jpg'},
    {'name': 'Nasi Goreng', 'image': 'assets/nasigoreng.jpg'},
    {'name': 'Ayam Goreng', 'image': 'assets/ayamgoreng.jpg'},
    {'name': 'Soto Ayam', 'image': 'assets/sotoayam.jpg'},
    {'name': 'Sayur Tumis', 'image': 'assets/sayurtumis.jpg'},
    {'name': 'Rendang', 'image': 'assets/rendang.jpg'},
    {'name': 'Ikan Kukus', 'image': 'assets/ikankukus.jpg'},
    {'name': 'Kue Panggang', 'image': 'assets/kuepanggang.jpg'},
    {'name': 'Gado Gado', 'image': 'assets/gadogado.jpg'},
    {'name': 'Sushi', 'image': 'assets/sushi.jpg'},
    {'name': 'Mie Goreng', 'image': 'assets/miegoreng.jpg'},
  ];
  
  final List<Map<String, String>> popularRecipes = [
    {'name': 'Ayam Goreng', 'image': 'assets/ayamgoreng.jpg'},
    {'name': 'Ikan Kukus', 'image': 'assets/ikankukus.jpg'},
    {'name': 'Kue Panggang', 'image': 'assets/kuepanggang.jpg'},
    {'name': 'Pizza', 'image': 'assets/pizza.jpg'},
    {'name': 'Sushi', 'image': 'assets/sushi.jpg'},
  ];

  Widget buildRecipeCard(Map<String, String>resep) {
    return Column(
        children: [
          Expanded(
            child: Image.asset(
              resep["image"]!,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            resep["name"]!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const history()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const favorite()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resepkita',
        style: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'Resep Terbaru'),
                RecipeList(
                  recipes: recentRecipes,
                ),
                const SizedBox(height: 20),
                const SectionTitle(title: 'Resep Terpopular'),
                RecipeList(
                  recipes: popularRecipes,
                ),
                const SizedBox(height: 20),
                const SectionTitle(title: 'Kategori Resep'),
                RecipeCategories(
                  categories: const [
                    {'name': 'Gorengan', 'icon': Icons.local_fire_department},
                    {'name': 'Kukus', 'icon': Icons.cloud},
                    {'name': 'Tumis', 'icon': Icons.kitchen},
                    {'name': 'Rebus', 'icon': Icons.water},
                    {'name': 'Panggang', 'icon': Icons.cake},
                  ],
                  onCategorySelected: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (selectedCategory.isNotEmpty) ...[
                  SectionTitle(title: 'Resep $selectedCategory'),
                  RecipeList(
                    recipes: recipesByCategory[selectedCategory] ?? [],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange, 
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Homepage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.orange.shade800,
        ),
      ),
    );
  }
}

class RecipeList extends StatelessWidget {
  final List<Map<String, String>> recipes;

  const RecipeList({
    super.key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        return SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              final isFavorite = favoriteProvider.isFavorite(recipe['name']!);

              return GestureDetector(
                onTap: () {
                  Provider.of<HistoryProvider>(context, listen: false).addToHistory({
                    'name': recipe['name']!,
                  });
                    
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailPage(
                        recipeName: recipe ['name']!,
                        imageAssets:recipe ['image']!,
                        description: recipeDescriptions[recipe['name']] ?? '',
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4,
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      gradient: LinearGradient(
                        colors: [Colors.orange.shade100, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Image container
                        Expanded(
                          flex: 2,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12.0),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(recipe['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    favoriteProvider.toggleFavorite(recipe['name']!);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Text container
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                recipe['name']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange.shade800,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class RecipeCategories extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final ValueChanged<String> onCategorySelected;

  const RecipeCategories({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: categories.map((category) {
        return GestureDetector(
          onTap: () => onCategorySelected(category['name']),
          child: Chip(
            avatar: Icon(category['icon'], color: Colors.white),
            label: Text(
              category['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.orange.shade600,
            elevation: 4,
            shadowColor: Colors.orange.shade200,
          ),
        );
      }).toList(),
    );
  }
}

class RecipeDetailPage extends StatelessWidget {
  final String recipeName;
  final String imageAssets;
  final String description;

  const RecipeDetailPage({
    super.key,
    required this.recipeName,
    required this.imageAssets,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageAssets),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipeName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final Map<String, String> recipeDescriptions = {
  'Mie Goreng':
      '''Mie goreng adalah salah satu makanan yang sangat digemari, terbuat dari mie yang digoreng bersama dengan sayur-sayuran dan bumbu khas.

Bahan-bahan:
- Mie instan
- Sayuran (wortel, kol, daun bawang)
- Telur
- Bawang merah, bawang putih
- Kecap manis
- Garam, merica, dan bumbu penyedap

Cara pembuatan:
1. Rebus mie hingga matang, tiriskan.
2. Tumis bawang merah dan bawang putih hingga harum.
3. Masukkan sayuran dan telur, aduk rata.
4. Tambahkan mie, kecap manis, garam, merica, dan bumbu penyedap, aduk hingga rata.''',
  
  'Nasi Goreng':
      '''Nasi goreng adalah makanan khas Indonesia yang terbuat dari nasi yang digoreng dengan berbagai bahan seperti sayuran, daging, dan telur.

Bahan-bahan:
- Nasi putih
- Telur
- Daging ayam atau udang
- Sayuran (wortel, kacang polong)
- Bawang merah, bawang putih
- Kecap manis, saus tiram
- Garam, merica

Cara pembuatan:
1. Tumis bawang merah dan bawang putih hingga harum.
2. Masukkan daging ayam/udang, masak hingga matang.
3. Tambahkan nasi putih, telur, sayuran, dan bumbu.
4. Aduk rata dan masak hingga semua bahan tercampur rata.''',
  
  'Ikan Kukus':
      '''Ikan kukus adalah hidangan sehat yang menggunakan ikan yang dikukus bersama dengan bumbu rempah, memberikan rasa yang segar dan nikmat.

Bahan-bahan:
- Ikan (ikan kerapu atau ikan lainnya)
- Bawang putih, bawang merah, jahe, kunyit
- Daun salam, daun jeruk
- Garam, merica
- Air lemon atau air jeruk nipis

Cara pembuatan:
1. Bersihkan ikan dan lumuri dengan air jeruk nipis, garam, dan merica.
2. Haluskan bawang putih, bawang merah, jahe, dan kunyit.
3. Lumuri bumbu halus pada ikan, tambahkan daun salam dan daun jeruk.
4. Kukus ikan selama 20-30 menit hingga matang.''',
  
  'Dorayaki':
      '''Dorayaki adalah kue tradisional Jepang yang terdiri dari dua pancake lembut yang diisi dengan pasta kacang merah.

Bahan-bahan:
- 2 butir telur
- 150 gram gula pasir
- 150 gram tepung terigu
- 1 sendok teh baking powder
- 100 gram pasta kacang merah (anko)

Cara pembuatan:
1. Kocok telur dan gula hingga mengembang.
2. Ayak tepung terigu dan baking powder, lalu campurkan ke adonan telur.
3. Masak adonan dalam wajan datar dengan api kecil hingga kedua sisi matang.
4. Setelah pancake matang, oleskan pasta kacang merah di tengahnya, lalu rapatkan.''',
  
  'Sushi':
      '''Sushi adalah makanan khas Jepang yang terdiri dari nasi yang dibumbui dengan cuka dan biasanya disajikan dengan irisan ikan mentah atau makanan laut.

Bahan-bahan:
- Nasi sushi
- Ikan mentah (salmon, tuna)
- Nori (rumput laut)
- Cuka beras, gula, garam
- Sayuran (timun, alpukat)

Cara pembuatan:
1. Masak nasi sushi dan campurkan dengan cuka, gula, dan garam.
2. Letakkan nori di atas tikar bambu, ratakan nasi di atasnya.
3. Tambahkan irisan ikan dan sayuran.
4. Gulung sushi dengan rapat, potong-potong dan sajikan.''',
  
  'Rendang':
      '''Rendang adalah masakan khas Padang yang terbuat dari daging sapi yang dimasak dengan bumbu rempah yang kaya dan dimasak hingga kering.

Bahan-bahan:
- Daging sapi
- Santan kelapa
- Bawang merah, bawang putih, jahe, kunyit
- Cabai, serai, daun jeruk
- Garam, gula

Cara pembuatan:
1. Tumis bawang merah, bawang putih, jahe, kunyit, dan cabai hingga harum.
2. Tambahkan daging sapi, masak hingga daging berubah warna.
3. Masukkan santan, serai, daun jeruk, garam, dan gula.
4. Masak dengan api kecil hingga santan menyusut dan daging empuk.''',
  
  'Sayur Tumis Telur Rebus':
      '''Sayur tumis telur rebus adalah hidangan sehat yang terdiri dari sayuran yang ditumis dan dipadukan dengan telur rebus.

Bahan-bahan:
- Sayuran (bayam, kangkung)
- Telur
- Bawang putih, bawang merah
- Garam, merica, dan bumbu penyedap

Cara pembuatan:
1. Rebus telur hingga matang, lalu kupas dan potong-potong.
2. Tumis bawang putih dan bawang merah hingga harum.
3. Masukkan sayuran, tumis hingga layu.
4. Tambahkan telur rebus, garam, merica, dan bumbu penyedap.''',
  
  'Udang Tumis Bawang Putih':
      '''Udang tumis bawang putih adalah hidangan cepat saji dengan udang yang ditumis dengan bawang putih dan bumbu lainnya.

Bahan-bahan:
- Udang
- Bawang putih, bawang merah
- Kecap manis
- Garam, merica

Cara pembuatan:
1. Tumis bawang putih dan bawang merah hingga harum.
2. Masukkan udang, masak hingga udang berubah warna.
3. Tambahkan kecap manis, garam, dan merica.
4. Aduk rata dan masak hingga udang matang.''',
  
  'Gado Gado':
      '''Gado Gado adalah salad sayuran khas Indonesia yang dilengkapi dengan saus kacang yang gurih.

Bahan-bahan:
- Sayuran (kentang, tauge, kol)
- Telur rebus
- Tahu tempe goreng
- Saus kacang (kacang tanah, cabai, gula merah, air asam jawa)

Cara pembuatan:
1. Rebus sayuran, kentang, dan telur hingga matang.
2. Goreng tahu dan tempe.
3. Haluskan kacang tanah, cabai, gula merah, dan air asam jawa untuk membuat saus kacang.
4. Sajikan sayuran, tahu tempe, dan saus kacang.''',
  
  'Bakso':
      '''Bakso adalah bola daging yang dimasak dalam kuah kaldu, salah satu makanan favorit di Indonesia.

Bahan-bahan:
- Daging sapi giling
- Tepung sagu
- Bawang putih, bawang merah
- Kaldu sapi
- Garam, merica

Cara pembuatan:
1. Campurkan daging sapi, tepung sagu, dan bumbu, bentuk adonan menjadi bola-bola kecil.
2. Rebus bola bakso dalam air mendidih hingga mengapung.
3. Sajikan bakso dengan kuah kaldu sapi dan pelengkap seperti mie dan sayuran.''',
  
  'Kue Panggang':
      '''Kue panggang adalah kue yang dibuat dengan memanggang adonan tepung yang biasanya mengandung bahan seperti coklat atau kacang.

Bahan-bahan:
- Tepung terigu
- Mentega
- Gula pasir
- Telur
- Coklat atau kacang

Cara pembuatan:
1. Campurkan tepung terigu, mentega, gula, dan telur hingga rata.
2. Tambahkan coklat atau kacang sesuai selera.
3. Panggang adonan dalam oven hingga matang.''',

  'Burger':
      '''Burger adalah roti isi yang biasanya diisi dengan patty daging, sayuran, dan saus yang lezat.

Bahan-bahan:
- Roti burger
- Daging patty
- Sayuran (selada, tomat, bawang bombay)
- Keju, saus tomat, mayones

Cara pembuatan:
1. Panggang roti burger dan daging patty.
2. Letakkan patty daging di atas roti, tambahkan sayuran, keju, dan saus.
3. Tutup dengan roti burger lainnya dan sajikan.''',

  'Pizza':
      '''Pizza adalah hidangan Italia yang terdiri dari adonan roti yang diberi topping berupa saus tomat, keju, dan berbagai bahan lainnya.

Bahan-bahan:
- Adonan pizza
- Saus tomat
- Keju mozzarella
- Topping (sosis, jamur, paprika, dll.)

Cara pembuatan:
1. Ratakan adonan pizza, olesi dengan saus tomat.
2. Taburi dengan keju mozzarella dan topping sesuai selera.
3. Panggang pizza dalam oven hingga matang.''',

  'Kebab':
      '''Kebab adalah hidangan daging panggang khas Timur Tengah yang disajikan dengan roti pita atau nasi.

Bahan-bahan:
- Daging domba atau ayam
- Bumbu kebab (bawang putih, jahe, ketumbar)
- Roti pita atau nasi
- Sayuran (timun, tomat, selada)

Cara pembuatan:
1. Marinasi daging dengan bumbu kebab.
2. Panggang daging hingga matang.
3. Sajikan dengan roti pita atau nasi, dan tambahkan sayuran segar.''',

  'Soto Ayam':
      '''Soto Ayam adalah sup ayam khas Indonesia yang terbuat dari kaldu ayam yang kaya rasa, dilengkapi dengan sayuran, telur, dan bumbu rempah yang harum.

Bahan-bahan:
- Daging ayam
- Daun salam, serai, daun jeruk
- Bawang putih, bawang merah, jahe
- Telur rebus
- Bumbu soto (kecap manis, garam, merica)

Cara pembuatan:
1. Rebus ayam dengan daun salam, serai, dan daun jeruk hingga empuk.
2. Tumis bawang putih, bawang merah, dan jahe hingga harum.
3. Masukkan bumbu tumis ke dalam kaldu ayam, masak hingga mendidih.
4. Sajikan dengan telur rebus, nasi, dan taburan daun seledri.''',

'Ayam Goreng':
      '''Ayam Goreng adalah salah satu hidangan khas yang sangat populer, dengan rasa gurih dan renyah yang menggugah selera.
      
Bahan-bahan:
- Ayam (potong sesuai selera)
- Bawang putih (haluskan)
- Ketumbar (haluskan)
- Kunyit (haluskan)
- Garam dan merica
- Daun salam
- Air Jeruk nipis
- Minyak

Cara pembuatan:
1. Lumuri potongan ayam dengan air jeruk nipis, diamkan selama 10 menit, lalu bilas.
2. Haluskan bawang putih, ketumbar, kunyit, garam, dan merica.
3. Campurkan bumbu halus dengan ayam, tambahkan daun salam, lalu diamkan selama 30 menit agar bumbu meresap.
4. Rebus ayam bersama bumbu hingga empuk, tiriskan.
5. Panaskan minyak, goreng ayam hingga cokelat ke emasan dan renyah.
6. Angkat dan sajikan ayamg goreng hangat dengan sambal dan lalapan''',

'Sayur Tumis':
      '''Sayur tumis adalah hidangan sederhana yang sehat dan lezat, terbuat dari sayur-sayuran segar yang ditumis dengan bumbu sederhana.
      
Bahan-bahan:
- Wortel (iris tipis)
- Buncis (potong serong)
- Kol (iris kasar)
- Daun bawang (iris)
- Bawang putih (cincang)
- Bawang merah (iris tipis)
- Cabai merah (iris serong)
- Garam, gula, dan merica
- Minyak untuk menumis
- Air secukupnya

Cara pembuatan:
1. Panaskan sedikit minyak di wajan. Tumis bawang merah, bawang putih, dan cabai hingga harum.
2. Masukkan wortel dan buncis, tumis sebentar.
3. Tambahkan sedikit air, garam, gula, dan merica. Masak hingga sayuran setengah matang.
4. Masukkan kol dan daun bawang, aduk hingga semua bahan tercampur rata dan sayuran matang tetapi tetap renyah.
5. Angkat dan sajikan sayur tumis hangat sebagai pelengkap hidangan utama.''',
};
