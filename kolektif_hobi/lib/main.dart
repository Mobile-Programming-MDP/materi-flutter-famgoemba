import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // WAJIB
import 'package:google_fonts/google_fonts.dart';
import 'package:kolektif_hobi/screens/sign_in_screen.dart';
import 'firebase_options.dart'; // File ini muncul setelah setup Firebase CLI

void main() async {
  // Pastikan widget binding siap sebelum inisialisasi
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const KolektifHobiApp());
}

class KolektifHobiApp extends StatelessWidget {
  const KolektifHobiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kolektif Hobi',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F172A),
          primary: const Color(0xFF0F172A),
          secondary: const Color(0xFF14B8A6),
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      ),
      home: const SignInScreen(),
    );
  }
}