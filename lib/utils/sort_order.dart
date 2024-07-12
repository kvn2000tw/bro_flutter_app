import 'package:bro_flutter_app/data.dart';
import 'package:bro_flutter_app/flutter_flow/flutter_flow_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SortOrder extends StatefulWidget {
  const SortOrder({super.key});

  @override
  State<SortOrder> createState() => _SortOrderState();
}

class _SortOrderState extends State<SortOrder> {
  final String SortIcon = 'assets/images/sort-ascending.svg';
 

@override
  void initState() {
    super.initState();
    Data.sort = 0;
   
  }

  @override
  void dispose() {
  
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
      var iconColor = Colors.grey;

      if(Data.sort != 0){
        iconColor = Colors.blue;
      }
      return Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton:  Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color:
                FlutterFlowTheme.of(context).secondaryBackground,
              ),
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:SvgPicture.asset(
                        SortIcon,
                        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),),
                      ),
                      ),
            openWithLongPress: false,
            items: [
              ...MenuItems.firstItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
            ],
            onChanged: (value) {
              MenuItems.onChanged(context, value! as MenuItem);
              setState(
                ()=>{

                }
              );
            },
            buttonStyleData: ButtonStyleData(
              // This is necessary for the ink response to match our customButton radius.
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(40),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              width: 80,
              padding: const EdgeInsets.only(left: 0, right: 0,top:0,bottom:0),
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(4),
                //color: Colors.redAccent,
              ),
              //offset: const Offset(0, 0),
              //offset: const Offset(40, -4),
            ),
            menuItemStyleData: MenuItemStyleData(
              customHeights: [
                ...List<double>.filled(MenuItems.firstItems.length, 48),
              ],
              padding: const EdgeInsets.only(left: 0, right: 0,top:0,bottom:0),
            ),
          ),
        ),
      );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

class MenuItems {
  static const List<MenuItem> firstItems = [like, share];

  static const like = MenuItem(text: '最新', icon: Icons.favorite);
  static const share = MenuItem(text: '最舊', icon: Icons.share);
 
  static Widget buildItem(MenuItem item) {
    print('buildItem ${Data.sort}');
    var color = Colors.black;
    var bkColor = Colors.white;

    if(item == like){
      
      if(Data.sort == 1){
        color = Colors.white;
        bkColor = Colors.blue;
      }
    }else {
      if(Data.sort == 2){
        color = Colors.white;
        bkColor = Colors.blue;
      }

    }
    return  Container(
            color: bkColor,
          child:
        Center(
          child: Text(
            item.text,
            style:  TextStyle(
              color: color,
              backgroundColor: bkColor,
            ),
          ),
    ));
  }

  static void onChanged(BuildContext context, MenuItem item) {
    print('onChanged ${Data.sort}');
    switch (item) {
      case MenuItems.like:
        //Do something
        if(Data.sort == 1){
          Data.sort = 0;
        }
        else{
          Data.sort = 1;
        }
        break;
      case MenuItems.share:
        //Do something
        if(Data.sort == 2){
          Data.sort = 0;
        }
        else{
          Data.sort = 2;
        }

        break;
    }
  }
}