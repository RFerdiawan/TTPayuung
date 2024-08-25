import 'package:get_storage/get_storage.dart';
import 'package:payuung_pribadi/models/wellness_product_model.dart';

class WellnessProductService {
  static final GetStorage _storage = GetStorage();
  static const String _masterDataKey = 'wellness_product_master_data';

  // Fungsi untuk menyimpan master data
  static void saveMasterData() {
    List<WellnessProductModel> products = [
      WellnessProductModel(
        id: '1',
        name: 'Voucher Digital Alfamart Rp. 100.000',
        price: 100000,
        type: 'Voucher Digital',
        image: 'assets/images/alfamart.png',
        minPurchase: 1,
        maxPurchase: 50,
        description: 'Deskripsi produk 1.',
        wishlist: false,
      ),
      WellnessProductModel(
        id: '2',
        name: 'Voucher Digital Grab Transport Rp. 50.000',
        price: 50000,
        type: 'Voucher Digital',
        image: 'assets/images/grab.png',
        minPurchase: 1,
        maxPurchase: 10,
        description: 'Deskripsi produk 2.',
        wishlist: true,
      ),
      WellnessProductModel(
        id: '3',
        name: 'Voucher Digital Indomaret Rp. 100.000',
        price: 100000,
        type: 'Voucher Digital',
        image: 'assets/images/indomaret.png',
        minPurchase: 1,
        maxPurchase: 50,
        description: 'Deskripsi produk 1.',
        wishlist: false,
      ),
      WellnessProductModel(
        id: '4',
        name: 'Voucher Digital Gojek Rp. 50.000',
        price: 50000,
        type: 'Voucher Digital',
        image: 'assets/images/gojek.png',
        minPurchase: 1,
        maxPurchase: 10,
        description: 'Deskripsi produk 2.',
        wishlist: true,
      ),
      WellnessProductModel(
        id: '5',
        name: 'Pulsa Telkomsel Rp. 100.000',
        price: 100000,
        type: 'Voucher Digital',
        image: 'assets/images/telkomsel.png',
        minPurchase: 1,
        maxPurchase: 50,
        description: 'Deskripsi produk 1.',
        wishlist: false,
      ),
      WellnessProductModel(
        id: '6',
        name: 'Voucher Digital Tiket.com Rp. 500.000',
        price: 450000,
        type: 'Voucher Digital',
        image: 'assets/images/tiket.com.png',
        minPurchase: 1,
        maxPurchase: 10,
        description: 'Deskripsi produk 2.',
        wishlist: true,
      ),
    ];

    List<Map<String, dynamic>> productsJson =
        products.map((product) => product.toJson()).toList();
    _storage.write(_masterDataKey, productsJson);
  }

  static List<WellnessProductModel> getMasterData() {
    List<dynamic> productsJson = _storage.read(_masterDataKey) ?? [];
    return productsJson
        .map((productJson) => WellnessProductModel.fromJson(productJson))
        .toList();
  }
}
