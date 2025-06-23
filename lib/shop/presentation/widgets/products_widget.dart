import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import '../../../core/styles/text_styles.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../core/util/duration_extension.dart';
import '../../../core/widgets/app_adaptive_grid.dart';
import '../../../core/widgets/product_tile.dart';
import '../../models/filtered_products_model.dart';
import '../cubit/shop_cubit.dart';
// ignore: depend_on_referenced_packages
import 'package:sliver_center/sliver_center.dart';
import 'package:e_commerce/shop/presentation/widgets/products_show_more.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/models/product.dart' as app_product;

class ProductsWidget extends StatelessWidget {
  final ProductsViewLayout layout;
  final FilteredProductsModel model;
  const ProductsWidget({super.key, required this.layout, required this.model});

  @override
  Widget build(BuildContext context) {
    final products = model.products;
    productTileBuilder({
      required BuildContext context,
      required int index,
      bool detailed = false,
    }) {
      final product = products[index];

      final appProduct = app_product.Product(
        id: product.id,
        productNew: product.productNew,
        name: product.name,
        price: product.price,
        rating: product.rating,
        details: product.details,
        discount: product.discount,
        favorite: product.favorite,
        imagesUrl: product.imagesUrl,
        description: product.description,
        measurements: product.measurements,
        currencyCode: product.currencyCode,
        discountEndDate: product.discountEndDate,
      );

      if (detailed) {
        return ProductTile.detailed(
          product: appProduct,
          index: index,
          productsLength: products.length,
          horizontalMode: false,
        );
      }

      return ProductTile(
        product: appProduct,
        index: index,
        productsLength: products.length,
        horizontalMode: false,
      );
    }

    getProductsSliver() {
      if (layout == ProductsViewLayout.grid) {
        return AppAdaptiveSliverGrid(
          key: ValueKey('Grid'),
          itemCount: products.length,
          minimumTileWidth: 230,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          staticChildHeight: 410,
          textPlaceholders: [
            TextPlaceholderParams(
              context: context,
              style: AppTextStyles.body2Semi,
              texts: products.map((e) => e.name).toList(),
              horizontalPadding: 12,
              maxLines: 1,
            ),
            TextPlaceholderParams(
              context: context,
              style: AppTextStyles.caption1Semi,
              texts:
                  products
                      .map(
                        (e) =>
                            '${getCurrencySymbol(products.first.currencyCode)}${e.price}',
                      )
                      .toList(),
              horizontalPadding: 12,
              maxLines: 1,
            ),
          ],
          itembuilder:
              (context, index) =>
                  productTileBuilder(context: context, index: index),
        );
      }

      return SliverConstrainedCrossAxis(
        key: ValueKey('list'),
        maxExtent: 800,
        sliver: SliverCenter(
          sliver: SliverList.separated(
            itemCount: products.length,
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemBuilder:
                (context, index) => productTileBuilder(
                  context: context,
                  index: index,
                  detailed: true,
                ),
          ),
        ),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        SliverAnimatedSwitcher(duration: 300.ms, child: getProductsSliver()),
        if (model.paginationInfo.currentPage < model.paginationInfo.totalPages)
          SliverPadding(
            padding: const EdgeInsets.only(top: 40),
            sliver: SliverToBoxAdapter(child: ProductsShowMore()),
          ),
        SliverPadding(padding: const EdgeInsets.only(top: 32)),
      ],
    );
  }
}
