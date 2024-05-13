package vn.devpro.projectshoes.controller.frontend;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.projectshoes.controller.BaseController;
import vn.devpro.projectshoes.dto.Contact;
import vn.devpro.projectshoes.dto.PsConstants;

@Controller
public class ContactController extends BaseController implements PsConstants{
	@RequestMapping(value="/contact", method = RequestMethod.GET)
	public String contact(final Model model,
			HttpServletRequest request,
			HttpServletResponse Response) throws IOException{
		return "frontend/contact/contact";
	}
	@RequestMapping(value="/contact-send", method = RequestMethod.POST)
	public String contactSend(final Model model,
			HttpServletRequest request,
			HttpServletResponse Response) throws IOException{
		
		Contact contact = new Contact();
		//Lấy dữ liệu từ form
		contact.setName(request.getParameter("txtName"));// Lấy theo name của input
		System.out.println("Name: "+ contact.getName());
		contact.setEmail(request.getParameter("txtEmail"));// Lấy theo name của input
		System.out.println("Email: "+ contact.getEmail());
		contact.setPhone(request.getParameter("txtPhone"));// Lấy theo name của input
		System.out.println("Phone: "+ contact.getPhone());
		return "frontend/contact/contact";
	}
}
