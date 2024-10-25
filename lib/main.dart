import 'package:flutter/material.dart';

void main() {
  runApp(TaxiApp());
}

class TaxiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Class Taxi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaxiForm(),
    );
  }
}

class TaxiForm extends StatefulWidget {
  @override
  _TaxiFormState createState() => _TaxiFormState();
}

class _TaxiFormState extends State<TaxiForm> {
  final _formKey = GlobalKey<FormState>();
  String kodeTransaksi = '';
  String kodePenumpang = '';
  String namaPenumpang = '';
  String jenisPenumpang = 'REGULAR';
  String platNomor = '';
  String supir = '';
  double biayaAwal = 0;
  double biayaPerKilometer = 0;
  double jumlahKilometer = 0;
  double totalBayar = 0;

  void calculateTotal() {
    double biaya = 0;

    if (jenisPenumpang == 'VIP') {
      biaya = (jumlahKilometer > 5) ? (jumlahKilometer - 5) * biayaPerKilometer : 0;
    } else if (jenisPenumpang == 'GOLD') {
      biaya = (jumlahKilometer > 2) ? (jumlahKilometer - 2) * biayaPerKilometer : 0;
    } else {
      biaya = jumlahKilometer * biayaPerKilometer;
    }

    totalBayar = biayaAwal + biaya;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taxi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Kode Transaksi'),
                onChanged: (value) {
                  kodeTransaksi = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Kode Penumpang'),
                onChanged: (value) {
                  kodePenumpang = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Penumpang'),
                onChanged: (value) {
                  namaPenumpang = value;
                },
              ),
              DropdownButtonFormField<String>(
                value: jenisPenumpang,
                items: ['REGULAR', 'GOLD', 'VIP'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    jenisPenumpang = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Jenis Penumpang'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Plat Nomor'),
                onChanged: (value) {
                  platNomor = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Supir'),
                onChanged: (value) {
                  supir = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Biaya Awal'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  biayaAwal = double.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Biaya Per Kilometer'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  biayaPerKilometer = double.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Jumlah Kilometer'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  jumlahKilometer = double.tryParse(value) ?? 0;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      calculateTotal();
                    });
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Total Bayar'),
                        content: Text('Total Bayar untuk $namaPenumpang: \$${totalBayar.toStringAsFixed(2)}'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Hitung Total Bayar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
