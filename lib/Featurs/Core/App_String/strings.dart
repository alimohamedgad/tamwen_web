import '../../Data/model/details_models.dart';

List<DetailsModel> imageWithNameProductList = [
  DetailsModel(
      image: 'assets/img/sugar.jpg',
      nameProduct: 'سكر',
      dateTime: DateTime.now().month),
  DetailsModel(
      image: 'assets/img/zit_tamwen.jpg',
      nameProduct: 'زيت تموين',
      dateTime: DateTime.now().month),
  DetailsModel(
      image: 'assets/img/rice.jpg',
      nameProduct: 'رز',
      dateTime: DateTime.now().month),
  DetailsModel(
      image: 'assets/img/tea.jpg',
      nameProduct: 'شاى ليبتون',
      dateTime: DateTime.now().month),
  DetailsModel(
      image: 'assets/img/tea_3arosa.jpg',
      nameProduct: 'شاى العروسه',
      dateTime: DateTime.now().month),
  DetailsModel(
      image: 'assets/img/zit_afia.jpg',
      nameProduct: 'زيت حر',
      dateTime: DateTime.now().month),
  DetailsModel(
      image: "assets/img/tona.jpg",
      nameProduct: 'تونه قطع',
      dateTime: DateTime.now().month),
  DetailsModel(
      image: 'assets/img/tona_mftata.jpg',
      nameProduct: 'تونه مفتته',
      dateTime: DateTime.now().month),
  DetailsModel(
      image: 'assets/img/samna.jpg',
      nameProduct: 'سمنه',
      dateTime: DateTime.now().month),
  DetailsModel(
      image: 'assets/img/marba.jpg',
      nameProduct: 'مربة',
      dateTime: DateTime.now().month),
  DetailsModel(
      image: 'assets/img/halawa.jpg',
      nameProduct: 'حلاوه',
      dateTime: DateTime.now().month),
  DetailsModel(
      image: 'assets/img/mar2tDagag.jpeg',
      nameProduct: 'مرقة دجاج',
      dateTime: DateTime.now().month),
];
var quantiteList = [for (var i = 0; i < 51; i++) i];
var listFromZeroTo9 = List.generate(9, (index) => index);
var mainPeopleList = List.generate(9, (index) => index);
