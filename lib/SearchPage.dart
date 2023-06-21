
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<List<dynamic>> medicineData;
  List<List<dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    loadCsvData().then((data) {
      setState(() {
        medicineData = data;
      });
    });
  }

  Future<List<List<dynamic>>> loadCsvData() async {
    final String response =
    await rootBundle.loadString('assets/medicine_data.csv');
    final List<List<dynamic>> csvTable =
    const CsvToListConverter().convert(response);
    return csvTable;
  }

  void searchMedicine(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      searchResults = medicineData.where((medicine) {
        final name = medicine[0].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  void showMedicineDetails(List<dynamic> medicine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicineDetailsPage(medicine: medicine),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: searchMedicine,
              decoration: const InputDecoration(
                labelText: 'Search Medicine',
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final medicine = searchResults[index];
                  final medName = medicine[0].toString();

                  return ListTile(
                    title: Text(medName),
                    onTap: () => showMedicineDetails(medicine),
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

class MedicineDetailsPage extends StatelessWidget {
  final List<dynamic> medicine;

  const MedicineDetailsPage({Key? key, required this.medicine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final medName = medicine[0].toString();
    final price = medicine[1].toString();
    final activeSalt = medicine[2].toString();
    final packSize = medicine[3].toString();
    final productDescription = medicine[4].toString();
    final sideEffect = medicine[5].toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(medName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                medName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Price:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(price),
            const SizedBox(height: 8),
            const Text(
              'Active Salt:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(activeSalt),
            const SizedBox(height: 8),
            const Text(
              'Pack Size:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(packSize),
            const SizedBox(height: 8),
            const Text(
              'Product Description:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(productDescription),
            const SizedBox(height: 8),
            const Text(
              'Side Effect:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(sideEffect),
          ],
        ),
      ),
    );
  }
}

