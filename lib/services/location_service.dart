import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;



class LocationData {

  final double latitude;

  final double longitude;

  final String city;

  final String country;



  const LocationData({

    required this.latitude,

    required this.longitude,

    required this.city,

    required this.country,

  });

}





class LocationService {


  const LocationService();





  Future<LocationData?> getLocation() async {


    try {


      LocationPermission permission =
          await Geolocator.checkPermission();



      if(permission == LocationPermission.denied){

        permission =
            await Geolocator.requestPermission();

      }



      if(permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever){

        return null;

      }





      final Position position =
          await Geolocator.getCurrentPosition(

            desiredAccuracy:
                LocationAccuracy.high,

          );




      final place =
          await _getCityCountry(

            position.latitude,

            position.longitude,

          );



      return LocationData(

        latitude: position.latitude,

        longitude: position.longitude,

        city: place['city'] ?? "Unknown",

        country: place['country'] ?? "Unknown",

      );



    } catch(e){


      print(
        "Location Error: $e",
      );


      return null;

    }


  }






  Future<Map<String,String>> _getCityCountry(

    double lat,

    double lon,

  ) async {


    try {


      final url = Uri.parse(

        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon',

      );



      final response = await http.get(

        url,

        headers: {

          'User-Agent':
              'Sky Trails App',

        },

      );




      final data =
          jsonDecode(response.body);




      final address =
          data['address'];



      return {


        'city':

            address['city']
            ??
            address['town']
            ??
            address['village']
            ??
            "Unknown",



        'country':

            address['country']
            ??
            "Unknown",


      };



    } catch(e){


      print(
        "Reverse Geocode Error: $e",
      );


      return {

        'city': "Unknown",

        'country': "Unknown",

      };


    }


  }



}