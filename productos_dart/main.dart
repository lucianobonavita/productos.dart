import 'dart:io';
import '../clases/productos.dart';

void main() {
  var productService = ProductService();

  while (true) {
    print('1. Mostrar productos');
    print('2. Agregar productos');
    print('3. agregar stock a producto');
    print('4. eliminar stock a producto');
    print('5. eliminar producto por ID');
    print('6. Salir');
    stdout.write('Seleccione una opcion: ');
    var option = int.parse(stdin.readLineSync()!);
    //lee la entrada del usuario desde la consola utilizando stdin.readLineSync() y la convierte a un número entero utilizando int.parse(). La entrada del usuario se almacena en la variable option.

    try {
      switch (option) {
        
        case 1:
          var products = productService.getProducts();
          if (products.isEmpty) {
            print('No hay productos');
          } else {
            print('Productos: ');
            for (var product in products) {
              print(
                  '${product.id}: ${product.name}, \$${product.price} stock: ${product.stock} precio total: ${product.precioTotal}');
            }
          }
          break;

        case 2:
          stdout.write('Ingrese el nombre del producto: ');
          var name = stdin.readLineSync()!;
          stdout.write('Ingrese el precio del producto: ');
          var price = double.parse(stdin.readLineSync()!);
          stdout.write('ingresa el stock del producto: ');
          var stock = int.parse(stdin.readLineSync()!);
          var id = productService.getProducts().length + 1; //Generar un ID único
          //var precioTotal = price * stock;
          var product = Product(id, name, price, stock);
          productService.addProduct(product);
          print(
              'Producto agregado: ${product.id}: ${product.name}, \$${product.price} stock: ${product.stock} precio total: ${product.precioTotal}');
          break;

        case 3: // Agregar stock a un producto
          stdout.write(
              'ingrese el id del producto al que desea agregar el stock: ');
          var productId = int.parse(stdin.readLineSync()!);
          var product = productService.getProductById(productId);
          if (product.id != 0) {
            stdout.write('ingrese la cantidad de stock a agregar: ');
            var stockToAdd = int.parse(stdin.readLineSync()!);
            product.addStock(stockToAdd);
            print('stock agregado al producto con el id: $productId stock actual: ${product.stock}');
          } else {
            print('no se encontró ningun producto con el id: $productId');
          }
          break;

        case 4:
          stdout.write(
              'Ingrese el ID del producto del cual desea eliminar stock: ');
          var productId = int.parse(stdin.readLineSync()!);

          // Buscar el producto por ID
          var product = productService.getProductById(productId);

          if (product.id != 0) {
            stdout.write('Ingrese la cantidad de stock a eliminar: ');
            var stockToRemove = int.parse(stdin.readLineSync()!);

            // Verificar si hay suficiente stock para eliminar
            if (product.stock >= stockToRemove) {
              // Eliminar stock del producto
              product.removeStock(stockToRemove);
              if (product.stock > 0) {
                print('Stock eliminado del producto con ID $productId. Stock restante: ${product.stock}');
              } else {
                print('Todo el stock del producto con ID $productId ha sido eliminado');
              }
            } else {
              print('No hay suficiente stock para eliminar esa cantidad');
            }
          } else {
            // El producto no fue encontrado, mostrar un mensaje de error
            print('Error: No se encontró un producto con el ID $productId');
          }
          break;
        case 5:
          stdout.write('Ingrese el ID del producto a eliminar: ');
          var productId = int.parse(stdin.readLineSync()!);

          // Buscar el producto por ID
          var productToRemove = productService.getProducts().firstWhere(
                (product) => product.id == productId,
                orElse: () => Product(0, "", 0, 0) // Valores predeterminados si no se encuentra el producto
              );

          // Verificar si se encontró el producto
          if (productToRemove.id != 0) {
            // El producto fue encontrado, mostrar su stock antes de eliminarlo
            print('Stock del producto con ID $productId: ${productToRemove.stock}');
          }

          // Verificar si se encontró el producto
          if (productToRemove.id != 0) {
            // El producto fue encontrado, eliminarlo
            var productName = productToRemove.name;
            var productPrice = productToRemove.price;
            productService.removeProductById(productId);
            print( 'Producto eliminado: id: $productId, Nombre: $productName, Precio: $productPrice');
          } else {
            // El producto no fue encontrado, mostrar un mensaje de error
            print('Error: No se encontró un producto con el ID $productId');
          }
          break;
        case 6:
          print('saliendo del programa, ¡hasta luego!');
          return;

        default:
          print('Opción no válida :/');
      }
    } catch (e) {
      print('Error: $e'); //Manejar la excepción mostrando un mensaje de error
    }
  }
}
