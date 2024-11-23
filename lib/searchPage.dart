import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        primarySwatch: Colors.indigo,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          backgroundColor: Colors.grey,
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
  List<Event> _events = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    const String url = 'http://localhost:3456/data/eventi';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _events = data.map((json) => Event.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pretraži događaje',
        ),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final event = _events[index];
                  return EventCard(
                    eventName: event.skraceniNaziv,
                    eventTime: event.datumPocetka,
                    venue: event.organizator,
                    category: event.kategorija,
                  );
                },
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
              backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Pretraži'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: 'Moj put'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Prijatelji'),
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
  final String? category;

  const EventCard({
    super.key,
    required this.eventName,
    required this.eventTime,
    required this.venue,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();

    String displayImage;

    displayImage = "";

    const glazbaImages = [
      'lib/images/header/glazba/glazba1.jpg',
      'lib/images/header/glazba/glazba2.jpg',
      'lib/images/header/glazba/glazba3.jpg'
    ];

    const filmImages = [
      'lib/images/header/film/film1.jpg',
      'lib/images/header/film/film2.jpg',
      'lib/images/header/film/film3.jpg'
    ];
    const kazalisteImages = [
      'lib/images/header/kazaliste/kazaliste1.jpg',
      'lib/images/header/kazaliste/kazaliste2.jpg',
      'lib/images/header/kazaliste/kazaliste3.jpg'
    ];
    const muzejiImages = [
      'lib/images/header/muzej/muzej1.jpg',
      'lib/images/header/muzej/muzej2.jpg',
      'lib/images/header/muzej/muzej3.jpg'
    ];
    const plesImages = [
      'lib/images/header/ples/ples1.jpg',
      'lib/images/header/ples/ples2.jpg',
      'lib/images/header/ples/ples3.jpg'
    ];
    const likovnaImages = [
      'lib/images/header/lik/lik1.jpg',
      'lib/images/header/lik/lik2.jpg',
      'lib/images/header/lik/lik3.jpg'
    ];
    const knjizevnostImages = [
      'lib/images/header/knjiga/knjiga1.jpg',
      'lib/images/header/knjiga/knjiga2.jpg',
      'lib/images/header/knjiga/knjiga3.jpg'
    ];

// Assign random image based on the category
    if (category == 'Glazba') {
      displayImage = glazbaImages[random.nextInt(glazbaImages.length)];
    } else if (category == 'Film') {
      displayImage = filmImages[random.nextInt(filmImages.length)];
    } else if (category == 'Kazalište') {
      displayImage = kazalisteImages[random.nextInt(kazalisteImages.length)];
    } else if (category == 'Muzeji') {
      displayImage = muzejiImages[random.nextInt(muzejiImages.length)];
    } else if (category == 'Ples') {
      displayImage = plesImages[random.nextInt(plesImages.length)];
    } else if (category == 'Likovna umjetnost') {
      displayImage = likovnaImages[random.nextInt(likovnaImages.length)];
    } else if (category == 'Književnost') {
      displayImage = knjizevnostImages[random.nextInt(knjizevnostImages.length)];
    } else {
      displayImage = ''; // Default image for unknown categories
    }


    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.asset(
                displayImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Nema slike'));
                },
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


class Event {
  final int id;
  final String skraceniNaziv;
  final String puniNaziv;
  final String organizator;
  final String datumPocetka;
  final String? opis;
  final String cijena;
  final String kategorija;

  Event({
    required this.id,
    required this.skraceniNaziv,
    required this.puniNaziv,
    required this.organizator,
    required this.datumPocetka,
    required this.kategorija,
    this.opis,
    required this.cijena,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? 0,
      skraceniNaziv: json['skraćeni naziv'] ?? 'Nepoznati naziv',
      puniNaziv: json['puni naziv'] ?? 'Nepoznati puni naziv',
      organizator: json['organizator'] ?? 'Nepoznat organizator',
      datumPocetka: json['datum i vrijeme početka'] ?? 'Nepoznat datum',
      opis: json['opis'], // Default placeholder image
      cijena: json['cijena'] ?? 'Cijena nije dostupna',
      kategorija: json['kategorija'] ?? 'Kategorija nije dostupna',
    );
  }
}
