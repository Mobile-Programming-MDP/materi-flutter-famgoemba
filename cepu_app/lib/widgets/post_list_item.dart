import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onDelete; // Tambahkan ini

  const PostListItem({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onDelete, // Tambahkan ini
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
        // Tambahkan tombol hapus di sebelah kanan
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}