package vn.devpro.projectshoes.controller.backend;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.projectshoes.controller.BaseController;

@Controller
@RequestMapping("/admin/")
public class HomeAdminController extends BaseController {
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home(){
		return "backend/home";
	}
}
