import 'package:first_card_project/Bloc/ServiceProvidersBloc.dart';
import 'package:first_card_project/Localization/AppLocal.dart';
import 'package:first_card_project/Models/NearestServiceProvidersModel.dart';
import 'package:first_card_project/UI/BaseUI.dart';
import 'package:first_card_project/UI/ServiceProviders/ServiceProviderDetails.dart';
import 'package:first_card_project/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearestServiceProvider extends BaseUI<ServiceProvidersBloc> {
  @override
  _NearestServiceProviderState createState() => _NearestServiceProviderState();
  NearestServiceProvider():super(bloc: ServiceProvidersBloc());

}

class _NearestServiceProviderState extends BaseUIState<NearestServiceProvider> {
  BitmapDescriptor pinLocationIconM;
  BitmapDescriptor pinLocationIconC;

  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(context, AppLocalizations.of(context).trans("placesNearYou"));

  }
  void setCustomMapPin() async {
    pinLocationIconM = await BitmapDescriptor.fromAssetImage(

        ImageConfiguration(size: Size(120, 120)),
        'assets/images/lo.png');
    pinLocationIconC = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(120, 120)),
        'assets/images/x.png');
  }
  @override
  Widget buildUI(BuildContext context) {
    return StreamBuilder<NearestServiceProvidersModel>(
      stream: widget.bloc.nearestServiceProvidersStream,
        builder: (context,snapshot){

        if(snapshot.hasData){
          return GoogleMap(
              initialCameraPosition:CameraPosition(//24.657026, 46.641068 // 24.858797,46.7927103
                target: LatLng(widget.bloc.pos?.latitude?? /*33.5155067*/24.858797,widget.bloc.pos?.longitude??/*36.2819488*/46.7927103),zoom: 14
              ),
            myLocationEnabled: true,
            markers: snapshot.data.data.map((e) => Marker(
              markerId: MarkerId(e.id.toString()),

              position: LatLng(double.parse(e?.latitude??"0.0"), double.parse(e?.longitude??"0.0")),
              icon:e.networkId == 2 ? pinLocationIconM :pinLocationIconC,
              infoWindow: InfoWindow(
                title: e.businessName,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ServiceProviderDetails(providerId: e.id.toString(),bloc: ServiceProvidersBloc(),)));
                }
              )

            )).toSet(),
          );
        }
        return Center(child: CircularProgressIndicator(),);
    });
  }

  @override
  void init() {
    widget.bloc.getNearestServiceProviders();
    setCustomMapPin();
  }

}
