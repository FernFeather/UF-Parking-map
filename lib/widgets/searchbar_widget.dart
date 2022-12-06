/*
    Desc:
      Class defining widget for slide up panel search bar
 */
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../services/parking_data.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    Key? key,
    required this.pc,
    required this.locationList,
    required this.notifyParent,
  }) : super(key: key);

  final PanelController pc;
  final List<ParkingLocation> locationList;

  final Function(List<ParkingLocation> updatedList) notifyParent;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool isIgnoring = true;
  String hintText = "Search Locations";
  List<ParkingLocation> locationList = [];

  @override
  void initState() {
    super.initState();
    locationList = widget.locationList;
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isIgnoring = false;
          hintText = "";
        });
      } else {
        setState(() {
          isIgnoring = true;
          hintText = "Search Locations";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    =======================================================
    ============= SLIDE UP PANEL SEARCH BAR  ==============
    =======================================================
    */
    return GestureDetector(
      onTap: () => _onTap(),
      child: Container(
        color: Colors.transparent,
        child: IgnorePointer(
          ignoring: isIgnoring,
          child: TextField(
            onChanged: (String query) => _searchLocation(query),
            focusNode: focusNode,
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.search),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 48,
              ),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height * (1 / 24),
                ),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _searchLocation(String query) {
    final suggestions = ParkingDatabaseService.parkingList.where((location) {
      final locationName = location.name!.toLowerCase();
      final input = query.toLowerCase();

      return locationName.contains(input);
    }).toList();

    setState(() {
      locationList = suggestions;
      widget.notifyParent(locationList);
    });
  }

  void _onTap() {
    setState(() {});
    widget.pc.open();
    FocusScope.of(context).requestFocus(focusNode);
  }
}
