import 'package:flutter/material.dart';
import 'package:proyecto_gr/main.dart';
// Asegúrate de importar las vistas correspondientes, puedes reutilizar las del usuario
import 'change_password_view.dart';
import 'font_size_view.dart';
import 'help_center_view.dart';
import 'about_view.dart';
import 'vehicle_details_view.dart';
import 'driver_profile_view.dart';
class DriverSettingsView extends StatefulWidget {
  const DriverSettingsView({super.key});

  @override
  State<DriverSettingsView> createState() => _DriverSettingsViewState();
}

class _DriverSettingsViewState extends State<DriverSettingsView> {
  bool _batterySaver = false;
  bool _autoStart = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración Conductor", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF01579B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          _buildSectionTitle("Perfil Profesional"),
          _buildSettingsTile(Icons.badge_outlined, "Datos del Conductor", "Licencia, nombre y foto", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const DriverProfileView()));
          }),
          _buildSettingsTile(Icons.local_shipping_outlined, "Datos del vehículo", "Placa y documentos técnicos", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const VehicleDetailsView()));
          }),
          _buildSettingsTile(Icons.lock_outline, "Seguridad", "Cambiar contraseña de acceso", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordView()));
          }),

          const Divider(),
          _buildSectionTitle("Parámetros de Ruta"),
          SwitchListTile(
            secondary: const Icon(Icons.battery_saver_rounded, color: Color(0xFF01579B)),
            title: const Text("Ahorro de Batería"),
            subtitle: const Text("Reduce la frecuencia del GPS en paradas"),
            value: _batterySaver,
            onChanged: (bool value) => setState(() => _batterySaver = value),
            activeColor: const Color(0xFF01579B),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.play_circle_outline, color: Color(0xFF01579B)),
            title: const Text("Inicio Automático"),
            subtitle: const Text("Transmitir al abrir la app"),
            value: _autoStart,
            onChanged: (bool value) => setState(() => _autoStart = value),
            activeColor: const Color(0xFF01579B),
          ),

          const Divider(),
          _buildSectionTitle("Interfaz y Pantalla"),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined, color: Color(0xFF01579B)),
            title: const Text("Modo Oscuro"),
            value: themeNotifier.value == ThemeMode.dark,
            onChanged: (bool value) {
              setState(() {
                themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
              });
            },
            activeColor: const Color(0xFF01579B),
          ),
          _buildSettingsTile(Icons.text_format_rounded, "Tamaño de Fuente", "Mejorar legibilidad al conducir", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const FontSizeView()));
          }),

          const Divider(),
          _buildSectionTitle("Asistencia"),
          _buildSettingsTile(Icons.support_agent_rounded, "Soporte Técnico", "Reportar fallas en la transmisión", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpCenterView()));
          }),
          _buildSettingsTile(Icons.info_outline_rounded, "Información Legal", "Versión Conductor 1.0.0", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutView()));
          }),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF01579B)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}