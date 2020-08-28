import 'package:flutter/material.dart';
import 'package:my_crypto_lib/my_crypto_lib.dart';
import 'sum.dart';
import 'common.dart';
import 'dart:math';
import 'package:flutter/foundation.dart';

Random rand = Random();

void main() {
  runApp(MyApp());
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final  MyCryptoLib lib = MyCryptoLib();
  final Sum sum = Sum();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('FFI example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('with FFI'),
                onPressed: (){
                  runWithFFI();
                },
              ),
              RaisedButton(
                child: Text('without FFI'),
                onPressed: (){
                  runWithoutFFI();
                },
              ),

              RaisedButton(
                child: Text('compute without FFI'),
                onPressed: () async{
                  await runIsolates();
                },
              ),
            ]
          )
        ),
      ),
    );
  }


  void runWithFFI(){
    List a = [];
    List b = [];
    for(int i = 0 ; i < 1000000 ; i++ ){
      a.add(rand.nextInt(100));
      b.add(rand.nextInt(100));
    }
    final Stopwatch watch = Stopwatch();
    print('Calc tracker FFI  benchmark...');
    watch.start();
    for(int i = 0 ; i < 1000000 ; i++ ){
      lib.nativeCrypto(a[i],b[i]);
    }
    watch.stop();
    final BenchmarkResultPrinter printer = BenchmarkResultPrinter();
    printer.addResult(
      description: 'Calc tracker',
      value: watch.elapsedMicroseconds.toDouble(),
      unit: 'µs',
      name: 'iteration',
    );
    printer.printToStdout();
  }

  void runWithoutFFI(){
    List a = [];
    List b = [];
    for(int i = 0 ; i < 1000000 ; i++ ){
      a.add(rand.nextInt(100));
      b.add(rand.nextInt(100));
    }
    final Stopwatch watch = Stopwatch();
    print('Calc pure dart tracker benchmark...');
    watch.start();
    for(int i = 0 ; i < 1000000 ; i++ ){
      //sum.sum(rand.nextInt(100),rand.nextInt(100));
      sum.sum(a[i],b[i]);
    }
    watch.stop();
    final BenchmarkResultPrinter printer = BenchmarkResultPrinter();
    printer.addResult(
      description: 'Calc tracker',
      value: watch.elapsedMicroseconds.toDouble(),
      unit: 'µs',
      name: 'iteration',
    );
    printer.printToStdout();
  }

  void runIsolates() async{
    List a = [];
    List b = [];
    for(int i = 0 ; i < 1000 ; i++ ){
      a.add(rand.nextInt(100));
      b.add(rand.nextInt(100));
    }
    final Stopwatch watch = Stopwatch();
    print('Calc Isolates tracker benchmark...');
    watch.start();

    for(int i=0 ; i<10 ; i++){
       await compute(Sum.calcalateSum,[a,b]);
    }


//    for(int i = 0 ; i < 10 ; i++ ){
//      //lib.nativeCrypto(rand.nextInt(100),rand.nextInt(100));
//      compute(Sum.sum2,[a[i],b[i]]);
//    }
    watch.stop();
    final BenchmarkResultPrinter printer = BenchmarkResultPrinter();
    printer.addResult(
      description: 'Calc tracker',
      value: watch.elapsedMicroseconds.toDouble(),
      unit: 'µs',
      name: 'iteration',
    );
    printer.printToStdout();
  }



}
