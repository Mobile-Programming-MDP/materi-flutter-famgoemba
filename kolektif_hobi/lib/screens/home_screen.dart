import 'package:flutter/material.dart';
import 'package:kolektif_hobi/services/database_service.dart';
import 'package:kolektif_hobi/models/item_model.dart';
import 'package:kolektif_hobi/widgets/item_card.dart';
import 'package:kolektif_hobi/services/auth_service.dart';
import 'package:kolektif_hobi/screens/add_item_screen.dart'; // 1. Pastikan import ini ada

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("Kolektif Hobi", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
            },
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
          ),
        ],
      ),
      body: StreamBuilder<List<ItemModel>>(
        stream: DatabaseService().getKoleksi(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Gagal memuat data"));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final data = snapshot.data!;

          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text("Belum ada koleksi. Tekan + untuk menambah."),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) => ItemCard(item: data[index]),
          );
        },
      ),
      
      // 2. Tambahkan Properti FloatingActionButton di bawah sini
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0F172A), // Warna Slate sesuai tema login
        foregroundColor: Colors.white,
        onPressed: () {
          // 3. Tautkan Navigasi ke Halaman AddItemScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}