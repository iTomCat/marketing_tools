import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

final _firestore = FirebaseFirestore.instance;

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);



  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {


  @override
  void initState() {
    super.initState();


    final docRef = _firestore
        .collection("PL")
        .doc("screens")
        .collection("recipes")
        .doc("index");

    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        debugPrint('Data From Firebase: $data');

        //Logger.level = Level.warning;
        //var logger = Logger( printer: PrefixPrinter(PrettyPrinter(colors: false)));
        var logger = Logger();
        logger.d("Logger is working!");
        logger.wtf("Data From Firebase: $data");
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );

    /*getDataFromFirebase().then((values){

    });*/

    /*context.read<MapProvider>().getMeasuringStations().then((values) {
      setState(() {
        _markers.addAll(values);
      });
    });*/

  }

  Future<void> getDataFromFirebase() async{

  }


  @override
  Widget build(BuildContext context) {
    debugPrint('Start');
    return Container();
  }
}

