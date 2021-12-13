import 'package:cached_network_image/cached_network_image.dart';
import 'package:compound/models/Logbook.dart';
import 'package:compound/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class LogbookItem extends StatelessWidget {
  final Logbook logbook;
  final Function onDeleteItem;

  const LogbookItem({Key key, this.logbook, this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: logbook.imageUrl != null ? null : 60,
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                logbook.imageUrl != null
                    ? SizedBox(
                        height: 250,
                        // child: CachedNetworkImage(
                        //   imageUrl: logbook.imageUrl,
                        //   progressIndicatorBuilder:
                        //       (context, url, downloadProgress) =>
                        //           CircularProgressIndicator(
                        //               value: downloadProgress.progress),
                        //   errorWidget: (context, url, error) =>
                        //       Icon(Icons.error),
                        // ),
                      )
                    : Container(),
                Text(logbook.title),
              ],
            ),
          )),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              if (onDeleteItem != null) {
                onDeleteItem();
              }
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
          ]),
    );
  }
}
