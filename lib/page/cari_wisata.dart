import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class CariWisata extends StatefulWidget {
  const CariWisata({super.key});

  @override
  State<CariWisata> createState() => _CariWisataState();
}

class _CariWisataState extends State<CariWisata> {
  String latitude = 'Latitude';
  String longitude = 'Longitude';

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
          center: LatLong(-8.172376, 113.716374),
          buttonColor: Colors.blue,
          // buttonText: 'Set Current Location',
          onPicked: (pickedData) {}),
    );
  }
}
