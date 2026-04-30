import 'package:cepu_app/screens/add_post_screen.dart';
import 'package:cepu_app/screens/sign_in_screen.dart';
import 'package:cepu_app/widgets/post_list_item.dart'; // <--- Pastikan file ini sudah dibuat
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (route) => false,
    );
  }

  String generateAvatarUrl(String? fullName) {
    final formattedName = (fullName ?? 'User').trim().replaceAll(' ', '+');
    return 'https://ui-avatars.com/api/?name=$formattedName&color=FFFFFF&background=000000';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          // Bagian Header (Profil sesuai gambar image_1a796b.png)
          const SizedBox(height: 20),
          Center(
            child: Image.network(
              generateAvatarUrl(FirebaseAuth.instance.currentUser?.displayName),
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            FirebaseAuth.instance.currentUser?.displayName ?? "User",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text("You Have Been Signed In!"),
          const SizedBox(height: 20),
          const Divider(thickness: 1),

          // BAGIAN LIST POSTINGAN
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // GANTI 'posts' sesuai dengan nama collection di Firebase Console kamu
              stream: FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Tidak ada data ditemukan di database."),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // Ambil data tiap dokumen
                    var doc = snapshot.data!.docs[index];
                    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

                    return PostListItem(
                      title: data['title'] ?? 'Tanpa Judul',
                      description: data['description'] ?? 'Tanpa Deskripsi',
                      imageUrl: data['imageUrl'] ?? 'https://via.placeholder.com/150', onDelete: () {  },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddPostScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}