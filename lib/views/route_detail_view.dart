import 'package:flutter/material.dart';

class RouteDetailView extends StatelessWidget {
  final String nombreRuta;
  final String frecuencia;
  final Color color;

  const RouteDetailView({
    super.key, 
    required this.nombreRuta, 
    required this.frecuencia, 
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nombreRuta, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: color,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Simulación de Mapa o Imagen del Sector
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey[300],
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.map_sharp, size: 100, color: Colors.grey),
                  Positioned(
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                      ),
                      child: const Text("Trazado de la ruta en Cali", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(nombreRuta, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      Chip(
                        label: const Text("ACTIVA", style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("Esta ruta conecta el centro con las zonas altas del sector.", style: TextStyle(color: Colors.grey)),
                  const Divider(height: 40),
                  
                  // Información en cuadritos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _infoItem(Icons.timer, "Frecuencia", frecuencia),
                      _infoItem(Icons.payments, "Tarifa", "\$2.700"),
                      _infoItem(Icons.star, "Rating", "4.8"),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  const Text("Puntos de Interés", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _puntoInteres("Estación MIO Unidad Deportiva"),
                  _puntoInteres("Sector La Nave"),
                  _puntoInteres("Mirador de la loma"),
                  
                  const SizedBox(height: 30),
                  
                  // Botón de acción principal
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.gps_fixed, color: Colors.white),
                      label: const Text("SEGUIR ESTA GUALA EN VIVO", style: TextStyle(color: Colors.white, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _puntoInteres(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
          const SizedBox(width: 10),
          Text(texto),
        ],
      ),
    );
  }
}