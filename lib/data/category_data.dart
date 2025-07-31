// Sample data for different categories
class CategoryData {
  static const Map<String, List<Map<String, dynamic>>> categoryItems = {
    'Vegetables': [
      {
        'name': 'Fresh Tomatoes',
        'imagePath': 'assets/images/tomatoes.png',
        'description': 'Fresh red tomatoes, perfect for cooking',
        'price': '8.50',
        'unit': 'per kg',
      },
      {
        'name': 'Green Peppers',
        'imagePath': 'assets/images/green_peppers.png',
        'description': 'Crisp green bell peppers',
        'price': '12.00',
        'unit': 'per kg',
      },
      {
        'name': 'Fresh Onions',
        'imagePath': 'assets/images/onions.png',
        'description': 'Yellow onions, locally grown',
        'price': '6.75',
        'unit': 'per kg',
      },
      {
        'name': 'Carrots',
        'imagePath': 'assets/images/carrots.png',
        'description': 'Fresh orange carrots',
        'price': '9.25',
        'unit': 'per kg',
      },
      {
        'name': 'Cabbage',
        'imagePath': 'assets/images/cabbage.png',
        'description': 'Fresh green cabbage',
        'price': '5.50',
        'unit': 'per head',
      },
      {
        'name': 'Spinach',
        'imagePath': 'assets/images/spinach.png',
        'description': 'Fresh leafy spinach',
        'price': '7.00',
        'unit': 'per bunch',
      },
      {
        'name': 'Cucumber',
        'imagePath': 'assets/images/cucumber.png',
        'description': 'Fresh green cucumbers',
        'price': '4.25',
        'unit': 'per kg',
      },
      {
        'name': 'Lettuce',
        'imagePath': 'assets/images/lettuce.png',
        'description': 'Crisp iceberg lettuce',
        'price': '6.00',
        'unit': 'per head',
      },
    ],
    'Fruits': [
      {
        'name': 'Fresh Bananas',
        'imagePath': 'assets/images/bananas.png',
        'description': 'Sweet ripe bananas',
        'price': '4.50',
        'unit': 'per dozen',
      },
      {
        'name': 'Red Apples',
        'imagePath': 'assets/images/apples.png',
        'description': 'Crisp red apples',
        'price': '15.00',
        'unit': 'per kg',
      },
      {
        'name': 'Sweet Oranges',
        'imagePath': 'assets/images/oranges.png',
        'description': 'Juicy sweet oranges',
        'price': '8.75',
        'unit': 'per kg',
      },
      {
        'name': 'Fresh Pineapple',
        'imagePath': 'assets/images/pineapple.png',
        'description': 'Sweet tropical pineapple',
        'price': '12.00',
        'unit': 'per piece',
      },
      {
        'name': 'Watermelon',
        'imagePath': 'assets/images/watermelon.png',
        'description': 'Fresh juicy watermelon',
        'price': '18.50',
        'unit': 'per piece',
      },
      {
        'name': 'Mangoes',
        'imagePath': 'assets/images/mangoes.png',
        'description': 'Sweet ripe mangoes',
        'price': '10.25',
        'unit': 'per kg',
      },
      {
        'name': 'Grapes',
        'imagePath': 'assets/images/grapes.png',
        'description': 'Fresh green grapes',
        'price': '22.00',
        'unit': 'per kg',
      },
      {
        'name': 'Papaya',
        'imagePath': 'assets/images/papaya.png',
        'description': 'Sweet ripe papaya',
        'price': '7.50',
        'unit': 'per piece',
      },
    ],
    'Beverages': [
      {
        'name': 'Fresh Coconut Water',
        'imagePath': 'assets/images/coconut_water.png',
        'description': 'Natural coconut water',
        'price': '5.00',
        'unit': 'per bottle',
      },
      {
        'name': 'Palm Wine',
        'imagePath': 'assets/images/palm_wine.png',
        'description': 'Traditional palm wine',
        'price': '8.50',
        'unit': 'per bottle',
      },
      {
        'name': 'Ginger Drink',
        'imagePath': 'assets/images/ginger_drink.png',
        'description': 'Spicy ginger beverage',
        'price': '6.75',
        'unit': 'per bottle',
      },
      {
        'name': 'Hibiscus Tea',
        'imagePath': 'assets/images/hibiscus_tea.png',
        'description': 'Natural hibiscus tea',
        'price': '4.25',
        'unit': 'per pack',
      },
      {
        'name': 'Baobab Juice',
        'imagePath': 'assets/images/baobab_juice.png',
        'description': 'Nutritious baobab fruit juice',
        'price': '9.00',
        'unit': 'per bottle',
      },
      {
        'name': 'Moringa Tea',
        'imagePath': 'assets/images/moringa_tea.png',
        'description': 'Healthy moringa leaf tea',
        'price': '12.50',
        'unit': 'per pack',
      },
    ],
    'Flour': [
      {
        'name': 'Cassava Flour',
        'imagePath': 'assets/images/cassava_flour.png',
        'description': 'Pure cassava flour',
        'price': '15.00',
        'unit': 'per 2kg bag',
      },
      {
        'name': 'Plantain Flour',
        'imagePath': 'assets/images/plantain_flour.png',
        'description': 'Ground plantain flour',
        'price': '18.50',
        'unit': 'per 2kg bag',
      },
      {
        'name': 'Yam Flour',
        'imagePath': 'assets/images/yam_flour.png',
        'description': 'Traditional yam flour',
        'price': '22.00',
        'unit': 'per 2kg bag',
      },
      {
        'name': 'Corn Flour',
        'imagePath': 'assets/images/corn_flour.png',
        'description': 'Fine ground corn flour',
        'price': '12.75',
        'unit': 'per 2kg bag',
      },
      {
        'name': 'Rice Flour',
        'imagePath': 'assets/images/rice_flour.png',
        'description': 'Pure rice flour',
        'price': '16.25',
        'unit': 'per 2kg bag',
      },
      {
        'name': 'Millet Flour',
        'imagePath': 'assets/images/millet_flour.png',
        'description': 'Nutritious millet flour',
        'price': '20.00',
        'unit': 'per 2kg bag',
      },
      {
        'name': 'Wheat Flour',
        'imagePath': 'assets/images/wheat_flour.png',
        'description': 'All-purpose wheat flour',
        'price': '14.50',
        'unit': 'per 2kg bag',
      },
    ],
  };

  static List<Map<String, dynamic>> getItemsForCategory(String category) {
    return categoryItems[category] ?? [];
  }

  static List<String> getAllCategories() {
    return categoryItems.keys.toList();
  }
}
