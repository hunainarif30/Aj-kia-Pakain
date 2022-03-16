// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SpiningWheel(),
    );
  }
}

class SpiningWheel extends StatefulWidget {
  @override
  _SpiningWheelState createState() => _SpiningWheelState();
}

class _SpiningWheelState extends State<SpiningWheel> {
  final StreamController _dividerController = StreamController<int>();
  final _wheelNotifier = StreamController<double>();
  @override
  dispose() {
    super.dispose();
    _dividerController.close();
    _wheelNotifier.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Center(child: Text('AAJ KIA BANAIN??')),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinningWheel(
              Image.asset('assets/images/spinwheel.png'),
              width: 310,
              height: 310,
              initialSpinAngle: _generateRandomAngle(),
              spinResistance: 0.6,
              canInteractWhileSpinning: false,
              dividers: 43,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
              secondaryImage:
                  Image.asset('assets/images/roulette-center-300.png'),
              secondaryImageHeight: 50,
              secondaryImageWidth: 50,
              shouldStartOrStop: _wheelNotifier.stream,
            ),
            SizedBox(height: 30),
            StreamBuilder(
              stream: _dividerController.stream,
              builder: (context, snapshot) =>
                  snapshot.hasData ? RouletteScore(snapshot.data) : Container(),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text("Start"),
              onPressed: () =>
                  _wheelNotifier.sink.add(_generateRandomVelocity()),
            )
          ],
        ),
      ),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;
  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: 'Daal',
    2: 'Biryani',
    3: 'Nihari',
    4: 'Koftay',
    5: 'Payee',
    6: 'Achaar Gosht',
    7: 'Tikkay',
    8: 'Pulao',
    9: 'Stoo',
    10: 'Aloo Gosht',
    11: 'Qeema',
    12: 'Korma',
    13: 'White Karahi',
    14: 'Karahi',
    15: 'Paneer Reshmi Handi',
    16: 'Manchurian',
    17: 'Haleem',
    18: 'Shami Kabab',
    19: 'Fish',
    20: 'Shashlek',
    21: 'Seekh kabab',
    22: 'Chapli kabab',
    23: 'Daal chicken',
    24: 'Maash ki daal',
    25: 'Masoor ki daal',
    26: 'chanay ki daal',
    27: 'moong ki daal',
    28: 'Kari',
    29: 'Palak Aloo',
    30: 'Bhindi',
    31: 'Arvi',
    32: 'Aloo Gobi matar',
    33: 'Sarsoo ka saag',
    34: 'Mandi',
    35: 'Aloo ki Taheri',
    36: 'Singaporean Rice',
    37: 'Chicken Seekh kabab',
    38: 'Desi Chowmein',
    39: 'Malai Tikka',
    40: 'Chicken Chargha',
    41: 'Balochi Karahi',
    42: 'Tandoori Chicken Pizza',
    43: 'Mirchi Chicken skewers'
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0));
  }
}
