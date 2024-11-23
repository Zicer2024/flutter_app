import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtriraj događaje'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: <Widget>[
          buildSectionTitle(context, 'Kategorije'),
          buildCategoryChips(),
          buildSectionTitle(context, 'Tip događaja'),
          buildTypeChips(),
          buildSectionTitle(context, 'Organizator'),
          buildDropdown(
              ['Hrvatsko narodno kazalište', 'Muzej suvremene umjetnosti']),
          buildSectionTitle(context, 'Cijena ulaznice'),
          buildSlider(),
          buildSectionTitle(context, 'Pristupačnost'),
          buildSwitch('Parking u blizini'),
          buildSwitch('Invaliditet'),
          buildSwitch('Ljubimci'),
          buildSectionTitle(context, 'Dobne skupine'),
          buildCheckbox('Za djecu'),
          buildCheckbox('Za mlade'),
          buildCheckbox('Za odrasle'),
          buildSectionTitle(context, 'Sortiranje'),
          buildDropdown(['Cijena', 'Popularnost', 'Datum']),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () =>
                Navigator.pop(context), // Apply filters and close or navigate
            child: Text('Primijeni filtre'),
            style: ElevatedButton.styleFrom(
              //primary: Colors.blue,
              minimumSize: Size(double.infinity, 50), // Full width button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded button
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    //return Padding(
    //  padding: const EdgeInsets.symmetric(vertical: 10),
    //  child: Text(title, style: Theme.of(context).textTheme.headline6),
    //);

    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: ['Glazba', 'Film', 'Kazalište', 'Ples', 'Muzeji', 'Festivali']
            .map((category) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: false,
                    onSelected: (selected) {},
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget buildCategoryChips() {
    List<String> categories = ['Glazba', 'Film', 'Kazalište', 'Ples', 'Muzeji'];
    return Wrap(
      spacing: 8,
      children: categories
          .map((category) => Chip(
                label: Text(category),
                // onSelected: (_) {},
              ))
          .toList(),
    );
  }

  Widget buildTypeChips() {
    List<String> types = ['Koncert', 'Festival', 'Izložba', 'Predstava'];
    return Wrap(
      spacing: 8,
      children: types
          .map((type) => Chip(
                label: Text(type),
                // onSelected: (_) {},
              ))
          .toList(),
    );
  }

  Widget buildDropdown(List<String> options) {
    String selected = options.first;
    return DropdownButton<String>(
      isExpanded: true,
      value: selected,
      onChanged: (value) {},
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildSlider() {
    return Slider(
      value: 40,
      min: 0,
      max: 100,
      divisions: 20,
      label: '40€',
      onChanged: (double value) {},
    );
  }

  Widget buildSwitch(String label) {
    return SwitchListTile(
      title: Text(label),
      value: true,
      onChanged: (bool value) {},
    );
  }

  Widget buildCheckbox(String label) {
    return CheckboxListTile(
      title: Text(label),
      value: true,
      onChanged: (_) => (),
    );
  }
}
