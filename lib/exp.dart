import 'package:bjppage/chat%20page/chatApi.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Exp extends StatefulWidget {
  const Exp({super.key});

  @override
  State<Exp> createState() => _ExpState();
}

class _ExpState extends State<Exp> {

  TextEditingController _controller = TextEditingController();
  ChateApis chatservies = ChateApis();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(

      appBar: AppBar(
        title: Text("Chat Page"),
      ),

      body: Column(
        children: [

          Expanded(child: Container(color: Colors.red,)),

          //text Feils\
          MyText()

        ],
      ),

    );

  }

  // Widget messages()
  // {
  //   return StreamBuilder(
  //       stream: channel.stream,
  //       builder: (context,snashot){
  //         return Center(child: Text(""),);
  //       });
  // }

  //textFeild
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

            suffixIcon: IconButton(onPressed: ()=>chatservies.sendMEssage(receverId: "2", messag: _controller.text.trim()),icon: Icon(Icons.send),)
        ),
      ),
    );
  }

}
