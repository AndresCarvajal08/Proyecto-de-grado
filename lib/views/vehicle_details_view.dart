import 'package:flutter/material.dart';

class VehicleDetailsView extends StatelessWidget {
  const VehicleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF01579B);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Datos del Vehículo", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Cabecera con Imagen/Icono del Vehículo
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.directions_bus_filled_rounded, 
                      size: 80, color: primaryColor),
                  ),
                  const SizedBox(height: 10),
                  const Text("Jeep Willys (Guala)", 
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const Text("Número Interno: 042", 
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 2. Sección: Información Legal
            _buildSectionHeader("Información Legal"),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  _buildDataTile(Icons.pin_outlined, "Placa", "VCI-123"),
                  const Divider(height: 1),
                  _buildDataTile(Icons.verified_user_outlined, "Seguro SOAT", "Vigente hasta: 15/12/2026"),
                  const Divider(height: 1),
                  _buildDataTile(Icons.article_outlined, "Tarjeta de Operación", "Nro: 99887766"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. Sección: Características
            _buildSectionHeader("Detalles de la Unidad"),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  _buildDataTile(Icons.event_seat_outlined, "Capacidad", "12 Pasajeros"),
                  const Divider(height: 1),
                  _buildDataTile(Icons.color_lens_outlined, "Color", "Azul / Blanco"),
                  const Divider(height: 1),
                  _buildDataTile(Icons.route_outlined, "Ruta Asignada", "Siloé - La Nave - Centro"),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Botón de Reportar Problema Técnico
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.build_circle_outlined),
                label: const Text("REPORTAR FALLO MECÁNICO"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange[800],
                  side: BorderSide(color: Colors.orange[800]!),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(title, style: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildDataTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF01579B)),
      title: Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
    );
  }
}