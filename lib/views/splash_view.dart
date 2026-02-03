import 'package:flutter/material.dart';
import 'login_view.dart'; // Asegúrate de que la ruta sea correcta

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Esperamos 3 segundos y navegamos al Login
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF03A9F4), Color(0xFF01579B)], // Mismos colores que tu Login
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tu logo con la forma orgánica que nos gustó
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(80),
                ),
              ),
              child: Image.asset(
                'assets/logo.png',
                height: 150, // Un poco más grande para el splash
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              "Cargando Rutas...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}