import 'package:flutter/material.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/screens/discount/discount_details_page.dart';

class SubcategoryPage extends StatelessWidget {
  final Category category;

  const SubcategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.name} 카테고리'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: category.subcategories.length,
        itemBuilder: (context, index) {
          final subcategory = category.subcategories[index];
          return ExpansionTile(
            title: Text(
              subcategory.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children:
                subcategory.stores.map((store) {
                  return ListTile(
                    title: Text(store.name),
                    enabled: store.hasDiscount,
                    textColor: store.hasDiscount ? null : Colors.grey,
                    trailing:
                        store.hasDiscount
                            ? const Icon(Icons.arrow_forward_ios, size: 16)
                            : const Text(
                              '혜택 없음',
                              style: TextStyle(color: Colors.grey),
                            ),
                    onTap:
                        store.hasDiscount
                            ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => DiscountDetailsPage(
                                        storeName: store.name,
                                        categoryName: category.name,
                                      ),
                                ),
                              );
                            }
                            : null,
                  );
                }).toList(),
          );
        },
      ),
    );
  }
}
