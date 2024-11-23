import 'package:flutter/material.dart';
import 'package:hackl_app/components.dart';

import 'package:hackl_app/filterPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pretraži Događaje',
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          backgroundColor: Colors.white12,
          selectedLabelStyle: TextStyle(color: Colors.black),
          unselectedLabelStyle: TextStyle(color: Colors.black54),
        ),
      ),
      home: SearchEventsPage(),
    );
  }
}

class SearchEventsPage extends StatefulWidget {
  @override
  _SearchEventsPageState createState() => _SearchEventsPageState();
}

class _SearchEventsPageState extends State<SearchEventsPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      // appBar: AppBar(
      //   title: const Text(
      //     'Pretraži događaje',
      //   ),
      // ),
      body: SingleChildScrollView(
        // Ovo omogućava scrollanje ako sadržaj prelazi veličinu ekrana
        child: Padding(
          padding: const EdgeInsets.all(
              10.0), // Dodavanje margine oko cijelog sadržaja
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Pretraži događaje',
                    style:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              ),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Pretražite po nazivu, lokaciji, kategoriji...',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Margina između elemenata
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Od datuma',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Margina između tekstualnih polja
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Do datuma',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Margina između elemenata
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ), // Filter icon
                      label: const Text(
                        'Filtriraj događaje',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FilterPage()), // Navigate to Filter Page
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity,
                                  50)), // Device width and 50px height
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Rounded corners
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Margina između elemenata
              ListView(
                shrinkWrap:
                    true, // Ovo omogućava da ListView bude unutar Column-a bez overflow problema
                physics:
                    const NeverScrollableScrollPhysics(), // Onemogućava scroll unutar ListView-a
                children: const [
                  EventCard(
                      eventName: 'Orašar',
                      eventTime: '29.11.2024. 19:00h',
                      venue: 'Hrvatsko narodno kazalište',
                      imageUrl:
                          'lib/images/orasar.png'), // Pretpostavljeno da su slike u assets folderu
                  EventCard(
                      eventName: 'Jimmy Carr - Laugh Funny',
                      eventTime: '05.12.2024. 20:00h',
                      venue: 'Arena Zagreb',
                      imageUrl:
                          'lib/images/jimmy_carr.png'), // Pretpostavljeno da su slike u assets folderu
                  EventCard(
                      eventName: 'Škrtac',
                      eventTime: '19.12.2024. 21:00h',
                      venue: 'Kazalište Kerempuh',
                      imageUrl:
                          'lib/images/skrtac.png'), // Pretpostavljeno da su slike u assets folderu
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Naslovnica',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Pretraži'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: 'Moj put'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: 'Prijatelji'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profil'),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String eventName;
  final String eventTime;
  final String venue;
  final String imageUrl;

  const EventCard(
      {super.key,
      required this.eventName,
      required this.eventTime,
      required this.venue,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Postavlja zaobljenost svih ivica
      ),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context)
                .size
                .width, // Širina slike postavljena na 200 piksela
            height: 150, // Visina slike postavljena na 150 piksela
            child: ClipRRect(
              // Zaobljava ivice slike u skladu sa Card
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover, // Osigurava da slika pokrije celu površinu
              ),
            ),
          ),
          ListTile(
            title: Text(eventName),
            subtitle: Text('$eventTime\n$venue'),
            isThreeLine: true,
          ),
        ],
      ),
    );
  }
}
