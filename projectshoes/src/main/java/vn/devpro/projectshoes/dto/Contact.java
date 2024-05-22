package vn.devpro.projectshoes.dto;

//public class Contact {
//	private String name;
//	private String email;
//	private String phone;
//	private String message;
//	public Contact() {
//		super();
//	}
//	public Contact(String name, String email, String phone, String message) {
//		super();
//		this.name = name;
//		this.email = email;
//		this.phone = phone;
//		this.message = message;
//	}
//	public String getName() {
//		return name;
//	}
//	public void setName(String name) {
//		this.name = name;
//	}
//	public String getEmail() {
//		return email;
//	}
//	public void setEmail(String email) {
//		this.email = email;
//	}
//	public String getPhone() {
//		return phone;
//	}
//	public void setPhone(String phone) {
//		this.phone = phone;
//	}
//	public String getMessage() {
//		return message;
//	}
//	public void setMessage(String message) {
//		this.message = message;
//	}
//	
//}
public class Contact {
	private String txtName;
	private String txtEmail;
	private String txtMobile;
	private String txtAddress;
	private String txtMessage;
	
	public Contact() {
		super();
	}

	public Contact(String txtName, String txtEmail, String txtMobile, String txtAddress, String txtMessage) {
		super();
		this.txtName = txtName;
		this.txtEmail = txtEmail;
		this.txtMobile = txtMobile;
		this.txtAddress = txtAddress;
		this.txtMessage = txtMessage;
	}

	public String getTxtName() {
		return txtName;
	}

	public void setTxtName(String txtName) {
		this.txtName = txtName;
	}

	public String getTxtEmail() {
		return txtEmail;
	}

	public void setTxtEmail(String txtEmail) {
		this.txtEmail = txtEmail;
	}

	public String getTxtMobile() {
		return txtMobile;
	}

	public void setTxtMobile(String txtMobile) {
		this.txtMobile = txtMobile;
	}

	public String getTxtAddress() {
		return txtAddress;
	}

	public void setTxtAddress(String txtAddress) {
		this.txtAddress = txtAddress;
	}

	public String getTxtMessage() {
		return txtMessage;
	}

	public void setTxtMessage(String txtMessage) {
		this.txtMessage = txtMessage;
	}
	
	
}
