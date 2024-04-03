import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final valor = TextEditingController();

  List<Map<String, dynamic>> compras = [
    {
      "name": "Macarrão",
      "isBought": false,
      "price": "R\$4,00",
    },
    {
      "name": "Arroz",
      "isBought": false,
      "price": "R\$3,50",
    },
  ];

  void addItem(String value) {
    // Adiciona um item sem preço inicialmente
    setState(() {
      compras.add({"name": value, "isBought": false, "price": "R\$0,00"});
    });
    valor.clear();
  }

  void removeItem(int index) {
    setState(() {
      compras.removeAt(index);
    });
  }

  void editItem(int index) {
    TextEditingController nameController =
        TextEditingController(text: compras[index]['name']);
    TextEditingController priceController =
        TextEditingController(text: compras[index]['price']);
    bool isBought = compras[index]['isBought'];

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Editar Item'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Preço'),
                ),
                Row(
                  children: [
                    Text('Comprado:'),
                    Checkbox(
                      value: isBought,
                      onChanged: (bool? value) {
                        setState(() {
                          isBought = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text('Salvar'),
                onPressed: () {
                  setState(() {
                    compras[index] = {
                      "name": nameController.text,
                      "isBought": isBought,
                      "price": priceController.text,
                    };
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras',
            style:
                GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 130, 21, 62),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: valor,
              decoration: InputDecoration(
                hintText: 'Digite um item',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: valor.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => addItem(valor.text),
              child: Text('Adicionar Item'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 130, 21, 62),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: compras.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(
                        '${compras[index]['name']} - ${compras[index]['price']}',
                        style: GoogleFonts.dmSans(fontSize: 16),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => editItem(index),
                            icon: Icon(Icons.edit,
                                color: Color.fromARGB(255, 130, 21, 62)),
                          ),
                          IconButton(
                            onPressed: () => removeItem(index),
                            icon: Icon(Icons.delete,
                                color: Color.fromARGB(255, 240, 65, 65)),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          compras[index]['isBought'] =
                              !compras[index]['isBought'];
                        });
                      },
                      leading: Icon(
                        compras[index]['isBought']
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: compras[index]['isBought']
                            ? Color.fromARGB(255, 76, 175, 84)
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
