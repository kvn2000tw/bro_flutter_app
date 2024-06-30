import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';


class TransportOrdersListModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.


  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for TextField widget.

  /// Initialization and disposal methods.

  var textFieldFocusNode = FocusNode();
  var textFieldFocusNode2 = FocusNode();
  var textFieldFocusNode3 = FocusNode();
  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textController?.dispose();
   
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
