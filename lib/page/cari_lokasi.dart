import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:travelgo/page/beranda.dart';
import 'package:travelgo/services/auth_service.dart';

class CariLokasi extends StatefulWidget {
  const CariLokasi({super.key});

  @override
  State<CariLokasi> createState() => _CariLokasiState();
}

class _CariLokasiState extends State<CariLokasi> {
  final _mapController = MapController(initMapWithUserPosition: true);

  var markerMap = <String, String>{};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.listenerMapSingleTapping.addListener(() async {
        var position = _mapController.listenerMapSingleTapping.value;
        if (position != null) {
          await _mapController.addMarker(position,
              markerIcon: const MarkerIcon(
                icon: Icon(
                  Icons.pin_drop,
                  color: Colors.blue,
                  size: 40,
                ),
              ));
          var key = '${position!.latitude}.${position!.longitude}';
          markerMap[key] = markerMap.length.toString();
        }
      });
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lokasi saat ini'),
        ),
        body: SafeArea(
            child: OSMFlutter(
          controller: _mapController,
          mapIsLoading: const Center(
            child: CircularProgressIndicator(),
          ),
          trackMyPosition: true,
          initZoom: 12,
          minZoomLevel: 4,
          maxZoomLevel: 18,
          stepZoom: 1.0,
          androidHotReloadSupport: true,
          userLocationMarker: UserLocationMaker(
              personMarker: const MarkerIcon(
                icon: Icon(
                  Icons.personal_injury,
                  color: Colors.red,
                ),
              ),
              directionArrowMarker: const MarkerIcon(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              )),
          roadConfiguration: const RoadOption(roadColor: Colors.blue),
          markerOption: MarkerOption(
              defaultMarker: MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.red,
              size: 2000,
            ),
          )),
          onMapIsReady: (isReady) async {
            if (isReady) {
              await Future.delayed(const Duration(seconds: 1), () async {
                await _mapController.currentLocation();
              });
            }
          },
          onGeoPointClicked: (geoPoint) {
            var key = '${geoPoint.latitude}, ${geoPoint.longitude}';
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Position ${markerMap[key]}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                Text(key)
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.clear),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        )));
  }
}
