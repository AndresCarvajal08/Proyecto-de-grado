import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF03A9F4), Color(0xFF01579B)],
          ),
        ),
        child: Stack(
          children: [
            // Botón para regresar al Login
            Positioned(
              top: 50,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    // Logo pequeño para dejar espacio al formulario
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Image.asset('assets/logo.png', height: 70),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "CREAR CUENTA",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Tarjeta de Registro
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          _buildField(label: "Nombre Completo", icon: Icons.person_outline),
                          const SizedBox(height: 15),
                          _buildField(label: "Correo Electrónico", icon: Icons.email_outlined),
                          const SizedBox(height: 15),
                          _buildField(label: "Contraseña", icon: Icons.lock_outline, isPass: true),
                          const SizedBox(height: 15),
                          _buildField(label: "Confirmar Contraseña", icon: Icons.lock_reset_rounded, isPass: true),
                          const SizedBox(height: 30),
                          
                          // Botón de Registro
                          Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF03A9F4), Color(0xFF0277BD)],
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              ),
                              child: const Text(
                                "REGISTRARME",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({required String label, required IconData icon, bool isPass = false}) {
    return TextField(
      obscureText: isPass,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF03A9F4)),
        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
      ),
    );
  }
}