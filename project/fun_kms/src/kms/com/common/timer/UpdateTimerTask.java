package kms.com.common.timer;

import javax.annotation.Resource;

import org.springframework.scheduling.timer.ScheduledTimerTask;

import com.ibm.icu.util.Calendar;

import egovframework.rte.fdl.property.EgovPropertyService;

public class UpdateTimerTask extends ScheduledTimerTask {
	
	private static final long MILIS_IN_DAY = 24 * 60 * 60 * 1000;
	
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	@Override
	public long getDelay() {
		Calendar now = Calendar.getInstance();
		Calendar then = Calendar.getInstance();
		
		int hour = propertiesService.getInt("updateStatisticHour");
		
		then.set(Calendar.HOUR_OF_DAY, hour);
		then.set(Calendar.MINUTE, 0);
		then.set(Calendar.SECOND, 1);
		
		//then.setTime(startDate);
		
		long result = then.getTimeInMillis() - now.getTimeInMillis();
		
		while (result <= 0)
			result += MILIS_IN_DAY;
		
		return result;
	}
	
	@Override
	public long getPeriod() {
		return MILIS_IN_DAY;
	}
	
}
