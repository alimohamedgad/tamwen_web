// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
// import 'package:input_quantity/input_quantity.dart';
// import 'package:quantity_input/quantity_input.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:tawmen_project/Featurs/Core/app_strings.dart';
// import 'package:tawmen_project/Featurs/Data/model/user_model.dart';
// import 'package:tawmen_project/Featurs/Presention/Widgets/custom_text_field.dart';
// import 'package:tawmen_project/Featurs/Presention/Widgets/navigator.dart';

// import '../../Data/model/details_models.dart';
// import 'DetailsScreen/details_screen.dart';

// class TF extends StatelessWidget {
//   const TF({Key? key}) : super(key: key);

//   static String id = 'TF';

//   @override
//   Widget build(BuildContext context) {
//     int stock = 0;
//     int num = 0;
//     TextEditingController controller = TextEditingController(text: '$stock');
//     TextEditingController quntateController =
//         TextEditingController(text: '$num');

//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Container(
//           margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: const ShapeDecoration(
//                         shape: CircleBorder(), color: Colors.cyanAccent),
//                     child: const Text("-")),
//                 onTap: () {
//                   int currentValue = int.tryParse(controller.text) ?? 0;
//                   controller.text =
//                       (currentValue > 0) ? "${currentValue - 1}" : "0";
//                 },
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 width: 50,
//                 child: TextField(
//                   controller: controller,
//                   maxLength: 3,
//                   textAlign: TextAlign.center,
//                   decoration: const InputDecoration(
//                     hintText: "0",
//                     border: InputBorder.none,
//                     counterText: "",
//                   ),
//                   keyboardType: TextInputType.number,
//                 ),
//               ),
//               InkWell(
//                 customBorder: const CircleBorder(),
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text("+"),
//                 ),
//                 onTap: () {
//                   int currentValue = int.tryParse(controller.text) ?? 0;
//                   controller.text = "${currentValue + 1}";
//                 },
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, DetailsScreen.idRouter);
//                   },
//                   child: const Text('Go')),
//               InputQty(
//                 maxVal: 250.0,
//                 initVal: 10,
//                 minVal: 0,
//                 steps: num,
//                 borderShape: BorderShapeBtn.circle,
//                 onQtyChanged: (val) {},
//               ),
//               TextField(
//                 controller: quntateController,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ParentWidget extends StatefulWidget {
//   const ParentWidget({Key? key}) : super(key: key);

//   static String id = 'ParentWidget';

//   @override
//   State<ParentWidget> createState() => _ParentWidgetState();
// }

// class _ParentWidgetState extends State<ParentWidget> {
//   int counter = 0;

//   SharedPreferences? preferences;

//   Future<void> initStorage() async {
//     preferences = await SharedPreferences.getInstance();
//     // init 1st time 0
//     int? savedData = preferences?.getInt("counter");
//     if (savedData == null) {
//       await preferences!.setInt("counter", counter);
//     } else {
//       counter = savedData;
//     }
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     initStorage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           preferences?.setInt("counter", counter = counter + 25);
//           setState(() {});
//         },
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(child: Text("${preferences?.getInt("counter")}")),
//         ],
//       ),
//     );
//   }
// }

// class QuantityInputSample extends StatefulWidget {
//   @override
//   State<QuantityInputSample> createState() => _QuantityInputSampleState();

//   static String id = 'QuantityInputSample';
// }

// class _QuantityInputSampleState extends State<QuantityInputSample> {
//   int simpleIntInput = 1;
//   int steppedIntInput = 1;
//   double simpleDoubleInput = 1;
//   double steppedDoubleInput = 1;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(title: const Text('Example')),
//           body: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ElegantNumberButton(
//                     initialValue: steppedIntInput,
//                     minValue: 0,
//                     maxValue: 10,
//                     step: 0.5,
//                     decimalPlaces: 2,
//                     onChanged: (value) {
//                       // get the latest value from here
//                       steppedIntInput = value as int;
//                     },
//                   ),
//                   Text('Value: $steppedIntInput',
//                       style: const TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 20),
//                   Text('Value: $simpleDoubleInput',
//                       style: const TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 20),
//                   QuantityInput(
//                       label: 'Double input with 1.5 step',
//                       type: QuantityInputType.double,
//                       value: steppedDoubleInput,
//                       step: 1.5,
//                       decimalDigits: 1,
//                       onChanged: (value) => setState(() => steppedDoubleInput =
//                           double.parse(value.replaceAll(',', '')))),
//                   Text('Value: $steppedDoubleInput',
//                       style: const TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FlutterFireBase extends StatelessWidget {
//   const FlutterFireBase({super.key});
//   static String id = 'FlutterFireBase';
//   @override
//   Widget build(BuildContext context) {
//     final nameController = TextEditingController();
//     final numMainPeopleController = TextEditingController();
//     final numExtraPeopleController = TextEditingController();
//     final priceExtraPeopleController = TextEditingController();
//     return Scaffold(
//       appBar: AppBar(
//         actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
//       ),
//       body: ListView(
//         children: [
//           CustomTextfield(
//             controller: nameController,
//             keyBordTyp: TextInputType.emailAddress,
//             labelText: 'الاسم',
//           ),
//           CustomTextfield(
//             controller: numMainPeopleController,
//             keyBordTyp: TextInputType.emailAddress,
//             labelText: 'عدد الافراد',
//           ),
//           CustomTextfield(
//             controller: numExtraPeopleController,
//             keyBordTyp: TextInputType.emailAddress,
//             labelText: 'عدد الافراد سلع',
//           ),
//           CustomTextfield(
//             controller: priceExtraPeopleController,
//             keyBordTyp: TextInputType.emailAddress,
//             labelText: 'سعر الفرد فى السلع',
//           ),
//           IconButton(
//             onPressed: () {
//               createUsers(
//                 UserModel(
//                     name: nameController.text,
//                     numberOfMainPeople: int.parse(numMainPeopleController.text),
//                     numberOfExtraPeople:
//                         int.parse(numExtraPeopleController.text),
//                     priceOfExtraPerople:
//                         int.parse(priceExtraPeopleController.text)),
//               );
//             },
//             icon: const Text('Add'),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, ReadAllData.id);
//             },
//             icon: const Text('Home Page'),
//           )
//         ],
//       ),
//     );
//   }

//   void createUsers(UserModel model) async {
//     final docuser = FirebaseFirestore.instance.collection('users').doc();
//     model.id = docuser.id;
//     await docuser.set(model.toJson());
//   }
// }

// final Stream<QuerySnapshot> _usersStream =
//     FirebaseFirestore.instance.collection('users').snapshots();

// class ReadAllData extends StatelessWidget {
//   const ReadAllData({super.key});

//   static String id = 'ReadAllData';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _usersStream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasData) {
//             List<UserModel> users = [];
//             snapshot.data!.docs.forEach((element) {
//               users.add(UserModel.fromJson(element));
//             });
//             return ListView.builder(
//               itemCount: users.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () {
//                     customNavPush(
//                         NewDetails(
//                           users: users[index],
//                         ),
//                         context);
//                   },
//                   child: Card(
//                     child: ListTile(
//                       title: Text(users[index].name),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           if (snapshot.hasError) {
//             return Text('Something went wrong');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Text("Loading");
//           }
//           return Text('data');
//         },
//       ),
//     );
//   }
// }

// class NewDetails extends StatelessWidget {
//   final UserModel? users;
//   const NewDetails({
//     Key? key,
//     this.users,
//   }) : super(key: key);
//   static String id = 'NewDetails';

//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> productsStram = FirebaseFirestore.instance
//         .collection('users')
//         .doc(users!.id)
//         .collection('products')
//         .snapshots();
//     return Scaffold(
//         appBar: AppBar(
//           title: InkWell(
//             onTap: () {
//               customNavPush(
//                   AddNewDetails(
//                     idUser: users!.id,
//                   ),
//                   context);
//             },
//             child: Text('add'),
//           ),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: productsStram,
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasData) {
//               List<DetailsModel> details = [];
//               for (var element in snapshot.data!.docs) {
//                 details.add(DetailsModel.fromJson(element));
//               }
//               return ListView.builder(
//                 itemCount: details.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {},
//                     child: Card(
//                       child: ListTile(
//                         title: Text("${details[index].nameProduct}"),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//             if (snapshot.hasError) {
//               return Text('Something went wrong');
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Text("Loading");
//             }

//             return Text('data');
//           },
//         ));
//   }
// }

// class AddNewDetails extends StatelessWidget {
//   String? idUser;
//   AddNewDetails({
//     Key? key,
//     this.idUser,
//   }) : super(key: key);
//   static String id = 'NewDetails';

//   @override
//   Widget build(BuildContext context) {
//     var priceProductContoller = TextEditingController();
//     var nameProductContoller = TextEditingController();
//     var counterController = TextEditingController();
//     var imageProductController = TextEditingController();
//     GlobalKey<FormState> key = GlobalKey<FormState>();

//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView(children: [
//         CustomTextfield(
//           colorIcon: const Color.fromRGBO(255, 87, 34, 1),
//           icon: Icons.person,
//           controller: nameProductContoller,
//           keyBordTyp: TextInputType.name,
//           labelText: AppStrings.productName,
//         ),
//         CustomTextfield(
//           colorIcon: Colors.deepOrange,
//           icon: Icons.money_off_rounded,
//           controller: priceProductContoller,
//           keyBordTyp: TextInputType.number,
//           labelText: AppStrings.price,
//         ),
//         CustomTextfield(
//           colorIcon: Colors.deepOrange,
//           icon: Icons.person,
//           controller: imageProductController,
//           keyBordTyp: TextInputType.number,
//           labelText: AppStrings.imageProduct,
//         ),
//         CustomTextfield(
//           colorIcon: Colors.deepOrange,
//           icon: Icons.money_off_rounded,
//           controller: counterController,
//           keyBordTyp: TextInputType.number,
//           labelText: AppStrings.amount,
//         ),
//         ElevatedButton(
//           onPressed: () {
//             creatProduct(
//                 DetailsModel(
//                     nameProduct: nameProductContoller.text,
//                     price: double.parse(priceProductContoller.text),
//                     counter: int.parse(counterController.text)),
//                 idUser!);
//           },
//           style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.deepOrange,
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
//               shape: const StadiumBorder()),
//           child: const Text('Add New Product'),
//         )
//       ]),
//     );
//   }

//   void creatProduct(
//     DetailsModel model,
//     String id,
//   ) async {
//     final docuser = FirebaseFirestore.instance
//         .collection('users')
//         .doc(id)
//         .collection('products')
//         .doc();
//     model.id = docuser.id;
//     await docuser.set(model.toJsonDoc());
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyWidget extends StatefulWidget {
  MyWidget({
    Key? key,
  }) : super(key: key);

  static String id = 'MyWidget';

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    // GlobalKey<FormBuilderState>? _fbKey;
    List<String> genderOptions = ['Male', 'Female', 'Other'];

    List<String> _items = [];
    GlobalKey<FormBuilderState>? _fbKey;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FormBuilderDropdown<String>(
              name: 'gender',
              decoration: InputDecoration(
                labelText: 'Gender',
                // initialValue: 'Male',
                suffix: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _fbKey?.currentState!.reset();
                  },
                ),
                hintText: 'Select Gender',
              ),
              items: genderOptions
                  .map((gender) => DropdownMenuItem(
                        alignment: AlignmentDirectional.center,
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
            ),
            FormBuilder(
              key: _fbKey,
              child: Column(
                children: <Widget>[
                  FormBuilderDropdown(
                    name: '',
                    onChanged: (val) {
                      setState(() {
                        final length =
                            _fbKey!.currentState?.fields.values.length;
                        _fbKey.currentState?.fields.values
                            .elementAt(length! - 1)

                            /// Widget position
                            .reset();

                        if (val == "x") {
                          _items = ["1", "2"];
                        } else {
                          _items = ["10", "11"];
                        }
                      });
                    },
                    items: ["x", "y"].map((cpt) {
                      return DropdownMenuItem(value: cpt, child: Text("$cpt"));
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
