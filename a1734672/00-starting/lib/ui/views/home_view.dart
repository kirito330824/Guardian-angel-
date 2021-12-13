import 'package:compound/ui/shared/ui_helpers.dart';
import 'package:compound/ui/widgets/logbook_item.dart';
import 'package:compound/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:compound/ui/widgets/navigation_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModel: HomeViewModel(),
        onModelReady: (model) => model.listenToLogbooks(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Guardian Angle'),
              ),
              drawer: NavigationDrawer(),
              backgroundColor: Colors.white,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child:
                    !model.busy ? Icon(Icons.add) : CircularProgressIndicator(),
                onPressed: model.navigateToCreateView,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpace(35),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          child: Image.asset('assets/images/icon.png'),
                        ),
                      ],
                    ),
                    Expanded(
                        child: model.Logbooks != null
                            ? ListView.builder(
                                itemCount: model.Logbooks.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () => model.editLogbook(index),
                                  child: LogbookItem(
                                    logbook: model.Logbooks[index],
                                    onDeleteItem: () =>
                                        model.deleteLogbook(index),
                                  ),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).primaryColor),
                                ),
                              ))
                  ],
                ),
              ),
            ));
  }
}
