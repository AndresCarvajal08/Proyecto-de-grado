import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Librería del mapa
import 'package:latlong2/latlong.dart';      // Manejo de coordenadas
import 'route_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  final List<String> _titles = ["RUTAS CALI", "MIS FAVORITOS", "ALERTAS"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF01579B),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      drawer: _buildDrawer(context),
      body: _buildCurrentBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF01579B),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alertas'),
        ],
      ),
    );
  }

  Widget _buildCurrentBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildMapaPrincipal();
      case 1:
        return const Center(child: Text("Próximamente: Tus Rutas Favoritas"));
      case 2:
        return const Center(child: Text("Próximamente: Alertas de Tráfico"));
      default:
        return _buildMapaPrincipal();
    }
  }

  // --- VISTA CON MAPA Y LISTA DESLIZABLE ---
  Widget _buildMapaPrincipal() {
    return Stack(
      children: [
        // 1. EL MAPA (OpenStreetMap)
        FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(3.4215, -76.5445), // Centro cerca de Siloé, Cali
            initialZoom: 14.5,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.rutas_cali.app',
            ),
            MarkerLayer(
              markers: [
                // Marcador de ejemplo (donde estaría una guala)
                Marker(
                  point: LatLng(3.4215, -76.5445),
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.directions_bus, color: Color(0xFF01579B), size: 30),
                ),
              ],
            ),
          ],
        ),

        // 2. BUSCADOR FLOTANTE
        Positioned(
          top: 15,
          left: 15,
          right: 15,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(30),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar guala (Siloé, Terrón...)",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF01579B)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),

        // 3. HOJA DESLIZABLE (Bottom Sheet)
        DraggableScrollableSheet(
          initialChildSize: 0.3, // Empieza ocupando el 30% de la pantalla
          minChildSize: 0.15,    // Mínimo para que se vea el título
          maxChildSize: 0.7,     // Hasta donde puede subir
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(15),
                children: [
                  // Rayita estética para deslizar
                  Center(child: Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
                  const SizedBox(height: 20),
                  const Text("Rutas Disponibles", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  _buildRutaCard(context, "Siloé - La Nave", "5 min", Colors.orange),
                  _buildRutaCard(context, "Terrón Colorado", "10 min", Colors.green),
                  _buildRutaCard(context, "La Sirena", "15 min", Colors.blue),
                  _buildRutaCard(context, "Pueblo Joven", "8 min", Colors.redAccent),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRutaCard(BuildContext context, String nombre, String frecuencia, Color color) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(Icons.directions_bus, color: color, size: 20),
        ),
        title: Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Pasa cada $frecuencia"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RouteDetailView(nombreRuta: nombre, frecuencia: frecuencia, color: color)),
          );
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF01579B)),
            accountName: Text("Usuario Guala"),
            accountEmail: Text("usuario@cali.com"),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, color: Color(0xFF01579B))),
          ),
          ListTile(leading: const Icon(Icons.settings), title: const Text("Configuración"), onTap: () {}),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Cerrar Sesión", style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}