import 'package:flutter/material.dart';

class FontSizeView extends StatefulWidget {
  const FontSizeView({super.key});

  @override
  State<FontSizeView> createState() => _FontSizeViewState();
}

class _FontSizeViewState extends State<FontSizeView> {
  double _currentFontSize = 16.0; // Tamaño por defecto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tamaño de Fuente", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF01579B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Área de Vista Previa
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Ruta Siloé - La Nave",
                        style: TextStyle(
                          fontSize: _currentFontSize + 4, 
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF01579B)
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Este es un ejemplo de cómo se verá el texto en la aplicación. Puedes ajustar la barra de abajo para aumentar o disminuir el tamaño según tu preferencia.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: _currentFontSize),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Control deslizante (Slider)
          Container(
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("A", style: TextStyle(fontSize: 14)),
                    Text("Tamaño de texto", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("A", style: TextStyle(fontSize: 24)),
                  ],
                ),
                Slider(
                  value: _currentFontSize,
                  min: 12.0,
                  max: 24.0,
                  divisions: 6,
                  activeColor: const Color(0xFF01579B),
                  label: _currentFontSize.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentFontSize = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF01579B),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("APLICAR CONFIGURACIÓN", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}