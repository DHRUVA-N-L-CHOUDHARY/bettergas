import 'dart:async';
import 'dart:convert';
import 'package:bettergas_assignment/app/data/models/Product_info_model.dart';
import 'package:bettergas_assignment/app/data/models/nearby_locations_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/remote/api_service.dart';
import 'package:google_places_flutter_api/google_places_flutter_api.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_google_maps_webservices/places.dart';

class SearchScreenController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxString search = "".obs;
  final RxBool isLoading = false.obs;
  RxString city = "Select Location".obs;
  RxBool getloc = true.obs;
  RxBool nonearbyLoc = true.obs;
  RxBool isSearch = false.obs;
  String? lati;
  String? longi;
  RxString radius = "100".obs;
  List<ProductInfoModel> products_info = List.empty(growable: true);
  RxString? kGoogleApiKey = "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0".obs;
  String currentAddress = "Choose Location";
  RxBool showLocLoader = false.obs;
  int pageingnumb = 1;
  int maxpages = 0;
  Timer? debounce;
  Position currentPosition = Position(
      longitude: 9.15635270,
      latitude: 7.35294650,
      timestamp: DateTime.now(),
      accuracy: 100,
      altitude: 0,
      altitudeAccuracy: 100,
      heading: 0,
      headingAccuracy: 100,
      speed: 0,
      speedAccuracy: 100);
  List<LocationModel> locations = [];

  Future<void> handlePressButton(context) async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      hint: "Search location",
      apiKey: kGoogleApiKey!.value,
      onError: (PlacesAutocompleteResponse res) {
        debugPrint("Places error ${res.errorMessage}");
      },
      types: [""],
      mode: Mode.overlay,
      strictbounds: false,
      language: "en",
      components: [Component(Component.country, "ng")],
    );
    print("---------dsfsdf-sdf---------");
    if (p != null) {
      displayPrediction(p);
    } else {
      showLocLoader(false);
      update();
    }
  }

  Future<void> displayPrediction(Prediction p) async {
    try {
      showLocLoader(true);
      update();
      if (p != null) {
        // get detail (lat/lng)
        GoogleMapsPlaces places = GoogleMapsPlaces(
          apiKey: kGoogleApiKey!.value,
          apiHeaders: await const GoogleApiHeaders().getHeaders(),
        );
        PlacesDetailsResponse detail =
            await places.getDetailsByPlaceId(p.placeId!);
        final lat = detail.result.geometry!.location.lat;
        final lng = detail.result.geometry!.location.lng;

        MySharedPref.setlati(lat.toString());
        MySharedPref.setlongi(lng.toString());
        List<geo.Placemark> placemarks =
            await geo.placemarkFromCoordinates(lat, lng);

        geo.Placemark placemark = placemarks[0];
        debugPrint("placemark ${placemark.locality}");
        //city = placemark.locality;
        MySharedPref.setcity(placemark.locality!);

        city.value = placemark.locality!;
        print(lat);
        print(lng);
        lati = lat.toString();
        longi = lng.toString();
        currentPosition = Position(
            longitude: lng,
            latitude: lat,
            timestamp: DateTime.now(),
            altitudeAccuracy: 0.0,
            headingAccuracy: 0.0,
            accuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0);
        showLocLoader(false);
        _getAddressFromLatLng(currentPosition);
        getData(pageingnumb, false);
        getloc(false);
        update();
      } else {
        showLocLoader(false);
        update();
        debugPrint("display predictions else ");
      }
    } on Exception catch (e) {
      showLocLoader(false);
      update();
      Get.snackbar("Unable to update location", e.toString());
    }
  }

  @override
  void onInit() async {
    super.onInit();
    isLoading(true);
    //  scrollController.addListener(() async {
    //   if (scrollController.position.pixels ==
    //           scrollController.position.maxScrollExtent &&
    //       pageingnumb < (maxpages - 1)) {
    //     await getData(++pageingnumb, false);
    //   }
    // });
    textEditingController.addListener(onSearchChanged);

    await getCurrentPosition();
    isLoading(false);
  }

  onSearchChanged() {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      onSearchTextChanged();
    });
  }

  void onSearchTextChanged() async {
    if (textEditingController.text.isEmpty) {
      isSearch.value = false;
    } else {
      isSearch.value = true;
    }
    await getData(pageingnumb, isSearch.value);
    update();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      Get.snackbar(
        'Message',
        'Location services are disabled. Please enable the services',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10.0,
        margin: const EdgeInsets.all(10.0),
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      await getData(pageingnumb, false);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          'Message',
          'Location permissions are denied',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10.0,
          margin: const EdgeInsets.all(10.0),
          isDismissible: true,
          duration: const Duration(seconds: 2),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        'Message',
        'Location permissions are permanently denied, we cannot request permissions.',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10.0,
        margin: const EdgeInsets.all(10.0),
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );

      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      _getAddressFromLatLng(position);
      getData(pageingnumb, false);
      update();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = "${place.locality}";
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getData(int pagenum, bool isSearch) async {
    try {
      Map<String, dynamic> data = {};
      if (!isSearch) {
        data = {
          "lat": currentPosition.latitude.toString(),
          "long": currentPosition.longitude.toString(),
          "distance": radius.value.toString(),
          "page": pagenum
        };
        update();
      } else {
        data = {"search_loc": textEditingController.text};
      }
      debugPrint("nearby req data $data");
      dynamic res = await ApiService().getSearchNearByLoc(data, isSearch);
      res = jsonDecode(res.body);
      print(res["data"].toString());
      locations = [];
      if (res["data"] != null) {
        if (res["data"] != "no_data") {
          print("---------------------");
          if (res["data"]["product"] != null) {
            List<dynamic> variations = res["data"]["product"]["variations"];
            for (var variation in variations) {
              products_info.add(ProductInfoModel(
                variationId: variation["variation_id"].toString(),
                displayPrice: variation["display_price"].toString(),
                weight: variation["weight"].toString(),
              ));
            }
          }
          update();
          print("---------------------");
          print(res["data"]["terms"]);
          for (var item in res["data"]["terms"]) {
            if (item['name'] != null) {
              String filteredName = item["name"]
                  .split(" ")
                  .where((word) => (word != "Better" && word != "Gas"))
                  .join(" ");
              print(filteredName);
              item["name"] = filteredName;
              locations.add(LocationModel.fromJson(item));
            }
          }
        }
      } else {
        nonearbyLoc(true);
      }
      print(locations);
      if (locations.length != 0) {
        nonearbyLoc(false);
        print(products_info.length);
        update();
      } else {
        nonearbyLoc(true);
      }
      update();
    } catch (e) {
      rethrow;
    }
  }
}
