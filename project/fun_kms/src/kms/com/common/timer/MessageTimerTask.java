package kms.com.common.timer;

import com.ibm.icu.util.Calendar;
import egovframework.rte.fdl.property.EgovPropertyService;
import org.springframework.scheduling.timer.ScheduledTimerTask;

import javax.annotation.Resource;

public class MessageTimerTask extends ScheduledTimerTask {
	
	private static final long MILIS_IN_DAY = 60 * 1000;
	
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	@Override
	public long getDelay() {
		Calendar now = Calendar.getInstance();
		Calendar then = Calendar.getInstance();
				
		then.set(Calendar.HOUR_OF_DAY, now.HOUR_OF_DAY);
		then.set(Calendar.MINUTE, 0);
		then.set(Calendar.SECOND, 0);
			
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
