
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'ShoppingItemDAO.dart';//import DAO
import 'ShoppingItem.dart';

part 'ShoppingItemDatabase.g.dart' ; // the generated code will be there

@Database( version:1, entities: [ShoppingItem] )//entities are array of ShoppingItem
abstract class ShoppingItemDatabase extends FloorDatabase{
//create a function returning a DAO object:

  ShoppingItemDAO get getDao; //get generates this function as a getter
}