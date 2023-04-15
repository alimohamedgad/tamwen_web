import '../../Featurs/Model/product.dart';

List<ProductModel> imageWithNameProductList = [
  ProductModel(
      image: 'assets/img/sugar.jpg',
      nameProduct: 'سكر',
      dateTime: DateTime.now().month),
  ProductModel(
      image: 'assets/img/zit_tamwen.jpg',
      nameProduct: 'زيت تموين',
      dateTime: DateTime.now().month),
  ProductModel(
      image: 'assets/img/rice.jpg',
      nameProduct: 'رز',
      dateTime: DateTime.now().month),
  ProductModel(
      image: 'assets/img/tea.jpg',
      nameProduct: 'شاى ليبتون',
      dateTime: DateTime.now().month),
  ProductModel(
      image: 'assets/img/tea_3arosa.jpg',
      nameProduct: 'شاى العروسه',
      dateTime: DateTime.now().month),
  ProductModel(
      image: 'assets/img/zit_afia.jpg',
      nameProduct: 'زيت حر',
      dateTime: DateTime.now().month),
  ProductModel(
      image: "assets/img/tona.jpg",
      nameProduct: 'تونه قطع',
      dateTime: DateTime.now().month),
  ProductModel(
      image: 'assets/img/tona_mftata.jpg',
      nameProduct: 'تونه مفتته',
      dateTime: DateTime.now().month),
  ProductModel(
      image: 'assets/img/samna.jpg',
      nameProduct: 'سمنه',
      dateTime: DateTime.now().month),
  ProductModel(
      image: 'assets/img/marba.jpg',
      nameProduct: 'مربة',
      dateTime: DateTime.now().month),
  ProductModel(
      image: 'assets/img/halawa.jpg',
      nameProduct: 'حلاوه',
      dateTime: DateTime.now().month),
  ProductModel(
      image: 'assets/img/mar2tDagag.jpeg',
      nameProduct: 'مرقة دجاج',
      dateTime: DateTime.now().month),
];

List<ProductModel> dumyProduct = [
  ProductModel(
      nameProduct: 'سكر تموين', id: '1', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'زيت تموين', id: '2', dateTime: DateTime.now().month),
  ProductModel(nameProduct: 'مكرونة', id: '3', dateTime: DateTime.now().month),
  ProductModel(nameProduct: 'سكر حر', id: '4', dateTime: DateTime.now().month),
  ProductModel(nameProduct: 'زيت حر', id: '5', dateTime: DateTime.now().month),
  ProductModel(nameProduct: 'ملح', id: '6', dateTime: DateTime.now().month),
  ProductModel(nameProduct: 'رز', id: '7', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'شاى عروسه كبير', id: '8', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'شاى عروسه صغير', id: '9', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'شاى ليبتون كبير', id: '10', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'شاى ليبتون صغير', id: '11', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'حلاوة كبيره', id: '12', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'حلاوة صغيره', id: '13', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'سمنه سايبه', id: '14', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'سمنه كيلوا', id: '15', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'سمنه 2 كيلوا', id: '16', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'سمنه 3 كيلوا', id: '17', dateTime: DateTime.now().month),
  ProductModel(nameProduct: 'مربى', id: '18', dateTime: DateTime.now().month),
  ProductModel(nameProduct: 'طماطم', id: '19', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'تونة قطع', id: '20', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'تونة مفتته', id: '21', dateTime: DateTime.now().month),
  ProductModel(
      nameProduct: 'مرقة دجاج', id: '22', dateTime: DateTime.now().month),
];
final quantiteList = [for (var i = 0; i < 51; i++) i];
final listFromZeroTo9 = [for (var i = 0; i < 9; i++) i];
final mainPeopleList = [for (var i = 0; i < 9; i++) i];

final priceForOnePerson = [for (var i = 30; i < 51; i += 5) i];
