package vn.devpro.projectshoes.controller;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;


import vn.devpro.projectshoes.dto.Cart;
import vn.devpro.projectshoes.model.Category;
import vn.devpro.projectshoes.model.Product;
import vn.devpro.projectshoes.model.User;
import vn.devpro.projectshoes.service.CategoryService;

@Controller
public class BaseController {
	@ModelAttribute("title")
	public String projectTitle() {
		return "Projectshoes";
	}
	@ModelAttribute("totalCartproducts")
	public BigInteger getTotalCartproducts(final HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("cart") == null) {
			return BigInteger.ZERO;
		}
		Cart cart = (Cart) session.getAttribute("cart");
		return cart.totalCartProduct();
	}
	//Lấy thông tin của user đăng nhập
	@ModelAttribute("loginedUser")
	public User getLogined() {
		Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(loginedUser != null && loginedUser instanceof UserDetails) {
			User user = (User) loginedUser;
			return user;
		}
		return new User();
	}
	@ModelAttribute("isLogined")
	public boolean isLogined() {
		Object loginedUser =  SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(loginedUser != null && loginedUser instanceof User) {
			return true;
		}
		return false;
	}
	
	// Hiển thị thông tin loại sản phẩm duyệt qua từng ID
	@Autowired
	private CategoryService categoryService;
	@ModelAttribute("categories")
	public List<Category> getCategory(final HttpServletRequest request) {
	     return categoryService.findAllActive();
	}
	// Phương thức để tính toán giá trị discount cho danh sách sản phẩm
	public List<BigDecimal> calculateDiscounts(List<Product> products) {
	    List<BigDecimal> discounts = new ArrayList<>();
	    for (Product product : products) {
	        BigDecimal discount = BigDecimal.ZERO;
	        if (product.getPrice() != null && product.getSalePrice() != null &&
	                product.getPrice().compareTo(BigDecimal.ZERO) > 0 &&
	                product.getSalePrice().compareTo(BigDecimal.ZERO) > 0) {
	            BigDecimal val = product.getPrice().subtract(product.getSalePrice());
	            discount = val.divide(product.getPrice(), 2, RoundingMode.HALF_UP)
	                    .multiply(BigDecimal.valueOf(100));
	        }
	        discounts.add(discount);
	    }
	    return discounts;
	}
	@ModelAttribute("superadmin")
    public boolean isSuperAdmin() {
        // Lấy thông tin người dùng hiện tại từ Spring Security
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.isAuthenticated()) {
            // Kiểm tra xem người dùng có thuộc quyền SuperAdmin hay không
            for (GrantedAuthority authority : authentication.getAuthorities()) {
                if (authority.getAuthority().equals("SUPERADMIN")) {
                    return true;
                }
            }
        }

        return false;
    }
}
