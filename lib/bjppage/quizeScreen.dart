import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bjppage/bjppage/const.dart';
import 'package:bjppage/bjppage/consvalluer.dart';
import 'package:bjppage/bjppage/quizemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizeScreen extends StatefulWidget {
  const QuizeScreen({super.key});

  @override
  State<QuizeScreen> createState() => _QuizeScreenState();
}

class _QuizeScreenState extends State<QuizeScreen> {

  int timer =15;
  PageController _controller = PageController();
  int pageIndex = 0;

  late List answer;

  String? selectedAnswee;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   update();
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      //appbar
      appBar: AppBar(

        backgroundColor: Colors.grey.shade100,

        //leadimg icon
        leading: IconButton(onPressed: ()=>Navigator.pop(context),icon: Icon(Icons.arrow_back,color: appcolor.one,)),

        titleSpacing: 0,

        shape:Border(
          bottom: BorderSide(width: 1,color: Colors.black87)
        ),

        //title
        title: Text("Answer the Question",

        //titleStyle
        style: TextStyle(
            color: appcolor.one,
          fontSize: 20,
          fontWeight: FontWeight.w400
        ),
        ),
      ),

      body: FutureBuilder(
        future: getQuistion(),
        builder: (context,snp){

          if(snp.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),);
            }
          if(snp.hasError)
            {
              return Center(child: Text("error \n"+snp.error.toString()),);
            }
          
          List allquestion  = snp.data["data"];

          List<Quistion> aiq = allquestion.map((e) => Quistion.fromMap(e)).toList();



          return  PageView(

            physics: NeverScrollableScrollPhysics(),

            //controller
            controller: _controller,

            //onpage Chnage
            onPageChanged: (e){
              pageIndex = e;
              timer = 15;
            },

            //cjilderew
            children:aiq.map<Widget>((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(height: 30,),

                  //quistion
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //quistion no
                        Text("Q."
                          ,style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 24
                          ),),
                        SizedBox(width: 5,),

                        //quistion
                        Expanded(child: Text(e.question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                          ),
                        ))

                      ],
                    ),
                  ),

                  //count Down
                  Expanded(
                    flex: 2,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color.fromRGBO(122, 122, 122, 1),
                                width: 5
                            )
                        ),
                        child: Counter(
                          begain: 30,
                          onConterEnd: (){
                            if(pageIndex != aiq.length-1)
                              {
                                _controller.nextPage(duration: Duration(milliseconds: 100), curve:Curves.linear);
                              }
                          },
                        ),

                      ),
                    ),
                  ),

                  // Options
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: OptioSeletor(
                          groupValue: selectedAnswee,
                          values: [e.a,e.b,e.c,e.d],
                          onChage: (e){
                            selectedAnswee = e;
                            print(selectedAnswee);
                          },
                        ),
                      )),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      elevation: 0,
                      child: Ink(
                        decoration: BoxDecoration(
                            color: appcolor.one,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        height: 50,
                        width: double.infinity,

                        child: InkWell(
                            onTap: ()async{
                              await postAnswer(e.id.toString());
                              _controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.linear);
                            },
                            child: Center(child: Text("Next Page",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400),))),
                      ),
                    ),
                  )

                ],
              ),
            )).toList(),
          );

          
          

        },
      ),

      //body
    );
  }

  //updat methid
  void update()
  {

    if(timer ==0&& pageIndex !=quistion.length-1)
      {
        _controller.nextPage(duration: (Duration(milliseconds: 100)), curve: Curves.linear);
      }

    if(timer>0)
      {
        timer--;
        setState(() {});
      }


  }

  Future postAnswer(String id) async
  {
    String url = "https://bjp.vyaparway.com/api/quiz_answer";
    if(selectedAnswee!=null)
      {
        showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator(),));
        var responce = await http.post(Uri.parse(url),
            body: {
          "question_id":id,
            "answer":selectedAnswee,
            },
            headers:
            {
              HttpHeaders.authorizationHeader: tocken,
            }
        );
        selectedAnswee = null;
        Navigator.pop(context);
        await showDialog(context: context, builder: (context)=>AlertDialog(
          content: Text(responce.body.toString()),
        ));
      }
  }


  //get quistion

Future getQuistion() async
{
  String url = "https://bjp.vyaparway.com/api/question_list?quiz_id=1";
  var responce = await http.get((Uri.parse(url)),headers:
      {
        HttpHeaders.authorizationHeader: tocken,
      }
  );
  print(responce.body);
  var jstring = responce.body;
  var data = jsonDecode(jstring);
  return data;
}



}




class OptioSeletor extends StatefulWidget {
  List<String> values;
  String? groupValue;
  String? vslueKey;
  void Function(String?) onChage;

  OptioSeletor({
    required this.values,
    required this.groupValue,
    required this.onChage,
});

  @override
  State<OptioSeletor> createState() => _OptioSeletorState();
}

class _OptioSeletorState extends State<OptioSeletor> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.only(top: 30,right: 10,left: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,mainAxisExtent: 60,
        crossAxisSpacing: 5,
        mainAxisSpacing: 8,
      ),
      shrinkWrap: true,

      primary: false,
      physics: NeverScrollableScrollPhysics(),
      children: [

        //
        option("a",title:widget.values[0],lead: "A. ",onChange: (e){

          setState(() {
            widget.groupValue=e;
            widget.onChage(e);
          });
        },groupvalue: widget.groupValue),

        //a
        option("b",title:widget.values[1],lead: "B. ",onChange: (e){
          setState(() {
            widget.groupValue=e;
            widget.onChage(e);
          });
        },groupvalue: widget.groupValue),

        //
        option("c",title: widget.values[2],lead: "C. ",onChange: (e){
          setState(() {
            widget.groupValue=e;
            widget.onChage(e);
          });
        },groupvalue: widget.groupValue),

        //
        option("d",title:widget.values[3],lead: "D. ",onChange: (e){
          setState(() {
            widget.groupValue=e;
            widget.onChage(e);
          });
        },groupvalue: widget.groupValue),

      ],
    );
  }

  Widget option(String option,{required void Function(String?) onChange,required String title,required String? groupvalue,String lead=""})
  {
    return Card(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none
      ),
      child: ListTile(
        tileColor: (groupvalue==option)?Colors.green:null,
        title: Text(lead+title,
          style: TextStyle(color: (groupvalue==option)?Colors.white:null),),
        onTap: (){
          onChange(option);
        },
      ),
    );
  }

}

class Counter extends StatefulWidget {
  int begain;
  void Function()? onConterEnd;
  void Function(int value)? onContChange;
  Counter({this.begain = 15,this.onConterEnd,this.onContChange});


  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  int timer  = 15;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = widget.begain;
    Timer.periodic(Duration(seconds: 1), (b) {
      if(timer>0)
        {
          update();
        }
    });
  }



  //updat methid
  void update()
  {

    if(timer>0)
    {
      timer--;
      if(widget.onContChange!=null)
      {
        widget.onContChange!(timer);
      }
      setState(() {});
    }


    if(timer==0&&widget.onConterEnd!=null)
      {
        widget.onConterEnd!();
      }


  }



  @override
  Widget build(BuildContext context) {
    return Text(timer.toString(),
      style:  const TextStyle(
          color: Color.fromRGBO(1, 170, 68, 1),
          fontSize: 50,
          fontWeight: FontWeight.w400
      ),
    );
  }
}




