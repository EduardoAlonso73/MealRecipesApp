import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../screens/home/home_provider.dart';
import '../utils/country.dart';

class NationalitiesSlider extends StatelessWidget {
  const NationalitiesSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
     // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Browse country",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: nationalities.length,
                itemBuilder: (_, int index) {
                  final Map<String, String> country = nationalities[index];
                  return _ChoiceChip(country.values.first, country.keys.first);
                }),
          )
        ],
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  final String label;
  final String value;

  const _ChoiceChip(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Wrap(
        runSpacing: 8,
        spacing: 8,
        children: [
          ChoiceChip(
            label: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: homeProvider.selectedChoiceTap == value
                    ? Colors.white
                    : Colors.orange,
              ),
            ),
            onSelected: (bool selected) {
              if (selected) homeProvider.selectChoice(value);
            },
            selected: homeProvider.selectedChoiceTap == value,
            selectedColor: Colors.orange,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            avatar: null,
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ],
      ),
    );
  }
}
