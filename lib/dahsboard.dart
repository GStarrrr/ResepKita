import 'package:flutter/material.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'dashboard',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // Indeks halaman yang sedang aktif
  int _selectedIndex = 0;

  // Daftar halaman yang dapat diakses
  final List<Widget> _pages = [
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.dashboard, size: 80, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Selamat Datang di Dashboard Admin!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Gunakan menu di samping untuk mengelola aplikasi.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    ),
    Center(
      child: Text(
        'Halaman Register Admin',
        style: TextStyle(fontSize: 18),
      ),
    ),
    Center(
      child: Text(
        'Halaman Atur Resep',
        style: TextStyle(fontSize: 18),
      ),
    ),
  ];

  // Mengubah halaman aktif berdasarkan indeks
  void _onMenuTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Menutup drawer setelah memilih menu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Admin'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.green),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ResepKita Admin',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'admin@resepkita.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.green),
              title: Text('Dashboard'),
              onTap: () => _onMenuTap(0),
            ),
            ListTile(
              leading: Icon(Icons.person_add, color: Colors.green),
              title: Text('Register Admin'),
              onTap: () => _onMenuTap(1),
            ),
            ListTile(
              leading: Icon(Icons.restaurant_menu, color: Colors.green),
              title: Text('Atur Resep'),
              onTap: () => _onMenuTap(2),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout'),
              onTap: () {
                // Aksi logout
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
