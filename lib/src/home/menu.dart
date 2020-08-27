import 'package:flutter/material.dart';
import '../config/size_config.dart';
import '../config/styling.dart';
import 'package:auto_size_text/auto_size_text.dart';
import './home.dart';
import '../localization/localization_value.dart';

class Menus extends StatefulWidget{
  MenuState createState()=> MenuState();
}

class MenuState extends State<Menus>{
  Widget build(context){
    Orientation orientation = MediaQuery.of(context).orientation;
    if(orientation == Orientation.portrait){
      return _buildMainContainerPortrait();
    }else if(orientation == Orientation.landscape){
      return _buildMainContainerLandscape();
    }
  }

  Widget _buildMainContainerPortrait(){
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: SizeConfig.blockSizeVertical,
        width: SizeConfig.blockSizeHorizontal,
        color: AppTheme.navIcon,
        child: LayoutBuilder(
          builder: (context, constraint){
            return Stack(
              children: [
                _buildTitleContainer(constraint),
                Padding(
                  padding: EdgeInsets.only(top: constraint.maxHeight*0.19),
                  child: LayoutBuilder(
                    builder: (context, constraint){
                      return _buildMenuPortrait(constraint);
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
  Widget _buildTitleContainer(BoxConstraints constraints){
    return Container(
      height: constraints.maxHeight*0.32,
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        color: AppTheme.appColor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(getTranslated(context, 'welcome'), style: TextStyle(color: AppTheme.navIcon, fontWeight: FontWeight.bold, fontSize: 24),),
          SizedBox(height: constraints.maxHeight*0.02,),
          Text(getTranslated(context, 'stay'), style: TextStyle(color: AppTheme.navIcon, fontWeight: FontWeight.bold, fontSize: 20),)
        ],
      ),
    );
  }
  Widget _buildMainContainerLandscape(){
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: SizeConfig.blockSizeHorizontal,
        width: SizeConfig.blockSizeVertical,
        color: AppTheme.appColor,
        child: LayoutBuilder(
          builder: (context, constraint){
            return Column(
              children: [
                _buildLandscapeMainTitle(constraint),
                SizedBox(height: constraint.maxHeight*0.12),
                _buildLandscapeBody(constraint)
              ],
            );
          },
        )
      ),
    );
  }
  Widget _buildMenuPortrait(BoxConstraints constraint){
    return Container(
      height: constraint.maxHeight*0.95,
      width: constraint.maxWidth,
      child: LayoutBuilder(
        builder: (context, constraint){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap:(){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Home(0)));},
                child: _buildInsertCard(constraint),
              ),
              SizedBox(height: constraint.maxHeight*0.06,),
              InkWell(
                onTap:(){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Home(1)));},
                child: _buildViewCard(constraint),
              ),
              SizedBox(height: constraint.maxHeight*0.06,),
              InkWell(
                onTap:(){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Home(2)));},
                child: _buildMoreCard(constraint),
              )
            ],
          );
        },
      ),
    );
  }
  Widget _buildInsertCard(BoxConstraints constraints){
    return Container(
      height: constraints.maxHeight*0.23,
      width: constraints.maxWidth*0.8,
      decoration: BoxDecoration(
        color: AppTheme.appColor2,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 15.0
          )
        ]
      ),
      child: LayoutBuilder(
        builder: (context, constraint){
          return Padding(
            padding: EdgeInsets.all(0.0),
            child: Card(
              color: AppTheme.appColor2,
              margin: EdgeInsets.all(0),
              child: Row(
                children: [
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.3,
                      color: AppTheme.appColor2,
                      child: Center(
                        child: Icon(Icons.playlist_add, size: 75.0,color: AppTheme.navIcon,),
                      )
                  ),
                  Container(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth*0.6699,
                      color: AppTheme.appColor2,
                      child: Center(
                        child: AutoSizeText(
                          getTranslated(context, 'menuAdd'),
                          style: TextStyle(color: AppTheme.navIcon, fontSize: 19),
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
  Widget _buildViewCard(BoxConstraints constraints){
    return Container(
        height: constraints.maxHeight*0.23,
        width: constraints.maxWidth*0.8,
        decoration: BoxDecoration(
            color: AppTheme.appColor2,
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 15.0
              )
            ]
        ),
        child: LayoutBuilder(
          builder: (context, constraint){
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Card(
                color: AppTheme.appColor2,
                margin: EdgeInsets.all(0),
                child: Row(
                  children: [
                    Container(
                        height: constraint.maxHeight,
                        width: constraint.maxWidth*0.3,
                        color: AppTheme.appColor2,
                        child: Center(
                          child: Icon(Icons.remove_red_eye, size: 75.0,color: AppTheme.navIcon,),
                        )
                    ),
                    Container(
                        height: constraint.maxHeight,
                        width: constraint.maxWidth*0.6699,
                        color: AppTheme.appColor2,
                        child: Center(
                          child: AutoSizeText(
                            getTranslated(context, 'viewBasic'),
                            style: TextStyle(color: AppTheme.navIcon, fontSize: 18),
                          ),
                        )
                    )
                  ],
                ),
              ),
            );
          },
        )
    );
  }
  Widget _buildMoreCard(BoxConstraints constraints){
    return Container(
        height: constraints.maxHeight*0.23,
        width: constraints.maxWidth*0.8,
        decoration: BoxDecoration(
            color: AppTheme.appColor2,
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 15.0
              )
            ]
        ),
        child: LayoutBuilder(
          builder: (context, constraint){
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: Card(
                color: AppTheme.appColor2,
                margin: EdgeInsets.all(0),
                child: Row(
                  children: [
                    Container(
                        height: constraint.maxHeight,
                        width: constraint.maxWidth*0.3,
                        color: AppTheme.appColor2,
                        child: Center(
                          child: Icon(Icons.info_outline, size: 75.0,color: AppTheme.navIcon,),
                        )
                    ),
                    Container(
                        height: constraint.maxHeight,
                        width: constraint.maxWidth*0.6699,
                        color: AppTheme.appColor2,
                        child: Center(
                          child: AutoSizeText(
                            getTranslated(context, 'more'),
                            style: TextStyle(color: AppTheme.navIcon, fontSize: 18),
                          ),
                        )
                    )
                  ],
                ),
              ),
            );
          },
        )
    );
  }
  Widget _buildLandscapeMainTitle(BoxConstraints constraints){
    return Column(
      children: [
        SizedBox(height: constraints.maxHeight*0.09,),
        Text(getTranslated(context, 'welcome'), style: TextStyle(color: AppTheme.navIcon, fontWeight: FontWeight.bold, fontSize: 24),),
        SizedBox(height: constraints.maxHeight*0.05,),
        Text(getTranslated(context, 'stay'), style: TextStyle(color: AppTheme.navIcon, fontWeight: FontWeight.bold, fontSize: 20),)
      ],
    );
  }
  Widget _buildLandscapeBody(BoxConstraints constraints){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          InkWell(
            onTap:(){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Home(0)));},
            child: _buildInsertCardLandscape(constraints),
          ),
          SizedBox(width: constraints.maxWidth*0.04,),
          InkWell(
            onTap:(){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Home(1)));},
            child: _buildViewCardLandscape(constraints),
          ),
          SizedBox(width: constraints.maxWidth*0.04,),
          InkWell(
            onTap:(){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Home(2)));},
            child: _buildMoreCardLandscape(constraints),
          )
      ],
    );
  }
  Widget _buildInsertCardLandscape(BoxConstraints constraints){
    return Container(
      height: constraints.maxHeight*0.43,
      width: constraints.maxWidth*0.28,
      color: AppTheme.appColor2,
      child: LayoutBuilder(
        builder: (context, constraints){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: constraints.maxHeight*0.4,
                width: constraints.maxWidth,
                child: Icon(Icons.playlist_add, size: 70, color: AppTheme.navIcon,),
              ),
              Container(
                height: constraints.maxHeight*0.6,
                width: constraints.maxWidth,
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Center(
                    child: AutoSizeText(
                      getTranslated(context, 'menuAdd'),
                      style: TextStyle(color: AppTheme.navIcon, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget _buildViewCardLandscape(BoxConstraints constraints){
    return Container(
      height: constraints.maxHeight*0.43,
      width: constraints.maxWidth*0.28,
      color: AppTheme.appColor2,
      child: LayoutBuilder(
        builder: (context, constraints){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: constraints.maxHeight*0.4,
                width: constraints.maxWidth,
                child: Icon(Icons.remove_red_eye, size: 70, color: AppTheme.navIcon,),
              ),
              Container(
                height: constraints.maxHeight*0.6,
                width: constraints.maxWidth,
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Center(
                    child: AutoSizeText(
                      getTranslated(context, 'viewBasic2'),
                      style: TextStyle(color: AppTheme.navIcon, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget _buildMoreCardLandscape(BoxConstraints constraints){
    return Container(
      height: constraints.maxHeight*0.43,
      width: constraints.maxWidth*0.28,
      color: AppTheme.appColor2,
      child: LayoutBuilder(
        builder: (context, constraints){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: constraints.maxHeight*0.4,
                width: constraints.maxWidth,
                child: Icon(Icons.info_outline, size: 70, color: AppTheme.navIcon,),
              ),
              Container(
                height: constraints.maxHeight*0.6,
                width: constraints.maxWidth,
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Center(
                    child: AutoSizeText(
                      getTranslated(context, 'more2'),
                      style: TextStyle(color: AppTheme.navIcon, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}