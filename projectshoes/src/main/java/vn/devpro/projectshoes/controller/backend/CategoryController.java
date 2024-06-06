package vn.devpro.projectshoes.controller.backend;

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


import vn.devpro.projectshoes.controller.BaseController;
import vn.devpro.projectshoes.dto.PsConstants;
import vn.devpro.projectshoes.dto.SearchModel;
import vn.devpro.projectshoes.model.Category;
import vn.devpro.projectshoes.model.User;
import vn.devpro.projectshoes.service.CategoryService;
import vn.devpro.projectshoes.service.UserService;

@Controller
@RequestMapping("/admin/category/")
public class CategoryController extends BaseController implements PsConstants{
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private UserService userService;
	
	@RequestMapping (value = "list", method = RequestMethod.GET)
	public String list(final Model model,
			final HttpServletRequest request) {
		
		// Bắt đầu phần trang
		SearchModel categorySearch = new SearchModel();
		if(!StringUtils.isEmpty(request.getParameter("currentPage"))) {
		categorySearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}else {
			categorySearch.setCurrentPage(1);
		}		
		List<Category> allCategory = categoryService.findAll();
		List<Category> categories = new ArrayList<Category>();// Danh sách hiển thị trang hiện tại
		// Tính tổng số trang theo tìm kiếm
		int totalPages = allCategory.size() / SIZE_OF_PAGE;
		if(allCategory.size() % SIZE_OF_PAGE > 0) {
			totalPages++;
		}
		// Nếu tổng số trang nhỏ hơn trang hiện tại
		if(totalPages < categorySearch.getCurrentPage()) {
			categorySearch.setCurrentPage(1);
		}
		// Lấy danh sách cần hiển thị trong một trang
		int firstIndex = (categorySearch.getCurrentPage() - 1) * SIZE_OF_PAGE;
		int index = firstIndex, count = 0;
		while(index < allCategory.size() && count < SIZE_OF_PAGE) {
			categories.add(allCategory.get(index));
			index++;
			count++;
		} 
		// Phân trang
		categorySearch.setSizeOfPage(SIZE_OF_PAGE);
		categorySearch.setTotalItems(allCategory.size());
		
		model.addAttribute("categories", categories);
		model.addAttribute("categorySearch", categorySearch);
		return "backend/category-list";
	}
	
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String add(final Model model) {
		
		List<User> users = userService.findAll();
		model.addAttribute("users", users);
		Category category = new Category();
		category.setCreateDate(new Date());
		model.addAttribute("category", category);
		
		return "backend/category-add";
	}
	@RequestMapping (value = "add-save", method = RequestMethod.POST)
	public String addSave(final Model model,
			@ModelAttribute("category") Category category) {

		categoryService.saveOrUpdate(category);
		return "redirect:/admin/category/list";
	}
	@RequestMapping (value = "edit/{categoryId}", method = RequestMethod.GET)
	public String edit(final Model model, 
				@PathVariable("categoryId") int categoryId) {
		List<User> users = userService.findAll();
		model.addAttribute("users", users);
		// Layas category trong DB bằng id
		Category category = categoryService.getById(categoryId);
		
		
		model.addAttribute("category", category);
		return "backend/category-edit";
	}
	
	@RequestMapping (value = "edit-save", method = RequestMethod.POST)
	public String editSave(final Model model,
			@ModelAttribute("category") Category category) {

		categoryService.saveOrUpdate(category);
		return "redirect:/admin/category/list";
	}
	@RequestMapping (value = "delete/{categoryId}", method = RequestMethod.GET)
	public String delete(final Model model, 
				@PathVariable("categoryId") int categoryId) {

		Category category = categoryService.getById(categoryId);
		category.setStatus(false);
		categoryService.inactiveCategory(category);
		
		return "redirect:/admin/category/list";
	}
}
