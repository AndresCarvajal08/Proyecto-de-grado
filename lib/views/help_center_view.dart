import 'package:flutter/material.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Centro de Ayuda", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF01579B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView( // Para que no haya problemas con pantallas pequeñas
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "¿Cómo podemos ayudarte?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Sección de Contacto Rápido
            Row(
              children: [
                _buildContactCard(
                  context,
                  "WhatsApp",
                  Icons.chat_bubble_outline,
                  Colors.green,
                  "Escríbenos"
                ),
                const SizedBox(width: 15),
                _buildContactCard(
                  context,
                  "Llamar",
                  Icons.phone_in_talk_outlined,
                  Colors.blue,
                  "Habla con nosotros"
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            const Text(
              "Preguntas Frecuentes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            _buildFAQTile("¿Cuál es el horario de las gualas?", "La mayoría operan de 5:00 AM a 10:30 PM, pero depende de la cooperativa."),
            _buildFAQTile("¿Cómo reporto un objeto perdido?", "Puedes usar el botón de WhatsApp arriba para contactar directamente al despacho de la zona."),
            _buildFAQTile("¿La app tiene costo?", "No, el uso de la app es totalmente gratuito para los pasajeros."),
            _buildFAQTile("¿Qué hago si el conductor no sigue la ruta?", "Por favor reporta el número interno del vehículo en nuestra sección de contacto."),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, String title, IconData icon, Color color, String sub) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
            Text(sub, style: TextStyle(fontSize: 11, color: color.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQTile(String question, String answer) {
    return ExpansionTile(
      title: Text(question, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(answer, style: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}