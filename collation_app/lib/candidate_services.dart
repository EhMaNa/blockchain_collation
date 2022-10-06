import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/material.dart';
import 'package:collation_app/candidates.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

class CandidateServices extends ChangeNotifier {
  List<Candidate> candidates = [];
  final String _rpcUrl =
      Platform.isAndroid ? 'http://10.0.2.2:7545' : 'http://127.0.0.1:7545';
  final String _wsUrl =
      Platform.isAndroid ? 'http://10.0.2.2:7545' : 'ws://127.0.0.1:7545';

  late Web3Client _web3cient;
  final String _privatekey =
      '61597377996460a55e16f81277b672f0213b6d448764d4cc49187c731e40f353';

  CandidateServices() {
    init();
  }
  Future<void> init() async {
    _web3cient = Web3Client(
      _rpcUrl,
      http.Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );
    await getABI();
    await getCredentials();
    await getDeployedContract();
  }

  late ContractAbi _abiCode;
  late EthereumAddress _contractAddress;
  Future<void> getABI() async {
    String abiFile =
        await rootBundle.loadString('build/contracts/CollationContract.json');
    var jsonABI = jsonDecode(abiFile);
    _abiCode =
        ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'CollationContract');
    _contractAddress =
        EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
  }

  late EthPrivateKey _creds;
  Future<void> getCredentials() async {
    _creds = EthPrivateKey.fromHex(_privatekey);
  }

  late DeployedContract _deployedContract;
  late ContractFunction _addCandidate;
  late ContractFunction _candidates;
  late ContractFunction _candidatesCount;

  Future<void> getDeployedContract() async {
    _deployedContract = DeployedContract(_abiCode, _contractAddress);
    _addCandidate = _deployedContract.function('addCandidate');
    _candidates = _deployedContract.function('candidates');
    _candidatesCount = _deployedContract.function('candidatesCount');
    await fetchNotes();
  }

  Future<void> fetchNotes() async {
    List totalTaskList = await _web3cient.call(
      contract: _deployedContract,
      function: _candidatesCount,
      params: [],
    );
    int totalTaskLen = totalTaskList[0].toInt();
    candidates.clear();
    for (var i = 0; i < totalTaskLen; i++) {
      var temp = await _web3cient.call(
          contract: _deployedContract,
          function: _candidates,
          params: [BigInt.from(i)]);
      if (temp[1] != "") {
        candidates.add(
          Candidate(
            id: (temp[0] as BigInt).toInt(),
            name: temp[1],
            voteCount: temp[2],
          ),
        );
      }
    }
    //isLoading = false;

    notifyListeners();
  }
}
