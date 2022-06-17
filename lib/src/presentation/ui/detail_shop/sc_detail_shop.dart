import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/domain/entities/shop/shop.dart';

import '../../../config/styles/app_text_style.dart';
import '../../views/components/app_bar/main_app_bar.dart';

class ScDetailShop extends StatefulWidget {
  final Shop argument;

  const ScDetailShop({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  _ScDetailShopState createState() => _ScDetailShopState();
}

class _ScDetailShopState extends State<ScDetailShop> {
  Completer<GoogleMapController> _controller = Completer();

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  //
  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: widget.argument.name ?? "Không xác định",
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${widget.argument.wardName != null ? widget.argument.wardName != "" ? widget.argument.wardName.toString() + ', ' : "" : ""}",
                      style: TextStyleApp.textStyle4.copyWith(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "${widget.argument.districtName != null ? widget.argument.districtName != "" ? widget.argument.districtName.toString() + ', ' : "" : ""}",
                      style: TextStyleApp.textStyle4.copyWith(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "${widget.argument.provinceName != null ? widget.argument.provinceName != "" ? widget.argument.provinceName.toString() + '.' : "" : ""}",
                      style: TextStyleApp.textStyle4.copyWith(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.argument.phone != null
                          ? widget.argument.phone != ""
                              ? widget.argument.phone.toString()
                              : "Không xác định"
                          : "Không xác định",
                      style: TextStyleApp.textStyle4.copyWith(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(21.0091053, 105.8542397),
                  zoom: 17,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId(
                      widget.argument.name ?? "Không xác định",
                    ),
                    position: LatLng(21.0091053, 105.8542397),
                    infoWindow: InfoWindow(
                      title: widget.argument.name ?? "Không xác định",
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                  )
                }),
          ),
        ],
      ),
    );
  }
}
