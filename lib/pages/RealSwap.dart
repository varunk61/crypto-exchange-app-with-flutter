import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

import 'package:flutter/services.dart';


class RealSwap extends StatefulWidget {
  final String tranaddress;
  final String address;
  const RealSwap({Key? key,required this.address,required this.tranaddress}) : super(key: key);
  @override 
  State<RealSwap> createState() => _RealSwapPage();
  
  
}

class _RealSwapPage extends State<RealSwap> { 
  
  late Client httpClient;
  late Web3Client ethClient;
  EthereumAddress myaddress=EthereumAddress.fromHex("0x8f06A7327E0a4A469253EEEb4fBC600346C0733a");
  final String api="https://sepolia.infura.io/v3/cef99b463fae490dab592851a44c5626";
  var privateAddress;
  var credentials;
  var temp;
  @override
  void initState(){
    httpClient=Client();
    ethClient=Web3Client(api, httpClient);
    myaddress=EthereumAddress.fromHex(widget.tranaddress);
    if(myaddress=='0x8f06A7327E0a4A469253EEEb4fBC600346C0733a'){
     privateAddress="1ff5f9fad8a695b789f72a9ac8b8aafabd1c8e4804c65170a5e2c8c2badd90ee";
    }
    else{
      privateAddress="8babfa9d04d6a4016a4b9809e5887b7910a01f7205c641f3dbe5daed830ae83f";
    }
     temp=EthPrivateKey.fromHex(privateAddress);
    credentials=temp.address;
    super.initState();
  }
  Future<DeployedContract>_getSmartContractData() async{
    String abi=await rootBundle.loadString('assets/abi/swaptokenabi.json');
    // String contractAddress="0x94b5034C49E4F7E656cCc90563B4E8f656816cA9";
    String contractAddress=widget.address;
    final contract=DeployedContract(ContractAbi.fromJson(abi,"swapToken"),
    EthereumAddress.fromHex(contractAddress));

    return contract;
  }


  Future<String> swapfunction(String name,List<dynamic>args) async {
    final contract=await _getSmartContractData();
    final function=contract.function(name);
    EthPrivateKey key=EthPrivateKey.fromHex(privateAddress);
    Transaction transaction = await Transaction.callContract(contract: contract,function: function,parameters: args,maxGas: 100000,);
    final result =await ethClient.sendTransaction(key, transaction, chainId:11155111);
    // return result;
    // final result=await ethClient.call(contract: contract,function: function,params:args);
    return result;
    
  }
  BigInt amount=BigInt.from(0);
  BigInt amount1=BigInt.from(0);
  // BigInt v=BigInt.from(1000000000000000000);
  var store='';
  var ans;
  @override
  Widget build(BuildContext context) {
            
          var controller=TextEditingController();
           var controller2=TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text("BlockchainATM"),
          // backgroundColor: Color.fromARGB(255, 42, 147, 239),
             backgroundColor: Color.fromARGB(255, 138, 246, 197),
        foregroundColor: Colors.black54,
        ),
        body:(
            Center(
                child:Column(
                    children:[
                      SizedBox(height: 110,),  
                      TextField(
                        controller:controller,        
                        decoration: InputDecoration(
                            border:OutlineInputBorder(
                              gapPadding: 50,
                              borderRadius: BorderRadius.circular(21),
                            ),
                            hintText: "Enter Amount of DVT Tokens"
                        ),
                      ),
                       SizedBox(height: 20,),
                      TextField(
                        controller:controller2,        
                        decoration: InputDecoration(
                            border:OutlineInputBorder(
                              gapPadding: 50,
                              borderRadius: BorderRadius.circular(21),
                            ),
                            hintText: "Enter Amount of EVT Tokens"
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      child:ElevatedButton(onPressed: ()async{
                        setState(() {
                          amount=BigInt.parse(controller.text);
                        });
                        setState(() {
                          amount1=BigInt.parse(controller2.text);
                        });
                       
                         ans=await swapfunction("swap", [amount,amount1]);
                         store=ans;
                         
                         }, child: const Text("Swap"),style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 237, 209, 107)),
                        //  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 249, 211, 147)),
                  foregroundColor: MaterialStateProperty.all(Colors.black45),
                        
                        shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(14.0)
                            )
                        ),
                      ),)),
                      Text(store,style: const TextStyle(color: Colors.blue),)
                    ])))
    );
          
        
  

  }
}
 

