import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/image_carousel_model.dart';

class CarouselService {
  Future<List<String?>> getListCarouselUrl() async {
    var listImageRef = await FirebaseFirestore.instance
        .collection('Settings')
        .doc('imageCarousel')
        .collection("listImage")
        .get();

    List<String?> listImageUrl = listImageRef.docs
        .map((doc) => ImageCarousel.fromFirestore(doc).imageUrl)
        .toList();
    return listImageUrl;
  }
}
