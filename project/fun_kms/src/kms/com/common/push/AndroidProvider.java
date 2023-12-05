package kms.com.common.push;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;

public class AndroidProvider implements IProvider {

	private static class FakeHostnameVerifier implements HostnameVerifier {
		@Override
		public boolean verify(String hostname, SSLSession session) {
			return true;
		}
	}

	public static String getAuthToken() throws Exception{
		final String email = "dosateny@gmail.com";
		final String password = "dosa3340";
		final String authTokenUrl = "https://www.google.com/accounts/ClientLogin";
		String authToken = "";
		StringBuffer parameter = new StringBuffer();
		parameter.append("accountType=HOSTED_OR_GOOGLE");
		parameter.append("&Email=" + email);
		parameter.append("&Passwd=" + password);
		parameter.append("&service=ac2dm");    
		parameter.append("&source=pe-mytrace-1");
		byte[] postData = parameter.toString().getBytes("UTF8");
		
		URL url = new URL(authTokenUrl);

		HttpsURLConnection.setDefaultHostnameVerifier(new FakeHostnameVerifier());
		HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
		conn.setDoOutput(true);
		conn.setUseCaches(false);
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		conn.setRequestProperty("Content-Length", Integer.toString(postData.length));
		 
		OutputStream out = conn.getOutputStream();
		out.write(postData);
		out.close();
		 
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String line = null;
		StringBuilder msg = new StringBuilder();
		while((line=br.readLine())!=null){
			msg.append(line);
		}
		authToken = msg.toString();
		authToken = authToken.substring(authToken.indexOf("Auth=")+5);
		
		return authToken;
	}

	public void sendMessage(String token, String message) throws Exception {
		String authToken = getAuthToken();
    	StringBuffer postDataBuilder = new StringBuffer();
    	postDataBuilder.append("registration_id=" + token);
    	postDataBuilder.append("&collapse_key=2");
    	postDataBuilder.append("&delay_while_idle=1");
    	postDataBuilder.append("&data.msg=" + URLEncoder.encode(message, "UTF-8"));
    	byte[] postData = postDataBuilder.toString().getBytes("UTF8");

    	URL url = new URL("https://android.apis.google.com/c2dm/send");
    	
    	HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    	conn.setDoOutput(true);
    	conn.setUseCaches(false);
    	conn.setRequestMethod("POST");
    	conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
    	conn.setRequestProperty("Content-Length", Integer.toString(postData.length));
    	conn.setRequestProperty("Authorization", "GoogleLogin auth=" + authToken);
    	
    	OutputStream out = conn.getOutputStream();
    	out.write(postData);
    	out.close();
    	
    	conn.getInputStream();
	}

	@Override
	public void sendMessage(String token, String message, String path){
		
	}
}
