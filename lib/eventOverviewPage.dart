import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Image that extends to half of the page
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: screenHeight * 0.40,
          child: Image.asset(
            'lib/images/orasar.png', // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        // Content on top of the image

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: screenHeight * 0.40,
          child:
          Padding(  padding: const EdgeInsets.all(16.0), // Add padding around the Column
            child:
            Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start, // Align horizontally to the left
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(2.0), // Margin around the Container
                    padding: const EdgeInsets.all(2.0), // Inner padding for the text
                    decoration: BoxDecoration(
                      color: Color(0xFF3B1FA3), // Background color
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    child: const Text(
                      "Kazalište",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(2.0), // Margin around the Container
                    padding: const EdgeInsets.all(2.0), // Inner padding for the text
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B1FA3), // Background color
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    child: const Text(
                      "Balet",
                      style: TextStyle(
                        color: Colors.white, // Text color
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
        ), ),
        // Content below the image
        Positioned(
          top: screenHeight * 0.4,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.white,
            child:
                Padding(padding: const EdgeInsets.all(16.0),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Informacije o događaju",
                  style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold),
                ),Container(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0), // Add padding around the content
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoRow(
                        icon: Icons.calendar_today, // Calendar icon
                        text: "29.11.2024.",
                      ),
                      SizedBox(height: 10), // Space between rows
                      InfoRow(
                        icon: Icons.access_time, // Clock icon
                        text: "19:00",
                      ),
                      SizedBox(height: 10), // Space between rows
                      InfoRow(
                        icon: Icons.location_on, // Location pin icon
                        text: "Hrvatsko narodno kazalište",
                      ),
                    ],
                  ),
                ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0), // Add padding around the content
                    child: const Text(
                  "Opis",
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),),
                const Text(
                  "Baletnu bajku Orašar obožavaju djeca različite dob  i i ona je neizostavan dio svake adventske čarolije u svim dijelovima zemaljske kugle. Jedno od najljepših djela klasične baletne umjetnosti vodi svoje obožavatelje kroz božićni svijet raskoši, šarenila, veselja, mašte, prinčeva i vila te nezaobilaznih slatkiša, prateći pustolovine djevojčice Klare koja od svojeg ujaka na Badnjak dobiva neobičan dar, drobilicu za orahe u obliku drvenoga lutka. ",
                  style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0), // Add top margin
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding on the sides
                  child: ElevatedButton(
                    onPressed: () {
                      print("Button Pressed!");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B1FA3), // Set background color
                      minimumSize: const Size(double.infinity, 30), // Full width and height
                    ),
                    child: const Text(
                      "Kupi kartu",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
                    )
          ),
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 24.0,
          color: Colors.grey[800], // Icon color
        ),
        SizedBox(width: 10), // Space between icon and text
        Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black87, // Text color
          ),
        ),
      ],
    );
  }
}