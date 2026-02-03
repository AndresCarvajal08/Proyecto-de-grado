import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de Ruta Cali", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF01579B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            // Logo o Icono de la App
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF01579B).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.directions_bus_filled, size: 80, color: Color(0xFF01579B)),
            ),
            const SizedBox(height: 20),
            const Text(
              "Ruta Cali",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF01579B)),
            ),
            const Text("Versión 1.0.0", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            
            const Text(
              "Nuestra Misión",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Ruta Cali nace como una iniciativa tecnológica para conectar a los habitantes de las laderas de Cali (Siloé, Terrón Colorado, Aguacatal) con el servicio tradicional de Gualas. Buscamos mejorar la movilidad, la seguridad y la confianza en nuestro transporte local.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
            
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            
            _buildAboutDetail("Desarrollado con ❤️ en Cali"),
            _buildAboutDetail("Apoyo a las Cooperativas de Ladera"),
            _buildAboutDetail("Términos y Condiciones"),
            _buildAboutDetail("Política de Privacidad"),
            
            const SizedBox(height: 50),
            const Text(
              "© 2026 Ruta Cali App",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutDetail(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF01579B), fontWeight: FontWeight.w500),
      ),
    );
  }
}