import 'package:covid19/src/localization/localization_value.dart';
import 'package:flutter/material.dart';
import '../fetch/get_api_data.dart';
import '../config/size_config.dart';
import '../config/styling.dart';


class More extends StatefulWidget{
  MoreState createState()=> MoreState();
}

class MoreState extends State<More>{

  Map<String, dynamic> globalData;
  Map<String, dynamic> countryData;
  int flagState = 0;
  int checkUp = 0;

  initState(){
    super.initState();
    _initConnValues();
  }

  _initConnValues(){
    setState(() {
      flagState = 0;
    });
    CovidInfo.getGlobal().then((res){
      _setGlobalValues(res);
    }).then((val){
      CovidInfo.getCountry().then((res){
        _setLocalValues(res);
      }).then((value){
        if(checkUp == 2){
          setState(() {
            checkUp = 0;
            flagState = 1;
          });
        }
      });
    }).catchError((err){
      setState(() {
        checkUp = 0;
        flagState = 2;
      });
    });
  }

  _setGlobalValues(res){
    globalData = Map.from(res);
    checkUp++;
    return checkUp;
  }

  _setLocalValues(res){
    countryData = Map.from(res);
    checkUp++;
    return checkUp;
  }

  Widget build(context){
    Orientation orientation = MediaQuery.of(context).orientation;
    if(flagState == 0){
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 4,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      );
    }else if(flagState == 2){
      if(orientation == Orientation.portrait){
        return _buildErrorPage();
      }
      return _buildErrorPageLandScape();
    }
    if(orientation == Orientation.portrait){
      return _buildPortrait();
    }
    return _buildLandScape();
  }

  Widget _buildLandScape(){
    return Container(
      height: SizeConfig.blockSizeHorizontal*100,
      width: SizeConfig.blockSizeVertical*100,
      child: LayoutBuilder(
        builder: (context, constraints){
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: constraints.maxHeight*0.07),
                _buildTitle1(),
                SizedBox(height: constraints.maxHeight*0.05),
                _buildGlobal(),
                SizedBox(height: constraints.maxHeight*0.05),
                _buildTitle2(),
                SizedBox(height: constraints.maxHeight*0.05),
                _buildCountry(),
                SizedBox(height: constraints.maxHeight*0.05),
                _buildRefreshButton(constraints),
                SizedBox(height: constraints.maxHeight*0.05)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPortrait(){
    return Container(
      height: SizeConfig.blockSizeVertical*100,
      width: SizeConfig.blockSizeHorizontal*100,
      child: LayoutBuilder(
        builder: (context, constraints){
          return Stack(
            children: [
              _buildHeadContainer(constraints),
              Padding(
                padding: EdgeInsets.only(top: constraints.maxHeight*0.14),
                child: _buildBodyContainer(constraints),
              )
            ],
          );
        },
      )
    );
  }

  Widget _buildHeadContainer(BoxConstraints constraints){
    return Container(
      height: constraints.maxHeight*0.2,
      width: constraints.maxWidth,
      color: AppTheme.appColor,
      child: Padding(
        padding: EdgeInsets.only(left: constraints.maxWidth*0.03, bottom: constraints.maxHeight*0.05),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              _buildRefreshButton(constraints),
              SizedBox(width: constraints.maxWidth*0.03),
              Text(getTranslated(context, 'current'), style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20, color: AppTheme.navIcon))
            ],
          )
        ),
      ),
    );
  }

  Widget _buildBodyContainer(BoxConstraints constraints){
    return Container(
      height: constraints.maxHeight*0.859,
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
      ),
      child: LayoutBuilder(
        builder: (context, constraints){
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight*0.03,),
                _buildTitle1(),
                SizedBox(height: constraints.maxHeight*0.03,),
                _buildGlobal(),
                SizedBox(height: constraints.maxHeight*0.03,),
                _buildTitle2(),
                SizedBox(height: constraints.maxHeight*0.03,),
                _buildCountry(),
                SizedBox(height: constraints.maxHeight*0.03,),
                // _buildRefreshButton(constraints)
              ],
            ),
          );
        },
      )
    );
  }

  Widget _buildTitle1(){
    return Text(getTranslated(context, 'total'), style: TextStyle(fontWeight: FontWeight.bold,
    fontSize: 20),);
  }

  Widget _buildTitle2(){
    return Text(getTranslated(context, 'covidEth'), style: TextStyle(fontWeight: FontWeight.bold,
    fontSize: 20),);
  }

  Widget _buildGlobal(){
    return Column(
      children: [
        ListTile(
          leading: Text(getTranslated(context, 'confirmed'), style: TextStyle(fontSize: 17),),
          trailing: Text('${globalData['confirmed']}', style: TextStyle(fontSize: 17)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'recovered'), style: TextStyle(fontSize: 17)),
          trailing: Text('${globalData['recovered']}', style: TextStyle(fontSize: 17)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'death'), style: TextStyle(fontSize: 17)),
          trailing: Text('${globalData['deaths']}', style: TextStyle(fontSize: 17)),
        ),
      ],
    );
  }

  Widget _buildCountry(){
    return Column(
      children: [
        ListTile(
          leading: Text(getTranslated(context, 'confirmed'), style: TextStyle(fontSize: 17),),
          trailing: Text('${countryData['confirmed']}', style: TextStyle(fontSize: 17)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'recovered'), style: TextStyle(fontSize: 17)),
          trailing: Text('${countryData['recovered']}', style: TextStyle(fontSize: 17)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'death'), style: TextStyle(fontSize: 17)),
          trailing: Text('${countryData['deaths']}', style: TextStyle(fontSize: 17)),
        ),
      ],
    );
  }

  Widget _buildRefreshButton(BoxConstraints constraints){
    return RaisedButton(
      onPressed: (){
        _initConnValues();
      },
      child: Icon(Icons.refresh, color: AppTheme.navIcon,),
      color: AppTheme.appColor2
      // backgroundColor: AppTheme.appColor2,
    );
  }

  Widget _buildErrorPage(){
    return Container(
        height: SizeConfig.blockSizeVertical*100,
        width: SizeConfig.blockSizeHorizontal*100,
        child: LayoutBuilder(
          builder: (context, constraints){
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  SizedBox(height: constraints.maxHeight*0.2,),
                  Container(
                      height: constraints.maxHeight*0.3,
                      width: constraints.maxWidth*0.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/404err.jpg'),
                              fit: BoxFit.scaleDown
                          )
                      )
                  ),
                  SizedBox(height: constraints.maxHeight*0.1,),
                  Container(
                      height: constraints.maxHeight*0.35,
                      width: constraints.maxWidth,
                      child: LayoutBuilder(
                          builder: (context, constraints){
                            return Align(
                              alignment: Alignment.topCenter,
                              child: MaterialButton(
                                child: Text(getTranslated(context, 'refresh'), style: TextStyle(color: AppTheme.navIcon),),
                                height: constraints.maxHeight*0.2,
                                color: AppTheme.appColor,
                                onPressed: (){
                                  setState(() {
                                    flagState = 0;
                                    _initConnValues();
                                  });
                                },
                              ),
                            ) ;
                          }
                      )
                  )
                ]
            );
          },
        )
    );
  }

  Widget _buildErrorPageLandScape(){
    return Container(
        height: SizeConfig.blockSizeHorizontal*100,
        width: SizeConfig.blockSizeVertical*100,
        child: LayoutBuilder(
          builder: (context, constraints){
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  SizedBox(height: constraints.maxHeight*0.2,),
                  Container(
                      height: constraints.maxHeight*0.3,
                      width: constraints.maxWidth*0.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/404err.jpg'),
                              fit: BoxFit.scaleDown
                          )
                      )
                  ),
                  SizedBox(height: constraints.maxHeight*0.1,),
                  Container(
                      height: constraints.maxHeight*0.35,
                      width: constraints.maxWidth,
                      child: LayoutBuilder(
                          builder: (context, constraints){
                            return Align(
                              alignment: Alignment.topCenter,
                              child: MaterialButton(
                                child: Text(getTranslated(context, 'refresh'), style: TextStyle(color: AppTheme.navIcon),),
                                height: constraints.maxHeight*0.4,
                                color: AppTheme.appColor,
                                onPressed: (){
                                  setState(() {
                                    flagState = 0;
                                    _initConnValues();
                                  });
                                },
                              ),
                            ) ;
                          }
                      )
                  )
                ]
            );
          },
        )
    );
  }

}