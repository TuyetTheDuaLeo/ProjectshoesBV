package vn.devpro.projectshoes.controller.backend;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.devpro.projectshoes.controller.BaseController;
import vn.devpro.projectshoes.dto.PsConstants;
import vn.devpro.projectshoes.dto.SearchModel;
import vn.devpro.projectshoes.model.Category;
import vn.devpro.projectshoes.model.Product;
import vn.devpro.projectshoes.model.User;
import vn.devpro.projectshoes.service.CategoryService;
import vn.devpro.projectshoes.service.ProductService;
import vn.devpro.projectshoes.service.UserService;

@Controller
@RequestMapping("/admin/product/")
public class ProductController extends BaseController implements PsConstants{
	@Autowired
	private ProductService productService;
	@Autowired
	private UserService userService;
	@Autowired
	private CategoryService categoryService;
	
	
//	@RequestMapping(value = "list", method = RequestMethod.GET)
//	public String list(final Model model) {
//		List<Product> products = productService.findAll();
//		model.addAttribute("products", products);
//		return "backend/product-list";
//	}
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(final Model model,
			final HttpServletRequest request) {
		SearchModel productSearch = new SearchModel();
		//Tìm theo status
		productSearch.setStatus(2);
		String status = request.getParameter("status");
		if(!StringUtils.isEmpty(status)) {// Có chọn status
			productSearch.setStatus(Integer.parseInt(status));
		}
		// Tìm kiếm theo category
		productSearch.setCategoryId(0);
		String categoryId = request.getParameter("categoryId");
		if(!StringUtils.isEmpty(categoryId)) {// Có chọn category
			productSearch.setCategoryId(Integer.parseInt(categoryId));
		}
		//Tìm theo từ khóa
		productSearch.setKeyword(null);
		String keyword = request.getParameter("keyword");
		if(!StringUtils.isEmpty(keyword)) {
			productSearch.setKeyword(keyword);
		}
		// Tìm kiếm theo ngày tháng
		String beginDate = null;
		String endDate = null;
		if (!StringUtils.isEmpty(request.getParameter("beginDate"))
				&& !StringUtils.isEmpty(request.getParameter("endDate"))) {
			beginDate = request.getParameter("beginDate");
			endDate = request.getParameter("endDate");
		}
		productSearch.setBeginDate(beginDate);
		productSearch.setEndDate(endDate);
		
		// Bắt đầu phần trang
		if(!StringUtils.isEmpty(request.getParameter("currentPage"))) {
			productSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}else {
			productSearch.setCurrentPage(1);
		}
		
		List<Product> allProducts = productService.searchProduct(productSearch);// Tìm kiếm
		List<Product> products = new ArrayList<Product>();// Danh sách hiển thị trang hiện tại
		// Tính tổng số trang theo tìm kiếm
		int totalPages = allProducts.size() / SIZE_OF_PAGE;
		if(allProducts.size() % SIZE_OF_PAGE > 0) {
			totalPages++;
		}
		// Nếu tổng số trang nhỏ hơn trang hiện tại
		if(totalPages < productSearch.getCurrentPage()) {
			productSearch.setCurrentPage(1);
		}
		// Lấy danh sách cần hiển thị trong một trang
		int firstIndex = (productSearch.getCurrentPage() - 1) * SIZE_OF_PAGE;
		int index = firstIndex, count = 0;
		while(index < allProducts.size() && count < SIZE_OF_PAGE) {
			products.add(allProducts.get(index));
			index++;
			count++;
		} 
		// Phân trang
		productSearch.setSizeOfPage(SIZE_OF_PAGE);
		productSearch.setTotalItems(allProducts.size());
		List<Category> categories = categoryService.findAll();
		model.addAttribute("categories", categories);
		
		model.addAttribute("products", products);
		model.addAttribute("productSearch", productSearch);
		// Tính tổng số lượng còn của một loại
		Integer totalProducts = 0;
		for(Product product : allProducts) {
		    Integer productTotal;
		    if(product.getProductQuantity() == null) {
		        productTotal = 0;
		    } else {
		        productTotal = product.getProductQuantity().intValue();
		    }
		    totalProducts += productTotal;
		}
		model.addAttribute("totalProducts", totalProducts);
		return "backend/product-list";
	}
	
	
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String add(final Model model) {
		List<User> users = userService.findAll();
		model.addAttribute("users", users);
		
		List<Category> categories = categoryService.findAll();
		model.addAttribute("categories", categories);
		
		Product product = new Product();
		product.setCreateDate(new Date());
		
		model.addAttribute("product", product);
		return "backend/product-add";
	}
	@RequestMapping(value="/add-save", method = RequestMethod.POST)
	public String productAddSave(final Model model,
			@ModelAttribute("product") Product product,
			@RequestParam("avatarFile") MultipartFile avatarFile,
			@RequestParam("imageFiles") MultipartFile[] imageFiles) throws IOException{
		productService.saveAddProduct(product, avatarFile, imageFiles);
		return "redirect:/admin/product/list";
	}
	@RequestMapping(value = "edit/{productId}", method = RequestMethod.GET)
	public String edit(final Model model,
			@PathVariable("productId") int productId) {
		List<User> users = userService.findAll();
		model.addAttribute("users", users);
		
		List<Category> categories = categoryService.findAll();
		model.addAttribute("categories", categories);
		
		// Lấy product trong DB 
		Product product = productService.getById(productId);
		product.setUpdateDate(new Date());
		
		model.addAttribute("product", product);
		return "backend/product-edit";
	}
	@RequestMapping(value="/edit-save", method = RequestMethod.POST)
	public String productEditSave(final Model model,
			@ModelAttribute("product") Product product,
			@RequestParam("avatarFile") MultipartFile avatarFile,
			@RequestParam("imageFiles") MultipartFile[] imageFiles) throws IOException{
		productService.saveEditProduct(product, avatarFile, imageFiles);
		return "redirect:/admin/product/list";
	}
//	@RequestMapping(value = "delete/{productId}", method = RequestMethod.GET)
//	public String delete(final Model model,
//			@PathVariable("productId") int productId) {
//		// Lấy product trong DB 
//		Product product = productService.getById(productId);
//		
//		productService.deleteProduct(product);
//		model.addAttribute("product", product);
//		return "redirect:/admin/product/list";
//	}
	//------------Inactive---------------
	@RequestMapping(value = "delete/{productId}", method = RequestMethod.GET)
	public String delete(final Model model,
			@PathVariable("productId") int productId) {
		// Lấy product trong DB 
		Product product = productService.getById(productId);
		
		product.setStatus(false);
		productService.inactiveProduct(product);
		return "redirect:/admin/product/list";
	}
}
