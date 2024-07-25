// TODO Implement this library.import '/flutter_flow/flutter_flow_theme.dart';
import 'package:bro_flutter_app/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

 
  final String UserIcon = 'assets/images/user-circle.svg';
 

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
   
    super.dispose();
  }
  _getRole(String role){
    switch(role){
          case 'director':
            return '管理員/廠長';
        case 'operations_supervisor':
            return '營運人員';
        case 'production_manager':
            return '生管人員';
        case 'storage_management_personnel':
            return '倉儲人員';
        case 'driver':
            return '運輸人員';
        default:
            return '未知';
    }
  }

  _goLogout(BuildContext context)async{
    
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("organization_vat",'');
    sharedPreferences.setString("username",'');
    sharedPreferences.setString("password",'');
    sharedPreferences.setBool("autoLogin",false);
    for(var i=0;i<Data.filter.length;i++){
      Data.filter[i].value = false;
    }
    Navigator.pushNamed(context,'/');
  }
  @override
  Widget build(BuildContext context) {

    String roles = '';
    for(var i=0;i<Data.user.roles.length;i++){
      final role = _getRole(Data.user.roles[i]);
      roles = '${roles} ${role}';
    }

    Widget widget =  SvgPicture.asset(
                            UserIcon,
                            height: 40,
                            width: 40,
                      
                          );
    if(Data.user.profile_photo_path != '')
    widget = Image.network(
      Data.user.profile_photo_path,
      width: 40,
      height: 40,
      fit: BoxFit.contain,
    );

    return 
   Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      '系統䛇定',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
                     Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 50,
                      height: 100,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: widget,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Text(
                                  Data.user.full_name,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 20,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Text(
                                roles,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 16,
                                      letterSpacing: 0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async { _goLogout(context);},
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Text(
                        '登出',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ]);
  }
}
