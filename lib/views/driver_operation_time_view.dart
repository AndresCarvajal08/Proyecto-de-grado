import 'package:flutter/material.dart';

class OperationTimesView extends StatelessWidget {
  const OperationTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF01579B);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tiempos de Operación", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. RESUMEN DE LA JORNADA DE HOY
            _buildSectionTitle("Jornada de Hoy (4 Feb)"),
            const SizedBox(height: 15),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: 0.65, // Simulación de 6.5 horas de 10 posibles
                      strokeWidth: 12,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                  Column(
                    children: [
                      const Text("6h 30m", 
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      Text("En servicio", style: TextStyle(color: Colors.grey.shade600)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 2. DESGLOSE DIARIO
            Row(
              children: [
                _buildStatCard("Inicio", "05:30 AM", Icons.play_arrow_rounded, Colors.green),
                const SizedBox(width: 15),
                _buildStatCard("Último Fin", "12:00 PM", Icons.stop_rounded, Colors.red),
              ],
            ),
            
            const SizedBox(height: 35),

            // 3. RESUMEN MENSUAL (ACUMULADO)
            _buildSectionTitle("Resumen Mensual (Febrero)"),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildMonthlyRow("Total Horas", "154 Horas", Icons.timer_outlined),
                    const Divider(),
                    _buildMonthlyRow("Días Laborados", "22 Días", Icons.calendar_today_outlined),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Botón de Reportar Novedad en Tiempo
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.info_outline, size: 18),
                label: const Text("¿Cómo se calculan estos tiempos?"),
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1),
    );
  }

  Widget _buildStatCard(String title, String time, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            Text(time, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF01579B)),
              const SizedBox(width: 10),
              Text(label, style: const TextStyle(fontSize: 15)),
            ],
          ),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}