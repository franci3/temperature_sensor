import 'dart:io';

class TemperatureSensorController {
  final pathToReaderExecutable = 'lib/util/bin/temp_sensor';

  Future<List<String>> getSensorNames() async {
    final Process sensorNamesProcess =
        await Process.start(pathToReaderExecutable, ['n']);
    try {
      return _transformStdOutToSensorNames(
          await sensorNamesProcess.stdout.first);
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  List<String> _transformStdOutToSensorNames(List<int> charCodes) {
    final String sensorNames = String.fromCharCodes(charCodes);
    final List<String> splittedSensorNames = sensorNames.split('_');
    return splittedSensorNames;
  }

  Future<List<double?>> getSensorValues() async {
    final Process sensorValuesProcess =
        await Process.start(pathToReaderExecutable, ['v']);
    try {
      return _transformStdOutToSensorValues(
          await sensorValuesProcess.stdout.first);
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  List<double?> _transformStdOutToSensorValues(List<int> charCodes) {
    final String sensorValues = String.fromCharCodes(charCodes);
    final List<String> splittedSensorValues = sensorValues.split('_');
    final List<double?> sensorValueList = splittedSensorValues
        .map((sensorTempererature) => double.tryParse(sensorTempererature))
        .toList();
    return sensorValueList;
  }
}
