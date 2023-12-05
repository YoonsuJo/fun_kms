package kms.com.common.utils;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XmlParseUtil {

	public static String getXml(String urlAddr) {
		String xml = "";

    	StringBuffer sBuffer = new StringBuffer();
		try{
			URL url = new URL(urlAddr);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			if(conn != null){
				conn.setConnectTimeout(20000);
				conn.setUseCaches(false);
				
				if(conn.getResponseCode() == HttpURLConnection.HTTP_OK){
					InputStreamReader isr = new InputStreamReader(conn.getInputStream());
					BufferedReader br = new BufferedReader(isr);
					
					while(true){
						String line = br.readLine();
						if(line==null){
							break;
						}
						sBuffer.append(line);
					}
					br.close();
					conn.disconnect();
				}
			}
		 
			xml = sBuffer.toString(); 
			System.out.println("xml ::: "+xml); // 정보 전달 오류로 인해 다운로드 링크 연결하니 java.lang.OutOfMemoryError: Java heap space 예외발생
		}catch (Exception e) {
			e.getStackTrace();
		}		
		
		return xml;
	}

	
	public static String parse(String xml, String tagName) {
		String version = "";

		try{
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		    DocumentBuilder documentBuilder = factory.newDocumentBuilder();
		    
		    InputStream is = new ByteArrayInputStream(xml.getBytes());
		   
		    Document doc = documentBuilder.parse(is);
		    Element element = doc.getDocumentElement();
		   
		    NodeList items = element.getElementsByTagName(tagName);
		    
		    int n = items.getLength();
		    
	    	Node item = items.item(0);
	    	Node text = item.getFirstChild();
	    	//String itemValue = text.getNodeValue();
	    	//String itemName = text.getNodeName();
	       
		    version = text.getNodeValue();
		      
		}catch (Exception e) {
			e.getStackTrace();
		}

		return version;	
	}
	
	
}
