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
        body: EventOverviewPage(
          eventName: "Orašar",
          eventCategory1: "Kazalište",
          eventCategory2: "Balet",
          eventAddress: "Hrvatsko narodno kazalište, Trg Republike Hrvatske 15",
          eventDate: "29.11.2024.",
          eventTime: "19:00",
          eventDescription: "Baletnu bajku Orašar obožavaju djeca različite dobi...",
          eventLocation: LatLng(45.80955, 15.969882),
          displayImage: '',
        ),
      ),
    );
  }
}

class EventOverviewPage extends StatelessWidget {
  final String eventName;
  final String eventCategory1;
  final String eventCategory2;
  final String eventAddress;
  final String eventDate;
  final String eventTime;
  final String eventDescription;
  final LatLng eventLocation;
  final String displayImage;

  const EventOverviewPage({
    super.key,
    required this.eventName,
    required this.eventCategory1,
    required this.eventCategory2,
    required this.eventAddress,
    required this.eventDate,
    required this.eventTime,
    required this.eventDescription,
    required this.eventLocation,
    required this.displayImage,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Image Banner with Overlay
          Stack(
            children: [
              Container(
                height: screenHeight * 0.40,
                width: double.infinity,
                child: Image.asset(
                  displayImage, // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CategoryTag(category: eventCategory1),
                          CategoryTag(category: eventCategory2),
                        ],
                      ),
                      Text(
                        eventName,
                        style: const TextStyle(
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
          // Content Section
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
                  text: eventDate,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                InfoRow(
                  icon: Icons.access_time,
                  text: eventTime,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                InfoRow(
                  icon: Icons.location_on,
                  text: eventAddress,
                  onTap: () => openMap(eventLocation),
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
                Text(
                  eventDescription,
                  style: const TextStyle(
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
                SizedBox(
                  height: 200,
                  child: FlutterMap(
                    options: MapOptions(
                      center: eventLocation,
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
                            point: eventLocation,
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

class CategoryTag extends StatelessWidget {
  final String category;

  const CategoryTag({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFF3B1FA3),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13.0,
        ),
      ),
    );
  }
}


class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const InfoRow({
    super.key,
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
