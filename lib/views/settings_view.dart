import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _darkMode = false;
  bool _proximityAlerts = true;
  bool _shareLocation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF01579B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          _buildSectionTitle("Cuenta y Perfil"),
          _buildSettingsTile(Icons.person_outline, "Editar Perfil", "Nombre, teléfono y foto", () {}),
          _buildSettingsTile(Icons.lock_outline, "Seguridad", "Cambiar contraseña", () {}),
          
          const Divider(),
          _buildSectionTitle("Preferencias de Viaje"),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_active_outlined, color: Color(0xFF01579B)),
            title: const Text("Alertas de Proximidad"),
            subtitle: const Text("Vibrar cuando la guala esté cerca"),
            value: _proximityAlerts,
            onChanged: (bool value) => setState(() => _proximityAlerts = value),
            activeColor: const Color(0xFF01579B),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.share_location_rounded, color: Color(0xFF01579B)),
            title: const Text("Compartir ubicación"),
            subtitle: const Text("Enviar ruta a contactos de confianza"),
            value: _shareLocation,
            onChanged: (bool value) => setState(() => _shareLocation = value),
            activeColor: const Color(0xFF01579B),
          ),

          const Divider(),
          _buildSectionTitle("Interfaz"),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined, color: Color(0xFF01579B)),
            title: const Text("Modo Oscuro"),
            value: _darkMode,
            onChanged: (bool value) => setState(() => _darkMode = value),
            activeColor: const Color(0xFF01579B),
          ),
          _buildSettingsTile(Icons.text_format_rounded, "Tamaño de Fuente", "Ajustar texto de la app", () {}),

          const Divider(),
          _buildSectionTitle("Soporte"),
          _buildSettingsTile(Icons.help_outline_rounded, "Centro de Ayuda", "Preguntas frecuentes y tarifas", () {}),
          _buildSettingsTile(Icons.info_outline_rounded, "Acerca de Rutas Cali", "Versión 1.0.0", () {}),
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