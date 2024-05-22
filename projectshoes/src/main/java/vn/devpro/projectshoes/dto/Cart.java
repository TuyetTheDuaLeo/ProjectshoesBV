package vn.devpro.projectshoes.dto;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class Cart {
	// Danh sach san pham trong gio hang
		private List<ProductCart> productCarts = new ArrayList<ProductCart>();
		// Tinh tong so san pham trong gio hang
		public BigInteger totalCartProduct() {
			BigInteger total = BigInteger.ZERO;
			for(ProductCart productCart: productCarts) {
				total = total.add(productCart.getQuantity());
			}
			return total;
		}
		// Tinh tong so tien ma khach hang phai tra
		public BigDecimal totalCartPrice() {
			BigDecimal total = BigDecimal.ZERO;
			for(ProductCart productCart: productCarts) {
				total = total.add(productCart.totalPrice());
			}
			return total;
		}
		// Tim san pham trong gio hang theo id
		public int findProductByIdAndSize(int productId, String size) {
		    for (int index = 0; index < productCarts.size(); index++) {
		        ProductCart productCart = productCarts.get(index);
		        if (productCart.getProductId() == productId && productCart.getSize().equals(size)) {
		            return index;
		        }
		    }
		    return -1;
		}
		public Cart() {
			super();
		}
		public Cart(List<ProductCart> productCarts) {
			super();
			this.productCarts = productCarts;
		}
		public List<ProductCart> getProductCarts() {
			return productCarts;
		}
		public void setProductCarts(List<ProductCart> productCarts) {
			this.productCarts = productCarts;
		}
}
