import 'package:flutter/material.dart';
import 'package:proyecto_gr/views/register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Graduación de fondo para que no sea un color plano aburrido
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF03A9F4), Color(0xFF01579B)],
          ),
        ),
        child: Stack(
          children: [
            // Círculos decorativos de fondo para dar estilo moderno
            Positioned(
              top: -50,
              right: -50,
              child: CircleAvatar(radius: 100, backgroundColor: Colors.white.withOpacity(0.1)),
            ),
            
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "RUTAS CALI",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    // Contenedor del Logo con Neumorfismo ligero
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(80),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: Image.asset(
                        'assets/logo.png',
                        height: 120,
                      ),
                    ),
                    
                    const SizedBox(height: 50),
                    
                    // Tarjeta de Login estilo Glassmorphism
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildCustomField(
                            label: "Correo Electrónico",
                            icon: Icons.alternate_email_rounded,
                          ),
                          const SizedBox(height: 20),
                          _buildCustomField(
                            label: "Contraseña",
                            icon: Icons.lock_person_rounded,
                            isPassword: true,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text("¿Olvidaste tu contraseña?", 
                                style: TextStyle(color: Color(0xFF01579B), fontSize: 13)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          
                          // Botón con gradiente
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
                                "INGRESAR",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterView()),
                        );
                      },
                      child: const Text(
                        "¿No tienes cuenta? Regístrate aquí",
                        style: TextStyle(color: Colors.white70, fontSize: 15),
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

  // Widget para campos de texto más limpios y modernos
  Widget _buildCustomField({required String label, required IconData icon, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xFF03A9F4)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF03A9F4), width: 2),
        ),
      ),
    );
  }
}