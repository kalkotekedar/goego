import 'package:flutter_skills_test/model/vehicle_model.dart';
import 'package:flutter_skills_test/screens/vehivle_details.dart';
import 'package:flutter_skills_test/utils/utils.dart';
import 'package:flutter_skills_test/widget/item_loader.dart';
import 'package:flutter_skills_test/bloc/bolc_vehicle.dart';
import 'package:flutter_skills_test/utils/constatns.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Vehicles extends StatefulWidget {
  static String tag = "/vehicles";

  @override
  _VehicleState createState() => _VehicleState();
}

class _VehicleState extends State<Vehicles> {
  List<Vehicle> vehicles = [];
  viewVehicle(BuildContext context, List<Vehicle> vehicles, int index) {
    return ListTile(
      leading: Image.asset('assets/logo.jpg', height: 96),
      title: appText(vehicles[index].carModel, size: 20, isBold: true),
      subtitle: appText(
          '${vehicles[index].carModelYear} | ${vehicles[index].carColor}'),
      onTap: () async {
        var res = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VehicleDetails(vehicles, index: index),
          ),
        );
        if (res != null)
          setState(() {
            vehicleBloc.allVehicles.clear();
            vehicleBloc.allVehicles.addAll(vehicles);
          });
      },
    );
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> refreshList() async {
    loadData();
    return;
  }

  loadData() {
    vehicleBloc.fetchAllVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t_vehicle_catalog)),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Column(
          children: <Widget>[
            Flexible(
              child: StreamBuilder(
                stream: vehicleBloc.allVehiclesStream,
                builder: (context, AsyncSnapshot<List<Vehicle>> snapshot) {
                  if (snapshot.hasData) {
                    List<Vehicle> data = snapshot.data.toList();
                    if (snapshot.data.length == 0)
                      return Center(
                        child: appText(msg_no_vehicles_found),
                      );
                    else {
                      if (data.length == 0)
                        return ListItemLoader(
                          size: 50,
                          lines: 1,
                          screenHeight: MediaQuery.of(context).size.height,
                        );

                      return ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: data.length,
                        separatorBuilder: (context, index) => Container(
                          child: Divider(color: Colors.greenAccent),
                          height: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return viewVehicle(context, data, index);
                        },
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  return ListItemLoader(
                    size: 50,
                    lines: 1,
                    screenHeight: MediaQuery.of(context).size.height,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
