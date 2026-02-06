import 'package:flutter/material.dart';
import 'package:proyecto_gr/views/admin_empresas_view.dart';
import 'package:proyecto_gr/views/admin_reportes_view';
import 'admin_solicitudes_view.dart';
import 'admin_map_view.dart';


class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  int _currentIndex = 0;

  // Lista de páginas
  final List<Widget> _pages = [
    const AdminHomeRoutes(), // Conductores con rutas activas
    const AdminMapView(),
    const AdminEmpresasView(),
    const AdminReportesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text(
          "Control Operativo Cali",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF01579B),
        elevation: 0,
      ),
      // --- MENÚ HAMBURGUESA (CON SOLICITUDES) ---
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF01579B)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.admin_panel_settings, size: 40, color: Color(0xFF01579B)),
              ),
              accountName: Text("Administrador Cali", style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text("admin@omniruta.com"),
            ),
            ListTile(
              leading: const Icon(Icons.person_add_alt_1_rounded, color: Colors.orange),
              title: const Text("Solicitudes de Conductores"),
              subtitle: const Text("8 pendientes por revisar"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SolicitudesView()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history_rounded),
              title: const Text("Historial de Viajes"),
              onTap: () {},
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.red),
              title: const Text("Cerrar Sesión"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          if (index == 1){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminMapView()));
          } else {
            setState(() => _currentIndex = index);
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF01579B),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: "Mapa"),
          BottomNavigationBarItem(icon: Icon(Icons.business_rounded), label: "Empresas"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: "Reportes"),
        ],
      ),
    );
  }
}

// --- VISTA DE CONDUCTORES ACTIVOS (HOME) ---
class AdminHomeRoutes extends StatelessWidget {
  const AdminHomeRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF01579B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Monitoreo en Tiempo Real", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text("Conductores y Gualas operando ahora", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // KPIs de estado actual
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                _StatCard(label: "En Ruta", value: "32", color: Colors.green, icon: Icons.local_taxi),
                SizedBox(width: 10),
                _StatCard(label: "Fuera de Servicio", value: "12", color: Colors.orange, icon: Icons.pause_circle_filled),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Conductores con Rutas Activas", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF01579B))),
            ),
          ),

          // LISTA DE CONDUCTORES EN RUTA
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: const [
              _ActiveRouteItem(name: "Carlos Arturo", empresa: "Cootransol (Guala)", ruta: "Siloé - Calle 5ta", placa: "VCN-456"),
              _ActiveRouteItem(name: "Jairo Varela", empresa: "Coop. La Ermita", ruta: "Poblado - Centro", placa: "WMB-102"),
              _ActiveRouteItem(name: "Marta Estela", empresa: "Cootransunidos", ruta: "Terrón - Av. 6ta", placa: "XAL-789"),
              _ActiveRouteItem(name: "Duván Zapata", empresa: "Recreativos S.A.", ruta: "Aguablanca - Terminal", placa: "TRK-234"),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// --- SUB-WIDGETS ---

class _StatCard extends StatelessWidget {
  final String label, value;
  final Color color;
  final IconData icon;
  const _StatCard({required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ActiveRouteItem extends StatelessWidget {
  final String name, empresa, ruta, placa;
  const _ActiveRouteItem({required this.name, required this.empresa, required this.ruta, required this.placa});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Colors.grey.shade200)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: const Color(0xFF03A9F4).withOpacity(0.1), child: const Icon(Icons.person, color: Color(0xFF01579B))),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$empresa • $placa", style: const TextStyle(fontSize: 12, color: Colors.blueGrey)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.multiple_stop, size: 14, color: Colors.orange),
                const SizedBox(width: 5),
                Text("Ruta: $ruta", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: const Text("EN VIVO", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}