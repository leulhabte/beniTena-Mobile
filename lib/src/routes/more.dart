import 'package:covid19/src/localization/localization_value.dart';
import 'package:flutter/material.dart';
import '../fetch/get_api_data.dart';
import '../config/size_config.dart';
import '../config/styling.dart';
import 'package:intl/intl.dart';


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

  var confirmed = '0';
  var recovered = '0';
  var death = '0';

  var confirmedLocal = '0';
  var recoveredLocal = '0';
  var deathLocal = '0';

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
            confirmed = NumberFormat.compact().format(globalData['confirmed']);
            recovered = NumberFormat.compact().format(globalData['recovered']);
            death = NumberFormat.compact().format(globalData['deaths']);
            confirmedLocal = NumberFormat.compact().format(countryData['confirmed']);
            recoveredLocal = NumberFormat.compact().format(countryData['recovered']);
            deathLocal = NumberFormat.compact().format(countryData['deaths']);
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
                _buildTitle1LandScape(constraints),
                SizedBox(height: constraints.maxHeight*0.05),
                _buildGlobalLandScape(constraints),
                SizedBox(height: constraints.maxHeight*0.05),
                _buildTitle2LandScape(constraints),
                SizedBox(height: constraints.maxHeight*0.05),
                _buildCountryLandScape(constraints),
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
                  fontSize: constraints.maxHeight*0.04, color: AppTheme.navIcon))
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
                _buildTitle1(constraints),
                SizedBox(height: constraints.maxHeight*0.03,),
                _buildGlobal(constraints),
                SizedBox(height: constraints.maxHeight*0.03,),
                _buildTitle2(constraints),
                SizedBox(height: constraints.maxHeight*0.03,),
                _buildCountry(constraints),
                SizedBox(height: constraints.maxHeight*0.03,),
                // _buildRefreshButton(constraints)
              ],
            ),
          );
        },
      )
    );
  }

  Widget _buildTitle1(BoxConstraints constraints){
    return Text(getTranslated(context, 'total'), style: TextStyle(fontWeight: FontWeight.bold,
    fontSize:  constraints.maxHeight*0.04),);
  }

  Widget _buildTitle2(BoxConstraints constraints){
    return Text(getTranslated(context, 'covidEth'), style: TextStyle(fontWeight: FontWeight.bold,
    fontSize:  constraints.maxHeight*0.04),);
  }

  Widget _buildGlobal(BoxConstraints constraints){
    return Column(
      children: [
        ListTile(
          leading: Text(getTranslated(context, 'confirmed'), style: TextStyle(fontSize: constraints.maxHeight*0.035),),
          trailing: Text('$confirmed', style: TextStyle(fontSize: constraints.maxHeight*0.035)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'recovered'), style: TextStyle(fontSize: constraints.maxHeight*0.035)),
          trailing: Text('$recovered', style: TextStyle(fontSize: constraints.maxHeight*0.035)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'death'), style: TextStyle(fontSize: constraints.maxHeight*0.035)),
          trailing: Text('$death', style: TextStyle(fontSize: constraints.maxHeight*0.035)),
        ),
      ],
    );
  }

  Widget _buildCountry(BoxConstraints constraints){
    return Column(
      children: [
        ListTile(
          leading: Text(getTranslated(context, 'confirmed'), style: TextStyle(fontSize: constraints.maxHeight*0.035),),
          trailing: Text('$confirmedLocal', style: TextStyle(fontSize: constraints.maxHeight*0.035)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'recovered'), style: TextStyle(fontSize: constraints.maxHeight*0.035)),
          trailing: Text('$recoveredLocal', style: TextStyle(fontSize: constraints.maxHeight*0.035)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'death'), style: TextStyle(fontSize: constraints.maxHeight*0.035)),
          trailing: Text('$deathLocal', style: TextStyle(fontSize: constraints.maxHeight*0.035)),
        ),
      ],
    );
  }

  Widget _buildTitle1LandScape(BoxConstraints constraints){
    return Text(getTranslated(context, 'total'), style: TextStyle(fontWeight: FontWeight.bold,
        fontSize:  constraints.maxHeight*0.1),);
  }

  Widget _buildTitle2LandScape(BoxConstraints constraints){
    return Text(getTranslated(context, 'covidEth'), style: TextStyle(fontWeight: FontWeight.bold,
        fontSize:  constraints.maxHeight*0.1),);
  }

  Widget _buildGlobalLandScape(BoxConstraints constraints){
    return Column(
      children: [
        ListTile(
          leading: Text(getTranslated(context, 'confirmed'), style: TextStyle(fontSize: constraints.maxHeight*0.065),),
          trailing: Text('$confirmed', style: TextStyle(fontSize: constraints.maxHeight*0.065)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'recovered'), style: TextStyle(fontSize: constraints.maxHeight*0.065)),
          trailing: Text('$recovered', style: TextStyle(fontSize: constraints.maxHeight*0.065)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'death'), style: TextStyle(fontSize: constraints.maxHeight*0.065)),
          trailing: Text('$death', style: TextStyle(fontSize: constraints.maxHeight*0.065)),
        ),
      ],
    );
  }

  Widget _buildCountryLandScape(BoxConstraints constraints){
    return Column(
      children: [
        ListTile(
          leading: Text(getTranslated(context, 'confirmed'), style: TextStyle(fontSize: constraints.maxHeight*0.065),),
          trailing: Text('$confirmedLocal', style: TextStyle(fontSize: constraints.maxHeight*0.065)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'recovered'), style: TextStyle(fontSize: constraints.maxHeight*0.065)),
          trailing: Text('$recoveredLocal', style: TextStyle(fontSize: constraints.maxHeight*0.065)),
        ),
        ListTile(
          leading: Text(getTranslated(context, 'death'), style: TextStyle(fontSize: constraints.maxHeight*0.065)),
          trailing: Text('$deathLocal', style: TextStyle(fontSize: constraints.maxHeight*0.065)),
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
                  SizedBox(height: constraints.maxHeight*0.1,),
                  Container(
                      height: constraints.maxHeight*0.3,
                      width: constraints.maxWidth*0.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/404err.png'),
                              fit: BoxFit.contain
                          )
                      )
                  ),
                  Container(
                    child: Align(
                      child: Text(getTranslated(context, 'err'), style: TextStyle(fontSize: constraints.maxHeight*0.04),),
                    ),
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
                      height: constraints.maxHeight*0.2,
                      width: constraints.maxWidth*0.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/404err.png'),
                              fit: BoxFit.scaleDown
                          )
                      )
                  ),
                  SizedBox(height: constraints.maxHeight*0.1,),
                  Container(
                    child: Align(
                      child: Text(getTranslated(context, 'err'), style: TextStyle(fontSize: constraints.maxHeight*0.06),),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight*0.1,),
                  Container(
                      height: constraints.maxHeight*0.3,
                      width: constraints.maxWidth,
                      child: LayoutBuilder(
                          builder: (context, constraints){
                            return Align(
                              alignment: Alignment.topCenter,
                              child: MaterialButton(
                                child: Text(getTranslated(context, 'refresh'), style: TextStyle(color: AppTheme.navIcon),),
                                height: constraints.maxHeight*0.35,
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