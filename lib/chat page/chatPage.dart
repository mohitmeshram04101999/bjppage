import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bjppage/chat%20page/chatApi.dart';
import 'package:bjppage/chat%20page/mesagemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../bjppage/const.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController _scrollController= ScrollController();
  int currntuserId = 263;
  ChateApis chatserv = ChateApis();
  StreamController _chatContrller = StreamController();
  int unreade = 0;
  List<String> chatss = [];
  TextEditingController _controller =TextEditingController();

  get http => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lodeChat();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // floateButton
      // floatingActionButton:(unreade==0)?null:FloatingActionButton(onPressed: (){
      //   _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOutBack);
      // },child: Text(unreade.toString()),),


      appBar: AppBar(title: Text("Chate page"),centerTitle:  true,),


      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _chatContrller.stream,
              builder: (context,snap){

                //waiting
                if(snap.connectionState==ConnectionState.waiting)
                  {
                    return Center(child: CircularProgressIndicator(),);
                  }

                //on error
                if(snap.hasError)
                  {
                    return Center(child: Text("Error\n ${snap.error}"),);
                  }

                //show data


                // List fdata = snap.data["message"];
                // List messages = fdata.reversed.toList();

                // return  ListView(
                //   controller: _scrollController,
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   children: messages.map<Widget>(genrateMessage).toList(),
                //   // children: snap.data!.map((e) => Text(e)).toList(),
                // );

                List b = snap.data["messages"];
                List<messageModel> b2 = b.map((e) => messageModel.fromMap(e)).toList();


                return ListView(
                  children:b.reversed.toList().map((e) => genrateMessage(e)).toList(),

                );




              },
            ),
          ),
          MyText(),
        ],
      ),

    );



  }


  Widget genrateMessage(dynamic e)
  {
    messageModel _msg = messageModel.fromMap(e);
    bool sender = _msg.fromId ==currntuserId;
    if(_msg.seen==0)
      {
        unreade++;
      }

    return Container(
      width: double.infinity,
      child: Card(
        color: sender?Colors.orangeAccent:Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_msg.body,style:TextStyle(color: Colors.white)),
          )),
      alignment: (sender)?Alignment.centerRight:Alignment.centerLeft,
    );
  }

  Widget MyText()
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,

        decoration: InputDecoration(


            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            hintText: "Type Your message",

            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [


                IconButton(onPressed: ()=>chatserv.sendMEssage(receverId: "254", messag: _controller.text.trim()),icon: Icon(Icons.send),),
              ],
            )
        ),
      ),
    );
  }


  //lode Chat
  lodeChat() async
  {
    Map<String,dynamic>? data = await chatserv.fatMessage();
    print(data);
    _chatContrller.sink.add(data);
    Timer(Duration(seconds: 1),lodeChat);
  }

}
