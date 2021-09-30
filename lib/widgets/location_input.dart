import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocatoinInput extends StatefulWidget {
  final Function ambillok;
  const LocatoinInput({Key key, this.ambillok}) : super(key: key);

  @override
  _LocatoinInputState createState() => _LocatoinInputState();
}

class _LocatoinInputState extends State<LocatoinInput> {
  double lat;
  double long;
  Future<void> getLocation() async {
    final locData = await Location().getLocation();
    setState(() {
      lat = locData.latitude;
      long = locData.longitude;
    });
    widget.ambillok(locData.latitude, locData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          width: double.infinity,
          alignment: Alignment.center,
          child: lat == null
              ? const Text(
                  'No Location Was found',
                  textAlign: TextAlign.center,
                )
              : FlutterMap(
                  options: MapOptions(
                    center: LatLng(lat, long),
                    zoom: 13.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://api.mapbox.com/styles/v1/hiro777/cku6o4apo0j9k17o4zsu3ai5x/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGlybzc3NyIsImEiOiJja3U2bWxsNmYycGF1MnRvcTBwanV2ZXQzIn0.ubaAsXmQnWbNz36pjoNaUQ",
                      additionalOptions: {
                        'access-token':
                            'pk.eyJ1IjoiaGlybzc3NyIsImEiOiJja3U2bWxsNmYycGF1MnRvcTBwanV2ZXQzIn0.ubaAsXmQnWbNz36pjoNaUQ',
                      },
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(lat, long),
                            builder: (ctx) => const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                )),
                      ],
                    ),
                  ],
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: getLocation,
              icon: const Icon(Icons.location_on),
              label: const Text(
                'Current Location',
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text(
                'Select On Map',
                style: TextStyle(color: Colors.indigo),
              ),
            ),
          ],
        )
      ],
    );
  }
}
