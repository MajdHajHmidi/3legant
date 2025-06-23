import 'package:e_commerce/core/widgets/app_gallery_widget.dart';
import 'package:e_commerce/core/widgets/app_image.dart';
import 'package:e_commerce/core/widgets/product_tile.dart';
import 'package:e_commerce/product_details/models/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/models/product.dart' as app_product;

class ProductImageCarousel extends StatelessWidget {
  final ProductDetailsModel model;
  const ProductImageCarousel({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Positioned.fill(
            child: AppGalleryWidget(
              borderRadius: BorderRadius.circular(12),
              itemCount: model.imagesUrl.length,
              itemBuilder:
                  (index) => AppNetworkImage(
                    imageUrl: model.imagesUrl[index],
                    fit: BoxFit.cover,
                  ),
            ),
          ),
          Positioned(
            top: 16.0,
            left: 16,
            right: 16,
            child: ProductTileOverlay(
              product: app_product.Product(
                id: model.id,
                productNew: model.isNew,
                name: model.name,
                price: model.price,
                rating: model.rating,
                details: model.details,
                discount: model.discount,
                favorite: model.isFavorite,
                imagesUrl: model.imagesUrl,
                description: model.description,
                measurements: model.measurements,
                currencyCode: model.currencyCode,
                discountEndDate: model.discountEndDate,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
