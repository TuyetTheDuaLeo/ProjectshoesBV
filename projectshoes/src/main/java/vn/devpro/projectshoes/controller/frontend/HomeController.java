package vn.devpro.projectshoes.controller.frontend;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.projectshoes.controller.BaseController;
import vn.devpro.projectshoes.model.Category;
import vn.devpro.projectshoes.model.Product;
import vn.devpro.projectshoes.model.ProductImage;
import vn.devpro.projectshoes.service.CategoryService;
import vn.devpro.projectshoes.service.ProductImageService;
import vn.devpro.projectshoes.service.ProductService;

@Controller
public class HomeController extends BaseController{
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductImageService productImageService;
	@Autowired 
	private CategoryService categoryService;
	
	@RequestMapping(value="/index", method = RequestMethod.GET)
	// @RequestMapping : Anh xa mot action den mot action method trong controller
	public String index(final Model model,
			final HttpServletRequest request,
			final HttpServletResponse response) throws IOException{
		List<Product> products = productService.findAllActive();
		List<Category> categories = categoryService.findAllActive();
		model.addAttribute("categories",categories);
		model.addAttribute("products",products);
		return "frontend/index";
	}
	@RequestMapping(value="/product-detail/{productId}", method = RequestMethod.GET)
	// @RequestMapping : Anh xa mot action den mot action method trong controller
	public String productDetail(final Model model,
			final HttpServletRequest request,
			final HttpServletResponse response,
			@PathVariable("productId") int productId) throws IOException{
		
		Product product = productService.getById(productId);
		model.addAttribute("product", product);
		
		List<ProductImage> productImages = productImageService.getProductImageByProductId(productId);
		model.addAttribute("productImages", productImages);
		return "frontend/product-detail";
	}
	
}
