package kms.com.community.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.community.service.MailService;
import kms.com.community.service.MailVO;
import kms.com.community.service.Mail;
import kms.com.community.service.NoteService;
import kms.com.community.service.impl.MailDAO;
import kms.com.member.service.MemberVO;
import kms.com.member.service.MemberService;

/**
 * @Class Name : TblMailsendServiceImpl.java
 * @Description : TblMailsend Business Implement class
 * @Modification Information
 *
 * @author 이병주
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("KmsMailService")
public class MailServiceImpl extends AbstractServiceImpl implements
        MailService {

    @Resource(name="KmsMailDAO")
    private MailDAO mailDAO;
    
    /** ID Generation */
    @Resource(name="kmsMailIdGnrService")    
    private EgovIdGnrService idGnrService;
    
    @Resource(name="KmsMemberService")
	MemberService memberService;
    
	@Resource(name = "KmsNoteService")
    private NoteService noteService;
	
	@Resource(name = "KmsFileMngService")
    private FileMngService fileService;

	@Override
	public String sendMail(Mail vo) throws Exception {
		String mailId = idGnrService.getNextStringId();
		
		vo.setMailId(mailId);
    	
    	mailDAO.insertMailsend(vo);
    	mailDAO.insertMailrecieve(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
		return null;
	}
	
	@Override	
	public String sendMailOut(Mail vo) throws Exception {		
		vo.setMailId("");    	
    	//TODO 외부메일 전송후 전송 플래그 Y로 변경
		return null;
	}	
	@Override	
	public String insertMailOut(Mail vo) throws Exception {
    	mailDAO.insertMailOut(vo);
		return null;
	}	
	@Override	
	public String setMailOut(Mail vo) throws Exception {
		mailDAO.setMailOut(vo);
		return null;
	}	
	
	@Override
	public List<MailVO> selectMailOutList(MailVO searchVO) throws Exception {
		return mailDAO.selectMailOutList(searchVO);
	}
	@Override
	public List<String> selectSMTPMailList(MailVO searchVO) throws Exception {
		List<String> resultList = mailDAO.selectSMTPMailList(searchVO);
		return resultList;
	}
	
	@Override
	public List<MailVO> selectRecieveMailList(MailVO searchVO) throws Exception {
		return mailDAO.selectRecieveMailList(searchVO);
	}


	@Override
	public int selectRecieveMailListTotCnt(MailVO searchVO) throws Exception {
		return mailDAO.selectRecieveMailListTotCnt(searchVO);
	}


	@Override
	public List<MailVO> selectSendMailList(MailVO searchVO) throws Exception {
		return mailDAO.selectSendMailList(searchVO);
	}


	@Override
	public int selectSendMailListTotCnt(MailVO searchVO) throws Exception {
		return mailDAO.selectSendMailListTotCnt(searchVO);
	}
	
    /**
	 * TBL_MAILSEND을 조회한다.
	 * @param vo - 조회할 정보가 담긴 TblMailsendVO
	 * @return 조회한 TBL_MAILSEND
	 * @exception Exception
	 */
	@Override
    public List<MailVO> readMail(MailVO vo) throws Exception {
		mailDAO.setReadDt(vo);
		
		return mailDAO.selectMail(vo);
	}


	@Override
	public void resendMail(MailVO mailVO) throws Exception {
		mailVO.setMailIdEx(mailVO.getMailId());

		String mailId = idGnrService.getNextStringId();
		mailVO.setMailId(mailId);
    	
    	mailDAO.insertMailsendR(mailVO);
    	mailDAO.insertMailrecieveR(mailVO);
	}


	@Override
	public void deleteRecieveMail(MailVO vo) throws Exception {
		String noteIds = vo.getMailId();
		vo.setMailIdList(noteIds.split(","));
		
		mailDAO.deleteRecieveMail(vo);
	}


	@Override
	public void deleteSendMail(MailVO vo) throws Exception {
		String mailIds = vo.getMailId();
		vo.setMailIdList(mailIds.split(","));
		
		mailDAO.deleteSendMail(vo);
	}
	
	@Override
	public void cancelSendMail(MailVO vo) throws Exception {
		String mailIds = vo.getMailId();
		vo.setMailIdList(mailIds.split(","));
		
		mailDAO.cancelSendMail(vo);
	}

	@Override
	public List<MailVO> selectSendMailState(MailVO searchVO) throws Exception {
		return mailDAO.selectSendMailState(searchVO);
	}

	@Override
	public int selectSendMailStateTotCnt(MailVO searchVO) throws Exception {
		return mailDAO.selectSendMailStateTotCnt(searchVO);
	}


    public int sendMailSMTPOut(MailVO mailVO) throws Exception {
    	
    	List<String> recieveMailList = selectSMTPMailList(mailVO);    	
    	//List<String> toAddress = CommonUtil.makeValidIdListArray(recieveMailList.get(0));
    	
    	MemberVO memberVO = new MemberVO();
		memberVO.setNo(mailVO.getUserNo());
		memberVO = (MemberVO) memberService.selectMember(memberVO).get("member");
				
    	String host = "mail.dosanet.co.kr";    	 
    	String sendingAccount = "mailsender@dosanet.co.kr";
    	String password = "dosanet";    	
    	String account = memberVO.getEmailAdres();
    	String name = memberVO.getUserNm();    	
    	String title = mailVO.getMailSj();
		String content = mailVO.getMailCn();
		String to = recieveMailList.get(0).replace(" ", "");		
		String[] toToken = to.split(",");		
		
		String path = "";// 파일전송 경로 GlobalConfigUtil.getConfig("htdocs_dir")+"/upload/nkms/mail/";
		String fileName = "";
		String realFileName = "";
		String atchFileId = mailVO.getAtchFileId();
		FileVO fileVO = new FileVO();
		fileVO.setAtchFileId(atchFileId);
		List<FileVO> result = fileService.selectFileInfs(fileVO);
		
		
		if(account.equals("") || account.length() < 6 || account == null){
			if(memberVO.getCompnyId().equals("dosanet"))
				account = "mailsender@dosanet.co.kr";
			else if(memberVO.getCompnyId().equals("saehasoft"))
				account = "mailsender@saeha.co.kr";    
			else if(memberVO.getCompnyId().equals("saeha"))
				account = "mailsender@saeha.co.kr";    
			else if(memberVO.getCompnyId().equals("probits"))
				account = "mailsender@probits.co.kr";    
			
			content = content + "<br> <br> ------------------------------------- <br>" +
					"이 계정은 회신이 불가능한 발신전용 메일 계정입니다.";
    				
    		noteService.sendNote(memberVO.getNo(), new String[] {memberVO.getUserId()}, 
    				"SMTP 외부메일 전송 컨트롤러 오류 경고창 \n사원정보 이메일 계정이 잘못되었습니다.\n사원정보 확인후 업무 메일계정으로 수정해주세요.");
    	}
		
    	//System.out.println("MailDAO - sendMail():START");
		
		int count = 0;						
		for (int i = 0; i < toToken.length; i++)
		{
			try
			{
				Properties props= new Properties ();
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.auth", "true");

				Session sess = Session.getInstance(props, null);
				//Session sess = Session.getDefaultInstance(props, null);
				Message msg = new MimeMessage(sess);
				
				msg.setFrom(new InternetAddress(account, name, "UTF-8"));
				InternetAddress[] address = {new InternetAddress(toToken[i])};
				msg.setRecipients (Message.RecipientType.TO, address);
				msg.setSubject(title);
				msg.setSentDate(new Date());
				
				
				if (result.size()>0) {
					MimeBodyPart messageBodyPart = new MimeBodyPart();
					messageBodyPart.setContent(content, "text/html;charset=KSC5601");

					Multipart multipart = new MimeMultipart();
					multipart.addBodyPart(messageBodyPart); 
					
					for(int j=0; j<result.size(); j++){
						fileVO = result.get(j);
						path = fileVO.getFileStreCours();
						fileName = fileVO.getOrignlFileNm();
						realFileName = fileVO.getStreFileNm();
	
						messageBodyPart = new MimeBodyPart();
	
						FileDataSource fds = new FileDataSource(path + realFileName);
						messageBodyPart.setDataHandler(new DataHandler(fds));
						//mbp.setFileName(fds.getName()); // 
						messageBodyPart.setFileName(new String(fileName.getBytes("EUC-KR"), "EUC-KR"));//"8859_1")); // 
						multipart.addBodyPart(messageBodyPart);
					}
					msg.setContent(multipart);
				} else {
					msg.setContent(content, "text/html;charset=KSC5601");
				}

				//Transport.send(msg);
				Transport transport = sess.getTransport("smtp");
				transport.connect(host, sendingAccount, password);
				transport.sendMessage(msg, msg.getAllRecipients());
				transport.close();
				count++;

				//System.out.println("MailDAO - sendMail() " + toToken[i] + " 전송성공");
			}
			catch (Exception e) {
				//System.out.println("MailDAO - sendMail():" + toToken[i] + " 전송실패 " + e);
				e.printStackTrace();
				
				noteService.sendNote(memberVO.getNo(), new String[] {memberVO.getUserId()}, 
				"SMTP 외부메일 전송실패 알림쪽지\n-----------------------------------\n전자결재문서 링크\n"
				+ "http://hm.hanmam.kr/approval/approvalV.do?docId=" + mailVO.getRefId() 
				+ "\n전송실패 수신메일주소 : " + toToken[i] );				
			}
		}
		//System.out.println("MailDAO - sendMail():END  " + count + "개 전송 성공");
		setMailOut(mailVO);
		return count;
    }
}
