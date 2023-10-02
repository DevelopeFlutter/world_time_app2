// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'Get_Time_Controller.dart';
import 'main.dart';
class CitiesList extends StatefulWidget {
  const CitiesList({Key? key}) : super(key: key);

  @override
  State<CitiesList> createState() => _CitiesListState();
}

class _CitiesListState extends State<CitiesList> {
  TextEditingController urlController = TextEditingController();
  bool ForIcon = false;
  CitiesUrls setUrl = Get.put(CitiesUrls());
  List<dynamic> cities = [
    'Berlin',
    'Athens',
    'Cairo',
    'Nairobi',
    'Chicago',
    'New York',
    'Seoul',
    'Jakarta'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Cities For Finding Time'),
      ),
      body:SingleChildScrollView(
        child: TypeAheadFormField(
            onSuggestionSelected: (dynamic val) {
              Get.to(const ForTimezone(),arguments: val);
              setUrl.urls.add(val);
              urlController.text = val;
            },
            itemBuilder: (context, dynamic item) {
              return ListTile(title: Text(item));
            },
            suggestionsCallback: (pattern) => cities.where((element) =>
                element.toLowerCase().contains(pattern.toLowerCase())),
            hideSuggestionsOnKeyboardHide: true,
            noItemsFoundBuilder: (context) => const Padding(
              padding: EdgeInsets.only(
                left: 8,
              ),
              child: SizedBox(
                  height: 30,
                  child: Text(
                    "No item Found",
                    style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  )),
            ),
            textFieldConfiguration: TextFieldConfiguration(
              controller: urlController,
              autofocus: true,
              onChanged: (dynamic value) {
                if (value.isEmpty) {
                  setState(() {
                    ForIcon = false;
                  });
                } else {
                  setState(() {
                    ForIcon = true;
                  });
                }
                // SkillController.text = value ;
                // SkillController.selection = TextSelection.fromPosition(
                //     TextPosition(offset:SkillController.text.length));
                setState(() {
                  // skillController.skills.value=value ;
                });
              },
              decoration: InputDecoration(
                  suffixIcon: ForIcon
                      ? IconButton(
                      onPressed: () {
                        urlController.clear();
                        setState(() {
                          ForIcon = false;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                      ))
                      : null,
                  hintText: "Search...",
                  contentPadding: const EdgeInsets.only(left: 15, top: 15)
                //
              ),
            )),
      ),
    );
  }
}
