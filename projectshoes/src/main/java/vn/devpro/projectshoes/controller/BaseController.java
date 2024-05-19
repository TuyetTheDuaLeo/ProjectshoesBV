package vn.devpro.projectshoes.controller;

import java.math.BigInteger;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;


import vn.devpro.projectshoes.dto.Cart;
import vn.devpro.projectshoes.model.Category;
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
}
