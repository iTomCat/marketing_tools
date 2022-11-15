import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../helpers/db_helper.dart';

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
        //final data = doc.data();

        data.forEach((recipeId, recipeIndexData) {

          debugPrint('Data From Firebase1: $recipeId');
          debugPrint('Data From Firebase2: ${recipeIndexData['order']}');
        });

        debugPrint('Data From Firebase: $data');


      /// z converteremFirebase robić dla poszczeghólnych Dokumentów
       /* final docRef2 = _firestore
            .collection("PL")
            .doc("screens")
            .collection("recipes")
            .doc("index").withConverter(
            fromFirestore: RecipeIndex.fromFirestore,
            toFirestore: (RecipeIndex city, _) => city.toFirestore(),
        );

        //final docSnap = await ref.get();
        docRef2.get().then(
              (DocumentSnapshot doc) {

                final data2 = doc.data();

                debugPrint('Data From Firebase3333: ${data2}');

                *//*data2.forEach((recipeId, recipeIndexData) {

                  debugPrint('Data From Firebase3333: $recipeIndexData');
                  debugPrint('Data From Firebase444: ${recipeIndexData['text']}');
                });*//*

                *//*final city = doc.data(); // Convert to City object
                if (city != null) {
                  debugPrint('aaaa: ${city.toString().length}');
                } else {
                  debugPrint("No such document.");
                }*//*
              }
        );*/


        //Logger.level = Level.warning;
        //var logger = Logger( printer: PrefixPrinter(PrettyPrinter(colors: false)));
        var logger = Logger();
        logger.d("Logger is working!");
        //logger.wtf("Data From Firebase: $data");
        // ...
      },
      onError: (e) => debugPrint("Error getting document: $e"),
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
    return Center(
      child:  Column(
        children: [
          TextButton(
              onPressed: (){
                //debugPrint('CLICK');

                //Zapisujemy do DB
                DBHelper.insertToDB(DBHelper.recipesTableName, {
                  'id': 101,
                  'title': 'To jest tytuł NEW',
                  'image_url': 'link do zdjęcia',
                });

                var logger = Logger();
                logger.d("Logger is working!");
              },
              child: const Text('Add to DB')),

          TextButton(
              onPressed: () async {

                var dataFromDB = await DBHelper.getData(DBHelper.recipesTableName);

                for (var recipeInDB in dataFromDB) {
                  debugPrint('Data From DBDBD: ${recipeInDB['title']}');
                }

                var logger = Logger();
                logger.d("Get Data: ${dataFromDB.length}");

                if(dataFromDB.isNotEmpty)  logger.d("Get Data: ${dataFromDB[0]}");
              },
              child: const Text('Get data from DB')),

          TextButton(
              onPressed: () async {

                //Usuwamy z DB
                DBHelper.deleteFromDB('101');

                var logger = Logger();
                logger.d("Delete from DB");
              },
              child: const Text('DELETE from DB')),
        ],
      ),

    );
  }

}

