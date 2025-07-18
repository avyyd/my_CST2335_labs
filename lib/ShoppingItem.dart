

import 'package:floor/floor.dart';

@entity //Tells floor to create a Table called ShoppingItem
class ShoppingItem{

  //constructor
  ShoppingItem( this.id, this.name, this.quantity)  // (  id here, name here)
  {
    if(this.id >= ID)
      ID = this.id + 1; //in case somwthing is loaded with id > ID
  }

  static int ID = 1; //belongs to class to hand out numbers

  @primaryKey //tells Floor that this is unique key
  final int id;
  final int quantity;
  String name;




}