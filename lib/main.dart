import 'package:flutter/material.dart';

void main() {
  runApp(const BillingApp());
}

class BillingApp extends StatelessWidget {
  const BillingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GST Billing App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const BillingHomePage(),
    );
  }
}

class BillingHomePage extends StatefulWidget {
  const BillingHomePage({super.key});

  @override
  State<BillingHomePage> createState() => _BillingHomePageState();
}

class _BillingHomePageState extends State<BillingHomePage> {
  final List<Map<String, dynamic>> _items = [];
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  double _selectedGstRate = 5.0;
  final List<double> _gstRates = [5.0, 12.0, 18.0, 28.0];

  void _addItem() {
    if (_productController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      setState(() {
        _items.add({
          'product': _productController.text,
          'price': double.parse(_priceController.text),
          'gstRate': _selectedGstRate,
        });
        _productController.clear();
        _priceController.clear();
      });
    }
  }

  double _calculateTotal() {
    double total = 0;
    for (var item in _items) {
      double price = item['price'];
      double gstRate = item['gstRate'];
      total += price + (price * gstRate / 100);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GST Billing App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _productController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<double>(
              value: _selectedGstRate,
              decoration: const InputDecoration(
                labelText: 'GST Rate',
                border: OutlineInputBorder(),
              ),
              items:
                  _gstRates.map((rate) {
                    return DropdownMenuItem(value: rate, child: Text('$rate%'));
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGstRate = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _addItem, child: const Text('Add Item')),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    child: ListTile(
                      title: Text(item['product']),
                      subtitle: Text(
                        'Price: ₹${item['price']} | GST: ${item['gstRate']}%',
                      ),
                      trailing: Text(
                        '₹${(item['price'] + (item['price'] * item['gstRate'] / 100)).toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${_calculateTotal().toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
