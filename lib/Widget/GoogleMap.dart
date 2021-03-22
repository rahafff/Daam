import 'dart:io';

import 'package:first_card_project/Helper/Utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapWidget extends StatefulWidget {
  final LatLng pos;
  final bool select;

  MapWidget(this.pos, {this.select = false});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  List<Marker> markers = List();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.pos.latitude, widget.pos.longitude),
              zoom: 15),
          onTap: (latlang) {
            if (!widget.select) return;
            if (markers.isEmpty) {
              markers.add(Marker(
                markerId: MarkerId("myLocation"),
                position: latlang,
              ));
            } else
              markers[0] = Marker(
                markerId: MarkerId("myLocation"),
                position: latlang,
              );
            setState(() {});
          },
          markers: markers.toSet(),
        ),
      ),
    );
  }

  @override
  void initState() async {
    if (!widget.select)
      markers.add(Marker(
          markerId: MarkerId("address"),
          position: widget.pos,
          onTap: () async {
            if (Platform.isIOS) {
              if (await canLaunch(
                  "comgooglemaps://?saddr=&daddr=${widget.pos.latitude},${widget.pos.longitude}")) {

                Utils.lunchURL("comgooglemaps://?saddr=&daddr=${widget.pos.latitude},${widget.pos.longitude}");
              }
              else {
                Utils.lunchURL(
                    "https://maps.apple.com/?q=${widget.pos.latitude},${widget.pos.longitude}");
              }


            }
          }));
    super.initState();
  }
}
