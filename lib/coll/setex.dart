void main(){
  var list = [1,2,3,4,5,10,23,45,11,1,2];
  var set = {1,2,3,4,5,6,6,7,8,8};
  //var set1 = new Set();
  var set2 = Set.from(set);
  print(set2);
  var set3 = Set.of(list);
  print(set3);

}