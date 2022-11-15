import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeIndex {
  final String? text;
  final int? order;


  RecipeIndex({
    this.text,
    this.order,
  });

  factory RecipeIndex.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return RecipeIndex(
      text: data?['text'],
      order: data?['order'],

      /*regions:
      data?['regions'] is Iterable ? List.from(data?['regions']) : null,*/
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (text != null) "text": text,
      if (order != null) "order": order,
    };
  }

}