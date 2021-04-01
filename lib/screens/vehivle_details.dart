import 'package:flutter_skills_test/utils/constatns.dart';
import 'package:flutter_skills_test/utils/utils.dart';
import 'package:flutter_skills_test/widget/colored_button.dart';
import 'package:flutter_skills_test/model/vehicle_model.dart';
import 'package:flutter_skills_test/widget/car_spec_row.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class VehicleDetails extends StatefulWidget {
  static String tag = "/vehicleDetails";

  final List<Vehicle> vehicles;
  final int index;
  VehicleDetails(this.vehicles, {this.index = 0});

  @override
  _VehicleDetailsState createState() =>
      _VehicleDetailsState(this.vehicles, this.index);
}

class _VehicleDetailsState extends State<VehicleDetails> {
  bool _isEdit = false;
  final _formKey = GlobalKey<FormState>();
  final List<Vehicle> vehicles;
  Vehicle currentVehicle;
  int totalCount = 0;
  int index;

  _VehicleDetailsState(this.vehicles, this.index) {
    totalCount = vehicles.length;
    if (index < 0 || index > totalCount)
      Navigator.pop(context, msg_vehicle_not_found);
    else
      currentVehicle = vehicles[index];
  }

  previousVehicle() {
    setState(() {
      index--;
      currentVehicle = vehicles[index];
    });
  }

  nextVehicle() {
    setState(() {
      index++;
      currentVehicle = vehicles[index];
    });
  }

  deleteCar() {
    setState(() {
      vehicles.removeAt(index);
      totalCount = vehicles.length;
      index = index + 1 < totalCount ? index++ : --index;
      if (index == -1) {
        vehicles.clear();
        Navigator.pop(context, vehicles);
      }
      if (index > 0) currentVehicle = vehicles[index];
    });
  }

  editCar() {
    setState(() {
      _isEdit = true;
    });
  }

  updateVehicle() {
    final form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        _formKey.currentState.save();
        _isEdit = false;
      });
    }
  }

  Future<bool> goBack() async {
    Navigator.pop(context, vehicles);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: goBack,
      child: Scaffold(
        appBar: AppBar(title: Text(currentVehicle.carModel)),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  'assets/logo.jpg',
                  height: MediaQuery.of(context).size.width / 3,
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    index > 0
                        ? IconButton(
                            icon: Icon(Icons.arrow_left),
                            onPressed: previousVehicle,
                            iconSize: 48,
                          )
                        : SizedBox(width: 48),
                    Expanded(
                      child: Center(
                        child: Text(
                          'CAR',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    index < totalCount - 1
                        ? totalCount != 1
                            ? IconButton(
                                icon: Icon(Icons.arrow_right),
                                onPressed: nextVehicle,
                                iconSize: 48,
                              )
                            : SizedBox(width: 48)
                        : SizedBox(width: 48)
                  ],
                ),
                const SizedBox(height: 20),
                _isEdit
                    ? Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: t_car_model,
                                ),
                                onChanged: (val) {
                                  if (currentVehicle.carModel != val)
                                    currentVehicle.carModel = val;
                                },
                                validator:
                                    RequiredValidator(errorText: t_required),
                                initialValue: currentVehicle.carModel,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: t_color,
                                ),
                                onChanged: (val) {
                                  if (currentVehicle.carColor != val)
                                    currentVehicle.carColor = val;
                                },
                                validator:
                                    RequiredValidator(errorText: t_required),
                                initialValue: currentVehicle.carColor,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: t_year,
                                ),
                                onChanged: (val) {
                                  currentVehicle.carModelYear = int.parse(val);
                                },
                                validator: RangeValidator(
                                  min: 1900,
                                  max: 2100,
                                  errorText: 'Enter valid year',
                                ),
                                initialValue:
                                    currentVehicle.carModelYear != null
                                        ? currentVehicle.carModelYear.toString()
                                        : "",
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: t_price,
                                ),
                                onChanged: (val) => currentVehicle.price = val,
                                validator:
                                    RequiredValidator(errorText: t_required),
                                initialValue: currentVehicle.price,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: t_vin,
                                ),
                                onChanged: (val) {
                                  if (currentVehicle.carVin != val)
                                    currentVehicle.carVin = val;
                                },
                                validator:
                                    RequiredValidator(errorText: t_required),
                                textCapitalization:
                                    TextCapitalization.characters,
                                initialValue: currentVehicle.carVin,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  appText(t_availablity),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  Switch(
                                    onChanged: (bool cb) {
                                      setState(() {
                                        currentVehicle.availability = cb;
                                      });
                                    },
                                    value: currentVehicle.availability,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          CarItem(t_car_model, currentVehicle.carModel),
                          CarItem(t_color, currentVehicle.carColor),
                          CarItem(t_year, '${currentVehicle.carModelYear}'),
                          CarItem(t_vin, currentVehicle.carVin),
                          CarItem(t_price, currentVehicle.price),
                          CarItem(
                            t_availablity,
                            currentVehicle.availability
                                ? t_available
                                : t_not_available,
                          ),
                        ],
                      ),
                SizedBox(height: 20),
                _isEdit
                    ? Row(
                        children: [
                          Expanded(
                              child: ColoredButton(t_cancel, () {
                            setState(() {
                              _isEdit = false;
                            });
                          })),
                          const SizedBox(width: 10),
                          Expanded(child: ColoredButton(t_save, updateVehicle))
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(child: ColoredButton(t_delete, deleteCar)),
                          const SizedBox(width: 10),
                          Expanded(child: ColoredButton(t_edit, editCar))
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
