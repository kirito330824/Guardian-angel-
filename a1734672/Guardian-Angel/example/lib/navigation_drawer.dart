import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Home Page'),
            leading: Icon(Icons.list),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            title: Text('Patient List'),
            leading: Icon(Icons.view_list),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/list_tile_example');
            },
          ),
          // ListTile(
          //   title: Text('Expansion Tiles'),
          //   leading: Icon(Icons.keyboard_arrow_down),
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.of(context)
          //         .pushReplacementNamed('/expansion_tile_example');
          //   },
          // ),

          ListTile(
            title: Text('Add New patient'),
            leading: Icon(Icons.add),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed('/drag_into_list_example');
            },
          ),

          ListTile(
            title: Text('Remove Patient'),
            leading: Icon(Icons.block),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/fixed_example');
            },
          ),

        ],
      ),
    );
  }
}
