import 'dart:math';

import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _angel=0;
  double _left=0;
  Offset? _origin;
  bool _isOpen=false;

  late double height;
  late double width;



  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    _origin=Offset(-width/2,-height/2);

    return Stack(
      children: [
        myDrawer(),
        FrontHome()
      ],
    );
  }


}









class FrontHome extends StatefulWidget {
  const FrontHome({Key? key}) : super(key: key);

  @override
  State<FrontHome> createState() => _FrontHomeState();
}

class _FrontHomeState extends State<FrontHome> with SingleTickerProviderStateMixin{

  double _angel=pi/20;
  late Offset _orrigin;
  late double toY;
  late double toX;

   double? endOfDragEnd;

  bool _isOpen=false;

  late AnimationController _positionController;


  @override
  void initState() {
    _positionController=AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this
    );
    _positionController.addListener(_OnAnimate);

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    double _width =MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;

     toX=_width/2;
     toY=70;
    _orrigin=Offset(-_width/2, -_height/2);

    return Transform.translate(
       offset: Offset(toX*_positionController.value,toY*_positionController.value),
        child: Transform.rotate(
          angle: -_angel*_positionController.value,
          origin: _orrigin,
          child: GestureDetector(
            onHorizontalDragEnd:onHorizontalDragEnd ,
            onHorizontalDragUpdate: onHorizontalDargUpdate,
            child: Scaffold(
              appBar: AppBar(
                title:const Text("Animated Drawer"),
                leading: IconButton(onPressed: _onMenuTaped,icon:const Icon(Icons.menu)),
              ),
            ),
          ),
        ),
    );
  }

  void _OnAnimate() {
    setState(() {

    });
  }

  void onHorizontalDargUpdate(DragUpdateDetails details){
    //print("=======================${details.primaryDelta}");
   // print("=====================${details.primaryDelta!/toX}");
    //print(details.globalPosition);
      endOfDragEnd=details.globalPosition.dx;
    _positionController.value=details.globalPosition.dx/toX;

  }
  void onHorizontalDragEnd(DragEndDetails details){
    print("=========================${details.velocity.pixelsPerSecond.dx}");
    if(endOfDragEnd!<toX/2){
      _positionController.reverse(from: _positionController.value);
      _isOpen=false;
    }else{
      _positionController.forward(from: _positionController.value);
      _isOpen=true;
    }
  }


  void _onMenuTaped() {
    if(!_isOpen){
      _open();
    }else{
      _close();
    }
  }



  void _open(){
    _positionController.forward();
    _isOpen=true;
  }
  void _close(){
    _positionController.reverse();
    _isOpen=false;
  }

}








class myDrawer extends StatelessWidget {
  myDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(child: Text("drawer"),),
    );
  }
}



