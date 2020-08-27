import '../config/size_config.dart';
import 'package:flutter/material.dart';
import '../localization/localization_value.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Help extends StatefulWidget{
  HelpState createState()=> HelpState();
}

class HelpState extends State<Help>{
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    if(orientation == Orientation.portrait){
      return _buildPortrait();
    }
    return _buildLandScape();
  }

  Widget _buildPortrait(){
    return Container(
      height: SizeConfig.blockSizeVertical*100,
      width: SizeConfig.blockSizeHorizontal*100,
//      color: Colors.green,
      child: LayoutBuilder(
        builder: (context, constraints){
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: constraints.maxHeight*0.03,),
                _buildCardOne(constraints),
                SizedBox(height: constraints.maxHeight*0.03,),
                _buildCardTwo(constraints),
                SizedBox(height: constraints.maxHeight*0.03,),
                _buildCardThree(constraints),
                SizedBox(height: constraints.maxHeight*0.03,),
                _buildCardFour(constraints),
                SizedBox(height: constraints.maxHeight*0.03,),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildLandScape(){
    return Container(
      height: SizeConfig.blockSizeHorizontal*100,
      width: SizeConfig.blockSizeVertical*100,
//      color: Colors.green,
      child: LayoutBuilder(
        builder: (context, constraints){
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: constraints.maxHeight*0.1,),
                _buildCardOneL(constraints),
                SizedBox(height: constraints.maxHeight*0.1,),
                _buildCardTwoL(constraints),
                SizedBox(height: constraints.maxHeight*0.1,),
                _buildCardThreeL(constraints),
                SizedBox(height: constraints.maxHeight*0.1,),
                _buildCardFourL(constraints),
                SizedBox(height: constraints.maxHeight*0.1,),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardOne(BoxConstraints constraints){
    return Container(
        height: constraints.maxHeight*0.20,
        width: constraints.maxWidth*0.95,
//        color: Colors.brown,
        child: LayoutBuilder(
          builder: (context, constraint){
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Row(
                  children: [
                    Container(
                        height: constraint.maxHeight,
                        width: constraint.maxWidth*0.3,
//                        color: Colors.white,
                        child: Center(
                          child: CircleAvatar(
                            radius: constraints.maxHeight*0.07,
                            backgroundImage: AssetImage('assets/image/h1.jpg'),
//                            child: ,
                          ),
                        )
                    ),
                    SizedBox(width: constraints.maxWidth*0.025,),
                    Container(
                        height: constraint.maxHeight,
                        width: constraint.maxWidth*0.6699,
//                        color: Colors.blue,
                        child: Center(
                          child: AutoSizeText(
                            getTranslated(context, 'prev1'),
                            style: TextStyle(fontSize: 19),
                          ),
                        )
                    )
                  ],
                ),
            );
          },
        )
    );
  }
  Widget _buildCardTwo(BoxConstraints constraints){
    return Container(
        height: constraints.maxHeight*0.20,
        width: constraints.maxWidth*0.95,
//        color: Colors.brown,
        child: LayoutBuilder(
          builder: (context, constraint){
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.3,
//                        color: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius:  constraints.maxHeight*0.07,
                          backgroundImage: AssetImage('assets/image/h2.jpg'),
//                            child: ,
                        ),
                      )
                  ),
                  SizedBox(width: constraints.maxWidth*0.025,),
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.6699,
//                        color: Colors.blue,
                      child: Center(
                        child: AutoSizeText(
                          getTranslated(context, 'prev2'),
                          style: TextStyle(fontSize: 19),
                        ),
                      )
                  )
                ],
              ),
            );
          },
        )
    );
  }
  Widget _buildCardThree(BoxConstraints constraints){
    return Container(
        height: constraints.maxHeight*0.20,
        width: constraints.maxWidth*0.95,
//        color: Colors.brown,
        child: LayoutBuilder(
          builder: (context, constraint){
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.3,
//                        color: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius:  constraints.maxHeight*0.07,
                          backgroundImage: AssetImage('assets/image/h3.jpg'),
//                            child: ,
                        ),
                      )
                  ),
                  SizedBox(width: constraints.maxWidth*0.025,),
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.6699,
//                        color: Colors.blue,
                      child: Center(
                        child: AutoSizeText(
                          getTranslated(context, 'prev3'),
                          style: TextStyle(fontSize: 19),
                        ),
                      )
                  )
                ],
              ),
            );
          },
        )
    );
  }
  Widget _buildCardFour(BoxConstraints constraints){
    return Container(
        height: constraints.maxHeight*0.20,
        width: constraints.maxWidth*0.95,
//        color: Colors.brown,
        child: LayoutBuilder(
          builder: (context, constraint){
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.3,
//                        color: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius:  constraints.maxHeight*0.07,
                          backgroundImage: AssetImage('assets/image/h4.jpg'),
//                            child: ,
                        ),
                      )
                  ),
                  SizedBox(width: constraints.maxWidth*0.025,),
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.6699,
//                        color: Colors.blue,
                      child: Center(
                        child: AutoSizeText(
                          getTranslated(context, 'prev4'),
                          style: TextStyle(fontSize: 19),
                        ),
                      )
                  )
                ],
              ),
            );
          },
        )
    );
  }

  Widget _buildCardOneL(BoxConstraints constraints){
    return Container(
        height: constraints.maxHeight*0.28,
        width: constraints.maxWidth*0.95,
//        color: Colors.brown,
        child: LayoutBuilder(
          builder: (context, constraint){
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.3,
//                        color: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius: constraints.maxHeight*0.15,
                          backgroundImage: AssetImage('assets/image/h1.jpg'),
//                            child: ,
                        ),
                      )
                  ),
                  SizedBox(width: constraints.maxWidth*0.025,),
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.6699,
//                        color: Colors.blue,
                      child: Center(
                        child: AutoSizeText(
                          getTranslated(context, 'prev1'),
                          style: TextStyle(fontSize: 19),
                        ),
                      )
                  )
                ],
              ),
            );
          },
        )
    );
  }
  Widget _buildCardTwoL(BoxConstraints constraints){
    return Container(
        height: constraints.maxHeight*0.28,
        width: constraints.maxWidth*0.95,
//        color: Colors.brown,
        child: LayoutBuilder(
          builder: (context, constraint){
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.3,
//                        color: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius:  constraints.maxHeight*0.15,
                          backgroundImage: AssetImage('assets/image/h2.jpg'),
//                            child: ,
                        ),
                      )
                  ),
                  SizedBox(width: constraints.maxWidth*0.025,),
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.6699,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            getTranslated(context, 'prev2'),
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                  )
                ],
              ),
            );
          },
        )
    );
  }
  Widget _buildCardThreeL(BoxConstraints constraints){
    return Container(
        height: constraints.maxHeight*0.28,
        width: constraints.maxWidth*0.95,
//        color: Colors.brown,
        child: LayoutBuilder(
          builder: (context, constraint){
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.3,
//                        color: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius:  constraints.maxHeight*0.15,
                          backgroundImage: AssetImage('assets/image/h3.jpg'),
//                            child: ,
                        ),
                      )
                  ),
                  SizedBox(width: constraints.maxWidth*0.025,),
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.6699,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            getTranslated(context, 'prev3'),
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                  )
                ],
              ),
            );
          },
        )
    );
  }
  Widget _buildCardFourL(BoxConstraints constraints){
    return Container(
        height: constraints.maxHeight*0.28,
        width: constraints.maxWidth*0.95,
//        color: Colors.brown,
        child: LayoutBuilder(
          builder: (context, constraint){
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.3,
//                        color: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius:  constraints.maxHeight*0.15,
                          backgroundImage: AssetImage('assets/image/h4.jpg'),
//                            child: ,
                        ),
                      )
                  ),
                  SizedBox(width: constraints.maxWidth*0.025,),
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.6699,
//                        color: Colors.blue,
                      child: Center(
                        child: AutoSizeText(
                          getTranslated(context, 'prev4'),
                          style: TextStyle(fontSize: 19),
                        ),
                      )
                  )
                ],
              ),
            );
          },
        )
    );
  }

}