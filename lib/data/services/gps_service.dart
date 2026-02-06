import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class GpsService {
  static final GpsService _instance = GpsService._internal();
  factory GpsService() => _instance;
  GpsService._internal();

  final _locationController = StreamController<LatLng>.broadcast();
  Stream<LatLng> get busLocationStream => _locationController.stream;

  // ESTA ES LA FUNCIÓN NUEVA QUE USA LA API
  Future<void> calcularRutaReal(LatLng origen, LatLng destino) async {
    final url = 'https://router.project-osrm.org/route/v1/driving/'
        '${origen.longitude},${origen.latitude};${destino.longitude},${destino.latitude}'
        '?overview=full&geometries=geojson';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List coords = data['routes'][0]['geometry']['coordinates'];

        List<LatLng> puntosCalle = coords
            .map((c) => LatLng(c[1].toDouble(), c[0].toDouble()))
            .toList();

        int i = 0;
        Timer.periodic(const Duration(milliseconds: 600), (timer) {
          if (i < puntosCalle.length) {
            _locationController.add(puntosCalle[i]);
            i++;
          } else {
            timer.cancel();
            print("Llegamos al destino");
          }
        });
      }
    } catch (e) {
      print("Error conectando con la API: $e");
    }
  }
}