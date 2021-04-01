import 'package:flutter_skills_test/services/generic_service.dart';
import 'package:flutter_skills_test/utils/constatns.dart';
import 'package:http/http.dart';

class VehicleServices extends GenericService {
  static VehicleServices _instance = VehicleServices._();

  VehicleServices._();

  static Future<Response> fetchVehicles() async {
    try {
      Response res = await _instance.getData(BASE_URL + E_GET_CARS);
      return res;
    } catch (ex) {
      return Response(msg_something_went_wrong, 400);
    }
  }
}
