package kms.com.common.push;

public class PushDevice {
	
	private IProvider provider = null;
	
	public PushDevice(String deviceType) {
		
		if (deviceType.equals("iphone")) {
			
			provider = new IOSProvider();
			
		} else if (deviceType.equals("ipad")) {
			
			provider = new IOSProvider();
			
		} if (deviceType.equals("android")) {
			
			provider = new AndroidProvider();
			
		} else {
			
			provider = null;
		}
	}
	

	public void sendMessage(String token, String message) throws Exception {
		provider.sendMessage(token, message);
	}
}
