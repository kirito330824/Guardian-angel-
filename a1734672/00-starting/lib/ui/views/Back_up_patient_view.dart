import 'package:compound/ui/widgets/navigation_drawer.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class PatientView extends StatefulWidget {
  PatientView({Key key}) : super(key: key);

  @override
  _PatientView createState() => _PatientView();
}

class _PatientView extends State<PatientView> {
  List<DragAndDropList> _contents;

  @override
  void initState() {
    super.initState();

    _contents = List.generate(1, (index) {
      return DragAndDropList(
        header: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'Patient Id : 001',
              ),
              subtitle: Text('FirstName: Test \nLastName Deom'),
            ),
            Divider(),
          ],
        ),
        footer: Column(
          children: <Widget>[
            Divider(),
            ListTile(
              title: Text(
                'Symptom: Alzheimer',
              ),
              subtitle: Text('Fall & Room exit'),
            ),
          ],
        ),
        children: <DragAndDropItem>[
          DragAndDropItem(
            child: ListTile(
              title: Text(
                'Gender: Male',
              ),
              trailing: Icon(Icons.male),
            ),
          ),
          DragAndDropItem(
            child: ListTile(
              title: Text(
                'Age: 80',
              ),
              trailing: Icon(Icons.elderly),
            ),
          ),
          DragAndDropItem(
            child: ListTile(
              title: Text(
                'Weight: 70kg',
              ),
              trailing: Icon(Icons.monitor_weight_outlined),
            ),
          ),
          DragAndDropItem(
            child: ListTile(
              title: Text(
                'Height 180cm',
              ),
              trailing: Icon(Icons.height_outlined),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient info'),
      ),
      drawer: NavigationDrawer(),
      body: DragAndDropLists(
        children: _contents,
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
        listGhost: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 100.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Icon(Icons.add_box),
            ),
          ),
        ),
        listPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        contentsWhenEmpty: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 10),
                child: Divider(),
              ),
            ),
            Text(
              'Empty List',
              style: TextStyle(
                  color: Theme.of(context).textTheme.caption.color,
                  fontStyle: FontStyle.italic),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 40),
                child: Divider(),
              ),
            ),
          ],
        ),
        listDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }
}
