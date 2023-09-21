import 'package:flutter/material.dart';
import 'tokens.dart';
import 'RealSwap.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';

class Contract extends StatefulWidget {
   final String  address;
  const Contract({Key? key,required this.address}) : super(key: key);
  @override 
  State<Contract> createState() => _Contract();
  
  
}


class _Contract extends State<Contract> { 
  var tranaddress;
  void initState(){
    tranaddress=widget.address;
  }
 
 
 var amount='';
 String address="0x94b5034C49E4F7E656cCc90563B4E8f656816cA9";
  @override
  
  Widget build(BuildContext context) {
    var controller=TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Load Swap Contract'),
        backgroundColor: Color.fromARGB(255, 138, 246, 197),
        foregroundColor: Colors.black54,
        
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/p.png',
            //   fit: BoxFit.fitHeight,
            // ),
             SizedBox(height: 30,),
          // TextField(
          //   // controller: amount,
          //   decoration: 
          //   // InputDecoration(
          //   //   hintText: "Enter Amount to Swap",
          //   //   contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          //   // ),
          // ),
           TextField(
            controller: controller,
            decoration: 
            InputDecoration(
              border:OutlineInputBorder(
            borderRadius: BorderRadius.circular(19),
          ),
              hintText: "Enter Swap Contract address",
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),

            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: (){
              setState(() {
                address=controller.text;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RealSwap(address:address,tranaddress:tranaddress)
              )
              );
            },
            //  SizedBox(height: 30,),
            // ElevatedButton(onPressed: (){
            //   // await callFunction("swap", [myaddress]);
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=>RealSwap(this.address)));
            //   // var bal=await callFunction("DVT", "balanceOf", [myaddress]);
  // }
             child:const Text("Proceed"),
             style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(235, 109, 218, 237), 
                foregroundColor: Colors.black87, 
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), 
                textStyle: const TextStyle(fontSize: 16), 
                elevation: 15,
                shadowColor: Color.fromARGB(255, 12, 12, 12),
                alignment: Alignment.center,
                shape: StadiumBorder()
              ),
            //  style:ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 154, 234, 181)),
            //       foregroundColor: MaterialStateProperty.all(Colors.black45),
            //       shape:MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(18.0),
            //                 //side: BorderSide(color: Colors.deepPurple)
            //               )
            //           )
            //  )
            
            ),
            // Text('EVT Tokens:'+evt,style: TextStyle(color: Color.fromARGB(255, 7, 228, 77)),),
           

           SizedBox(height: 30,),
      //        Container(
      //     alignment: Alignment.center,
      //   padding:EdgeInsets.fromLTRB(30,30,30,15),
      //    child:ElevatedButton(onPressed: (){
      //      Navigator.push(context,
      //      MaterialPageRoute(builder: (context)=>tokens()));
          
      //    },child: const Text("Tokens Details"),
      //     style: ElevatedButton.styleFrom(
      //           backgroundColor: Color.fromARGB(235, 241, 229, 136), 
      //           foregroundColor: Colors.black87, 
      //           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), 
      //           textStyle: const TextStyle(fontSize: 16), 
      //           elevation: 15,
      //           shadowColor: Color.fromARGB(255, 244, 209, 105),
      //           alignment: Alignment.center,
      //           shape: StadiumBorder()
      //         ),
       
      //    )
      // // )
      // ),
          ],
    )
      )
    );
  }
}
