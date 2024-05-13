package vn.devpro.projectshoes.controller.frontend;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.projectshoes.controller.BaseController;
import vn.devpro.projectshoes.dto.PsConstants;

@Controller
public class IntroduceController extends BaseController implements PsConstants{
	@RequestMapping(value = "/Introduce" , method = RequestMethod.GET)
	public String introduce(final Model model) {
		return "frontend/Introduce";
	}
}
