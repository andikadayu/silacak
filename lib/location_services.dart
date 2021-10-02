// class LocationServices{
//   Future<String> getCoordinate()async{
//     Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   }
// }
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  Future<String> getCoordinate() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);

    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var alamat = addresses.first;

    return alamat.addressLine;
  }

  Future<double> getLat() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = position.latitude;
    return coordinates;
  }

  Future<double> getLong() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = position.longitude;
    return coordinates;
  }
}