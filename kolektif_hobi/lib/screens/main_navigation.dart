import 'package:flutter/material.dart';
import 'package:kolektif_hobi/screens/home_screen.dart';
import 'package:kolektif_hobi/screens/add_item_screen.dart'; // Import tujuan navigasi
// import 'package:kolektif_hobi/screens/wishlist_screen.dart'; // Uncomment jika sudah ada file wishlist

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Daftar halaman
  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text("Halaman Wishlist")), // Placeholder jika WishlistScreen belum dibuat
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      
      // Tombol Tambah (Floating Action Button)
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        onPressed: () {
          // --- INI ADALAH TAUTAN NAVIGASI YANG BENAR ---
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),

      // Letakkan tombol di tengah bawah jika ingin tampilan modern
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            label: 'Koleksi',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }
}