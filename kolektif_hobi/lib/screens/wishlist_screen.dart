import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/item_model.dart';
import '../widgets/item_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("Wishlist", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder<List<ItemModel>>(
        stream: DatabaseService().getKoleksi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          // Filter hanya item yang isWishlist == true
          final wishlistItems = snapshot.data!.where((item) => item.isWishlist == true).toList();

          if (wishlistItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text("Belum ada barang impian.", style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) => ItemCard(item: wishlistItems[index]),
          );
        },
      ),
    );
  }
}