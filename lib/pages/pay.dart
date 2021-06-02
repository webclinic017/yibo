import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/IndexBack.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class pay extends StatefulWidget {
  Map data;
  pay(this.data);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<pay> {
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 25.0,
            color: Colors.white, //修改颜色
          ),
          backgroundColor: Color(0xfffa2020),
          title: Text("充值",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
           Column(

             children: <Widget>[
               Container(
                 margin: EdgeInsets.only(top: 20,bottom: 20),
                 child: Text((widget.data["actual_price"]).toString()+"元",style: TextStyle(color: Colors.red,fontSize: 24),),
               ),
               Container(
                 margin: EdgeInsets.only(top: 20,bottom: 20),
                 child: Image.network(widget.data["type"]==1?widget.data["ali_ewm"]:widget.data["wx_ewm"],fit: BoxFit.fill,),
               ),

               Container(
                 margin: EdgeInsets.only(top: 20,bottom: 20),
                 child: Wrap(
                   direction: Axis.vertical,
                   spacing: 15,
                   children: <Widget>[
                     Text("1、截屏保存到手机"),
                     widget.data["type"]==1?Text("2、打开支付宝扫一扫相册二维码"):Text("2、打开微信扫一扫相册二维码")
                   ],
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(top: 20),
                 child: MaterialButton(
                   minWidth: 200,
                   color: Colors.red,
                   onPressed: ()async{
                     ResultData res = await HttpManager.getInstance().post("recharge/submit_recharge",params: {"price":widget.data["actual_price"],"type":widget.data["type"]},withLoading: false);

                     Toast.toast(context,msg: "申请成功");
                     JumpAnimation().jump(new IndexBack(), context);

                   },
                   child: Text("提交支付申请",style: TextStyle(color: Colors.white),),
                 ),
               )
             ],
           )

          ],
        ),
      ),
    );
  }
}
