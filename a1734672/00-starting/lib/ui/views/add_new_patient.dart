import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/widgets/input_field.dart';
import 'package:compound/viewmodels/add_new_patient_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class AddPatientView extends StatelessWidget {
  final IdController = TextEditingController();
  final pfc = TextEditingController();
  final plc = TextEditingController();
  final pwc = TextEditingController();
  final phc = TextEditingController();
  final pac = TextEditingController();

  AddPatientView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreatePostViewModel>.withConsumer(
      viewModel: CreatePostViewModel(),
      builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: !model.busy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
            onPressed: () {
              if (!model.busy)
                model.addPatient(
                  Id: IdController.text,
                );
            },
            backgroundColor:
                !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                Text(
                  'Add New Patient',
                  style: TextStyle(fontSize: 26),
                ),
                InputField(
                  placeholder: 'Patient Id',
                  controller: IdController,
                ),
                InputField(
                  placeholder: 'Patient First Name',
                  controller: pfc,
                ),
                InputField(
                  placeholder: 'Patient Last Name',
                  controller: plc,
                ),
                InputField(
                  placeholder: 'Patient Weight',
                  controller: pwc,
                ),
                InputField(
                  placeholder: 'Patient height',
                  controller: phc,
                ),
                InputField(
                  placeholder: 'Patient age',
                  controller: pac,
                )
              ],
            ),
          )),
    );
  }
}
