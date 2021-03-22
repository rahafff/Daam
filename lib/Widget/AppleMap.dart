import 'dart:io';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:first_card_project/Helper/Utils.dart';
import 'package:flutter/material.dart';

class AppleMapWidget extends StatefulWidget {

  final LatLng pos;
  final bool select;
  AppleMapWidget(this.pos,{this.select = false});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<AppleMapWidget> {
  List<Annotation> markers=List();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8),
      child: Container(
        child: AppleMap(
          //mapToolbarEnabled: true,
            myLocationButtonEnabled: true,
          // myLocationEnabled: true,
          mapType: MapType.standard,
          // indoorViewEnabled: true,
          // zoomControlsEnabled: true,
          // trafficEnabled: true,
          // mapToolbarEnabled:true,
          scrollGesturesEnabled: widget.select,
          initialCameraPosition: CameraPosition(target: LatLng(widget.pos.latitude, widget.pos.longitude),zoom: 15),
          onTap: (latlang){
            if(!widget.select) return;
            if(markers.isEmpty)
            {
              markers.add(Annotation(
                  annotationId: AnnotationId("myLocation"),
                  position: latlang,
                  onTap: (){
                    print("lunch");

                    if(Platform.isIOS){
                      print("lunch");
                      print("https://maps.apple.com/?q=${latlang.latitude},${latlang.longitude}");
                      Utils.lunchURL("https://maps.apple.com/?q=${latlang.latitude},${latlang.longitude}");
                    }
                  }
              ));
            }
            else markers[0] = Annotation(
                annotationId: AnnotationId("myLocation"),
                position: latlang,
                onTap: (){
                  print("lunch");

                  if(Platform.isIOS){
                    print("lunch");
                    print("https://maps.apple.com/?q=${latlang.latitude},${latlang.longitude}");
                    Utils.lunchURL("https://maps.apple.com/?q=${latlang.latitude},${latlang.longitude}");
                  }
                }
            );
            setState(() {

            });
          },
          annotations: markers.toSet(),
        ),
      ),
    );
  }

  @override
  void initState() {
    if(!widget.select)
      markers.add(Annotation(annotationId: AnnotationId("address") , position: widget.pos));
    super.initState();
  }
}
