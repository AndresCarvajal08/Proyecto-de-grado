import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../data/services/gps_service.dart';

class MapViewModel extends ChangeNotifier {
  final GpsService _gpsService = GpsService();
  
  // 1. DECLARAR LA LISTA (El error suele ser que falta esta línea)
  List<LatLng> routePoints = []; 
  
  LatLng _busPos = const LatLng(3.4516, -76.5320);
  LatLng get busPos => _busPos;

  MapViewModel() {
    _gpsService.busLocationStream.listen((nuevaPosicion) {
      _busPos = nuevaPosicion;
      
      // 2. AGREGAR EL PUNTO A LA LISTA PARA LA LÍNEA
      routePoints.add(nuevaPosicion); 
      
      notifyListeners(); // Avisa a la vista que el bus y la línea cambiaron
    });
  }
  void arrancarBus() {
  routePoints.clear(); // Limpia la línea azul anterior
  
  // Coordenadas reales de Cali
  const inicio = LatLng(3.4589, -76.5222); // Terminal
  const fin = LatLng(3.4298, -76.5428);    // Estadio Pascual Guerrero

  _gpsService.calcularRutaReal(inicio, fin);
  notifyListeners();
}

 
}