import 'package:flutter/material.dart';
import 'views/login_view.dart'; // Importamos tu nueva vista

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transporte Cali',
      debugShowCheckedModeBanner: false,
      home: const LoginView(), // Pantalla inicial
    );
  }
}