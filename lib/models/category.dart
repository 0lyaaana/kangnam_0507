import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final List<Subcategory> subcategories;

  Category(this.name, this.icon, this.subcategories);
}

class Subcategory {
  final String name;
  final List<Store> stores;

  Subcategory(this.name, this.stores);
}

class Store {
  final String name;
  final bool hasDiscount;

  Store(this.name, this.hasDiscount);
}
