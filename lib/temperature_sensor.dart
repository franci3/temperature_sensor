library temperature_sensor;

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:temperature_sensor/util/models/sensor_model.dart';
import 'package:temperature_sensor/util/temperature_sensor_controller.dart';

///TemperatureSensor API
class TemperatureSensor {

  TemperatureSensor({this.interval = 3}){
    _temperatureSensorController = TemperatureSensorController();
  }

  ///Sets the interval for getting fresh values in seconds
  int interval;
  late TemperatureSensorController _temperatureSensorController;

  Future<List<Sensor>> _getSensorData() async {
    return await _getTransformedRawData();
  }

  Future<List<Sensor>> _getTransformedRawData() async {
    final List<String> sensorNames = await _temperatureSensorController.getSensorNames();
    final List<double?> sensorValues = await _temperatureSensorController.getSensorValues();
    return IterableZip([sensorNames, sensorValues]).map((values) {
      return Sensor(name: values[0].toString(), temperature: values[1] as double?);
    }).toList();
  }

  ///Start reading Sensor Data with previously set interval
  Stream<List<Sensor>> startReadingSensorData() async* {
    yield* Stream.periodic(Duration(seconds: interval), (_) {
      return _getSensorData();
    }).asyncMap((event) async => await event);
  }
}
