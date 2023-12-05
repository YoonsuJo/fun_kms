package kms.com.common.push;

public class SHProvider {	
	
	public void sendMessage(String deviceType, String token, String message) throws Exception {
		
		/**
		 * 	deviceType : "iphone", "ipad", "android", "pc"
		 */
		
		deviceType = deviceType.toLowerCase();
		new PushDevice(deviceType).sendMessage(token, message);
	}
}
