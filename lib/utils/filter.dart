import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:bro_flutter_app/utils/filter_widget.dart';

import 'package:flutter/material.dart';

Future<void> showTransportFilter(BuildContext context,
  VoidCallback onPressed
) async {

  return showDialog<void>(
    context: context,
   
    //barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Dialog(
        
        alignment: AlignmentDirectional(0, 1),
        insetPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
 shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16.0),
            
            ), //this right here
          child: FilterWidget()
      );
    },
  );
}
