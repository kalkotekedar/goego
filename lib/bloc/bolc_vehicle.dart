import 'dart:convert';

import 'package:flutter_skills_test/model/vehicle_model.dart';
import 'package:flutter_skills_test/services/vehicle_service.dart';
import 'package:flutter_skills_test/utils/constatns.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

class VehicleBloc {
  List<Vehicle> allVehicles = [];
  final _allVehicleFetcher = PublishSubject<List<Vehicle>>();
  Stream<List<Vehicle>> get allVehiclesStream => _allVehicleFetcher.stream;

  fetchAllVehicles() async {
    try {
      Response res = await VehicleServices.fetchVehicles();
      if (res != null && res.statusCode == 200) {
        allVehicles.clear();
        var data = jsonDecode(res.body);
        var itemData = data['cars'] as List<dynamic>;
        var vehicles =
            itemData.take(10).map((v) => Vehicle.fromJson(v)).toList();
        allVehicles.addAll(vehicles);
        _allVehicleFetcher.sink.add(allVehicles);
      } else
        _allVehicleFetcher.addError(res.body);
    } catch (ex) {
      _allVehicleFetcher.addError(msg_something_went_wrong);
    }
  }
}

final vehicleBloc = VehicleBloc();
