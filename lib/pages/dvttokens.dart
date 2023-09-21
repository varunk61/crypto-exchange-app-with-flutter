import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';

class Tokeninfo extends StatefulWidget{
  final String address;
  const Tokeninfo({Key? key,required this.address}):super(key:key);

  @override
  State<Tokeninfo> createState()=>_Tokeninfo();
}

class _Tokeninfo extends State<Tokeninfo>{
  
  late Client httpClient;
  late Web3Client ethClient;
   EthereumAddress ethaddress=EthereumAddress.fromHex("0x301740eEbcF09c8be48604f40bb68CB8B328AE55");
  final String api="https://sepolia.infura.io/v3/cef99b463fae490dab592851a44c5626";
  // var contractadd;
  @override
  void initState(){
    httpClient=Client();
    ethClient=Web3Client(api, httpClient);
    ethaddress=EthereumAddress.fromHex(widget.address);
    super.initState();
  }
  Future<DeployedContract>_getSmartContract(String token) async{
       // var abi = 'assets/abi/evt.json';
    String abi=await rootBundle.loadString('assets/abi/evt.json');
    String contractAddress="";
    if(token=="EVT"){
      contractAddress="0x5a56bEf646FeC74dd77cdb7A7Faf14481C98ed22";
    }
    else{
      contractAddress="0x8Aa47A9dd0e8F0dA7A08bae1f3b9e2659A9d8F69";
    }
    final contract=DeployedContract(ContractAbi.fromJson(abi,"Token"),
    EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> _BalanceOf(String token,String name,List<dynamic>args) async {
    final contract=await _getSmartContract(token);
    final function=contract.function(name);
    final accbalance=await ethClient.call(contract: contract,function: function,params:args);
    return accbalance;
  }
  var evt="";
  var dvt="";
  @override
  Widget build(BuildContext context){
   return Scaffold(
      appBar: AppBar(
        title: Text("Token Details"),
         backgroundColor: Color.fromARGB(255, 138, 246, 197),
        foregroundColor: Colors.black54,
        
      ),
      body:
      (
      Center(
        child: Column(
          children: [
            SizedBox(height: 90,),
            ElevatedButton(onPressed: ()async{
              var balance=await _BalanceOf("EVT", "balanceOf", [ethaddress]);
              var bal=await _BalanceOf("DVT", "balanceOf", [ethaddress]);
              setState(() {
                evt='${balance[0]}';
              });
               setState(() {
                dvt='${bal[0]}';
              });
            }, child:const Text("No of tokens"),
              style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 237, 190, 113)),
                  foregroundColor: MaterialStateProperty.all(Colors.black45),
                  shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            //side: BorderSide(color: Colors.deepPurple)
                          )
                      )
             )
            )
            ,
            Text('EVT Tokens:'+evt,style: TextStyle(color: Color.fromARGB(255, 1, 58, 19)),),
           
            SizedBox(height: 20,),
             Text("DVT Tokens:"+dvt,style: TextStyle(color: Color.fromARGB(255, 2, 68, 23))),
            //  Text(dvt),
          
          ],
        ),
      )
      )
    );
  }

}