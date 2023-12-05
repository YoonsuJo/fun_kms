package kms.com.sample.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kms.com.sample.vo.SampleVO;


@Controller
public class SampleController {
	Logger logT = Logger.getLogger("TENY");
	
	/* sample 기능을 테스트 할수 있는 화면 */
	@RequestMapping("/sample/KMS_selectUser.do")
	public String KMS_selectUser(@ModelAttribute("SampleVO") SampleVO sampleVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		return "sample/KMS_selectUser";
	}

}
