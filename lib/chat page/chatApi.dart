import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bjppage/NotiFcationPageBjp/Notification%20Model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../bjppage/const.dart';


class ChateApis
{

  //-------
  List<String> b = ["lksa"];
  String _baseurl = "https://bjp.vyaparway.com/chatify/api";
  String _baseurl1 = "https://bjp.vyaparway.com/api";
  var hed ={
  HttpHeaders.authorizationHeader: tocken,
  };

  //-------------------

  //get Chat List for all chat
  Future<Map<String,dynamic>?>  fatMessage() async
  {
    String _url = "/fetchMessages?page=1";

    var resp = await http.post(Uri.parse(_baseurl+_url),
    body: {
      "id":"254"
    },
      headers:{
        HttpHeaders.authorizationHeader: tocken,
      }
    );

    if(resp.statusCode ==200)
      {
        var chats = jsonDecode(resp.body);
        return chats;
      }
    else
      {
        print(resp.statusCode);
      }

  }


  void sendMEssage({
    required String receverId,
    required String messag,
})async
  {
    String url = "/sendMessage";

    try{
      var resp = await http.post(Uri.parse(_baseurl+url)
          ,headers: hed,
          body: {
            "file":"",
            "id":receverId,
            "type":"user",
            "message":messag
          }
      );

      if(resp.statusCode ==200)
        {
          print("suceces");
        }

    }
    catch(ex){
      print("Error\n\$ ${ex.toString()}");
    }
  }


  //cchange past this code in yoer file-----------------------------------------------

  //get notificaion Service
Future<NotificationdateModelData?> getNotifications() async
{
  String uri = _baseurl1+"/get-user-notification";

  var resp = await http.get(Uri.parse(uri),headers: hed);
  try
      {
        NotificationdateModel notificationdateModel=  notificationdateModelFromJson(resp.body);

        return notificationdateModel.data;
      }
      catch(e)
  {
    print("Erroe \n"+"--"*100+e.toString()+"Erroe \n"+"--"*100);
  }



}


//ACCEPT REQUEST
  Future<Response?> acceptReq(String id) async
  {
    String uri = _baseurl1+"/accept_invitation?invitation_id=$id";
    var resp = await http.get(Uri.parse(uri),headers: hed);
    print("Run"+"--"*20);
    print(resp.body);
    print("Run"+"--"*20);
    return resp;
  }

  Future<Response?>readeMessage(String id) async
  {
    String uri = _baseurl1+"user-notification-read";

    var resp = http.get(Uri.parse(uri));
    return resp;
}


Future<void> sendInvitation() async
{

  String uri = _baseurl1+"/accept_invitation?invitation_id=13";
  try
      {
        var resp = await http.get(Uri.parse(uri),headers: hed);
        print(resp.statusCode);
      }
      catch(e)
  {
    print("Error \n ${e.toString()}");
  }
}



//------------------------------------------------------------------------------


}





