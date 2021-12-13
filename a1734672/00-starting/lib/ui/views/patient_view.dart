// import 'package:compound/ui/shared/ui_helpers.dart';
// import 'package:compound/ui/widgets/patient_item.dart';
// import 'package:compound/viewmodels/patient_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider_architecture/provider_architecture.dart';

// class PatientView extends StatelessWidget {
//   const PatientView({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelProvider<PatientViewModel>.withConsumer(
//         viewModel: PatientViewModel(),
//         onModelReady: (model) => model.fetchPatients(),
//         builder: (context, model, child) => Scaffold(
//               appBar: AppBar(
//                 title: Text('Guardian Angle Patient Page'),
//               ),
//               backgroundColor: Colors.white,
//               floatingActionButton: FloatingActionButton(
//                 backgroundColor: Theme.of(context).primaryColor,
//                 child:
//                     !model.busy ? Icon(Icons.add) : CircularProgressIndicator(),
//                 onPressed: model.navigateToCreateView,
//               ),
//               body: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     verticalSpace(35),
//                     Row(
//                       children: <Widget>[
//                         SizedBox(
//                           height: 50,
//                           child: Image.asset('assets/images/icon.png'),
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                         child: model.patients != null
//                             ? ListView.builder(
//                                 itemCount: model.patients.length,
//                                 itemBuilder: (context, index) =>
//                                     GestureDetector(
//                                   child: PatientItem(
//                                     patient: model.patients[index],
//                                   ),
//                                 ),
//                               )
//                             : Center(
//                                 child: CircularProgressIndicator(
//                                   valueColor: AlwaysStoppedAnimation(
//                                       Theme.of(context).primaryColor),
//                                 ),
//                               ))
//                   ],
//                 ),
//               ),
//             ));
//   }
// }
