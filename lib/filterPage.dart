import 'package:flutter/material.dart';
import 'package:hackl_app/searchPage.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double _currentValue = 40;

  // State for selected filters
  final Map<String, List<String>> _selectedFilters = {
    'Kategorije': [],
    'Tip događaja': [],
    'Organizator': [],
    'Pristupačnost': [],
    'Dobne skupine': [],
    'Sortiranje': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('Filtriraj događaja',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          ),
          buildSectionTitle(context, 'Kategorije'),
          buildFilterChips('Kategorije', [
            'Glazba',
            'Film',
            'Kazalište',
            'Ples',
            'Muzeji',
            'Festivali'
          ]),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Tip događaja'),
          buildFilterChips('Tip događaja',
              ['Koncert', 'Festival', 'Izložba', 'Predstava']),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Organizator'),
          buildFilterChips('Organizator', [
            'Hrvatsko narodno kazalište',
            'Muzej suvremene umjetnosti',
            'Lisinski'
          ]),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Cijena ulaznice'),
          buildSlider(),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Pristupačnost'),
          buildFilterChips(
              'Pristupačnost', ['Parking u blizini', 'Invaliditet', 'Ljubimci']),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Dobne skupine'),
          buildFilterChips(
              'Dobne skupine', ['Za djecu', 'Za mlade', 'Za odrasle']),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Sortiranje'),
          buildFilterChips('Sortiranje', ['Cijena', 'Popularnost', 'Datum']),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final filterJson = {
                ..._selectedFilters,
                'Cijena ulaznice': _currentValue.round(),
              };
              debugPrint(filterJson.toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SearchEventsPage()), // Navigate to Filter Page
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:  const Color(0xFF3B1FA3),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Primijeni filtre',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    );
  }

  Widget buildFilterChips(String filterKey, List<String> options) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: options
            .map((option) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ChoiceChip(
            backgroundColor: Colors.white,
            selectedColor:  const Color(0xFF3B1FA3).withOpacity(0.8),
            label: Text(option),
            selected: _selectedFilters[filterKey]?.contains(option) ??
                false,
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  _selectedFilters[filterKey]?.add(option);
                } else {
                  _selectedFilters[filterKey]?.remove(option);
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.black, width: 1),
            ),
          ),
        ))
            .toList(),
      ),
    );
  }

  Widget buildSlider() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(
            value: _currentValue,
            min: 0,
            max: 100,
            divisions: 20,
            label: '${_currentValue.round()}€',
            onChanged: (double value) {
              setState(() {
                _currentValue = value;
              });
            },
            activeColor: Colors.blue,
            thumbColor: Colors.blue,
          ),
          Text(
            'Cijena do ${_currentValue.round()}€',
            style: const TextStyle(fontSize: 14),
          ),
        ]);
  }
}
