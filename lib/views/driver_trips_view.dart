import 'package:flutter/material.dart';

class DriverTripsView extends StatelessWidget {
  const DriverTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF01579B);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Recorridos de Hoy", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // RESUMEN SUPERIOR DE PRODUCTIVIDAD
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.05),
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(Icons.route, "12", "Vueltas"),
                _buildStat(Icons.people, "145", "Pasajeros"),
                _buildStat(Icons.timer, "7.5h", "Operación"),
              ],
            ),
          ),
          
          // LISTADO DE RECORRIDOS (HISTORIAL)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                _buildTripItem(
                  context,
                  hour: "12:30 PM",
                  route: "Siloé ➔ Estación Tequendama",
                  passengers: 15,
                  isLast: false,
                ),
                _buildTripItem(
                  context,
                  hour: "11:15 AM",
                  route: "Estación Tequendama ➔ Siloé",
                  passengers: 8,
                  isLast: false,
                ),
                _buildTripItem(
                  context,
                  hour: "10:00 AM",
                  route: "Siloé ➔ Centro (Cll 5ta)",
                  passengers: 18,
                  isLast: false,
                ),
                _buildTripItem(
                  context,
                  hour: "08:45 AM",
                  route: "Centro (Cll 5ta) ➔ Siloé",
                  passengers: 12,
                  isLast: true, // El primero del día
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF01579B), size: 28),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildTripItem(BuildContext context, {
    required String hour, 
    required String route, 
    required int passengers,
    required bool isLast
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // LÍNEA DE TIEMPO (TIMELINE)
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(color: Color(0xFF01579B), shape: BoxShape.circle),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: Colors.grey.shade300),
                ),
            ],
          ),
          const SizedBox(width: 20),
          
          // TARJETA DE INFORMACIÓN
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hour, style: const TextStyle(color: Color(0xFF01579B), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(route, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person_pin_circle_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text("$passengers pasajeros registrados", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}