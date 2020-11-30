class Prescription {
  String id;
  String prescriptionName;
  String givenBy;
  DateTime dateGiven;
  List<Map<String, dynamic>> recipes;

  Prescription({
    this.id,
    this.prescriptionName,
    this.givenBy,
    this.dateGiven,
    this.recipes,
  });
}
