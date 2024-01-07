
class Product {
    final int id; 
    final String name; //no pueden cambiar después de que se hayan inicializado en el constructor.
    final double price; //no pueden cambiar después de que se hayan inicializado en el constructor.
    int stock;
    double precioTotal;

    Product(this.id, this.name, this.price, this.stock)
       : precioTotal = price * stock;
        
    void addStock(int cantidad) {
    stock += cantidad; // Método para agregar stock
      precioTotal = price * stock;
    }

      void removeStock(int cantidad) {
    if (stock >= cantidad) {
      stock -= cantidad; // Método para eliminar stock, verifica que haya suficiente stock antes de eliminar
      precioTotal = price * stock;
    } else {
      print('No hay suficiente stock para eliminar');
    }
      
  }

   void removePrecioTotal(double precioTotal){
      if(precioTotal != 0){
        precioTotal = 0;
      }
    }
  

}


class ProductService {
  List<Product> products = [];

  List<Product> getProducts() {
    return products;
  }

  void addProduct(product) {
    products.add(product);
  }

  void removeProductById(int id) {
    products.removeWhere((product) => product.id == id);
  }

Product getProductById(int id) {
  var product = products.firstWhere((product) => product.id == id, orElse: () {
    throw StateError('No se encontró ningún producto con el ID $id');
  });
  return product;
}

  void addStockToProduct(int productId, int cantidad) {
  try {
    var product = getProductById(productId);
    product.addStock(cantidad);
    print('Stock agregado al producto con ID $productId');
  } catch (e) {
    print(e); // Manejar la excepción mostrando un mensaje de error
  }
}

void removeStockFromProduct(int productId, int cantidad) {
  try {
    var product = getProductById(productId);
    product.removeStock(cantidad);
    print('Stock eliminado del producto con ID $productId');
  } catch (e) {
    print(e); // Manejar la excepción mostrando un mensaje de error
  }
}

      void removePrecioTotal(int productId, double precioTotal) {
      try {
        var product = getProductById(productId);
        product.removePrecioTotal(precioTotal);
      } catch (e) {
        print(e); // Manejar la excepción mostrando un mensaje de error
      }
    }
}

