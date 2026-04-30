import 'package:flutter/material.dart';
import 'package:kolektif_hobi/models/item_model.dart';
import 'package:kolektif_hobi/services/database_service.dart';
import 'package:kolektif_hobi/widgets/custom_button.dart'; // Import custom button

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _imageController = TextEditingController();
  bool _isLoading = false;

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Pastikan menggunakan ItemModel (bukan Item)
      final newItem = ItemModel(
        name: _nameController.text.trim(),
        description: _descController.text.trim(),
        imageUrl: _imageController.text.trim(),
      );

      try {
        await DatabaseService().addItem(newItem);
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Berhasil menambahkan koleksi!")),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e")),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Item")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nama Item", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: "Deskripsi", border: OutlineInputBorder()),
                maxLines: 3,
                validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: "URL Gambar", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 32),
              
              // Menggunakan CustomButton yang baru dibuat
              CustomButton(
                text: "Simpan ke Koleksi",
                isLoading: _isLoading,
                onPressed: _submitData,
                color: const Color(0xFF14B8A6), // Warna Teal agar kontras
              ),
            ],
          ),
        ),
      ),
    );
  }
}