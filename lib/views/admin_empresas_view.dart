import 'package:flutter/material.dart';

class AdminEmpresasView extends StatelessWidget {
  const AdminEmpresasView({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo (Simulando lo que vendría de una base de datos)
    final List<Map<String, dynamic>> empresas = [
      {"nombre": "Cootransol", "ruta": "Siloé - Calle 5ta", "vehiculos": 12, "color": Colors.blue},
      {"nombre": "La Ermita", "ruta": "Terrón Colorado - Centro", "vehiculos": 8, "color": Colors.green},
      {"nombre": "Alameda", "ruta": "Oeste - Av. Sexta", "vehiculos": 15, "color": Colors.orange},
      {"nombre": "Recreativos", "ruta": "Pance - Universidades", "vehiculos": 10, "color": Colors.red},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cooperativas de Cali"),
        backgroundColor: const Color(0xFF01579B),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_business),
            onPressed: () {
              // Aquí iría la lógica para agregar una nueva empresa
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Buscador superior para filtrar empresas
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar cooperativa...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          
          // Listado de empresas
          Expanded(
            child: ListView.builder(
              itemCount: empresas.length,
              itemBuilder: (context, index) {
                final empresa = empresas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: CircleAvatar(
                      backgroundColor: empresa['color'].withOpacity(0.1),
                      radius: 30,
                      child: Icon(Icons.business, color: empresa['color'], size: 30),
                    ),
                    title: Text(
                      empresa['nombre'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text("Ruta principal: ${empresa['ruta']}"),
                        Text("Vehículos activos: ${empresa['vehiculos']}", 
                             style: const TextStyle(color: Color(0xFF01579B), fontWeight: FontWeight.bold)),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Acción al tocar la empresa (ver detalles)
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}