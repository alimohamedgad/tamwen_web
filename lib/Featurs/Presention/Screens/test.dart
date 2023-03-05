// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import ;
// import 'package:tamwen_web/Featurs/Data/model/user_model.dart';
// import 'package:tamwen_web/Featurs/Presention/Cubits/People_Cubit/people_cubit.dart';
// import 'package:tamwen_web/Featurs/Presention/Cubits/People_Cubit/people_state.dart';
// import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Home/body_home_screen.dart';
// import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Widgets/CustomButton/custom_button.dart';
// import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Widgets/Custom_Text/custom_text.dart';

// import 'Mobile/Drawer/drawer_screens.dart';

// class TestProduct extends StatefulWidget {
//   const TestProduct({super.key});

//   @override
//   State<TestProduct> createState() => _TestProductState();
// }

// class _TestProductState extends State<TestProduct> {
//   @override
//   void initState() {
//     context.read<PeopleCubit>().getAllUsers();

//     getUserData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PeopleCubit, PeopleState>(
//       builder: (context, state) {
//         var cubit = context.read<PeopleCubit>();

//         return Scaffold(
//           appBar: AppBar(),
//           body: Column(
//             children: [
//               // if (state is UsersSuccess)
//               CustomText(text: ' state.users.id'),
//               CustomButton(
//                   onPressed: () {
//                     print('aaaaaaaaa');
//                   },
//                   text: 'get ID'),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   getUserData() {
//     var cubit = context.read<PeopleCubit>();

//     var detailsModel = cubit.users.map((e) => e.id).toList();
//     print(detailsModel.length);
//   }
// }

// class HomePage5 extends StatelessWidget {
//   const HomePage5({super.key});
//   static String id = 'HomePage';

//   @override
//   Widget build(BuildContext context) {
//     var peopleCubit = PeopleCubit.get(context);

//     return StreamBuilder<Object>(
//       stream: peopleCubit.getAllUsers(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           UserModel uss = snapshot.data as UserModel;
//           List<UserModel> usermodel = [];
//           for (var data in usermodel) {
//             usermodel.add(UserModel.fromJson(data));
//           }
//           return Scaffold(
//             // appBar: appBarHomePage(context, peopleCubit),
//             drawer: DrawerScreen(peopleCubit: peopleCubit),
//             body: BodyHomeScreen(
//                 users: peopleCubit.users, peopleCubit: peopleCubit),
//           );
//         } else {
//           return Text('s');
//         }
//       },
//     );
//   }
// }
