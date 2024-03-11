import 'dart:async';
import 'dart:convert';

import 'package:bjppage/NotiFcationPageBjp/Notification%20Model.dart';
import 'package:bjppage/bjppage/consvalluer.dart';
import 'package:bjppage/chat%20page/chatApi.dart';
import 'package:flutter/material.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
    getDatainstrim();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didchange");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }

  @override
  void didUpdateWidget(covariant NotificationPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("didUpdate");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deacticve");
  }

  @override
  void activate() {
    // TODO: implement activate
    super.activate();
    print("Active");

  }



  StreamController<NotificationdateModelData?> _streamController = StreamController();

  List data = [];

  Future<void>getDatainstrim() async
  {
    NotificationdateModelData? _data = await chatService.getNotifications();
    _streamController.add(_data);
  }

  ChateApis chatService = ChateApis();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appcolor.one,
        title: Text("Notifications",style: TextStyle(color: Colors.white),),
      ),



      body: StreamBuilder<NotificationdateModelData?>(
      stream: _streamController.stream,
        builder: (context,snap){
          if(snap.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),);
            }
          if(snap.data==null)
            {
              return Center(child: Text("Null"));
            }

          List<NotificationElement>? notifications = snap.data!.notifications;
          var unreage = snap.data!.unread;
          return ListView(
            children: notifications!.map((e) => NotificationWidget(noti: e,onTap: ()=>acceptReq(e.data!.typeId!.invitationId.toString(),e.id.toString()),)).toList(),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(onPressed:()=>setState(() {

      }),),
    );
  }

  void acceptReq(String invitationid,String notiid) async
  {

    showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator(),));
    var resp = await chatService.acceptReq(invitationid);
    Map<String,dynamic> _data = jsonDecode(resp!.body);
    if(_data["success"]==false)
      {
        chatService.readeMessage(notiid);
      }
    Navigator.pop(context);
  }
}









class NotificationWidget extends StatelessWidget {
  void Function()? onTap;
  NotificationElement noti;
  NotificationWidget({required this.noti,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appcolor.one.withOpacity(.1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 50,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle
                  ),
                  // child: (noti.notification!.image==null)?CircleAvatar(child: Icon(Icons.person),):Image.network(noti.notification!.image!),
                  child: Icon(Icons.person,color: Colors.white,),
                ),
              ),
            ),
            SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4,),
                  Text(noti.notification!.title.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16
                  ),),
                  SizedBox(height: 4,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${noti.data!.dateTime!.day}-${noti.data!.dateTime!.month}-${noti.data!.dateTime!.year}",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w300
                      ),),
                      Text("${noti.data!.dateTime!.hour}:${noti.data!.dateTime!.minute}",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w300
                      ),),
                    ],
                  ),

                  if((noti.data!.type==Type.FOLLOW_REQUEST&& noti.read==1))
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) => appcolor.one)
                      ),
                      onPressed:onTap??(){},child: Text("Accept",style: TextStyle(
                      color: Colors.white
                    ),),)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}

