package kms.com.common.push;

public interface IProvider {
	public void sendMessage(String token, String message) throws Exception;
	public void sendMessage(String token, String message, String path) throws Exception;
}
