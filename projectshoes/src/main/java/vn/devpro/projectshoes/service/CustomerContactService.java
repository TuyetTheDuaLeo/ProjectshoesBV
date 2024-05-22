package vn.devpro.projectshoes.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import vn.devpro.projectshoes.dto.SearchModel;
import vn.devpro.projectshoes.model.CustomerContact;

@Service
public class CustomerContactService extends BaseService<CustomerContact> {

	@Override
	public Class<CustomerContact> clazz() {
		return CustomerContact.class;
	}

	public List<CustomerContact> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_contact WHERE status=1");
	}

	@Transactional
	public void CustomerContact(int id) {
		super.deleteById(id);
	}

	@Transactional
	public void inactiveCustomerContact(CustomerContact customerContact) {
		super.saveOrUpdate(customerContact);
	}

	// -----------------------------search Contact----------------------------
	public List<CustomerContact> searchCustomerContact(SearchModel contactSearch) {
		// Tao cau lenh sql;
		String sql = "SELECT * FROM tbl_contact c WHERE 1=1";

		// Tim kiem voi status
		if (contactSearch.getStatus() != 2) { // Có chọn Active/Inactive
			sql += " AND c.status=" + contactSearch.getStatus();
		}

		// Tim kiem voi keyword
		if (!StringUtils.isEmpty(contactSearch.getKeyword())) {
			String keyword = contactSearch.getKeyword().toLowerCase();

			sql += " AND (LOWER(c.name) like '%" + keyword + "%'" + " OR LOWER(c.address) like '%" + keyword + "%'"
					+ " OR LOWER(c.message) like '%" + keyword + "%')";
		}

		// Tim kiem voi ngay thang
		if (!StringUtils.isEmpty(contactSearch.getBeginDate()) && !StringUtils.isEmpty(contactSearch.getEndDate())) {
			String beginDate = contactSearch.getBeginDate();
			String endDate = contactSearch.getEndDate();

			sql += " AND c.create_date BETWEEN '" + beginDate + "' AND '" + endDate + "'";
		}
		return super.executeNativeSql(sql);
	}
}
