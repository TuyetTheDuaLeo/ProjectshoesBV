package vn.devpro.projectshoes.controller.frontend;

import java.io.IOException;
import java.math.BigInteger;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.projectshoes.controller.BaseController;
import vn.devpro.projectshoes.dto.Cart;
import vn.devpro.projectshoes.dto.Customer;
import vn.devpro.projectshoes.dto.ProductCart;
import vn.devpro.projectshoes.dto.PsConstants;
import vn.devpro.projectshoes.model.Product;
import vn.devpro.projectshoes.model.SaleOrder;
import vn.devpro.projectshoes.model.SaleOrderProduct;
import vn.devpro.projectshoes.model.User;
import vn.devpro.projectshoes.service.ProductService;
import vn.devpro.projectshoes.service.SaleOrderService;

@Controller
public class CartController extends BaseController implements PsConstants {
	@Autowired
	private ProductService productService;
	
	@Autowired
	private SaleOrderService saleOrderService;
	
	// Thêm một sản phẩm vào giỏ hàng
	@RequestMapping(value = "/add-to-cart", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addToCart(final Model model,
			final HttpServletRequest request,
			@RequestBody ProductCart addProduct) throws IOException{
		
		HttpSession session = request.getSession();
		Cart cart = null;
		// Lay gio hang trong Session
		// Kiem tra xem gio hang da duoc tao trong Session chua
		if(session.getAttribute("cart") != null) { // da co gio hang
			cart = (Cart)session.getAttribute("cart");
			
		}else {
			cart = new Cart();
			session.setAttribute("cart", cart);
		}
		
		// Laay san pham trong co so du lieu
		Product dbProduct = productService.getById(addProduct.getProductId());
		String size = addProduct.getSize();

		// Kiem tra san phamdat mua co trong gio hang chua
		int index = cart.findProductByIdAndSize(dbProduct.getId(),size);
		if(index != -1) {// San pham da co trong gio hang
			cart.getProductCarts().get(index).setQuantity(cart.getProductCarts().get(index).getQuantity().add(addProduct.getQuantity()));
		}else {
			// Kiểm tra xem có size được chọn từ jsp không
			if(addProduct.getSize() != null && !addProduct.getSize().isEmpty()) {
				addProduct.setSize(addProduct.getSize());
			}else {
				// Nếu không có size được chọn thì mặc định lấy size đầu tiên từ danh sách size của sản phẩm
				addProduct.setSize(dbProduct.getSize().split(",")[0]);
			}
			addProduct.setProductName(dbProduct.getName());
			addProduct.setAvatar(dbProduct.getAvatar());
			addProduct.setPrice(dbProduct.getPrice());
			
			cart.getProductCarts().add(addProduct);//Thêm sản phẩm mới vào giỏ hàng
		}
		
		// Thiet lap lai gio hang trong session
		session.setAttribute("cart", cart);
		// Tra ve du lieu cho view
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		jsonResult.put("code", "Thông báo");
		jsonResult.put("totalCartProducts", cart.totalCartProduct());
		jsonResult.put("message"," Đã thêm sản phẩm " + addProduct.getProductName() + " vào giỏ hàng ");
		
		return ResponseEntity.ok(jsonResult);
	}
	// Hiển thị giỏ hàng
	@RequestMapping(value = "/cart-view", method = RequestMethod.GET)
	public String cartView(final Model model, final HttpServletRequest request) throws IOException{
		HttpSession session = request.getSession();
		if(session.getAttribute("cart") != null) {
			Cart cart = (Cart) session.getAttribute("cart");
			model.addAttribute("totalCartPrice", cart.totalCartPrice());
			String message = "Co tong cong" + cart.totalCartProduct() + "trong gio hang";
			model.addAttribute("message", message);
		}else {
			String errorMessage = "khong co san pham nao trong gio hang";
			model.addAttribute("errorMessage", errorMessage);
		}
		return "frontend/cart-view";
	}
	// Them/bot so luong san pham trong gio hang
		@RequestMapping(value = "/update-product-quantity", method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> updateProductQuantity(@RequestBody ProductCart productCart,
				 final HttpServletRequest request) throws IOException {
			HttpSession session = request.getSession();
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			if (session.getAttribute("cart") != null) {
				Cart cart = (Cart) session.getAttribute("cart");
				//Kiêm tra null cho kích thước
				String size = productCart.getSize();
				if(size == null) {
					size = cart.getProductCarts().get(0).getSize();
				}
				// Cap nhat so luong
				int index = cart.findProductByIdAndSize(productCart.getProductId(),size);
				if(index != -1) {
					BigInteger oldQuantity = cart.getProductCarts().get(index).getQuantity();
					BigInteger newQuantity = oldQuantity.add(productCart.getQuantity()); // -/+
					if (newQuantity.intValue() < 1) {
						newQuantity = BigInteger.ONE;
					}
					cart.getProductCarts().get(index).setQuantity(newQuantity);
					jsonResult.put("newQuantity", newQuantity);
					jsonResult.put("productId", productCart.getProductId());
				}
			}	
			// Tra ve du lieu cho view
			return ResponseEntity.ok(jsonResult);
		}
		// 
		@RequestMapping(value = "/place-order", method = RequestMethod.POST)

		public ResponseEntity<Map<String, Object>> placeOrder(final HttpServletRequest request,
				@RequestBody Customer customer) throws IOException {
			Map<String, Object> jsonResult = new HashMap<String, Object>();
			
			//Kiểm tra thông tin customer bắt buộc
			if(StringUtils.isEmpty(customer.getTxtName())) {
				jsonResult.put("code", "Thông báo");
				jsonResult.put("message", "Bạn chưa nhập họ tên");
			}
			else if(StringUtils.isEmpty(customer.getTxtMobile())) {
				jsonResult.put("code", "Thông báo");
				jsonResult.put("message", "Bạn chưa nhập số điện thoại");
			}
			else if(StringUtils.isEmpty(customer.getTxtEmail())) {
				jsonResult.put("code", "Thông báo");
				jsonResult.put("message", "Bạn chưa nhập số email");
			}
			else if(StringUtils.isEmpty(customer.getTxtAddress())) {
				jsonResult.put("code", "Thông báo");
				jsonResult.put("message", "Bạn chưa nhập số địa chỉ");
			}
			else {
				HttpSession session = request.getSession();
				if(session.getAttribute("cart") == null) {
					jsonResult.put("message", "Ban chua co gio hang");
				}else {
					Cart cart = (Cart) session.getAttribute("cart");
					// Lưu các sản phẩm trong giỏ hàng vào bảng tbl_sale_order_product
					SaleOrder saleOrder = new SaleOrder();
					boolean hasEnoughInventory = true;
					for(ProductCart productCart: cart.getProductCarts()) {
						// Lấy sản phẩm trong db
						SaleOrderProduct saleOrderProduct = new SaleOrderProduct();
						Product dbProduct = productService.getById(productCart.getProductId());
						//Lấy ra số lượng sản phẩm trong giỏ hàng
						BigInteger cartQuantity = productCart.getQuantity();
						//Lấy ra số lượng sản phẩm trong kho
						BigInteger currentQuantity = BigInteger.valueOf(dbProduct.getProductQuantity());
						//Tính toán giá trị mới cho cho số lượng còn trong kho
						BigInteger updateQuantity = currentQuantity.subtract(cartQuantity);
						if(updateQuantity.compareTo(BigInteger.ZERO) < 0) {
							hasEnoughInventory = false;
							jsonResult.put("code", "Thông báo");
							jsonResult.put("message", "Sản phẩm " + dbProduct.getName() + " chỉ còn " + currentQuantity + " sản phẩm trong kho. Vui lòng điều chỉnh số lượng.");
			                break; 
						}
						dbProduct.setProductQuantity(updateQuantity.intValue());
						saleOrderProduct.setProduct(dbProduct);
						saleOrderProduct.setQuantity(productCart.getQuantity().intValue());
						saleOrderProduct.setSize(productCart.getSize());
						saleOrderProduct.setCreateDate(new Date());
						saleOrder.addRelationalSaleOrderProduct(saleOrderProduct);
					}
					//Lưu đơn hàng vào tbl_sale_order 
					if(hasEnoughInventory) {
						Calendar cal = Calendar.getInstance();
						String code = customer.getTxtMobile() + cal.get(Calendar.YEAR) + cal.get(Calendar.MONTH)+ 
								cal.get(Calendar.DAY_OF_MONTH);
						saleOrder.setCode(code);
						User user = new User();
						user.setId(1);
						saleOrder.setUser(user);
						saleOrder.setStatus(false);
						saleOrder.setCustomerName(customer.getTxtName());
						saleOrder.setCustomerMobile(customer.getTxtMobile());
						saleOrder.setCustomerEmail(customer.getTxtEmail());
						saleOrder.setCreateDate(new Date());
						saleOrder.setCustomerAddress(customer.getTxtAddress());
						saleOrder.setTotal(cart.totalCartPrice());
						
						saleOrderService.saveOrder(saleOrder);
						jsonResult.put("code", "Thông báo");
						jsonResult.put("message", "Bạn đã đặt hàng thành công");
						// Xóa giỏ hàng sau khi đã đặt hàng
						cart = new Cart();
						session.setAttribute("cart", cart);
					}
				}
			}
			return ResponseEntity.ok(jsonResult);
		}
		@RequestMapping(value = "/product-cart-delete/{productId}/{size}", method = RequestMethod.GET)
		public String deleteProduct(@PathVariable("productId") int productId,@PathVariable("size") String size,
				final HttpServletRequest request,
				final Model model) {
			HttpSession session = request.getSession();
			if(session.getAttribute("cart") != null) {
				Cart cart = (Cart) session.getAttribute("cart");
				//Tìm vị trí của sản phẩm trong giỏ hàng
				int index = cart.findProductByIdAndSize(productId,size);
				if(index != -1) {
					cart.getProductCarts().remove(index);
				}
				// Thiết lập lại giỏ hàng trong session
				session.setAttribute("cart", cart);
			}
			return "redirect:/cart-view";
		}
}
