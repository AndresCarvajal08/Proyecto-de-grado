import 'package:flutter/material.dart';

class AdminMapView extends StatefulWidget {
  const AdminMapView({super.key});

  @override
  State<AdminMapView> createState() => _AdminMapViewState();
}

class _AdminMapViewState extends State<AdminMapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos un Stack para poner elementos sobre el mapa
      body: Stack(
        children: [
          // 1. EL MAPA (Simulación visual de Google Maps con estilo Dark)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF242f3e), // Color de fondo típico de mapas nocturnos
            child: CustomPaint(
              painter: MapGridPainter(), // Dibujamos unas líneas para que parezca un mapa
              child: Center(
                child: Opacity(
                  opacity: 0.3,
                  child: Icon(Icons.map_rounded, size: 150, color: Colors.white),
                ),
              ),
            ),
          ),

          // 2. BUSCADOR SUPERIOR
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Buscar placa o empresa (Ej: VCN-456)",
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Color(0xFF01579B)),
                  ),
                ),
              ),
            ),
          ),

          // 3. MARCADORES DE GUALAS/BUSES EN TIEMPO REAL
          _buildMarker(top: 250, left: 100, label: "Guala - Siloé", status: "En Movimiento"),
          _buildMarker(top: 380, left: 220, label: "MIO - Centro", status: "Detenido"),
          _buildMarker(top: 180, left: 280, label: "Bus - Norte", status: "En Movimiento"),

          // 4. PANEL INFERIOR DE DETALLES
          Positioned(
            bottom: 30,
            left: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 20)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Vehículo Seleccionado", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text("Placa: VCN-456", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.gps_fixed, color: Colors.green),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(backgroundColor: Color(0xFF01579B), child: Icon(Icons.person, color: Colors.white)),
                    title: const Text("Conductor: Carlos Arturo"),
                    subtitle: const Text("Ruta: Terrón Colorado - Centro"),
                    trailing: const Text("45 km/h", style: TextStyle(color: Color(0xFF01579B), fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.phone),
                          label: const Text("Llamar"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.warning_amber_rounded),
                          label: const Text("Alerta"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          
          // BOTÓN PARA CERRAR O VOLVER
          Positioned(
            top: 15,
            left: 15,
            child: SafeArea(
              child: CircleAvatar(
                backgroundColor: const Color(0xFF01579B),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget para crear marcadores personalizados en el mapa
  Widget _buildMarker({required double top, required double left, required String label, required String status}) {
    return Positioned(
      top: top,
      left: left,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
            ),
            child: Column(
              children: [
                Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Text(status, style: TextStyle(fontSize: 8, color: status == "Detenido" ? Colors.red : Colors.green)),
              ],
            ),
          ),
          const Icon(Icons.location_on, color: Colors.orange, size: 35),
        ],
      ),
    );
  }
}

// Pintor simple para simular calles en el mapa
class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 2;

    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}