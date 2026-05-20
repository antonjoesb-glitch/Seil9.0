import 'package:flutter/material.dart';
import 'venue_map_stub.dart' if (dart.library.html) 'venue_map_web.dart';

class VenueMap extends StatelessWidget {
  const VenueMap({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: getVenueMap(),
      ),
    );
  }
}
