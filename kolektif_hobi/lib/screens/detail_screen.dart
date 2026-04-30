import 'package:flutter/material.dart';
import '../models/item_model.dart';

class DetailScreen extends StatelessWidget {
  final ItemModel item;
  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(item.imageUrl, width: double.infinity, height: 300, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(20) ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Icon(item.isWishlist ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(item.description, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}