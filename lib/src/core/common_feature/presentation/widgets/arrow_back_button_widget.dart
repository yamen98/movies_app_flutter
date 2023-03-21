/*
 * Created by Yamen Abdulrahman on 1/8/2023.
 * Connection email: yamen.abd98@gmail.com
*/

import 'package:flutter/material.dart';

class ArrowBackButtonWidget extends StatelessWidget {
  final Function()? callback;

  const ArrowBackButtonWidget({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: IconButton(
        onPressed: () {
          callback?.call();
          Navigator.pop(context);
        },
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
