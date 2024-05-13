package vn.devpro.projectshoes.controller.backend;

import java.math.BigDecimal;
import java.util.ArrayList;
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
import vn.devpro.projectshoes.model.SaleOrder;
import vn.devpro.projectshoes.model.User;
import vn.devpro.projectshoes.service.SaleOrderService;
import vn.devpro.projectshoes.service.UserService;

@Controller
@RequestMapping("admin/order/")
public class OrderController extends BaseController implements PsConstants{
	@Autowired
	private SaleOrderService saleOrderService;
	@Autowired
	private UserService userService;
	@RequestMapping(value = "list" , method = RequestMethod.GET)
	public String list(final Model model,
			HttpServletRequest request) {
		SearchModel orderSearch = new SearchModel();
		
		// Tìm theo status
		orderSearch.setStatus(2);// All
		String status = request.getParameter("status");
		if(!StringUtils.isEmpty(status)) {// Có chọn status
			orderSearch.setStatus(Integer.parseInt(status));
		}
		
		// Tìm theo keyword
		orderSearch.setKeyword(null);
		String keyword = request.getParameter("keyword");
		if(!StringUtils.isEmpty(keyword)) {// Có chọn status
			orderSearch.setKeyword(keyword);
		}
		
		// Tìm kiếm theo ngày tháng
		String beginDate = null;
		String endDate = null;
		if (!StringUtils.isEmpty(request.getParameter("beginDate"))
				&& !StringUtils.isEmpty(request.getParameter("endDate"))) {
			beginDate = request.getParameter("beginDate");
			endDate = request.getParameter("endDate");
			}
		orderSearch.setBeginDate(beginDate);
		orderSearch.setEndDate(endDate);
		
		List<SaleOrder> saleOrders = saleOrderService.searchOrder(orderSearch);
		model.addAttribute("saleOrders", saleOrders);
		
		// Bắt đầu phần trang
		if(!StringUtils.isEmpty(request.getParameter("currentPage"))) {
			orderSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}else {
			orderSearch.setCurrentPage(1);
		}
		
		List<SaleOrder> allOrders = saleOrderService.searchOrder(orderSearch);// Tìm kiếm
		List<SaleOrder> orders = new ArrayList<SaleOrder>();// Danh sách hiển thị trang hiện tại
		// Tính tổng số trang theo tìm kiếm
		int totalPages = allOrders.size() / SIZE_OF_PAGE;
		if(allOrders.size() % SIZE_OF_PAGE > 0) {
			totalPages++;
		}
		// Nếu tổng số trang nhỏ hơn trang hiện tại
		if(totalPages < orderSearch.getCurrentPage()) {
			orderSearch.setCurrentPage(1);
		}
		// Lấy danh sách cần hiển thị trong một trang
		int firstIndex = (orderSearch.getCurrentPage() - 1) * SIZE_OF_PAGE;
		int index = firstIndex, count = 0;
		while(index < allOrders.size() && count < SIZE_OF_PAGE) {
			orders.add(allOrders.get(index));
			index++;
			count++;
		} 
		// Phân trang
		orderSearch.setSizeOfPage(SIZE_OF_PAGE);
		orderSearch.setTotalItems(allOrders.size());
		
		model.addAttribute("saleOrders", orders);
		model.addAttribute("orderSearch", orderSearch);
		
		// Tính tổng doanh số bán hàng
		BigDecimal totalSales = BigDecimal.ZERO;

		// Duyệt qua danh sách đơn hàng và cộng dồn giá trị total của mỗi đơn
		for (SaleOrder saleOrder : allOrders) {
			BigDecimal orderTotal;

			if (saleOrder.getTotal() == null) {
				orderTotal = BigDecimal.ZERO;
			} else {
				orderTotal = saleOrder.getTotal();
			}

			totalSales = totalSales.add(orderTotal);
		}
		// Thêm totalSales vào model
		model.addAttribute("totalSales", totalSales);
		
		return "backend/order-list";
	}
	@RequestMapping(value = "edit/{saleOrderId}", method = RequestMethod.GET)
	public String edit (final Model model, 
			@PathVariable("saleOrderId") int saleOrderId) {
		List<User> user = userService.findAll();
		model.addAttribute("users",user);
		
		SaleOrder saleOrders = saleOrderService.getById(saleOrderId);
		model.addAttribute("saleOrder", saleOrders);
		
		return "backend/order-edit";
	}
	
	@RequestMapping(value = "/edit-save", method = RequestMethod.POST)
	public String editSave(final Model model,
			@ModelAttribute("saleOrder") SaleOrder saleOrder) {
		saleOrderService.saveOrder(saleOrder);
		return "redirect:/admin/order/list";
	}
	
	@RequestMapping(value = "delete/{saleOrderId}", method = RequestMethod.GET)
	// Cách đẩy 1 dữ liệu sang view
	public String delete(final Model model, @PathVariable("saleOrderId") int saleOrderId) {

		SaleOrder saleOrder = saleOrderService.getById(saleOrderId);
		saleOrder.setStatus(false);
		saleOrderService.inactiveSaleOrder(saleOrder);
		return "redirect:/admin/order/list";
	}
}
