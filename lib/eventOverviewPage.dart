import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // For specifying coordinates
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: EventOverviewPage(),
      ),
    );
  }
}

class EventOverviewPage extends StatelessWidget {
  const EventOverviewPage({super.key});

  final String address = "Hrvatsko narodno kazalište, Trg Republike Hrvatske 15";
  static const lCoordinates = {"latitude": 45.80955, "longitude": 15.969882};

  static LatLng locationCoordinates = LatLng(lCoordinates['latitude']!, lCoordinates['longitude']!);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Image that extends to half of the page
          Stack(
            children: [
              Container(
                height: screenHeight * 0.40,
                width: double.infinity,
                child: Image.asset(
                  'lib/images/orasar.png', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              // Text on top of the image
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(2.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3B1FA3),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              "Kazalište",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(2.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3B1FA3),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              "Balet",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Orašar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Content below the image
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Informacije o događaju",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                InfoRow(
                  icon: Icons.calendar_today,
                  text: "29.11.2024.",
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                InfoRow(
                  icon: Icons.access_time,
                  text: "19:00",
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                InfoRow(
                  icon: Icons.location_on,
                  text: address,
                  onTap: () => openMap(locationCoordinates),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Opis",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Baletnu bajku Orašar obožavaju djeca različite dobi i ona je neizostavan dio svake adventske čarolije u svim dijelovima zemaljske kugle. Jedno od najljepših djela klasične baletne umjetnosti vodi svoje obožavatelje kroz božićni svijet raskoši, šarenila, veselja, mašte, prinčeva i vila te nezaobilaznih slatkiša, prateći pustolovine djevojčice Klare koja od svojeg ujaka na Badnjak dobiva neobičan dar, drobilicu za orahe u obliku drvenoga lutka.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Lokacija",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // OpenStreetMap
                SizedBox(
                  height: 200,
                  child: FlutterMap(
                    options: MapOptions(
                      center: locationCoordinates,
                      zoom: 16.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 50.0,
                            height: 50.0,
                            point: locationCoordinates,
                            builder: (ctx) => const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    print("Button Pressed!");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B1FA3),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Kupi kartu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void openMap(LatLng coordinates) async {
    final Uri url = Uri.parse(
        "https://www.openstreetmap.org/?mlat=${coordinates.latitude}&mlon=${coordinates.longitude}&zoom=16");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch map.";
    }
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const InfoRow({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 24.0, color: Colors.grey[800]),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
