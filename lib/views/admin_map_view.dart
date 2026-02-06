import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; 
import 'package:latlong2/latlong.dart';      
import 'package:provider/provider.dart';
import '../viewmodels/map_viewmodel.dart';

class AdminMapView extends StatefulWidget {
  const AdminMapView({super.key});

  @override
  State<AdminMapView> createState() => _AdminMapViewState();
}

class _AdminMapViewState extends State<AdminMapView> {
  final LatLng centroCali = const LatLng(3.4516, -76.5320);

  @override
  Widget build(BuildContext context) {
    // Escuchamos el ViewModel para obtener la posición en tiempo real
    final mapVm = context.watch<MapViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          // 1. EL MAPA REAL
          FlutterMap(
            options: MapOptions(
              initialCenter: centroCali,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.omniruta.app',
              ),

              // --- MOVIMIENTO SINCRONIZADO AQUÍ ---
              // Los marcadores deben ir DENTRO del FlutterMap para que se muevan con las coordenadas
              MarkerLayer(
                markers: [
                  _buildMarker(
                    point: mapVm.busPos, // ESTO VIENE DEL VIEWMODEL Y GPS_SERVICE
                    label: "VCN-456",
                    status: "En Ruta",
                  ),
                ],
              ),
            ],
          ),

          // 2. BUSCADOR SUPERIOR
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                margin: const EdgeInsets.only(top: 50), // Espacio para el botón volver
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Buscar placa o empresa...",
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Color(0xFF01579B)),
                  ),
                ),
              ),
            ),
          ),

          // 3. PANEL INFERIOR DE DETALLES
          Positioned(
            bottom: 30,
            left: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 20)],
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
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(backgroundColor: Color(0xFF01579B), child: Icon(Icons.person, color: Colors.white)),
                    title: const Text("Conductor: Carlos Arturo"),
                    subtitle: const Text("Ruta: Terrón Colorado - Centro"),
                    trailing: const Text("45 km/h", style: TextStyle(color: Color(0xFF01579B), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          
          // BOTÓN PARA VOLVER
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

  // DISEÑO DEL MARCADOR QUE SE MUEVE
  Marker _buildMarker({required LatLng point, required String label, required String status}) {
    return Marker(
      point: point,
      width: 120,
      height: 90,
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
                Text(status, style: const TextStyle(fontSize: 8, color: Colors.green)),
              ],
            ),
          ),
          // Usamos un icono de bus para que sea más claro
          const Icon(Icons.directions_bus, color: Color(0xFF01579B), size: 35),
        ],
      ),
    );
  }
}