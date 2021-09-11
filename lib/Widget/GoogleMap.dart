import 'dart:io';

import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapWidget extends StatefulWidget {
  final LatLng pos;
  final LatLng center;
  final bool select;

  MapWidget(this.pos,{this.select = false,this.center});

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
        child: Stack(
          children: [
            GoogleMap(
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
            // Expanded(
            //   child: Row(children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: InkWell(
            //         onTap: ()  {
            //           String origin =
            //               "${widget.center.latitude},${widget.center.longitude}"; // lat,long like 123.34,68.56
            //           String destination =
            //               "${widget.pos.latitude ?? "0.0"},${widget.pos.longitude ??" 0.0"}";
            //           print("now lanuch");
            //           Utils.lunchURL(
            //               "https://www.google.com/maps/dir/?api=1&origin=" +
            //                   origin +
            //                   "&destination=" +
            //                   destination);
            //         },
            //         child: Container(
            //           // decoration: BoxDecoration(
            //           //     color: AppColors.orange,
            //           //     borderRadius: BorderRadius.circular(50)),
            //           // child: Padding(
            //           //   padding: const EdgeInsets.all(8.0),
            //           //   child: Row(
            //           //     mainAxisSize: MainAxisSize.min,
            //           //     children: [
            //           //       Text(
            //           //         AppLocalizations.of(context)
            //           //             .trans("direction"),
            //           //         style: AppTextStyle.mediumWhiteBold,
            //           //       ),
            //           //       SizedBox(
            //           //         width: 16,
            //           //       ),
            //           //       Icon(
            //           //         Icons.location_on,
            //           //         size: 24,
            //           //         color: AppColors.white,
            //           //       )
            //           //     ],
            //           //   ),
            //           // ),
            //         ),
            //       ),
            //     ),
            //   ],),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    iniMap();
    super.initState();
  }

  iniMap() async {
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
