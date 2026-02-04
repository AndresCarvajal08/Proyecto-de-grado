import 'package:flutter/material.dart';

class DriverProfileView extends StatelessWidget {
  const DriverProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF01579B);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil del Conductor", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header con Foto y Nombre
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: primaryColor,
                        child: CircleAvatar(
                          radius: 56,
                          backgroundImage: NetworkImage('https://www.w3schools.com/howto/img_avatar.png'),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, size: 18, color: primaryColor),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text("Juan Alberto Pérez", 
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const Text("Conductor Certificado", 
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Información Laboral"),
                  
                  // Tarjeta de Datos Profesionales
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        _buildProfileTile(Icons.badge_rounded, "Número de Licencia", "7605-123456-9"),
                        const Divider(height: 1),
                        _buildProfileTile(Icons.category_rounded, "Categoría", "C2 - (Servicio Público)"),
                        const Divider(height: 1),
                        _buildProfileTile(Icons.calendar_month_rounded, "Vencimiento Licencia", "20/10/2028"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  _buildSectionTitle("Contacto y Seguridad"),
                  
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        _buildProfileTile(Icons.phone_android_rounded, "Teléfono", "+57 315 123 4567"),
                        const Divider(height: 1),
                        _buildProfileTile(Icons.email_outlined, "Correo Electrónico", "juan.perez@gualas.com"),
                        const Divider(height: 1),
                        _buildProfileTile(Icons.emergency_rounded, "Contacto de Emergencia", "Esposa (310 987 6543)"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  
                  // Botón para Editar Información
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text("SOLICITAR ACTUALIZACIÓN DE DATOS", 
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10),
      child: Text(title, style: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.5)),
    );
  }

  Widget _buildProfileTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF01579B).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF01579B), size: 22),
      ),
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
    );
  }
}