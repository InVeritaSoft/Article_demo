

class Sum{

  int sum(int a, int b){
    return a + b;
  }

  static sum2(list){
    var val1 = list[0];
    var val2 = list[1];
    return val1 + val2;
  }

  static void calcalateSum(list){
    for(int i = 0 ; i < list[0].length ; i++ ){
      sum2([list[0],list[1]]);
    }
  }

}
