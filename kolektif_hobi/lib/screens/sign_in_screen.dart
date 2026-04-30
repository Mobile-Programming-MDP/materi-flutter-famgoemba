import 'package:flutter/material.dart';
import 'package:kolektif_hobi/screens/sign_up_screen.dart'; // Pastikan import ini benar
import 'package:kolektif_hobi/screens/home_screen.dart';    // Pastikan import ini benar
import 'package:kolektif_hobi/services/auth_service.dart';  // Import logic auth

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // 1. Tambahkan Controller untuk mengambil teks dari input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // 2. Fungsi Login
  void _handleSignIn() async {
    setState(() => _isLoading = true);
    
    // Memanggil AuthService yang sudah kita buat sebelumnya
    final result = await AuthService().signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (result != null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal Masuk. Periksa Email/Password.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan SingleChildScrollView agar tidak error saat keyboard muncul
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selamat Datang di\nKolektif Hobi",
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold, 
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Kelola koleksi kesayanganmu dalam satu genggaman.",
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
              const SizedBox(height: 40),
              
              // Email Input
              TextField(
                controller: _emailController, // Tambahkan ini
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              
              // Password Input
              TextField(
                controller: _passwordController, // Tambahkan ini
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 24),
              
              // Tombol Masuk
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isLoading ? null : _handleSignIn, // Tambahkan logic login
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Masuk", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              
              // Navigasi ke Daftar Akun
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigasi ke Sign Up Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: const Text("Belum punya akun? Daftar sekarang"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}