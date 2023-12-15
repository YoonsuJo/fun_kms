package kms.com.common.push;

import javapns.Push;

public class IOSProvider implements IProvider {
	final String CERTIFICATE_NAME = "mkms_apns.p12";
	final String CERTIFICATE_PASS = "saeha1111";

	public void sendMessage(String token, String message, String path) throws Exception {
		
		System.out.println("IOSProvider::sendMessage " + token + " " + message + " <====");		
		Push.alert(message, CERTIFICATE_NAME, CERTIFICATE_PASS, true, token);		
		System.out.println("IOSProvider::sendMessage " + token + " " + message + " ====>");
	}
	
	public void sendMessage(String token, String message) throws Exception {
		
		System.out.println("IOSProvider::sendMessage " + token + " " + message + " <====");		
		Push.alert(message, CERTIFICATE_NAME, CERTIFICATE_PASS, true, token);		
		System.out.println("IOSProvider::sendMessage " + token + " " + message + " ====>");
	}
}
