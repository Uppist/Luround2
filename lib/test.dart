import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final double price;
  final double vat;
  final double discount;

  Product({
    required this.name,
    required this.price,
    required this.vat,
    required this.discount,
  });
}

class MyApp extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Product 1', price: 50.0, vat: 0.05, discount: 0.1),
    Product(name: 'Product 2', price: 30.0, vat: 0.08, discount: 0.05),
    Product(name: 'Product 3', price: 20.0, vat: 0.1, discount: 0.0),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
        ),
        body: ProductList(products: products),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  final List<Product> products;

  ProductList({required this.products});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.products[index].name),
                subtitle: Text('Price: \$${widget.products[index].price.toString()}'),
                trailing: Checkbox(
                  value: selectedProducts.contains(widget.products[index]),
                  onChanged: (value) {
                    setState(() {
                      if (value != null && value) {
                        selectedProducts.add(widget.products[index]);
                      } else {
                        selectedProducts.remove(widget.products[index]);
                      }
                    });
                  },
                ),
              );
            },
          ),
        ),
        SelectedProductList(selectedProducts: selectedProducts),
        ElevatedButton(
          onPressed: () {
            _showTotal();
          },
          child: Text('Calculate Total'),
        ),
      ],
    );
  }

  void _showTotal() {
    double totalPrice = 0;
    double totalDiscount = 0;
    double totalVat = 0;

    for (var product in selectedProducts) {
      totalPrice += product.price;
      totalDiscount += product.discount;
      totalVat += product.price * product.vat;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Total'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total Price: \$${totalPrice.toString()}'),
              Text('Total Discount: \$${totalDiscount.toString()}'),
              Text('Total VAT: \$${totalVat.toString()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class SelectedProductList extends StatelessWidget {
  final List<Product> selectedProducts;

  SelectedProductList({required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Selected Products:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: selectedProducts.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(selectedProducts[index].name),
              );
            },
          ),
        ),
      ],
    );
  }
}
