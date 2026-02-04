import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'driver_settings_view.dart';
import 'driver_operation_time_view.dart';
import 'driver_trips_view.dart';
// Make sure the class in driver_trips_view.dart is named DriverTripsView

// Importa aquí tus otras vistas para que la navegación no de error
// import 'package:tu_proyecto/views/profile_view.dart';
// import 'package:tu_proyecto/views/settings_view.dart';

class DriverPanelView extends StatefulWidget {
  const DriverPanelView({super.key});

  @override
  State<DriverPanelView> createState() => _DriverPanelViewState();
}

class _DriverPanelViewState extends State<DriverPanelView> {
  bool _isTransmitting = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDriverDrawer(context, theme),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text("Modo Conductor"),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(3.4243, -76.5543),
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.tu_proyecto.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(3.4243, -76.5543),
                    width: 80,
                    height: 80,
                    child: Icon(Icons.location_on, size: 40, color: theme.primaryColor),
                  ),
                ],
              ),
            ],
          ),

          // PANEL INFERIOR
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor.withOpacity(0.95),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _isTransmitting ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _isTransmitting ? "EN VIVO" : "DESCONECTADO",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () => setState(() => _isTransmitting = !_isTransmitting),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isTransmitting ? Colors.redAccent : Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 0,
                      ),
                      child: Text(
                        _isTransmitting ? "FINALIZAR RUTA" : "INICIAR RUTA",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- MENU LATERAL (DRAWER) ADAPTADO AL CONDUCTOR ---
  Widget _buildDriverDrawer(BuildContext context, ThemeData theme) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF01579B),
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=2069&auto=format&fit=crop'), 
                fit: BoxFit.cover,
                opacity: 0.2,
              ),
            ),
            accountName: const Text("Conductor Guala", style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: const Text("Placa: VCI-123 | Interno: 042"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.drive_eta, color: Color(0xFF01579B), size: 40),
            ),
          ),
          
          ListTile(
            leading: const Icon(Icons.map_rounded),
            title: const Text("Mapa de Ruta"),
            onTap: () => Navigator.pop(context),
          ),

          ListTile(
            leading: const Icon(Icons.history_rounded),
            title: const Text("Mis Recorridos de Hoy"),
            onTap: () {
              Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DriverTripsView()));
              // If you still get an error, check driver_trips_view.dart for the correct class name and use it here.
            },
          ),

          ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: const Text("Tiempos de operación"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OperationTimesView()));
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text("Configuración"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DriverSettingsView()));
            },
          ),
          
          const Divider(),
          const Spacer(),
          
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: Colors.red),
            title: const Text("Cerrar Sesión", style: TextStyle(color: Colors.red)),
            onTap: () {
              // Aquí deberías navegar de vuelta al LoginView o pantalla de inicio
              Navigator.pop(context); 
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}