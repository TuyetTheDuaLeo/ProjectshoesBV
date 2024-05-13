package vn.devpro.projectshoes.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import vn.devpro.projectshoes.dto.PsConstants;
import vn.devpro.projectshoes.dto.SearchModel;
import vn.devpro.projectshoes.model.SaleOrder;


@Service
public class SaleOrderService extends BaseService<SaleOrder> implements PsConstants{
	@Override
	public Class<SaleOrder> clazz(){
		return SaleOrder.class;
	}
	@Transactional
	public SaleOrder saveOrder(SaleOrder saleOrder) {
		return super.saveOrUpdate(saleOrder);
	}
	@Transactional
	public void inactiveSaleOrder(SaleOrder saleOrder) {
		super.saveOrUpdate(saleOrder);
	}
	public List<SaleOrder> findAllActive(){
		return super.executeNativeSql("Select * From tbl_sale_order WHERE status = 1");
	}
	public List<SaleOrder> searchOrder(SearchModel orderSearch){
		String sql = "SELECT * from tbl_sale_order p WHERE 1=1";
		
		//Tim kiem voi tieu chi status
		if(orderSearch.getStatus() != 2) {
			sql += " AND p.status = " + orderSearch.getStatus();
		}
		
		//Tim kiem voi keyword
		if (!StringUtils.isEmpty(orderSearch.getKeyword())) {
			String keyword = orderSearch.getKeyword().toLowerCase();
			
			sql += " AND (LOWER(p.customer_name) like '%" + keyword + "%'" +
					" OR LOWER(p.customer_email) like '%" + keyword + "%'" +
					" OR LOWER(p.customer_mobile) like '%" + keyword + "%')";
		}
		// Tìm kiếm theo ngày tháng
		if(!StringUtils.isEmpty(orderSearch.getBeginDate() )&& !StringUtils.isEmpty(orderSearch.getEndDate())) {
			String beginDate = orderSearch.getBeginDate();
			String endDate = orderSearch.getEndDate();
			sql += " AND p.create_date BETWEEN '" + beginDate + "'AND '" + endDate + "'";
		}
		return super.executeNativeSql(sql);
	}
}
