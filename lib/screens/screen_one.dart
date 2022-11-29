

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../helpers/db_helper.dart';
import '../models/recipe.dart';
import '../widgets/gray_fading_apla.dart';


final _firestore = FirebaseFirestore.instance;

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);



  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  List<Recipe> _recipesList = [];


  @override
  void initState() {
    super.initState();

    /// Clear Firenase Cash
    /// musi być zanim wywołane zostaną inne odwołania do FirebaseFirestore.instance
    /*FirebaseFirestore.instance.clearPersistence().whenComplete((){
      debugPrint('CLEAR DB >>>>>>>>>>>>>>>....');
    }
    );*/


    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );


    final docRef = _firestore
        .collection("PL")
        .doc("screens")
        .collection("recipes")
        .doc("index");

    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        //final data = doc.data();

        debugPrint('Data From Firebase0: $data');

        data.forEach((recipeId, recipeIndexData) {

          debugPrint('Data From Firebase1: $recipeId');
          debugPrint('Data From Firebase2: ${recipeIndexData['order']}');
        });

        //czytamy INDEX z firebase i potem po kolei sprawdzamy z baza DB
        //jak z bazy db jest ID w indexie i time ok to czytamy albo z db albo z firebase i dodajemy do listy List<Recipes>
        //mamy -1 w indexie dla usuwanych


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
        //var logger = Logger();
        //logger.d("Logger is working! $data");
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

    //final _prefs = await SharedPreferences.getInstance();
    //String savedOrganizationContext =  _prefs.getString(OrganizationsData.selectedOrganization) ?? defaultCode;

    SharedPreferences.getInstance().then((values) {

      //values.getString('test_values') ?? null;
      String? aa = values.getString('test_values');
      debugPrint('Prefs: $aa');
    });


    final docRefTest = _firestore
        .collection("PL")
        .doc("screens")
        .collection("tests");
        //.doc("index");


    Source CACHE = Source.cache;
    Source SERVER = Source.server;

    /*FirebaseFirestore rootRef = FirebaseFirestore.getInstance();
    CollectionReference shoesRef = rootRef.collection("shoes");
    Query lastAddedQuery = shoesRef.orderBy("lastModified", DESCENDING)
    shoesRef.get(CACHE).addOnCompleteListener(task -> {
    if (task.isSuccessful()) {
    boolean isEmpty = task.getResult().isEmpty();
    if (isEmpty) {
    shoesRef.get(SERVER).addOnCompleteListener(*//* ... *//*);
    }
    }
    });*/

    docRefTest.get().then(
          (QuerySnapshot doc1) {
        //final data = doc.data() as Map<String, dynamic>;
        final _docData = doc1.docs.map((doc) => doc.data()).toList();
        //final data = doc.data() as Map<String, dynamic>;
        //final data = doc.data();

        var logger = Logger();
        logger.d("Test Data: ${_docData}");

        //sprawdzić timestamp i potem pobieranie danych po zmianie daty


      },
      onError: (e) => debugPrint("Error getting document: $e"),
    );

    getDataFromFirebase().then(
          (data) {
            for (var recipeData in data) {
              var logger = Logger();
              //logger.wtf('Test Data from FUNCTION: ${recipeData.id}, ${recipeData.title}');
            }

          }
    );
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

          CachedNetworkImage(
            height: 300,
            //fit: BoxFit.cover,
            fit: BoxFit.fitHeight,
            //placeholder: (context, url) => CircularProgressIndicator(),
            placeholder: (context, url) => const GrayFadingApla(),
            //progressIndicatorBuilder: (context, url, downloadProgress) => GrayFadingApla(downloadProgress.progress),
            //progressIndicatorBuilder: (context, url, downloadProgress) => TestDwa(downloadProgress.progress),
            //errorWidget: (context, url, error) => Icon(Icons.error),
            errorWidget: (context, url, error) => GrayFadingApla(),

            //imageUrl: 'https://images.unsplash.com/photo-1580137189272-c9379f8864fd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80',
            //imageUrl: 'http://musthave.agency/files/pancakes/test.jpg',
            imageUrl: 'http://musthave.agency/files/pancakes/test_2.jpg',
          ),
        ],
      ),

    );
  }


  Future<List<Recipe>> getDataFromFirebase() async{
    List<Recipe> actualRecipeList = [];


    Timestamp timestampNow = Timestamp.now();

    // https://medium.com/firebase-tips-tricks/how-to-drastically-reduce-the-number-of-reads-when-no-documents-are-changed-in-firestore-8760e2f25e9e
    // zaopisywać ostatnie odświeżenie do Preferences


    final docRefTest = _firestore
        .collection("PL")
        .doc("screens")
        .collection("tests");

    // 1. To na początku;
    QuerySnapshot querySnapshot = await docRefTest.get( const GetOptions(source: Source.cache));

    if (querySnapshot.docs.isEmpty) { // Nie ma pobranych dokumentów, tworzymy pobieramy wszystko z serwera
      debugPrint('List is EMPTY');
      querySnapshot = await docRefTest.get(const GetOptions(source: Source.server));
      return makeRecipesList(querySnapshot);
    }

    actualRecipeList = makeRecipesList(querySnapshot);


    // 2. Potem takie pytania sprawdzające czy są nowsze pliki
    final newUpdatesRef = docRefTest
        .where('timestamp', isGreaterThanOrEqualTo: timestampNow);

    // SPrawdxamy czy są wpisy nowsze niż zapisane w Preferences
    QuerySnapshot updatedRecipes = await newUpdatesRef.get(const GetOptions(source: Source.server));
    for (var recipeId in updatedRecipes.docs) {
      final aa = recipeId.data() as Map<String, dynamic>;

      debugPrint('Data From Firebase UPDATED: ${recipeId.id}');
      debugPrint('Data From Firebase UPDATED: ${aa}');
      debugPrint('Data From Firebase UPDATED: ${recipeId["timestamp"]}');
      //Jeżeli są nowsze wpisy czytamy dane
      final updateRecipe = Recipe(
          id: recipeId.id,
          title: recipeId['title']
      );


      //var recipeByIDinList = actualRecipeList.firstWhere((recipe) => recipe.id == recipeId.id);
      //debugPrint('Data From Firebase UPDATED in List: ${recipeByIDinList.id}');

      // Sprawdzamy index na liście w którym mamy odnowić wpis i podmieniamy obiekt
      int index = actualRecipeList.indexWhere((recipe) => recipe.id == recipeId.id);
      debugPrint('$index');
      actualRecipeList[index] = updateRecipe;
      debugPrint('AfterChange title: ${actualRecipeList[index].title}');
    }

    // zapisać do Preferences date now



    return actualRecipeList;

  }

  String convertDateFromTimestamp(DocumentSnapshot document){
    // Konwert timestamp do daty potrzebny import 'package:intl/intl.dart'
    return DateFormat('dd/MM/yyyy HH:mm').format(document["timestamp"].toDate());
  }

  List<Recipe> makeRecipesList(QuerySnapshot querySnapshot){
    List<Recipe> recipeList = [];

    for (var recipe in querySnapshot.docs) {
      final newRecipe = Recipe(
          id: recipe.id,
          title: recipe['title']);

      debugPrint('BeforeChange title: ${ recipe['title']}');

      recipeList.add(newRecipe);
    }



    return recipeList;
  }

}

