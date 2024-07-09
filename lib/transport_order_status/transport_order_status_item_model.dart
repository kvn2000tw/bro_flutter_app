import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';


class TransportOrderStatusItemModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.


  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  /// Initialization and disposal methods.

  var textFieldFocusNode1 = FocusNode();
  var textFieldFocusNode2 = FocusNode();
  var textFieldFocusNode3 = FocusNode();
  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textController1?.dispose();
    textController2?.dispose();
   
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
