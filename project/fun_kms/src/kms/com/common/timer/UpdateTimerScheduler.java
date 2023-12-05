package kms.com.common.timer;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimerTask;

import javax.annotation.Resource;

import kms.com.common.service.LoginService;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.management.service.BusinessResultService;
import kms.com.management.service.InputResultPerson;
import kms.com.management.service.InputResultService;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.fdl.property.EgovPropertyService;

@Component("updateTimer")
public class UpdateTimerScheduler extends TimerTask {
	
	@Resource(name = "KmsBusinessResultService")
	BusinessResultService brService;
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	@Override
	public void run() {
	
		// 하루에 한번 2시에 수행 // context-common.xml 에 타이머 bean 설정 
		// 개발컴은 문자 안보내게 설정 // context-properties.xml 키 값 smsSendHour 
		boolean isHmServer = propertiesService.getBoolean("isHmServer");
		if(isHmServer){
			try {
				String updateYear = Integer.toString(CalendarUtil.getYear() );			
				for(int i=1; i<13; i++){
					String updateMonth = String.format("%02d", i);
					System.out.println(CalendarUtil.getThisTime() + " 당해 월간사업실적 updateTimer 실행 :" + updateYear + "년 " + updateMonth + "월");
					brService.updateStatistic(updateYear, updateMonth);
				}
				
				updateYear = Integer.toString(CalendarUtil.getNextYear() );
				for(int i=1; i<13; i++){
					String updateMonth = String.format("%02d", i);
					System.out.println(CalendarUtil.getThisTime() + " 차년도 월간사업실적 updateTimer 실행 :" + updateYear + "년 " + updateMonth + "월");
					brService.updateStatistic(updateYear, updateMonth);
				}
				
				// [2015.01.15, dwkim] 매년 1년에만 전년도 사업실적 집계되도록 수정 - 안태규 부장님 요청
				if (CalendarUtil.getMonth() == 1) {
					updateYear = Integer.toString(CalendarUtil.getLastYear() );
					for(int i=1; i<13; i++){
						String updateMonth = String.format("%02d", i);
						System.out.println(CalendarUtil.getThisTime() + " 전년도 월간사업실적 updateTimer 실행 :" + updateYear + "년 " + updateMonth + "월");
						brService.updateStatistic(updateYear, updateMonth);
					}
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}