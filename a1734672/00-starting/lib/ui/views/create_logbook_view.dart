import 'package:compound/models/Logbook.dart';
import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/widgets/input_field.dart';
import 'package:compound/viewmodels/create_logbook_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class CreateLogbookView extends StatelessWidget {
  final titleController = TextEditingController();
  final Logbook edittingLogbook;
  CreateLogbookView({Key key, this.edittingLogbook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreateLogbookViewModel>.withConsumer(
      viewModel: CreateLogbookViewModel(),
      onModelReady: (model) {
        titleController.text = edittingLogbook?.title ?? '';
        model.setEdittingLogbook(edittingLogbook);
      },
      builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: !model.busy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
            onPressed: () {
              if (!model.busy) {
                model.addLogbooks(title: titleController.text);
              }
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
                  'Create Paitient Logbook',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'logbook',
                  controller: titleController,
                ),
                verticalSpaceMedium,
                // Text('Logbook Image'),
                // verticalSpaceSmall,
                // GestureDetector(
                //     onTap: () => model.selectImage(),
                //     child: Container(
                //         height: 250,
                //         decoration: BoxDecoration(
                //             color: Colors.grey[200],
                //             borderRadius: BorderRadius.circular(10)),
                //         alignment: Alignment.center,
                //         // If the selected image is null we show "Tap to add post image"
                //         child: model.selectedImage == null
                //             ? Text(
                //                 'Tap to add patient image',
                //                 style: TextStyle(color: Colors.grey[400]),
                //               )
                //             : Image.file(model.selectedImage)))
              ],
            ),
          )),
    );
  }
}
