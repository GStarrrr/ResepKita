import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Admin',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class Dashboard2 extends StatefulWidget {
  const Dashboard2({super.key});

  @override
  _Dashboard2State createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  int _selectedIndex = 0;

  // Data dummy untuk daftar resep
  final List<Map<String, String>> _recipes = [
    {'name': 'Resep 1', 'description': 'Deskripsi singkat resep 1'},
    {'name': 'Resep 2', 'description': 'Deskripsi singkat resep 2'},
  ];

  // Halaman utama Dashboard
  Widget _buildDashboard() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.dashboard, size: 80, color: Colors.orange),
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
    );
  }

  // Halaman Register Admin
  Widget _buildRegisterAdminPage() {
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Register Admin',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nama Admin'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || !value.contains('@')) {
                  return 'Email tidak valid';
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'Password minimal 6 karakter';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Admin berhasil didaftarkan')),
                  );
                }
              },
              child: const Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }

  // Halaman Atur Resep (CRUD)
  Widget _buildManageRecipesPage() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRecipeDialog,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          final recipe = _recipes[index];
          return Slidable(
            key: ValueKey(index),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    _editRecipe(index);
                  },
                  icon: Icons.edit,
                  label: 'Edit',
                  backgroundColor: Colors.blue,
                ),
                SlidableAction(
                  onPressed: (context) {
                    _deleteRecipe(index);
                  },
                  icon: Icons.delete,
                  label: 'Hapus',
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            child: ListTile(
              leading: const Icon(Icons.food_bank, color: Colors.orange),
              title: Text(recipe['name']!),
              subtitle: Text(recipe['description']!),
            ),
          );
        },
      ),
    );
  }

  // Dialog Tambah Resep
  void _showAddRecipeDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Resep'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama Resep'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty) {
                setState(() {
                  _recipes.add({
                    'name': nameController.text,
                    'description': descriptionController.text,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Resep berhasil ditambahkan')),
                );
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  // Fungsi Edit Resep
  void _editRecipe(int index) {
    // Tambahkan logika edit di sini
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit resep ${_recipes[index]['name']}')),
    );
  }

  // Fungsi Hapus Resep
  void _deleteRecipe(int index) {
    setState(() {
      _recipes.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resep berhasil dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(['Dashboard Admin', 'Register Admin', 'Atur Resep'][_selectedIndex]),
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.orange),
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
              leading: const Icon(Icons.dashboard, color: Colors.orange),
              title: const Text('Dashboard'),
              onTap: () {
                setState(() => _selectedIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add, color: Colors.orange),
              title: const Text('Register Admin'),
              onTap: () {
                setState(() => _selectedIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu, color: Colors.orange),
              title: const Text('Atur Resep'),
              onTap: () {
                setState(() => _selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                // Tambahkan aksi logout
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildDashboard(),
          _buildRegisterAdminPage(),
          _buildManageRecipesPage(),
        ],
      ),
    );
  }
}
