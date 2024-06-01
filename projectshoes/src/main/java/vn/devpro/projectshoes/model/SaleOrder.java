package vn.devpro.projectshoes.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_sale_order")
public class SaleOrder extends BaseModel{
	@Column(name ="code", length = 60, nullable = false)
	private String code;
	
	@Column(name = "total", nullable = true)
	private BigDecimal total;
	
	@Column(name = "customer_name", length = 300, nullable = false)
	private String customerName;
	
	@Column(name = "customer_mobile", length = 120, nullable = true)
	private String customerMobile;
	
	@Column(name ="customer_email", length = 120, nullable = true)
	private String customerEmail;
	
	@Column(name = "customer_address", length = 300, nullable = true)
	private String customerAddress;
	
	@Column(name = "payment_method", nullable = true)
	private Boolean paymentMethod;
	
//---------Mapping Many-to-one : tbl_sale_order-to-tbl_user
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name ="user_id")
	private User user;

//---------Mapping One-to-Many : tbl_sale_order-to-tbl_sale_order_product
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "saleorder")
	private Set<SaleOrderProduct> SaleOrderProducts = new HashSet<SaleOrderProduct>();
	
	public void addRelationalSaleOrderProduct(SaleOrderProduct saleorderproduct) {
		SaleOrderProducts.add(saleorderproduct);
		saleorderproduct.setSaleorder(this);
	}
	public void removeRelationalSaleOrderProduct(SaleOrderProduct saleorderproduct) {
		SaleOrderProducts.remove(saleorderproduct);
		saleorderproduct.setSaleorder(this);
	}
	// Mapping many-to-one: tbl_sale_order-to-tbl_user (for create category)
		@ManyToOne(fetch = FetchType.EAGER)
		@JoinColumn(name = "create_by")
		private User userCreateSaleOrder;

		// Mapping many-to-one: tbl_sale_order-to-tbl_user (for update category)
		@ManyToOne(fetch = FetchType.EAGER)
		@JoinColumn(name = "update_by")
		private User userUpdateSaleOrde;
	
	
	public SaleOrder() {
		super();
	}
	
	
//	public SaleOrder(Integer id, Date createDate, Date updateDate, Boolean status, String code, BigDecimal total,
//			String customerName, String customerMobile, String customerEmail, String customerAddress, User user,
//			Boolean paymentMethod ,Set<SaleOrderProduct> saleOrderProducts, User userCreateSaleOrder, User userUpdateSaleOrde) {
//		super(id, createDate, updateDate, status);
//		this.code = code;
//		this.total = total;
//		this.customerName = customerName;
//		this.customerMobile = customerMobile;
//		this.customerEmail = customerEmail;
//		this.customerAddress = customerAddress;
//		this.user = user;
//		SaleOrderProducts = saleOrderProducts;
//		this.userCreateSaleOrder = userCreateSaleOrder;
//		this.userUpdateSaleOrde = userUpdateSaleOrde;
//	}
	public SaleOrder(Integer id, Date createDate, Date updateDate, Boolean status, String code, BigDecimal total,
			String customerName, String customerMobile, String customerEmail, String customerAddress,
			Boolean paymentMethod, User user, Set<SaleOrderProduct> saleOrderProducts, User userCreateSaleOrder,
			User userUpdateSaleOrde) {
		super(id, createDate, updateDate, status);
		this.code = code;
		this.total = total;
		this.customerName = customerName;
		this.customerMobile = customerMobile;
		this.customerEmail = customerEmail;
		this.customerAddress = customerAddress;
		this.paymentMethod = paymentMethod;
		this.user = user;
		SaleOrderProducts = saleOrderProducts;
		this.userCreateSaleOrder = userCreateSaleOrder;
		this.userUpdateSaleOrde = userUpdateSaleOrde;
	}
	
	public User getUserCreateSaleOrder() {
		return userCreateSaleOrder;
	}
	public void setUserCreateSaleOrder(User userCreateSaleOrder) {
		this.userCreateSaleOrder = userCreateSaleOrder;
	}
	public User getUserUpdateSaleOrde() {
		return userUpdateSaleOrde;
	}
	public void setUserUpdateSaleOrde(User userUpdateSaleOrde) {
		this.userUpdateSaleOrde = userUpdateSaleOrde;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public BigDecimal getTotal() {
		return total;
	}
	public void setTotal(BigDecimal total) {
		this.total = total;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerMobile() {
		return customerMobile;
	}
	public void setCustomerMobile(String customerMobile) {
		this.customerMobile = customerMobile;
	}
	public String getCustomerEmail() {
		return customerEmail;
	}
	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}
	public String getCustomerAddress() {
		return customerAddress;
	}
	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Set<SaleOrderProduct> getSaleOrderProducts() {
		return SaleOrderProducts;
	}
	public void setSaleOrderProducts(Set<SaleOrderProduct> saleOrderProducts) {
		SaleOrderProducts = saleOrderProducts;
	}
	public Boolean getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(Boolean paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
}
