package kms.com.app.service.impl;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import kms.com.app.service.AccountVO;
import kms.com.app.service.KmsAccountService;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  
 *  </pre>
 */
/**
 * @author blind
 *
 */
/**
 * @author blind
 *
 */
@Service("accountService")
public class KmsAccountServiceImpl extends AbstractServiceImpl implements
	KmsAccountService {

    @Resource(name="accountDAO")
    private AccountDAO accountDAO;
 
	@Override
	public List selectAccountList(AccountVO searchVO) throws Exception {
		return accountDAO.selectAccountList(searchVO);
	}

	@Override
	public void insertAccount(AccountVO accountVO) {
		accountDAO.insertAccount(accountVO);
		
	}

	@Override
	public AccountVO selectAccountView(AccountVO searchVO) {
		return accountDAO.selectAccountView(searchVO);
	}

	@Override
	public void updateAccount(AccountVO accountVO) {		
		accountDAO.updateAccount(accountVO);		
	}

	@Override
	public void updateAccountOrder(JSONObject orderResultJ) {
		Set a = orderResultJ.keySet();
		Iterator it = a.iterator();
		while(it.hasNext())
		{
			String accId = (String)it.next();
			String accOrd = (String) orderResultJ.get(accId);
			AccountVO vo = new AccountVO();
			vo.setAccId(accId);	
			vo.setAccOrd(Integer.parseInt(accOrd));
			accountDAO.updateAccountOrder(vo);
		}
	    	
	}

	@Override
	public List selectAccountListTree(AccountVO vo) {
		return accountDAO.selectAccountListTree(vo);
	}

	@Override
	public int selectChildAccountCnt(AccountVO searchVO) {
		return accountDAO.selectChildAccountCnt(searchVO);
	}

	@Override
	public void updateBatchChildAccTyp(AccountVO accountVO) {
		accountDAO.updateBatchChildAccTyp(accountVO);
		
	}

	@Override
	public int selectPresetChildAccCnt(AccountVO accountVO) {
		return accountDAO.selectPresetChildAccCnt(accountVO);
	}

	@Override
	public int selectPresetAccCnt(AccountVO accountVO) {
		return accountDAO.selectPresetAccCnt(accountVO);
	}

	
        
}
