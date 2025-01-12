import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coba/favorite.dart';
import 'package:coba/history.dart';
import 'package:coba/favorite_provider.dart';
import 'history_provider.dart';
import 'dashboard.dart';
import 'signup.dart';
import 'wellcome.dart';
import 'signin.dart';
import 'homepage.dart';

void main() {
  final recipesByCategory = {
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

  final recentRecipes = [
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

  final recipeDescriptions = {
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

  runApp(MyApp(
    recipesByCategory: recipesByCategory,
    recentRecipes: recentRecipes,
    recipeDescriptions: recipeDescriptions,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, List<Map<String, String>>> recipesByCategory;
  final List<Map<String, String>> recentRecipes;
  final Map<String, String> recipeDescriptions;

  const MyApp({
    super.key,
    required this.recipesByCategory,
    required this.recentRecipes,
    required this.recipeDescriptions,
    });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(
          create: (context) => HistoryProvider(
          recipesByCategory: recipesByCategory,
          recentRecipes: recentRecipes,
          recipeDescriptions: recipeDescriptions,
        )
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App',
        initialRoute: '/', 
        routes: {
          '/': (context) => const Welcome(),
          '/login': (context) => const Signin(),
          '/signup': (context) => const Signup(),
          '/homepage': (context) => const HomePage(),
          '/favorite': (context) => const favorite(),
          '/history': (context) => const history(),
          '/Admin': (context) => const Dashboard2(),
        },
      ),
    );
  }
} 