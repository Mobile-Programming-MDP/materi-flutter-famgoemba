import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item_model.dart';

class DatabaseService {
  final CollectionReference _collection = FirebaseFirestore.instance.collection('items');

  // Menambah data
  Future<void> addItem(ItemModel item) async {
    await _collection.add(item.toMap());
  }

  // Mengambil data secara real-time
  Stream<List<ItemModel>> getKoleksi() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ItemModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}