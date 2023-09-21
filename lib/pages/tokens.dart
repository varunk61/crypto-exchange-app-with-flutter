import 'package:flutter/material.dart';
import 'package:my_app/pages/dvttokens.dart';
class tokens extends StatefulWidget{
  const tokens({Key? key}):super(key:key);
  @override
  State<tokens> createState()=>_tokens();
}
class _tokens extends State<tokens>{
  String address="";

@override
Widget build(BuildContext context){
  var controller=TextEditingController();

  return Scaffold(
    appBar: AppBar(
      title: Text("Token Details"),
      backgroundColor: Color.fromARGB(255, 138, 246, 197),
        foregroundColor: Colors.black54,
        
    ),
    
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Align the children in the center
        children:[
          SizedBox(height: 30,),
          TextField(
            controller: controller,
            decoration: 
            InputDecoration(
              border:OutlineInputBorder(
            borderRadius: BorderRadius.circular(19),
          ),
              hintText: "Enter your Metamask address",
              contentPadding: EdgeInsets.symmetric(horizontal: 75.0),

            ),
          ),
          ElevatedButton(
            onPressed: (){
              setState(() {
                address=controller.text;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Tokeninfo(address:address)));
            },
            child: const Text("Get Balance"),
              style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 249, 211, 147)),
                  foregroundColor: MaterialStateProperty.all(Colors.black45),
               
                  shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            
                          )
                      )
                      // shadowColor: MaterialState,
             )

          )
        ]
      )
    )
  );
}

}

