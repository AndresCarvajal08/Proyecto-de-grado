import 'package:flutter/material.dart';

class SolicitudesView extends StatelessWidget {
  const SolicitudesView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gestión de Solicitudes"),
          backgroundColor: const Color(0xFF01579B),
          foregroundColor: Colors.white,
        ),
        body: TabBarView(
          children: [
            _buildListByStatus(context, "Pendiente"),
            _buildListByStatus(context, "En Corrección"),
            _buildListByStatus(context, "Aprobado"),
            _buildListByStatus(context, "Rechazado"),
          ],
        ),
        bottomNavigationBar: Material(
          color: const Color(0xFF01579B),
          elevation: 10,
          child: TabBar(
            isScrollable: false,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorColor:  Colors.white,
            indicatorWeight: 4,
            labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            tabs: [
              Tab(icon: Icon(Icons.hourglass_empty, size: 33,), text: "Pendientes"),
              Tab(icon: Icon(Icons.edit_note, size: 36,), text: "En Corrección"),
              Tab(icon: Icon(Icons.check_circle_outline, size: 33,), text: "Aprobados"),
              Tab(icon: Icon(Icons.cancel_outlined, size: 33,), text: "Rechazados"),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildListByStatus(BuildContext context, String status) {
    // Datos simulados (Se muestran solo en pendientes para el ejemplo)
    final List<Map<String, String>> conductores = status == "Pendiente" 
      ? [
          {"nombre": "Carlos Arturo", "empresa": "Cootransol", "fecha": "Hoy, 10:30 AM", "placa": "VCN-456"},
          {"nombre": "Jairo Varela", "empresa": "Coop. La Ermita", "fecha": "Ayer", "placa": "WMB-102"},
        ]
      : [];

    if (conductores.isEmpty) {
      return Center(child: Text("No hay conductores en estado: $status"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: conductores.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFF01579B), 
              child: Icon(Icons.person, color: Colors.white)
            ),
            title: Text(conductores[index]['nombre']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${conductores[index]['empresa']} • $status"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FichaTecnicaView(driver: conductores[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// --- VISTA DE DETALLE: FICHA TÉCNICA ---
class FichaTecnicaView extends StatelessWidget {
  final Map<String, String> driver;
  const FichaTecnicaView({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ficha Técnica"), backgroundColor: const Color(0xFF01579B), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Datos del Conductor"),
            _buildInfoTile("Nombre", driver['nombre']!, Icons.person),
            _buildInfoTile("Empresa", driver['empresa']!, Icons.business),
            const SizedBox(height: 20),
            
            _buildSectionTitle("Documentación del Vehículo"),
            _buildDocumentCard("Placa del Vehículo", driver['placa']!, Icons.featured_video_outlined, true),
            _buildDocumentCard("SOAT", "Vence: 12/12/2026", Icons.verified_user_rounded, true),
            _buildDocumentCard("Revisión Tecnomecánica", "Vence: 05/08/2026", Icons.build_circle_outlined, true),
            
            const SizedBox(height: 30),
            
            // ACCIONES
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400, padding: const EdgeInsets.symmetric(vertical: 15)),
                    onPressed: () => _showRejectionDialog(context),
                    child: const Text("RECHAZAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600, padding: const EdgeInsets.symmetric(vertical: 15)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Conductor aprobado exitosamente")));
                      Navigator.pop(context);
                    },
                    child: const Text("APROBAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.edit_document, color: Colors.orange),
                label: const Text("SOLICITAR CORRECCIÓN", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.orange, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => _showCorrectionDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRejectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Motivo de Rechazo"),
        content: const TextField(
          decoration: InputDecoration(hintText: "Ej: Antecedentes o documentos falsos"),
          maxLines: 3,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text("Enviar Rechazo")),
        ],
      ),
    );
  }

  void _showCorrectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Solicitar Corrección"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Indique qué debe corregir el conductor:"),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ej: La foto del SOAT está borrosa",
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () { Navigator.pop(context); Navigator.pop(context); }, 
            child: const Text("Enviar a Proceso", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF01579B))),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildDocumentCard(String title, String info, IconData icon, bool isValid) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF03A9F4)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(info, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.remove_red_eye, color: Colors.blue),
        ],
      ),
    );
  }
}