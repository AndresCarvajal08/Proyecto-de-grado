import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; 
import 'package:latlong2/latlong.dart';      // Corregido el import a latlong2
import 'route_detail_view.dart';
import 'settings_view.dart';
import 'profile_view.dart';
import 'companies_view.dart';

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
          BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active_rounded), label: 'Alertas'),
        ],
      ),
    );
  }

  Widget _buildCurrentBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildMapaPrincipal();
      case 1:
        return _buildFavoritosTab();
      case 2:
        return _buildAlertasTab();
      default:
        return _buildMapaPrincipal();
    }
  }

  // --- 1. VISTA DE MAPA ---
  Widget _buildMapaPrincipal() {
    return Stack(
      children: [
        FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(3.4215, -76.5445),
            initialZoom: 14.5,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.rutas_cali.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: const LatLng(3.4215, -76.5445),
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.directions_bus, color: Color(0xFF01579B), size: 30),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 15, left: 15, right: 15,
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
        DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.15,
          maxChildSize: 0.7,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(15),
                children: [
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

  // --- 2. VISTA DE FAVORITOS ---
  Widget _buildFavoritosTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("Tus lugares frecuentes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        _buildFavoriteItem(Icons.home, "Casa", "Loma de la Cruz"),
        _buildFavoriteItem(Icons.work, "Trabajo", "Centro Comercial Cosmocentro"),
      ],
    );
  }

  Widget _buildFavoriteItem(IconData icon, String title, String sub) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.blue.shade50, child: Icon(icon, color: const Color(0xFF01579B))),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(sub),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }

  // --- 3. VISTA DE ALERTAS ---
  Widget _buildAlertasTab() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _buildAlertCard("Vía Cerrada", "Bloqueo en la subida a Siloé por reparaciones.", Colors.red),
        _buildAlertCard("Lluvia fuerte", "Precaución en Terrón Colorado por piso mojado.", Colors.orange),
      ],
    );
  }

  Widget _buildAlertCard(String title, String desc, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(Icons.warning_amber_rounded, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(desc),
      ),
    );
  }

  // --- RUTA CARD ---
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

  // --- DRAWER (MENÚ LATERAL) RE-ESTILIZADO ---
  Widget _buildDrawer(BuildContext context) {
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
            accountName: const Text("Usuario Guala", style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: const Text("usuario@cali.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF01579B), size: 40),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.history_rounded),
            title: const Text("Mis Viajes"),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.favorite_rounded),
            title: const Text("Mi Perfil"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileView()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.business_rounded),
            title: const Text("Empresas Afiliadas"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CompaniesView()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text("Configuración"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SettingsView()),
              );
            },
          ),
          const Divider(),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: Colors.red),
            title: const Text("Cerrar Sesión", style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}