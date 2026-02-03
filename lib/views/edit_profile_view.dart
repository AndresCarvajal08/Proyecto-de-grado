import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  // Estos controladores guardan lo que el usuario escribe
  final TextEditingController _nameController = TextEditingController(text: "Usuario Guala");
  final TextEditingController _phoneController = TextEditingController(text: "+57 300 123 4567");
  final TextEditingController _emailController = TextEditingController(text: "usuario@cali.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF01579B),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Botón de guardar en la parte superior
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // Aquí iría la lógica para guardar en la base de datos
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cambios guardados correctamente")),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFE1F5FE),
              child: Icon(Icons.camera_alt, size: 40, color: Color(0xFF01579B)),
            ),
            const SizedBox(height: 30),
            _buildTextField("Nombre Completo", _nameController, Icons.person),
            const SizedBox(height: 15),
            _buildTextField("Teléfono", _phoneController, Icons.phone),
            const SizedBox(height: 15),
            _buildTextField("Correo Electrónico", _emailController, Icons.email),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF01579B),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("GUARDAR CAMBIOS", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF01579B)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}