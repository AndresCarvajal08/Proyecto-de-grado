import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // --- VARIABLES DE ESTADO ---
  int _selectedRole = 0; // 0: Pasajero, 1: Conductor
  int _currentStep = 1;  // 1: Datos Personales, 2: Datos Vehículo
  
  // Datos para listas desplegables
  String? _selectedDocType = 'C.C.';
  final List<String> _docTypes = ['C.C.', 'C.E.', 'Pasaporte', 'P.P.T.'];

  String? _selectedCompany;
  final List<String> _companiesCali = [
    'Coop. La Ermita',
    'Transportes Alameda',
    'Recreativos S.A.',
    'Alfonso López S.A.',
    'Transportes Blanco y Negro',
    'Cootransol (Gualas - Los Chorros)',
    'Cootranscalipuerto (Gualas)',
    'Cootransunidos (Gualas - Siloé)',
    'Transportes La Estrella (Gualas)',
    'Cootransol (Gualas)',
    'TaxEmperador',
    'Particular / Independiente'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF03A9F4), Color(0xFF01579B)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  if (_currentStep == 2) {
                    setState(() => _currentStep = 1);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                child: Column(
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 30),
                    Text(
                      _currentStep == 1 ? "CREAR CUENTA" : "DATOS DEL VEHÍCULO",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white, fontSize: 22,
                        fontWeight: FontWeight.bold, letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 25),

                    if (_currentStep == 1) ...[
                      _buildRoleSelector(),
                      const SizedBox(height: 20),
                    ],
                    
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15, offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          if (_currentStep == 1) _buildPersonalStep(),
                          if (_currentStep == 2) _buildVehicleStep(),
                          const SizedBox(height: 30),
                          _buildSubmitButton(),
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

  // --- PASO 1: DATOS PERSONALES ---
  Widget _buildPersonalStep() {
    return Column(
      children: [
        _buildField(label: "Nombre Completo", icon: Icons.person_outline),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: DropdownButtonFormField<String>(
                value: _selectedDocType,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: "Tipo",
                  labelStyle: TextStyle(color: Color(0xFF03A9F4), fontSize: 12),
                  contentPadding: EdgeInsets.zero,
                ),
                items: _docTypes.map((type) => DropdownMenuItem(value: type, child: Text(type, style: const TextStyle(fontSize: 13)))).toList(),
                onChanged: (value) => setState(() => _selectedDocType = value),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(flex: 7, child: _buildField(label: "Número Documento", icon: Icons.badge_outlined)),
          ],
        ),
        const SizedBox(height: 15),
        _buildField(label: "Correo Electrónico", icon: Icons.email_outlined),
        const SizedBox(height: 15),
        _buildField(label: "Contraseña", icon: Icons.lock_outline, isPass: true),
        const SizedBox(height: 15),
        _buildField(label: "Confirmar Contraseña", icon: Icons.lock_reset_rounded, isPass: true),
      ],
    );
  }

  // --- PASO 2: DATOS VEHÍCULO (AHORA CON DROPDOWN DE EMPRESAS) ---
  Widget _buildVehicleStep() {
    return Column(
      children: [
        _buildField(label: "Placa del Vehículo", icon: Icons.pin_outlined),
        const SizedBox(height: 15),
        _buildField(label: "Número de Licencia (C2/C3)", icon: Icons.contact_mail_outlined),
        const SizedBox(height: 15),
        _buildField(label: "Vencimiento SOAT", icon: Icons.calendar_today_outlined),
        const SizedBox(height: 15),
        _buildField(label: "Vencimiento Tecno.", icon: Icons.build_circle_outlined),
        const SizedBox(height: 15),
        
        // MENÚ DESPLEGABLE DE EMPRESAS DE CALI
        DropdownButtonFormField<String>(
          value: _selectedCompany,
          isExpanded: true,
          menuMaxHeight: 350,
          icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Color(0xFF03A9F4)),
          hint: const Text("Seleccione Empresa/Cooperativa", style: TextStyle(fontSize: 14)),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.business_outlined, color: Color(0xFF03A9F4)),
            border: UnderlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
          items: _companiesCali.map((company) => DropdownMenuItem(
            value: company, 
            child: Text(company, style: const TextStyle(fontSize: 13))
          )).toList(),
          onChanged: (value) => setState(() => _selectedCompany = value),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    String text = _selectedRole == 0 ? "REGISTRARME" : (_currentStep == 1 ? "CONTINUAR REGISTRO" : "ENVIAR SOLICITUD");
    return Container(
      width: double.infinity, height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(colors: [Color(0xFF03A9F4), Color(0xFF0277BD)]),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_selectedRole == 1 && _currentStep == 1) {
            setState(() => _currentStep = 2);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Procesando...")));
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(20), 
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15, offset: const Offset(0, 8))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(25), bottomLeft: Radius.circular(35), bottomRight: Radius.circular(45)),
      ),
      child: Image.asset('assets/logo.png', height: 100, fit: BoxFit.contain),
    );
  }

  Widget _buildRoleSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _roleButton(index: 0, label: "PASAJERO", icon: Icons.person),
        const SizedBox(width: 15),
        _roleButton(index: 1, label: "CONDUCTOR", icon: Icons.drive_eta),
      ],
    );
  }

  Widget _roleButton({required int index, required String label, required IconData icon}) {
    bool isSelected = _selectedRole == index;
    return GestureDetector(
      onTap: () => setState(() { _selectedRole = index; _currentStep = 1; }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF01579B) : Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: isSelected ? const Color(0xFF01579B) : Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildField({required String label, required IconData icon, bool isPass = false}) {
    return TextField(
      obscureText: isPass,
      decoration: InputDecoration(
        labelText: label, labelStyle: const TextStyle(fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xFF03A9F4), size: 20),
        border: const UnderlineInputBorder(),
      ),
    );
  }
}