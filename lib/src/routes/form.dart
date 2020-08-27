import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import '../config/size_config.dart';
import '../config/styling.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import '../localization/localization_value.dart';

class Forms extends StatefulWidget{
  FormsState createState()=> FormsState();
}

class FormsState extends State<Forms>{

  List<String> ages = [];
  String gender = "ወንድ";
  List<bool> values_1 = [];
  List<bool> values_2 = [];
  List<bool> values_3 = [];
  int _initialValue = 20;
  String initVal = "አሶሳ";
  String initVal_2 = "ማንዱራ";
  String initVal_3 = "ካማሽ";
  String initVal2 = "አሶሳ ዞን";
  var s;
  var loadStatus = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController weredaController = TextEditingController();
  TextEditingController kebeleController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController additionalController = TextEditingController();
  List<String> wereda = ["አሶሳ", "ባምባሲ", "ኦዳቢልዲግሉ", "ሆሞሻ", "ሽርቆሌ", "ኩርሙክ", "መንጌ", "ኡንዱሉ", "ማኦኮሞ"];
  List<String> wereda_1 = ["አሶሳ", "ባምባሲ", "ኦዳቢልዲግሉ", "ሆሞሻ", "ሽርቆሌ", "ኩርሙክ", "መንጌ", "ኡንዱሉ", "ማኦኮሞ"];
  List<String> wereda_2 = ["ማንዱራ", "ፓዊ", "ዳንጉር", "ጉባ", "ድባጢ", "ቡለን", "ወምበራ"];
  List<String> wereda_3 = ["ካማሽ", "ደምቤ", "ያሶ", "ሰዳል", "ምዥጋ"];
  List<String> zone = ["አሶሳ ዞን", "መተከል ዞን", "ካማሽ ዞን"];
  List<String> commonSymptoms = ['Fever', 'Dry Cough', 'Tiredness'];
  List<String> lessSymptoms = ['Muscle and body pain', 'Sore throat', 'Diarrhea',
    'Conjunctivitis', 'Headache', 'Loss of Test and Smell',
    'Rash on skin,discolouration of fingers, toes'];
  List<String> seriousSymptoms = ['Difficult Breathing', 'Chest pain', 'Loss of speach'];
  List<String> commonSymptoms_2 = ['ትኩሳት', 'ደረቅ ሳል', 'ድካም'];
  List<String> lessSymptoms_2 = ['የጡንቻ ወይም የአካል ህመም', 'በጉንፋን የተዘጋ ጉሮሮ',
    'ተቅማጥ', 'የአይን መቅላት', 'ራስ ምታት', 'የመቅመሰ እና ማሽተት ማጣት', 'በቆዳ ላይ ሽፍታ'];
  List<String> seriousSymptoms_2 = ['ለመተንፈስ መቸገር', 'የደረት ህመም', 'የንግግር ማጣት'];
  initState(){
    super.initState();
    _initialSymptomValues();
  }


  dispose(){
    nameController.dispose();
    weredaController.dispose();
    kebeleController.dispose();
    phoneController.dispose();
    additionalController.dispose();
    super.dispose();
  }

  _initialSymptomValues(){
    for(int i=0; i<=2; i++){
      values_1.add(false);
    }
    for(int i=0; i<=6; i++){
      values_2.add(false);
    }
    for(int i=0; i<=2; i++){
      values_3.add(false);
    }
  }

  _handleAgePicker(int value){
    if(value != null){
      setState(() {
        _initialValue = value;
      });
    }
  }

  Future _handleSubmit() async{
    setState(() {
      loadStatus = true;
    });
    String name = nameController.text.toString();
    String wereda;
    String kebele = initVal2;
    String phone = phoneController.text.toString();
    int age = _initialValue;
    String sex = gender;
    String additional = additionalController.text;
    List<String> lessSymptoms = [];
    List<String> seriousSymptoms = [];
    var csm = [];
    for(int i=0;i<3;i++){
      if(values_1[i] == true){
        csm.add('"${this.commonSymptoms_2[i]}"');
      }
    }
    for(int i=0;i<7;i++){
      if(values_2[i] == true){
        lessSymptoms.add('"${this.lessSymptoms_2[i]}"');
      }
    }
    for(int i=0;i<3;i++){
      if(values_3[i] == true){
        seriousSymptoms.add('"${this.seriousSymptoms_2[i]}"');
      }
    }

    if(initVal2.compareTo("አሶሳ ዞን") == 0){
      wereda = initVal;
    }else if(initVal2.compareTo("መተከል ዞን") == 0){
      wereda = initVal_2;
    }else if(initVal2.compareTo("ካማሽ ዞን") == 0){
      wereda = initVal_3;
    }

    Map<String, dynamic> info = {
      "fullName": name,
      "age": age,
      "gender": sex,
      "wereda": wereda,
      "kebele": kebele,
      "phoneNumber": phone,
      "mostCommonSymptoms": csm,
      "lessCommonSymptoms": lessSymptoms,
      "seriousSymptoms": seriousSymptoms,
      "additionalInfo": additional
    };

    var response = await http.post('https://beni-tena.herokuapp.com/answer',
        body: json.encode(info), headers: {"Content-type": "application/json"}
    );
    setState(() {
      loadStatus = false;
    });

    if(response.statusCode == 200){
      final snackBar = SnackBar(
        content: Text(getTranslated(context, 'sent'), style: TextStyle(fontWeight: FontWeight.bold),)
      );
      nameController.clear();
      weredaController.clear();
      kebeleController.clear();
      phoneController.clear();
      additionalController.clear();
      _initialSymptomValues();

      Scaffold.of(context).showSnackBar(snackBar);
    }else if(response.statusCode != 200){
      final snackBar = SnackBar(
          content: Text('Error please try again', style: TextStyle(fontWeight: FontWeight.bold),)
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  // ignore: missing_return
  Widget build(context){

    if(loadStatus == false){
      return buildMainWidget();
    }else if(loadStatus == true){
      return buildProgressBar();
    }
  }

  // ignore: missing_return
  Widget buildMainWidget(){
    Orientation orientation = MediaQuery.of(context).orientation;
    if(orientation == Orientation.portrait){
      return Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: LayoutBuilder(
          builder: (context, constraints){
            return ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: buildColumn(constraints),
                )
              ],
            );
          },
        ),
      );
    }else{
      if(orientation == Orientation.landscape){
        return Container(
          width: SizeConfig.blockSizeVertical * 100,
          height: SizeConfig.blockSizeHorizontal * 100,
          child: LayoutBuilder(
            builder: (context, constraints){
              return ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: buildColumn(constraints),
                  )
                ],
              );
            },
          ),
        );
      }
    }
  }

  Widget buildProgressBar(){
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 4,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  Widget buildColumn(BoxConstraints constraints){
    return Form(
      key: _formKey,
      child: Column(
//      mainAxisAlignment: MainAxisAlignment.s,
        children: <Widget>[
//          buildSelectLang(),

          buildMainTitle1(constraints),

          buildNameField(),

          SizedBox(height: constraints.maxHeight*0.05,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildAgeFieldButton(constraints),
              SizedBox(width: constraints.maxWidth*0.04,),
//            buildGenderTitle(constraints),
              Expanded(
                flex: 2,
                child: buildSexFieldMale(),
              ),
              buildMaleTitle(),
              Expanded(
                flex: 2,
                child: buildSexFieldFemale(),
              ),
              buildFemaleTitle(),
            ],
          ),
        SizedBox(height: constraints.maxHeight*0.05,),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildWeredaDropDown(),
              ),
              SizedBox(
                width: constraints.maxWidth*0.05,
              ),
              Expanded(
                child: _buildZoneField(),
              )
            ],
          ),

          SizedBox(height: constraints.maxHeight*0.05,),

          buildPhoneField(),

          SizedBox(height: constraints.maxHeight*0.05,),

          buildMainTitle2(constraints),

          buildSubTitle1(constraints),

          buildCommonSymptoms(),

          buildSubTitle2(constraints),

          buildLessCommonSymptoms(),

          buildSubTitle3(constraints),

          buildSeriousSymptoms(),

          buildAdditional(),

          SizedBox(height: constraints.maxHeight*0.05,),

          Row(
            children: <Widget>[
              Expanded(
                child: buildSubmitButton(),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildMainTitle1(BoxConstraints constraints){
    double conHeight = constraints.maxHeight;
    return Padding(
      padding: EdgeInsets.only(top: conHeight*0.05),
      child: Align(
        child: Text(getTranslated(context, 'basicInfo'), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        alignment: Alignment.topLeft,
      ),
    );
  }

  Widget buildMainTitle2(BoxConstraints constraints){
    double conHeight = constraints.maxHeight;
    return Padding(
      padding: EdgeInsets.only(bottom: conHeight*0.01),
      child: Align(
        child: Text(getTranslated(context, 'symptoms'), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        alignment: Alignment.topLeft,
      ),
    );
  }

  Widget buildSubTitle1(BoxConstraints constraints){
    double conHeight = constraints.maxHeight;
    return Padding(
      padding: EdgeInsets.only(top: conHeight*0.05, bottom: conHeight*0.02),
      child: Align(
        child: Text(getTranslated(context, 'mostCommon'), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
        alignment: Alignment.topLeft,
      ),
    );
  }

  Widget buildSubTitle2(BoxConstraints constraints){
    double conHeight = constraints.maxHeight;
    return Padding(
      padding: EdgeInsets.only(top: conHeight*0.05, bottom: conHeight*0.02),
      child: Align(
        child: Text(getTranslated(context, 'lessCommon'), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
        alignment: Alignment.topLeft,
      ),
    );
  }

  Widget buildSubTitle3(BoxConstraints constraints){
    double conHeight = constraints.maxHeight;
    return Padding(
      padding: EdgeInsets.only(top: conHeight*0.05, bottom: conHeight*0.02),
      child: Align(
        child: Text(getTranslated(context, 'serious'), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
        alignment: Alignment.topLeft,
      ),
    );
  }

  Widget buildMaleTitle(){
    return Text(getTranslated(context, 'male'));
  }

  Widget buildFemaleTitle(){
    return Text(getTranslated(context, 'female'));
  }

  Widget buildNameField(){
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: getTranslated(context, 'name'),
      ),
      validator: (value){
        if(value.isEmpty){
          return getTranslated(context, 'warn');
        }
        return null;
      },
    );
  }

  Widget _buildWeredaDropDown(){
     if(initVal2.compareTo("አሶሳ ዞን") == 0){
          return _buildWeredaField1();
    }else if(initVal2.compareTo("መተከል ዞን") == 0){
          return _buildWeredaField2();
    }else if(initVal2.compareTo("ካማሽ ዞን") == 0){
          return _buildWeredaField3();
    }
  }

  Widget _buildWeredaField1(){
    return DropdownButton<String>(
      onChanged: (value){
        setState(() {
          initVal = value;
        });
      },
      value: initVal,
      items: wereda_1.map<DropdownMenuItem<String>>((String e) {
         return DropdownMenuItem<String>(
           value: e,
           child: Text(e)
         );
      }).toList(),
    );
  }

  Widget _buildWeredaField2(){
    return DropdownButton<String>(
      onChanged: (value){
        setState(() {
          initVal_2 = value;
        });
      },
      value: initVal_2,
      items: wereda_2.map<DropdownMenuItem<String>>((String e) {
        return DropdownMenuItem<String>(
            value: e,
            child: Text(e)
        );
      }).toList(),
    );
  }

  Widget _buildWeredaField3(){
    return DropdownButton<String>(
      onChanged: (value){
        setState(() {
          initVal_3 = value;
        });
      },
      value: initVal_3,
      items: wereda_3.map<DropdownMenuItem<String>>((String e) {
        return DropdownMenuItem<String>(
            value: e,
            child: Text(e)
        );
      }).toList(),
    );
  }

  Widget _buildZoneField(){
    return DropdownButton<String>(
      value: initVal2,
      onChanged: (value){
        setState(() {
          initVal2 = value;
        });
      },
      items: zone.map<DropdownMenuItem<String>>((String val){
        return DropdownMenuItem<String>(
            value: val,
            child: Text(val)
        );
      }).toList(),
    );
  }

  Widget buildKebeleField(){
    return TextFormField(
      controller: kebeleController,
      decoration: InputDecoration(
        labelText:  getTranslated(context, 'Kebele'),
      ),
      validator: (value){
        if(value.isEmpty){
          return  getTranslated(context, 'warn');
        }
        return null;
      },
    );
  }

  Widget buildPhoneField(){
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        labelText:  getTranslated(context, 'phonenum'),
      ),
      validator: (value){
        if(value.isEmpty){
          return  getTranslated(context, 'warn');
        }
          final Pattern _pattern = r'(^(\+251)+|^0)[9][0-9]{8}\b';
          RegExp regExp = RegExp(_pattern);
          if(regExp.hasMatch(value)){
            return null;
          }else{
            return getTranslated(context, 'warn2');
          }
      },
    );
  }

  Widget buildAgeFieldButton(BoxConstraints constraints){
    double conHeight = constraints.maxHeight;
    double conWidth = constraints.maxWidth;
    return Container(
      height: conHeight*0.07,
      width: conWidth*0.3,
      child: RaisedButton(
        onPressed: _buildNumberPicker,
        child: Text('${getTranslated(context, 'age')} $_initialValue'),
        textColor: AppTheme.navIcon,
        color: AppTheme.appColor,
      ),
    );
  }

  Future _buildNumberPicker() async{
      showDialog<int>(context: context,
      builder: (context){
        return NumberPickerDialog.integer(
            initialIntegerValue: _initialValue,
            minValue: 0,
            maxValue: 99,
            title: Text(getTranslated(context, 'age'))
        );
      }
      ).then(_handleAgePicker);
  }

  Widget buildSexFieldMale(){
         return Radio(
           groupValue: gender,
           value: "ወንድ",
           activeColor: AppTheme.appColor,
           onChanged: (value){
             setState(() {
               gender = value;
             });
           },
         );
  }

  Widget buildSexFieldFemale(){
    return Radio(
      groupValue: gender,
      value: "ሴት",
      activeColor: AppTheme.appColor,
      onChanged: (value){
        setState(() {
          gender = value;
        });
      },
    );
  }

  Widget buildCommonSymptoms(){
    return Column(
      children: <Widget>[
        CheckboxListTile(
          value: values_1[0],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'fever'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
                values_1[0] = value;
            });
          },
        ),
        CheckboxListTile(
          value: values_1[1],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'dryCough'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_1[1] = value;
            });
          },
        ),
        CheckboxListTile(
          value: values_1[2],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'tiredness'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_1[2] = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildLessCommonSymptoms(){
    return Column(
      children: <Widget>[
        CheckboxListTile(
          value: values_2[0],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'aches'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_2[0] = value;
            });
          },
        ),
        CheckboxListTile(
          value: values_2[1],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'sore'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_2[1] = value;
            });
          },
        ),
        CheckboxListTile(
          value: values_2[2],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'diarrhea'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_2[2] = value;
            });
          },
        ),
        CheckboxListTile(
          value: values_2[3],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'conj'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_2[3] = value;
            });
          },
        ),
        CheckboxListTile(
          value: values_2[4],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'head'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_2[4] = value;
            });
          },
        ),
        CheckboxListTile(
          value: values_2[5],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'loss'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_2[5] = value;
            });
          },
        ),
        CheckboxListTile(
          value: values_2[6],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'rash'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_2[6] = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildSeriousSymptoms(){
    return Column(
      children: <Widget>[
        CheckboxListTile(
          value: values_3[0],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'difficult'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_3[0] = value;
            });
          },
        ),
        CheckboxListTile(
          value: values_3[1],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'chest'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_3[1] = value;
            });
          },
        ),
        CheckboxListTile(
          value: values_3[2],
          activeColor: AppTheme.appColor,
          secondary: Text(getTranslated(context, 'lossOfSpeech'), style: TextStyle(fontSize: 16),),
          onChanged: (value){
            setState(() {
              values_3[2] = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildAdditional(){
    return TextFormField(
      controller: additionalController,
      decoration: InputDecoration(
        labelText: getTranslated(context, 'additionalInfo'),
      ),
      maxLines: 5,
    );
  }

  Widget buildSubmitButton(){
    return RaisedButton(
      onPressed: (){
        var form = _formKey.currentState;
        if(form.validate()){
          _handleSubmit();
        }
      },
      color: AppTheme.appColor,
      child: Text(getTranslated(context, 'submit'), style: TextStyle(color: Colors.white, fontSize: 17),),
    );
  }
}