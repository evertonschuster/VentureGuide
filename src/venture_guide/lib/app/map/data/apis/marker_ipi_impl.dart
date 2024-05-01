import 'package:injectable/injectable.dart';
import 'package:venture_guide/app/map/domain/api/marker_api.dart';
import 'package:venture_guide/app/map/domain/models/marker.dart';
import 'package:cloud_functions/cloud_functions.dart';

class RequestData<T>{
  final T data;

  RequestData(this.data);
}

@Injectable(as: MarkerApi)
class MarkerApiImpl extends MarkerApi {

  @override
  Future<List<Marker>> getNearbyPlaces(double lat, double lng) async {
    final callable = FirebaseFunctions.instance.httpsCallable('getNearbyPlaces');
    final response = await callable.call<List<Object?>>({'latitude': lat, "longitude" : lng});

    List<Marker> markers = [];
    List<Object?> data = response.data;
    markers = data.map((item) => Marker.fromJson(item as Map<Object?, Object?>)).toList();
  
    return markers;
  }
  
  @override
  Future<List<Marker>> getPlaces(int titleX, int titleY) async {
    final callable = FirebaseFunctions.instance.httpsCallable('getPlaces');
    final response = await callable.call<List<Object?>>({'titleX': titleX, "titleY" : titleY});

    List<Marker> markers = [];
    List<Object?> data = response.data;
    markers = data.map((item) => Marker.fromJson(item as Map<Object?, Object?>)).toList();
  
    return markers;
  }
}