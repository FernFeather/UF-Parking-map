/*
    Desc:
      Class containing code for the sliding panel widget in the parking app.

    To-do:
      1. Create search bar [COMPLETED]
        - Make sure keyboard does not push up on items in list [DONE]
        - Make so clicking off keyboard closes keyboard [DONE]
        - Make so clicking on keyboard opens panel [DONE]
        - Format search bar layout [DONE]
        - On tap of header, bounce the header up and down [DONE]
        - Make sure list items are filtered as they are searched [DONE]
            - Update when searchbar widget updates?
      2. Make list tiles buttons
        - Give list tiles state where they change color on press
        - On release have panel change state to info state -> (3)
        - On button click, center camera position to location coordinates
      3. Make info state widget
        - enable parallax to center location marker
        - Display parking area info
        - Have icon to go back to search list
        - If search bar is reselected, change back to search list
      4. Have click on marker activate info state widget
      5. Gestures
        - Swipe left or right gesture
          - closes list if open on search page
          - closes info panel and goes back to search panel
 */

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../services/parking_data.dart';
import 'maps_widget.dart';
import 'searchbar_widget.dart';

class PanelWidget extends StatefulWidget {
  const PanelWidget({Key? key}) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

/*
  ============= ============== ==============
  ============= SLIDE UP PANEL ==============
  ============= ============== ==============
*/
class _PanelWidgetState extends State<PanelWidget> {
  // Stores state parameters for panelBuilder
  bool open = false;
  bool onSlideCallState = false;
  Widget? _currentState;
  ScrollController? _sc;
  final _pc = PanelController();
  // Important search list parameters
  List<ParkingLocation> listedLocations = [];

  @override
  void initState() {
    super.initState();
    _currentState = const _StateLoading();
  }

  void onOpen() {
    setState(() {
      open = true;
    });
  }

  void onClose() {
    setState(() {
      open = false;
    });
  }

  Future<void> onSlide(double pos) async {
    // Close keyboard on close
    if (pos <= 0.9 && open) {
      // Solely exists to ensure keyboard closes
      FocusManager.instance.primaryFocus?.unfocus();
    }
    // Load list
    else if (_sc != null && (pos >= 0.1 && !open)) {
      if (listedLocations.isEmpty && _currentState is _StateLoading) {
        // listedLocations hasn't loaded from Firebase yet
        await ParkingDatabaseService.awaitParkingData().then((value) {
          for (final location in ParkingDatabaseService.parkingList) {
            listedLocations.add(location);
          }
        });
      }
      _currentState = _StateScrollingList(
        controller: _sc!,
        locationList: listedLocations,
      );
    }
    onSlideCallState = false;
  }

  void onHeaderTap() {
    _pc
        .animatePanelToPosition(
          /* position */ 1.0 / 50.0,
          duration: const Duration(milliseconds: 100),
        )
        .then(
          (value) => _pc.animatePanelToPosition(/* position */ 0.0,
              duration: const Duration(milliseconds: 100)),
        );
  }

  void onSearchBarChange(List<ParkingLocation> updatedList) {
    setState(() {
      listedLocations = updatedList;
      _currentState = _StateScrollingList(
        controller: _sc!,
        locationList: listedLocations,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    ======================================================
    ============= SLIDE UP PANEL PROPERTIES ==============
    ======================================================
    */
    return SlidingUpPanel(
        controller: _pc,
        backdropEnabled: true,
        backdropOpacity: 0.0,
        maxHeight: MediaQuery.of(context).size.height * (9/10),
        minHeight: MediaQuery.of(context).size.height * (1/11),
        parallaxEnabled: false,
        parallaxOffset: 0.4,
        body: const MapsWidget(),
        /*
        ===================================================
        ============= SLIDE UP PANEL HEADER  ==============
        ===================================================
        */
        header: GestureDetector(
          onTap: () => onHeaderTap(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * (1 / 11),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
              ),
              Positioned(
                height: MediaQuery.of(context).size.height * (1 / 12) - 20,
                width: MediaQuery.of(context).size.width - 36,
                top: 18.0,
                child: SearchBarWidget(
                  pc: _pc,
                  locationList: listedLocations,
                  notifyParent: onSearchBarChange,
                ),
              ),
              Positioned(
                top: 7.0,
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        panelBuilder: (ScrollController sc) => _getCurrentState(sc),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        onPanelOpened: () => onOpen(),
        onPanelClosed: () => onClose(),
        onPanelSlide: (double pos) {
          // Make sure onSlide isn't called excessively. VERY DETRIMENTAL IF SO.
          if (onSlideCallState == false) {
            onSlideCallState = true;
            onSlide(pos);
          }
        });
  }

  Widget _getCurrentState(ScrollController controller) {
    _sc = controller;
    return _currentState!;
  }
}

/*
  ============= ============== ==============
  =============  PANEL STATES  ==============
  ============= ============== ==============
*/
/*
    ========== INIT STATE ===========
 */
class _StateLoading extends StatelessWidget {
  const _StateLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

/*
    ========== SEARCH LIST STATE ===========
 */
class _StateScrollingList extends StatelessWidget {
  final ScrollController controller;
  final List<ParkingLocation> locationList;

  const _StateScrollingList({
    Key? key,
    required this.controller,
    required this.locationList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: locationList.length,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * (1 / 11),
        bottom: 12.0,
        left: 12.0,
        right: 12.0,
      ),
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          child: Card(
            child: ListTile(
              title: Text(locationList[i].name!),
              trailing: const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.lightBlue,
              ),
            ),
          ),
        );
      },
    );
  }
}
/*
    ========== LOCATION INFO STATE ===========
 */

