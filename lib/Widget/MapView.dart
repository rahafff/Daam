import 'package:first_card_project/Helper/AppColors.dart';
import 'package:first_card_project/Helper/AppTextStyle.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Widget/CustomAppButton.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final Function(double,double) onChanged;
  MapView({this.onChanged});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _center = LatLng(33.5155067,36.2819488);
  Set<Marker> _markers = {};

  @override
  void initState() {
    getLocation();
    super.initState();
  }
  getLocation(){
    Geolocator.getCurrentPosition().then((value) {
      if(value!= null)
        {

          print("hi");
          _center = LatLng(value.latitude, value.longitude);
        }
      if(mounted) setState(() {
        if(_controller.isCompleted){
          _controller.future.then((con) {
            con.moveCamera(CameraUpdate.newLatLng(_center));
          });
        }
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: helper.mainAppBar(context, ""),
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              onTap: (long) {
                addMarker(long.latitude, long.longitude);
                if(widget.onChanged != null)
                  widget.onChanged(long.latitude, long.longitude);
              },
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 16.0,
              ),
//                              circles:circles ,
              mapType: MapType.normal,
              markers: _markers,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomAppButton(
                color: AppColors.orange,
                child: Text(AppLocalizations.of(context).trans("ok"),style: AppTextStyle.mediumWhiteBold,),
                padding: EdgeInsets.symmetric(vertical: 8 , horizontal: 16),
                onTap: (){
                  Navigator.of(context).pop();
                },
                borderRadius: 20,
              ),
            ),
          )
        ],
      ),
    );
  }


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void addMarker(latitude, longitude) {
    _markers = {};
    _markers.add(Marker(
        markerId: MarkerId('marker'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        position: LatLng(latitude, longitude),
        onTap: () {},
        draggable: true));
    setState(() {});
  }
}
