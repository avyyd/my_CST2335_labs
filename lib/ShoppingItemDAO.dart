
//mark this as a DAO class:
import 'package:floor/floor.dart';
import 'ShoppingItem.dart';

@dao
abstract class ShoppingItemDAO{ //Floor codes the functions for you

//create a Query function to get our objects:
  @Query("Select * from ShoppingItem")//Entity is the TableName
  Future< List< ShoppingItem > > getAllShoppingItems(); //No function body in this abstract class

  //@insert, @delete, @update

  @insert
  Future<void> addShoppingItem( ShoppingItem toBeInserted );

  @delete
  Future<void> deleteShoppingItem( ShoppingItem toBeDeleted);

  @update
  Future<void> updateItem( ShoppingItem newItem ); //by id=

}
