import 'dart:async';

// import 'package:medik/model/borrower.dart';
// import 'package:medik/model/users.dart';
import 'package:medik/model/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:flutter_offline/models/trans.dart';

class DbConnProduct {

  Database database;

  Future initDB() async {
    if (database != null) {
      return database;
    }

    String databasesPath = await getDatabasesPath();

  //  const transpeminjam = """
  //   CREATE TABLE IF NOT EXISTS product (
  //         id INTEGER PRIMARY KEY, 
  //         contract_no TEXT, 
  //         borrower_name TEXT, 
  //         jenis_usaha_code TEXT, 
  //         nilai_pendanaan TEXT, 
  //         tenor_pembayaran TEXT, 
  //         sisa_pokok TEXT, 
  //         tgl_byr_akhir TEXT, 
  //         frekuensi TEXT
  //       );""";
    // 'code': code,
    //   'name': name,
    //   'price': price,
    //   'stock': stock

    const dbproduct = """
    CREATE TABLE IF NOT EXISTS medicine (
          id INTEGER PRIMARY KEY, 
          code INTEGER, 
          name TEXT,
          price DOUBLE,
          stock DOUBLE
        );""";

    database = await openDatabase(
      join(databasesPath, 'db_product.db'),
      // onCreate: (db, version) {
      //  return  _createDb(database,1);
      // },
       onCreate: (db, int version) async {
          // await db.execute(transpeminjam);
          await db.execute(dbproduct);
      },
      version: 1,
    );

    return database;
  }

  // void insertTrans(TransPeminjam trans) async {
  //   final Database db = database;
  //   print(trans);
  //   db.insert(
  //     'transpeminjam',
  //     trans.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  void insertTransUser(ProductModel product) async {
    final Database db = database;
    print(product);
    db.insert(
      'medicine',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('berhasil');
  }

  // Future<List<TransPeminjam>> trans() async {
  //   final Database db = database;

  //   final List<Map<String, dynamic>> maps = await db.query('transpeminjam');

  //   return List.generate(maps.length, (i) {
  //     return TransPeminjam(
  //       id: maps[i]['id'],
  //       contractno: maps[i]['contract_no'],
  //       borrowername: maps[i]['borrower_name'],
  //       jenisusahacode: maps[i]['jenis_usaha_code'],
  //       nilaipendanaan: maps[i]['nilai_pendanaan'],
  //       tenorpembayaran: maps[i]['tenor_pembayaran'],
  //       sisapokok: maps[i]['sisa_pokok'],
  //       tglbyrakhir: maps[i]['tgl_byr_akhir'],
  //       frekuensi: maps[i]['frekuensi'],
  //     );
  //   });
  // }

  Future<List<ProductModel>> transuser() async {
    final Database db = database;

    final List<Map<String, dynamic>> maps = await db.query('medicine');

    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        code: maps[i]['code'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        stock: maps[i]['stock'],
      );
    });
  }

  Future<int> countTotal() async {
    final Database db = database;
    final int sumEarning = Sqflite
        .firstIntValue(await db.rawQuery('SELECT SUM(amount) FROM medicine WHERE type = "earning"'));
    final int sumExpense = Sqflite
        .firstIntValue(await db.rawQuery('SELECT SUM(amount) FROM medicine WHERE type = "expense"'));
    return ((sumEarning  == null? 0: sumEarning) - (sumExpense == null? 0: sumExpense));
  }

  // Future<void> updateTrans(ProductModel trans) async {
  //   final db = database;

  //   await db.update(
  //     'transpeminjam',
  //     trans.toMap(),
  //     where: "id = ?",
  //     whereArgs: [trans.id],
  //   );
  // }

  Future<void> updateTransUser(ProductModel product) async {
    final db = database;

    await db.update(
      'medicine',
      product.toMap(),
      where: "id = ?",
      whereArgs: [product.id],
    );
  }

  // Future<void> deleteTrans(int id) async {
  //   final db = database;

  //   await db.delete(
  //     'transpeminjam',
  //     where: "id = ?",
  //     whereArgs: [id],
  //   );
  // }
  Future<void> deleteTransuser(int id) async {
    final db = database;

    await db.delete(
      'medicine',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Future<void> deleteTransSql(String contractno) async {
  //   final db = database;

  //   await db.delete(
  //     'transpeminjam',
  //     where: "contract_no = ?",
  //     whereArgs: [contractno],
  //   );
  // }
  Future<void> deleteTransuserSql(String email) async {
    final db = database;

    await db.delete(
      'medicine',
      where: "type = ?",
      whereArgs: [email],
    );
  }
}