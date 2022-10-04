class Sensor{
  Sensor({required this.name, this.temperature}) {
    id = name.hashCode;
  }

  late int id;
  String name;
  double? temperature;

  @override
  String toString() {
    return 'Sensor Id: $id, Sensor Name: $name, Sensor Temp: $temperature';
  }
}