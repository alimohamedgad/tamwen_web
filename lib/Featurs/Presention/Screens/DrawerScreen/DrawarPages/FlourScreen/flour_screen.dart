// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../Data/Data_Source/FireStore_DataBase/flour_database.dart';
import '../../../../../Data/model/flour_model.dart';
import 'flour_body.dart';

class FlourScreen extends StatefulWidget {
  const FlourScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FlourScreen> createState() => _FlourScreenState();
}

class _FlourScreenState extends State<FlourScreen> {
  @override
  void initState() {
    FlourDataBase.getFlours();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FlourDataBase.getFlours(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FlourModel> flourList = [];
            for (var element in snapshot.data!.docs) {
              flourList.add(FlourModel.fromJson(element));
            }
            return Scaffold(
              appBar: AppBar(),
              body: BodyFlourScreen(
                flourList: flourList,
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
