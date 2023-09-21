import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';

// // import 'package:web3dart/web3dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'SwapTokensPage.dart';
// import 'tokens.dart';
// import 'dart:convert';
import 'package:flutter/services.dart';
// import 'dart:math';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  // @override 
  // State<SwapTokensPage> createState() => _SwapTokensPageState();
  
  @override
  
  State<LoginPage> createState() => _LoginPageState();
  
}


class _LoginPageState extends State<LoginPage> {
    void navigateToSwapTokensPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  SwapTokensPage()),
    );
  }
   var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'My App',
          description: 'An app for converting pictures to NFT',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  var _session, _uri;
  
  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        setState(() {
          _session = session;
        });
      } catch (exp) {
        print(exp);
      }
    }
  }
 String _latestPrice = '';
   @override
  void initState() {
    super.initState();
    _getSmartContractData();
  }

 Future<void> _getSmartContractData() async {
    // var infuraUrl = 'https://sepolia.infura.io/v3/cef99b463fae490dab592851a44c5626';
    var infuraUrl = 'https://goerli.infura.io/v3/3232c0f26c3843cbabbf3ac5ff189e68';
    // var contractAddress = '0x3692Ae3047A6d945Babf7F283517FC068f5a04e1';
    var contractAddress = '0x3692Ae3047A6d945Babf7F283517FC068f5a04e1';
       

    // var abi = jsonDecode('[{"inputs": [],"stateMutability": "nonpayable","type": "constructor"},{"inputs": [],"name": "getLatestPrice","outputs": [{"internalType": "int256","name": "","type": "int256"	}],"stateMutability": "view","type": "function"}]');
    String abi = await rootBundle.loadString("assets/abi/abi.json");
    // var abi = 'assets/abi/abi.json';
    var functionName = 'getLatestPrice';
    var httpClient = Client();
    var ethClient = Web3Client(infuraUrl, httpClient);
    var contract = DeployedContract(ContractAbi.fromJson(abi,contractAddress), EthereumAddress.fromHex(contractAddress));
    var function = contract.function(functionName);
    var result = await ethClient.call(contract: contract, function: function, params: []);
    setState(() {
      _latestPrice = result[0].toString();
    });
    // return result[0].toString();
  }
  // String aa='';
  // void _onButtonPress() {
  //   var y=await _getSmartContractData;
  //   setState(() {
  //     aa = _latestPrice;
  //   });
  // }



  // void printSmartContractData() async {
    
  //   // print("hello world1");
  //   var infuraUrl = 'https://sepolia.infura.io/v3/cef99b463fae490dab592851a44c5626';
  //   var contractAddress = '0x3692Ae3047A6d945Babf7F283517FC068f5a04e1';
  //   //  print("hello world2");
  //   var abi = 'assets/abi/abi.json';
  //   var functionName = 'getLatestPrice';
  //   //  print("hello world3"); 
  //   var httpClient = Client();
  //   var ethClient = Web3Client(infuraUrl, httpClient);
  //   //  print("hello world4");
  //   //call the function
  //   var contract = DeployedContract(ContractAbi.fromJson(abi, contractAddress), EthereumAddress.fromHex(contractAddress));
  //   var function = contract.function(functionName);
  //   var result = await ethClient.call(contract: contract, function: function, params: []);

  //   // Print the result
  //   print(result);
  // }
  String bb='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        backgroundColor: Color.fromARGB(255, 138, 246, 197),
        foregroundColor: Colors.black54,
        
      ),
      body: SingleChildScrollView(
        
        child: Column(
          

          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
              SizedBox(height:80),
             
      Image.asset(alignment: Alignment.center,'assets/images/ppp.png',
      fit: BoxFit.fitHeight,
      width: 125.0,),
            // Image.asset(
              
            //   fit: BoxFit.fitHeight,
            // ),
           
              SizedBox(height: 10),
              Container(
                 alignment: Alignment.center,
          //  style: backgroundColor:Color.white
        padding:EdgeInsets.fromLTRB(30,30,30,15),
              child: ElevatedButton(
                // child: const Text("Current Price"),
                onPressed: ()async{
                  var x=BigInt.parse(_latestPrice);
                  BigInt y=x;
                  setState(() {
                    bb="\$ "+" "+'${x}';
                  });
                  },
                 
                child: const Text("Ethereum Price "),
                 style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(235, 111, 238, 107), 
                foregroundColor: Colors.black87, 
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), 
                textStyle: const TextStyle(fontSize: 16), 
                elevation: 15,
                shadowColor: Color.fromARGB(255, 12, 12, 12),
                alignment: Alignment.center,
                shape: StadiumBorder()
              ),
              //   style:ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 3, 48, 18)),
              // //  backgroundColor: Color.fromARGB(236, 245, 243, 227), 
                  
              //   // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), 
              //   // textStyle: const TextStyle(fontSize: 16), 
              //   // elevation: 15,
              //   // shadowColor: Color.fromARGB(255, 12, 12, 12),
              //   // side:BorderSide(color: Colors.black87,width: 2),
              //   alignment: Alignment.center,
              //   //  shadowColor: Color.fromARGB(a, r, g, b),
              //   // shape: StadiumBorder()

              //   )
                
              ),
              ),
               Text(
              '$bb',
              style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 2, 113, 11))
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => loginUsingMetamask(context),
              child: const Text("Connect with Metamask"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(236, 245, 243, 227), 
                foregroundColor: Colors.black87, 
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), 
                textStyle: const TextStyle(fontSize: 16), 
                elevation: 15,
                shadowColor: Color.fromARGB(255, 12, 12, 12),
                alignment: Alignment.center,
                shape: StadiumBorder()
              ),
            ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () => _getSmartContractData(),
            //   child: const Text("Current Price"),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blue, 
            //     foregroundColor: Colors.white, 
            //     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), 
            //     textStyle: const TextStyle(fontSize: 16), 
            //   ),
            // ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => navigateToSwapTokensPage(context),
              child: const Text("Swap Tokens"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 245, 209, 130), 
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), 
                textStyle: const TextStyle(fontSize: 16), 
                 elevation: 15,
                shadowColor: Color.fromARGB(255, 247, 232, 158),
                alignment: Alignment.center,
                shape: StadiumBorder()
              ),
            ),
      //        Container(

      //     alignment: Alignment.center,
      //   padding:EdgeInsets.fromLTRB(30,30,30,15),
      //    child:ElevatedButton(onPressed: (){
      //      Navigator.push(context,
      //      MaterialPageRoute(builder: (context)=>tokens()));
      //    },child: const Text("Tokens Details"
        
      //    ),)
      // // )
      // ),
          ],
        ),
      ),
    );
  }
}
