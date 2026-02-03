import 'package:flutter/material.dart';

class CompaniesView extends StatelessWidget {
  const CompaniesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Empresas Afiliadas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF01579B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const Text(
            "Cooperativas de Transporte de Ladera",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 15),
          _buildCompanyCard(
            "Cootransol", 
            "Siloé - La Nave - Belisario", 
            "45 Vehículos", 
            Colors.orange,
            "https://cdn-icons-png.flaticon.com/512/2855/2855620.png"
          ),
          _buildCompanyCard(
            "Cootransmayo", 
            "Terrón Colorado - Vista Hermosa", 
            "30 Vehículos", 
            Colors.blue,
            "https://cdn-icons-png.flaticon.com/512/2855/2855620.png"
          ),
          _buildCompanyCard(
            "Recreativos S.A.", 
            "Rutas Urbanas y Alimentadoras", 
            "12 Vehículos", 
            Colors.green,
            "https://cdn-icons-png.flaticon.com/512/2855/2855620.png"
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyCard(String name, String routes, String fleet, Color color, String logoUrl) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.1),
              backgroundImage: NetworkImage(logoUrl),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(routes, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.directions_bus_filled, size: 14, color: color),
                      const SizedBox(width: 5),
                      Text(fleet, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.phone_in_talk_rounded, color: Colors.green),
              onPressed: () {
                // Aquí podrías usar url_launcher para llamar a la empresa
              },
            ),
          ],
        ),
      ),
    );
  }
}