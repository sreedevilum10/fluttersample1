void main() {
  // var list = [];
  // print("list = $list");
  // list.addAll([1,2,3,4]);
  // print("updated list = $list");

  // var le = List.empty(growable: true);
  // print("le = $le");
  // le.addAll([10,20,30]);
  // print("updated le = $le");

  // var list = List.filled(5,1,growable: true);
  // print("list = $list");
  // list[1] = 23;
  // print("updated list = $list");
  //
  // var list2 = List.from(list);
  // print("list = $list2");
  // list2.addAll([2,3,4,5]);
  // print("updated list = $list2");

  // var list = List.generate(10, (index) {
  //   return 2 * index+1;
  // });
  // print("list = $list");
  // list.add(100);
  // print("updated list = $list");

  var list = List.unmodifiable([2,4,6,8,9,0]);
  print("list = $list");
  //list[1] = 23;
  //list.remove(9);
  print("updated list = $list");

}