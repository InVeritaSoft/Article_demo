import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_lib/my_lib.dart';
import 'package:my_lib_example/sum.dart';

import 'common.dart';

class AddWidget extends StatelessWidget {

  final  MyLib lib = MyLib();
  final Sum sum = Sum();
  final Random rand = Random();

  @override
  Widget build(BuildContext context) {
    return Column(
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
      lib.nativeAdd(a[i],b[i]);
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
