import 'package:flutter/material.dart';
import 'package:hackl_app/components.dart';
import 'package:hackl_app/searchPage.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double _currentValue = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: <Widget>[
          const Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Filtriraj događaja',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          ),
          buildSectionTitle(context, 'Kategorije'),
          buildFilterChips(
              ['Glazba', 'Film', 'Kazalište', 'Ples', 'Muzeji', 'Festivali']),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Tip događaja'),
          buildFilterChips(['Koncert', 'Festival', 'Izložba', 'Predstava']),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Organizator'),
          buildFilterChips([
            'Hrvatsko narodno kazalište',
            'Muzej suvremene umjetnosti',
            'Lisinski'
          ]),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Cijena ulaznice'),
          buildSlider(),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Pristupačnost'),
          buildFilterChips(['Parking u blizini', 'Invaliditet', 'Ljubimci']),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Dobne skupine'),
          buildFilterChips(['Za djecu', 'Za mlade', 'Za odrasle']),
          const SizedBox(height: 20),
          buildSectionTitle(context, 'Sortiranje'),
          buildFilterChips(['Cijena', 'Popularnost', 'Datum']),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchEventsPage()), // Navigate to Filter Page
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: blueColor,
              minimumSize: const Size(double.infinity, 50), // Full width button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded button
              ),
            ), // Apply filters and close or navigate
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

  Widget buildFilterChips(List list) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: list
            .map((category) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  backgroundColor: Color.fromARGB(255, 242, 242, 242),
                  label: Text(category),
                  selected: false,
                  onSelected: (selected) {},
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Sets the border radius
                    side: const BorderSide(
                        color: Colors.black, width: 1), // Black, thin border
                  ),
                )))
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
                _currentValue =
                    value; // Update the state with the new slider value
              });
            },
            activeColor: blueColor,
            thumbColor: blueColor,
            secondaryActiveColor: blueColor,
          ),
          Text(
            'Cijena do ${_currentValue.round()}€',
            style: const TextStyle(fontSize: 14),
          ),
        ]);
  }
}
