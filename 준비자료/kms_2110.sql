/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DELIMITER //
CREATE FUNCTION `CALC_VAC`($CIN_DT CHAR(8), $CMP_DT CHAR(8)) RETURNS int(11)
BEGIN
	DECLARE cinY INT DEFAULT CONVERT(SUBSTRING($CIN_DT,1,4), UNSIGNED);
	DECLARE cinM INT DEFAULT CONVERT(SUBSTRING($CIN_DT,5,2), UNSIGNED);
	DECLARE cinD INT DEFAULT CONVERT(SUBSTRING($CIN_DT,7,2), UNSIGNED);
	DECLARE cmpY INT DEFAULT CONVERT(SUBSTRING($CMP_DT,1,4), UNSIGNED);
	DECLARE cmpM INT DEFAULT CONVERT(SUBSTRING($CMP_DT,5,2), UNSIGNED);
	DECLARE cmpD INT DEFAULT CONVERT(SUBSTRING($CMP_DT,7,2), UNSIGNED);
	DECLARE mon INT DEFAULT 0;
	DECLARE yr INT DEFAULT 0;
	DECLARE r INT DEFAULT 0;
	
	IF cmpD < cinD then SET mon = -1; end if;
	IF cmpM < cinM OR (cmpM = cinM AND cmpD < cinD) then SET yr = -1; end if;
	SET mon = mon + cmpM - cinM;
	SET yr = yr + cmpY - cinY;
	
	IF mon < 0 THEN SET mon = mon + 12; END IF;
	
	IF yr = 0 then set r=mon;
	else
		IF yr < 3 then set r=15;
		else
			set r=14 + (yr/2);
		END IF;
	END IF;
	
	RETURN r;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `CALC_VAC2`($CIN_DT CHAR(8), $CMP_DT CHAR(8)) RETURNS int(11)
BEGIN
	DECLARE cinY INT DEFAULT CONVERT(SUBSTRING($CIN_DT,1,4), UNSIGNED);
	DECLARE cinM INT DEFAULT CONVERT(SUBSTRING($CIN_DT,5,2), UNSIGNED);
	DECLARE cinD INT DEFAULT CONVERT(SUBSTRING($CIN_DT,7,2), UNSIGNED);
	DECLARE cmpY INT DEFAULT CONVERT(SUBSTRING($CMP_DT,1,4), UNSIGNED);
	DECLARE cmpM INT DEFAULT CONVERT(SUBSTRING($CMP_DT,5,2), UNSIGNED);
	DECLARE cmpD INT DEFAULT CONVERT(SUBSTRING($CMP_DT,7,2), UNSIGNED);
	DECLARE mon INT DEFAULT 0;
	DECLARE yr INT DEFAULT 0;
	DECLARE r INT DEFAULT 0;
	
	IF cmpD < cinD then SET mon = -1; end if;
	IF cmpM < cinM OR (cmpM = cinM AND cmpD < cinD) then SET yr = -1; end if;
	SET mon = mon + cmpM - cinM;
	SET yr = yr + cmpY - cinY;
	
	IF mon < 0 THEN SET mon = mon + 12; END IF;
	
	IF yr = 0 then set r=mon;
	else
		IF yr < 3 then set r=15;
		else
			if (yr%2)=1 then set r=14 + (yr/2);
			ELSE set r=13 + (yr/2);
			END IF;
		END IF;
	END IF;
	
	RETURN yr/2;
END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `comtccmmnclcode` (
  `CL_CODE` char(3) NOT NULL,
  `CL_CODE_NM` varchar(60) DEFAULT NULL,
  `CL_CODE_DC` varchar(200) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `FRST_REGISTER_PNTTM` date DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDUSR_PNTTM` date DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `comtccmmnclcode` (`CL_CODE`, `CL_CODE_NM`, `CL_CODE_DC`, `USE_AT`, `FRST_REGISTER_PNTTM`, `FRST_REGISTER_ID`, `LAST_UPDUSR_PNTTM`, `LAST_UPDUSR_ID`) VALUES
	('EFC', '전자정부 프레임워크 공통서비스', '전자정부 프레임워크 공통서비스', 'Y', '2011-12-01', NULL, '2011-12-01', NULL);

CREATE TABLE IF NOT EXISTS `comtccmmncode` (
  `CL_CODE` char(3) DEFAULT NULL,
  `CODE_ID` varchar(6) NOT NULL,
  `CODE_ID_NM` varchar(60) DEFAULT NULL,
  `CODE_ID_DC` varchar(200) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `FRST_REGISTER_PNTTM` date DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDUSR_PNTTM` date DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CODE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `comtccmmncode` (`CL_CODE`, `CODE_ID`, `CODE_ID_NM`, `CODE_ID_DC`, `USE_AT`, `FRST_REGISTER_PNTTM`, `FRST_REGISTER_ID`, `LAST_UPDUSR_PNTTM`, `LAST_UPDUSR_ID`) VALUES
	('EFC', 'COM001', '등록구분', '게시판, 커뮤니티, 동호회 등록구분코2', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM002', '이력구분', '시스템이력등록구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM003', '업무구분', '업무구분코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM004', '게시판유형', '게시판유형구분코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM005', '템플릿유형', '템플릿유형구분코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM006', '승인유형', '동호회, 커뮤니티 승인 유형', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM007', '승인상태', '동호회, 커뮤니티 승인 상태', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM008', '처리상태', '송수신 요청의 처리상태', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM009', '게시판속성', '게시판 속성', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM010', '권한유형', '시스템을 사용하기 위한 권한 구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM011', '롤유형', '시스템의 기능을 사용하기 위한 롤 구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM012', '회원유형', '일반/기업/업무담당자를 구현하기 위한 사용자 구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM013', '회원상태', '회원 가입 신청/승인/삭제를 위한 상태 구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM014', '성별구분', '남녀 성별 구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM015', '인증방식유형', '주민등록번호 인증, Gpin 인증과 같은 사용자 인증 구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM016', '변경요청처리 상태', '프로그램 변경의 요청/처리 등의 변경요청 상태 구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM017', '휴일구분', '휴일의 구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM018', '질문유형', '질문유형 객관식/주관식 상태구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM019', '일정중요도', '일정중요도 낮음/보통/높음 상태구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM020', '일정구분', '일정구분 부서일지정보/일지정보 상태구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM021', '도움말구분', '도움말 설명 구분코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM022', '비밀번호 힌트', '비밀번호 힌트 구분코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM023', '사이트주제분류', '사이트주제분류 설명 구분코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM024', '발송결과구분', '발송메일 수신결과 구분 코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM025', '소속기관', '소속기관정보를 관리할때 사용하는 구분코드(시스템별로 재정의)', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM026', '기업구분', '기업구분정보를 관리할때 사용하는 구분코드(시스템별로 재정의)', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM027', '업종', '대표업종코드(시스템별로 재정의)', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM028', '질의응답처리상태', 'Q/A 처리상태코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM029', '롤유형코드', '', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM030', '일정구분', '일정구분 코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM031', '반복구분', '일정 반복구분 코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM032', '작업유형', '승인이력 작업유형', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM033', '시스템로그구분', '', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM034', '직업유형', '직업유형코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM035', '행사유형', '행사/이벤트/캠페인 구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM036', '보고서 진행상태코드', '보고서의 진행상태를 코드화 하여 관리한다.', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM038', '온라인POLL페기유무', '온라인POLL-온라인POLL페기유무', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM039', '온라인POLL구분', '온라인POLL-온온라인POLL구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM040', '보고서 종류코드', '보고서 종류코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM041', '온라인메뉴얼구분', '온라인메누얼-온라인메뉴얼구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM042', '보고서통계기간구분', '보고서통계기간구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM043', '기관코드변경구분', '기관코드변경구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM044', '기관코드수신처리구분', '기관코드수신처리구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM045', '사용여부', '사용여부', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM046', '모니터링상태구분', '모니터링상태구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM047', '실행주기구분', '실행주기구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM048', 'DBMS종류', 'DBMS종류', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM049', '압축구분', '압축구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM050', '수신구분', '쪽지관리', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM051', '신청상태', '신청중 승인 반려', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM052', '달력구분', '달력구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM053', '행사구분', '행사구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM054', '경조구분', '경조구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM055', '포상구분', '포상구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM056', '휴가구분', '휴가구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM057', '일정구분', '일정구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM058', '반복구분코드', '반복구분코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM059', '우선순위', '우선순위', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM060', '보고서구분', '보고서구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM061', '간부상태', '간부상태', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM062', 'Error description', 'Error description', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM063', 'SERVER STATUS', 'SERVER STATUS', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM064', '서버종류코드', '서버종류코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM065', '장애종류코드', '장애종류코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM066', '서버자원종류', '서버자원종류', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM067', '네트워크관리항목', '네트워크관리항목', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM068', '처리상태코드', '처리상태코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM069', '기념일구분', '기념일구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM070', '위치구분', '회의실 위치구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM071', '당직체크구분', '당직체크구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM072', '서비스상태', '서비스상태', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM073', '가족관계', '가족관계', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM074', '요일구분', '요일구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM075', '업무구분코드', '업무구분코드', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'COM076', '실행상태구분', '실행상태구분', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS000', '결재상태', '결재실패/저장중/검토중/협조중/전결중/결재완료/참조중', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS001', '결재자정류', '작성자/검토자/협조자/전결자/참조자', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS002', '학력종류', '고졸/초대졸/대졸/대학원졸', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS003', '직급종류', '직급종류', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS004', '야근등록', '야근등록', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS005', '근무지', '근무지', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS006', '휴일종류', '휴일종류', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS007', '회사종류', '회사종류', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS008', '예/아니오', '예/아니오', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS009', '업무실적/비용지출', '투입인력만/누구나/불가능', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS010', '프로젝트 상태', '프로젝트 상태', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS011', '보직정보', '보직정보', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS012', '인금인상률', '인금인상률', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS013', '조기출근시간', '조기출근시간', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS014', '출근시간', '출근시간', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS015', '계정과목 상위 타입', 'E - 판관비/ S - 매출원가', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS016', '계정과목 하위 타입', '10,11,12,13 - 지결서 temlptId 값을 따라감', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS017', '카드상태', 'N - 정상, L - 분실 E - 만료 S - 정지', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS018', '공인IP', '본사 공인IP 목록', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS019', '글작성분류', 'C1 게시물작성 C2 덧글작성 R1 일일업무보고작성 R2 일일업무보고작성(300자 초과)', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS020', '접속단말', '접속하기 PC IOS ANDROID', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS021', '입출금', 'D 입금 W 출금 RD 대체입금 RW 대체출금', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS022', '비용계정과목', '비용계정과목', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS023', '은행목록', '은행목록', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS024', '상담관리 구분', '멀티뷰 1 메가미트 2 스쿨넷 3 KT사내 4 메신저 5 코덱 6', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS025', '상담관리 상담분류', '일반상담 1 영업문의 2 장애처리 3 화상상담 4 기타 5 유저수변경 6', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS026', '재고관리코드', '재고 0 판매 1 데모 2  수리 3 기타 4 재입고 5', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS027', '상담관리 장애항목', '1:PC, 2:AOS, 3:IOS, 4:MAC, 5: WEB, 6: SERVER, 7: 기타', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS028', '상담관리 처리상태', '접수 1 처리중 2 처리완료 3 종료 4 미종료 5', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS029', '상담관리 상담만족도', '만족 1 보통 2 불만족 3 매우불만족 4 Black 5', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS030', '상담관리 열람상태', '완료 1 열람중 2', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS031', '재고관리분류', 'codec 1 camera 2 phone 3 mic 4', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS032', '회사주소', '도사 라이브텍 프로비츠 새하컴즈', 'Y', '2011-12-01', NULL, '2011-12-01', NULL),
	('EFC', 'KMS033', '학력코드', '고졸 전문대재학 전문대졸업 대학재학 대학졸업 석사재학 석사졸업 석사수료 박사재학 박사졸업 박사수료', 'Y', '2012-12-11', NULL, '2012-12-11', NULL),
	('EFC', 'KMS034', '연봉제시 상태코드', '상태코드 1 - 제시 2 - 동의 3 - 면담', 'Y', '2012-12-11', NULL, '2012-12-11', NULL),
	('EFC', 'KMS035', '연봉협상 기간', '연봉협상 기간', 'Y', '2012-12-11', NULL, '2012-12-11', NULL),
	('EFC', 'KMS036', '연봉관리 제외 사용자번호', '연봉관리 제외 사용자번호', 'Y', '2012-12-11', NULL, '2012-12-11', NULL),
	('EFC', 'KMS037', '한마음 시스템 점검코드', '점검코드 0 - 정상 1 - 점검중', 'Y', '2012-12-11', NULL, '2012-12-11', NULL),
	('EFC', 'KMS038', '관리자 공통코드 관리', '관리자 공통코드 관리기능 포함 코드', 'Y', '2012-12-11', NULL, '2012-12-11', NULL),
	('EFC', 'KMS039', '근태관리 제외 코드', '근태관리에서 제외되는 사용자들', 'Y', '2012-12-11', NULL, '2012-12-11', NULL),
	('EFC', 'KMS040', '팀장경비 최상위프로젝트', '팀장경비신청서 최상위프로젝트코드', 'Y', '2013-01-28', NULL, '2013-01-28', NULL),
	('EFC', 'KMS041', '특별근태적용회사코드', '특별근태 적용회사 코드 및 적용기간 적용시간', 'Y', '2013-03-18', NULL, '2013-03-18', NULL),
	('EFC', 'KMS042', '상담관리 고객사관리 구분코드', '상담관리 고객사관리 구분코드', 'Y', '2013-08-01', NULL, '2013-08-01', NULL),
	('EFC', 'KMS043', '상담관리 접수방법', '1:전화, 2:이메일, 3:카톡, 4:기타', 'Y', '2014-04-07', NULL, '2014-04-07', NULL),
	('EFC', 'KMS044', '회의실 위치구분', '0:내부, 1:외부', 'Y', '2015-04-02', NULL, '2015-04-02', NULL),
	('EFC', 'KMS045', '서비스구분', '0:보다, 1:ezview, 2:Multiview', 'Y', '2021-07-23', NULL, '2021-07-23', NULL),
	('EFC', 'KMS046', '상담관리 장애상세', '1: 프로그램 설치, 2: 로그인 (계정), 3: 개설/입장, 4: 품질(네트워크), 5: 비디오, 6: 오디오, 7: 문서공유, 8: 기타', 'Y', '2021-07-23', NULL, '2021-07-23', NULL);

CREATE TABLE IF NOT EXISTS `comtccmmndetailcode` (
  `CODE_NM` varchar(60) DEFAULT NULL,
  `CODE_DC` varchar(200) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `CODE` varchar(15) NOT NULL,
  `CODE_ID` varchar(6) NOT NULL,
  `FRST_REGISTER_PNTTM` date DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDUSR_PNTTM` date DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `COLUMN1` varchar(200) DEFAULT NULL,
  `COLUMN2` varchar(200) DEFAULT NULL,
  `COLUMN3` varchar(200) DEFAULT NULL,
  `COLUMN4` varchar(200) DEFAULT NULL,
  `DATE1` datetime DEFAULT NULL,
  `ORD` int(11) DEFAULT NULL,
  UNIQUE KEY `NewIndex2` (`CODE_ID`,`CODE`),
  KEY `NewIndex1` (`CODE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `comtccmmndetailcode` (`CODE_NM`, `CODE_DC`, `USE_AT`, `CODE`, `CODE_ID`, `FRST_REGISTER_PNTTM`, `FRST_REGISTER_ID`, `LAST_UPDUSR_PNTTM`, `LAST_UPDUSR_ID`, `COLUMN1`, `COLUMN2`, `COLUMN3`, `COLUMN4`, `DATE1`, `ORD`) VALUES
	('단일 게시판 이용등록', '단일 게시판 이용등록', 'Y', 'REGC01', 'COM001', '2011-12-01', NULL, '2013-01-02', NULL, '', '', '', '', NULL, NULL),
	('커뮤니티 등록', '커뮤니티 등록', 'Y', 'REGC02', 'COM001', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회 등록', '동호회 등록', 'Y', 'REGC03', 'COM001', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('명함등록', '명함등록', 'Y', 'REGC04', 'COM001', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회 게시판 등록', '동호회 게시판 등록', 'Y', 'REGC05', 'COM001', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티 게시판 등록', '커뮤니티 게시판 등록', 'Y', 'REGC06', 'COM001', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판사용자등록', '게시판사용자등록', 'Y', 'REGC07', 'COM001', '2011-12-01', NULL, '2013-01-03', NULL, '', '', '', '', NULL, NULL),
	('소프트웨어패치', '소프트웨어패치', 'Y', 'HIST01', 'COM002', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('소프트웨어설치', '소프트웨어설치', 'Y', 'HIST02', 'COM002', '2011-12-01', NULL, '2013-01-03', NULL, '', '', '', '', NULL, NULL),
	('소프트웨어삭제', '소프트웨어삭제', 'Y', 'HIST03', 'COM002', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('하드웨어업그레이드', '하드웨어업그레이드', 'Y', 'HIST04', 'COM002', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('하드웨어삭제', '하드웨어삭제', 'Y', 'HIST05', 'COM002', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판', '게시판', 'Y', 'BBS', 'COM003', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회', '동호회', 'Y', 'CLB', 'COM003', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티', '커뮤니티', 'Y', 'CMY', 'COM003', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('명함', '명함', 'Y', 'NCD', 'COM003', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일반게시판', '일반게시판', 'N', 'BBST01', 'COM004', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('익명게시판', '익명게시판', 'N', 'BBST02', 'COM004', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('공지게시판', '공지게시판', 'N', 'BBST03', 'COM004', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('방명록', '방명록', 'N', 'BBST04', 'COM004', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티', '커뮤니티', 'Y', 'COMM', 'COM004', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('업무공유', '업무공유', 'Y', 'COOP', 'COM004', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('업무지원', '업무지원', 'Y', 'SPRT', 'COM004', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판템플릿', '게시판템플릿', 'Y', 'TMPT01', 'COM005', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티템플릿', '커뮤니티템플릿', 'Y', 'TMPT02', 'COM005', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회템플릿', '동호회템플릿', 'Y', 'TMPT03', 'COM005', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티등록', '커뮤니티등록', 'Y', 'CF01', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티삭제', '커뮤니티삭제', 'Y', 'CF02', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회등록', '동호회등록', 'Y', 'CF03', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회삭제', '동호회삭제', 'Y', 'CF04', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티운영자등록', '커뮤니티운영자등록', 'Y', 'CF05', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티운영자삭제', '커뮤니티운영자삭제', 'Y', 'CF06', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회운영자등록', '동호회운영자등록', 'Y', 'CF07', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회운영자삭제', '동호회운영자삭제', 'Y', 'CF08', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판이용등록', '게시판이용등록', 'Y', 'CF09', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판삭제', '게시판삭제', 'Y', 'CF10', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티사용자등록', '커뮤니티사용자등록', 'Y', 'CF11', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티사용자탈퇴', '커뮤니티사용자탈퇴', 'Y', 'CF12', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회사용자등록', '동호회사용자등록', 'Y', 'CF13', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회사용자탈퇴', '동호회사용자탈퇴', 'Y', 'CF14', 'COM006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('승인요청', '승인요청', 'Y', 'AP01', 'COM007', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('승인허가', '승인허가', 'Y', 'AP02', 'COM007', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('승인반려', '승인반려', 'Y', 'AP03', 'COM007', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('전송요청', '전송요청', 'Y', 'S01', 'COM008', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('전송완료', '전송완료', 'Y', 'S02', 'COM008', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('전송실패', '전송실패', 'Y', 'S03', 'COM008', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('수신요청', '수신요청', 'Y', 'S04', 'COM008', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('수신완료', '수신완료', 'Y', 'S05', 'COM008', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('수신실패', '수신실패', 'Y', 'S06', 'COM008', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('유효게시판', '유효게시판', 'N', 'BBSA01', 'COM009', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('갤러리', '갤러리', 'N', 'BBSA02', 'COM009', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일반게시판', '일반게시판', 'N', 'BBSA03', 'COM009', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일반게시판', '일반게시판', 'Y', 'COMMON', 'COM009', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('토론게시판', '토론게시판', 'Y', 'DISCUS', 'COM009', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('프로젝트', '프로젝트', 'Y', 'PRJBBS', 'COM009', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('경조사게시판', '경조사게시판', 'Y', 'SCHDL', 'COM009', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('건의/제안', '건의/제안', 'Y', 'SGST', 'COM009', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('주간업무보고', '주간업무보고', 'Y', 'WKRPRT', 'COM009', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('어플리케이션 관련 권한', '어플리케이션 관련 권한', 'Y', 'PRVA001', 'COM010', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판 관련 권한', '게시판 관련 권한', 'Y', 'PRVB001', 'COM010', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티 관련 권한', '커뮤니티 관련 권한', 'Y', 'PRVC001', 'COM010', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('데이터베이스 관련 권한', '데이터베이스 관련 권한', 'Y', 'PRVD001', 'COM010', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('시스템 관련 권한(최상위 권한)', '시스템 관련 권한(최상위 권한)', 'Y', 'PRVS001', 'COM010', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('사용자 관련 권한', '사용자 관련 권한', 'Y', 'PRVU001', 'COM010', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('어플리케이션 관련 최상위 롤', '어플리케이션 관련 최상위 롤', 'Y', 'ROLA001', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('업무 어플리케이션 접근 롤', '업무 어플리케이션 접근 롤', 'Y', 'ROLA002', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('업무 어플리케이션 관리 롤', '업무 어플리케이션 관리 롤', 'Y', 'ROLA003', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일반 어플리케이션 접근 롤', '일반 어플리케이션 접근 롤', 'Y', 'ROLA004', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일반 어프리케이션 관리 롤', '일반 어프리케이션 관리 롤', 'Y', 'ROLA005', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('어플리케이션 약관 관리 롤', '어플리케이션 약관 관리 롤', 'Y', 'ROLA006', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('어플리케이션 저작권 관리 롤', '어플리케이션 저작권 관리 롤', 'Y', 'ROLA007', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('통계 및 보고서 접근 롤', '통계 및 보고서 접근 롤', 'Y', 'ROLA008', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판 관련 최상위 롤', '게시판 관련 최상위 롤', 'Y', 'ROLB001', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판 생성 롤', '게시판 생성 롤', 'Y', 'ROLB002', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판 접근 롤', '게시판 접근 롤', 'Y', 'ROLB003', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판 글쓰기 롤', '게시판 글쓰기 롤', 'Y', 'ROLB004', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판 글 수정/삭제 롤', '게시판 글 수정/삭제 롤', 'Y', 'ROLB005', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티 관련 최상위 롤', '커뮤니티 관련 최상위 롤', 'Y', 'ROLC001', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티 생성 롤', '커뮤니티 생성 롤', 'Y', 'ROLC002', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티 접근 롤', '커뮤니티 접근 롤', 'Y', 'ROLC003', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티 글쓰기 롤', '커뮤니티 글쓰기 롤', 'Y', 'ROLC004', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티 글 수정/삭제 롤', '커뮤니티 글 수정/삭제 롤', 'Y', 'ROLC005', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('파일 업로드 롤', '파일 업로드 롤', 'Y', 'ROLC006', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('데이터베이스 관련 최상위 롤', '데이터베이스 관련 최상위 롤', 'Y', 'ROLD001', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('데이터베이스 스키마 등록/변경 롤', '데이터베이스 스키마 등록/변경 롤', 'Y', 'ROLD002', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('데이터 조회 롤', '데이터 조회 롤', 'Y', 'ROLD003', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('데이터 등록/변경 롤', '데이터 등록/변경 롤', 'Y', 'ROLD004', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('시스템 관리 최상위 롤', '시스템 관리 최상위 롤', 'Y', 'ROLS001', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('시스템 접근(view) 롤', '시스템 접근(view) 롤', 'Y', 'ROLS002', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('시스템 설정 등록/변경 롤', '시스템 설정 등록/변경 롤', 'Y', 'ROLS003', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('시스템 파일 등록/변경 롤', '시스템 파일 등록/변경 롤', 'Y', 'ROLS004', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('사용자 관련 최상위 롤', '사용자 관련 최상위 롤', 'Y', 'ROLU001', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('업무 시스템 사용자 관리 롤', '업무 시스템 사용자 관리 롤', 'Y', 'ROLU002', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기업회원 시스템 사용자 관리 롤', '기업회원 시스템 사용자 관리 롤', 'Y', 'ROLU003', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일반회원 시스템 사용자 관리 롤', '일반회원 시스템 사용자 관리 롤', 'Y', 'ROLU004', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판 사용자 관리 롤', '게시판 사용자 관리 롤', 'Y', 'ROLU005', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티 사용자 관리 롤', '커뮤니티 사용자 관리 롤', 'Y', 'ROLU006', 'COM011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일반 회원 유형', '일반 회원 유형', 'Y', 'USR01', 'COM012', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기업 회원 유형', '기업 회원 유형', 'Y', 'USR02', 'COM012', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('업무 담당자(사용자) 유형', '업무 담당자(사용자) 유형', 'Y', 'USR03', 'COM012', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('사용자 유형 최상위 롤', '사용자 유형 최상위 롤', 'Y', 'USR99', 'COM012', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('회원 가입 신청 상태', '회원 가입 신청 상태', 'Y', 'A', 'COM013', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('회원 가입 삭제 상태', '회원 가입 삭제 상태', 'Y', 'D', 'COM013', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('회원 가입 승인 상태', '회원 가입 승인 상태', 'Y', 'P', 'COM013', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('여자', '여자', 'Y', 'F', 'COM014', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 3),
	('남자', '남자', 'Y', 'M', 'COM014', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 2),
	('무관', '무관', 'Y', 'U', 'COM014', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 1),
	('주민등록번호 인증', '주민등록번호 인증', 'Y', 'ATH01', 'COM015', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('GPIN 인증', 'GPIN 인증', 'Y', 'ATH02', 'COM015', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('프로그램 변경 요청 신청', '프로그램 변경 요청 신청', 'Y', 'PUR01', 'COM016', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('프로그램 변경 요청 수락', '프로그램 변경 요청 수락', 'Y', 'PUR02', 'COM016', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('프로그램 변경 진행', '프로그램 변경 진행', 'Y', 'PUR03', 'COM016', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('프로그램 변경 완료', '프로그램 변경 완료', 'Y', 'PUR04', 'COM016', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('프로그램 변경 이관', '프로그램 변경 이관', 'Y', 'PUR05', 'COM016', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('법정휴일', '법정휴일', 'Y', '01', 'COM017', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('법정공휴일', '법정공휴일', 'Y', '02', 'COM017', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('임시공휴일', '임시공휴일', 'Y', '03', 'COM017', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('객관식', '객관식', 'Y', '1', 'COM018', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('주관식', '주관식', 'Y', '2', 'COM018', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('높음', '높음', 'Y', 'A', 'COM019', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('보통', '보통', 'Y', 'B', 'COM019', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('낮음', '낮음', 'Y', 'C', 'COM019', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('부서일정관리', '부서일정관리', 'Y', '1', 'COM020', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일정관리', '일정관리', 'Y', '2', 'COM020', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기능설명', '기능설명', 'Y', '1', 'COM021', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('절차설명', '절차설명', 'Y', '2', 'COM021', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('가장 기억에 남는 장소는?', '가장 기억에 남는 장소는?', 'Y', ' P01', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('나의 좌우명은?', '나의 좌우명은?', 'Y', ' P02', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('나의 보물 제1호는?', '나의 보물 제1호는?', 'Y', ' P03', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('가장 기억에 남는 선생님 성함은?', '가장 기억에 남는 선생님 성함은?', 'Y', ' P04', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('다른 사람은 모르는 나만의 신체비밀은?', '다른 사람은 모르는 나만의 신체비밀은?', 'Y', ' P05', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('오래도록 기억하고 싶은 날짜는?', '오래도록 기억하고 싶은 날짜는?', 'Y', ' P06', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('받았던 선물 중 기억에 남는 독특한 선물은?', '받았던 선물 중 기억에 남는 독특한 선물은?', 'Y', ' P07', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('가장 생각나는 친구 이름은?', '가장 생각나는 친구 이름은?', 'Y', ' P08', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('인상 깊게 읽은 책 이름은?', '인상 깊게 읽은 책 이름은?', 'Y', ' P09', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('내가 존경하는 인물은?', '내가 존경하는 인물은?', 'Y', ' P10', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('나의 노래방 애창곡은?', '나의 노래방 애창곡은?', 'Y', ' P11', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('가장 감명깊게 본 영화는?', '가장 감명깊게 본 영화는?', 'Y', ' P12', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('좋아하는 스포츠팀 이름은?', '좋아하는 스포츠팀 이름은?', 'Y', ' P13', 'COM022', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('경제', '경제', 'Y', '01', 'COM023', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('전산', '전산', 'Y', '02', 'COM023', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('행정', '행정', 'Y', '03', 'COM023', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('완료', '완료', 'Y', 'C', 'COM024', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('실패', '실패', 'Y', 'F', 'COM024', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('요청', '요청', 'Y', 'R', 'COM024', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('공공기관', '공공기관', 'Y', '00000001', 'COM025', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('금융기관', '금융기관', 'Y', '00000002', 'COM025', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('교육기관', '교육기관', 'Y', '00000003', 'COM025', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('의료기관', '의료기관', 'Y', '00000004', 'COM025', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('대기업', '대기업', 'Y', 'C0000001', 'COM026', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('중소기업', '중소기업', 'Y', 'C0000002', 'COM026', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('다국적기업', '다국적기업', 'Y', 'C0000003', 'COM026', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('축산업', '축산업', 'Y', 'A', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('어업', '어업', 'Y', 'B', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('광업', '광업', 'Y', 'C', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('제조업', '제조업', 'Y', 'D', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('전기,가스및수도사업', '전기,가스및수도사업', 'Y', 'E', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('건설업', '건설업', 'Y', 'F', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('도소매 및 소비자용품수리업', '도소매 및 소비자용품수리업', 'Y', 'G', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('숙박및음식점', '숙박및음식점', 'Y', 'H', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('운수창고및통신업', '운수창고및통신업', 'Y', 'I', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('금융및보험업', '금융및보험업', 'Y', 'J', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('부동산,임대및사업서비스업', '부동산,임대및사업서비스업', 'Y', 'K', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('교육서비스업', '교육서비스업', 'Y', 'M', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('보건업', '보건업', 'Y', 'N', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타공공,사회및개인서비스업', '기타공공,사회및개인서비스업', 'Y', 'O', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('가사서비스업', '가사서비스업', 'Y', 'P', 'COM027', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('접수대기', '접수대기', 'Y', '1', 'COM028', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('접수', '접수', 'Y', '2', 'COM028', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('완료', '완료', 'Y', '3', 'COM028', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('METHOD', 'METHOD', 'Y', 'method', 'COM029', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('POINTCUT', 'POINTCUT', 'Y', 'pointcut', 'COM029', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('URL', 'URL', 'Y', 'url', 'COM029', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('회의', '회의', 'Y', '1', 'COM030', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('세미나', '세미나', 'Y', '2', 'COM030', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('강의', '강의', 'Y', '3', 'COM030', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('교육', '교육', 'Y', '4', 'COM030', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '5', 'COM030', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('당일', '당일', 'Y', '1', 'COM031', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('반복', '반복', 'Y', '2', 'COM031', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('연속', '연속', 'Y', '3', 'COM031', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('요일반복', '요일반복', 'Y', '4', 'COM031', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('회원가입', '회원가입', 'Y', 'WC01', 'COM032', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('사용자등록', '사용자등록', 'Y', 'WC02', 'COM032', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('회원탈퇴', '회원탈퇴', 'Y', 'WC03', 'COM032', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('사용자삭제', '사용자삭제', 'Y', 'WC04', 'COM032', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티등록', '커뮤니티등록', 'Y', 'WC05', 'COM032', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회등록', '동호회등록', 'Y', 'WC06', 'COM032', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('커뮤니티폐쇄', '커뮤니티폐쇄', 'Y', 'WC07', 'COM032', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동호회폐쇄', '동호회폐쇄', 'Y', 'WC08', 'COM032', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판등록', '게시판등록', 'Y', 'WC09', 'COM032', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시판폐쇄', '게시판폐쇄', 'Y', 'WC10', 'COM032', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('생성', '생성', 'Y', 'C', 'COM033', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('삭제', '삭제', 'Y', 'D', 'COM033', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('조회', '조회', 'Y', 'R', 'COM033', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('수정', '수정', 'Y', 'U', 'COM033', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('학생', '학생', 'Y', '1', 'COM034', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('대학생', '대학생', 'Y', '2', 'COM034', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('군인', '군인', 'Y', '3', 'COM034', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('교사', '교사', 'Y', '4', 'COM034', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '5', 'COM034', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('행사', '행사', 'Y', '1', 'COM035', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('이벤트', '이벤트', 'Y', '2', 'COM035', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('캠페인', '캠페인', 'Y', '3', 'COM035', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('작성', '작성', 'Y', '01', 'COM036', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('상신', '상신', 'Y', '02', 'COM036', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('반려', '반려', 'Y', '03', 'COM036', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('결재완료', '결재완료', 'Y', '04', 'COM036', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('N', '아니오', 'Y', 'N', 'COM038', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 1),
	('Y', '예', 'Y', 'Y', 'COM038', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('사회', '사회', 'Y', '001', 'COM039', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('정치', '정치', 'Y', '002', 'COM039', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('경제', '경제', 'Y', '003', 'COM039', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('문화', '문화', 'Y', '004', 'COM039', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('인문', '인문', 'Y', '005', 'COM039', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('공학', '공학', 'Y', '006', 'COM039', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '007', 'COM039', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('휴가계획서', '휴가계획서', 'Y', '01', 'COM040', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('출장보고서', '출장보고서', 'Y', '02', 'COM040', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('교육보고서', '교육보고서', 'Y', '03', 'COM040', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('판품요청서', '판품요청서', 'Y', '04', 'COM040', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('지원요청서', '지원요청서', 'Y', '05', 'COM040', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('절차설명', '절차설명', 'Y', '001', 'COM041', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기능설명', '기능설명', 'Y', '002', 'COM041', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타설명', '기타설명', 'Y', '003', 'COM041', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('연도별', '연도별', 'Y', '%Y', 'COM042', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('월별', '월별', 'Y', '%Y-%m', 'COM042', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일별', '일별', 'Y', '%Y-%m-%d', 'COM042', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('생성', '생성', 'Y', '01', 'COM043', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('변경', '변경', 'Y', '02', 'COM043', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('말소', '말소', 'Y', '03', 'COM043', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('수신처리', '수신처리', 'Y', '00', 'COM044', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('처리완료', '처리완료', 'Y', '01', 'COM044', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기등록', '기등록', 'Y', '10', 'COM044', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('생성오류', '생성오류', 'Y', '11', 'COM044', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('변경오류', '변경오류', 'Y', '12', 'COM044', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('말소오류', '말소오류', 'Y', '13', 'COM044', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('정상', '정상', 'Y', '01', 'COM046', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('비정상', '비정상', 'Y', '02', 'COM046', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('매일', '매일', 'Y', '01', 'COM047', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('매주', '매주', 'Y', '02', 'COM047', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('매월', '매월', 'Y', '03', 'COM047', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('매년', '매년', 'Y', '04', 'COM047', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('한번만', '한번만', 'Y', '05', 'COM047', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Oracle', 'Oracle', 'Y', '01', 'COM048', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Mysql', 'Mysql', 'Y', '02', 'COM048', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Tibero', 'Tibero', 'Y', '03', 'COM048', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Altibase', 'Altibase', 'Y', '04', 'COM048', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Tar', 'Tar', 'Y', '01', 'COM049', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('ZIP', 'ZIP', 'Y', '02', 'COM049', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('수신', '수신', 'Y', '01', 'COM050', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('참조', '참조', 'Y', '02', 'COM050', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('신청중', '신청중', 'Y', '01', 'COM051', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('승인', '승인', 'Y', '02', 'COM051', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('반려', '반려', 'Y', '03', 'COM051', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('양력', '양력', 'Y', '01', 'COM052', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('음력', '음력', 'Y', '02', 'COM052', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('교육', '교육', 'Y', '01', 'COM053', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('세미나', '세미나', 'Y', '02', 'COM053', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('홍보', '홍보', 'Y', '03', 'COM053', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('단합', '단합', 'Y', '04', 'COM053', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('간담회', '간담회', 'Y', '05', 'COM053', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '99', 'COM053', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('결혼', '결혼', 'Y', '01', 'COM054', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('출생', '출생', 'Y', '02', 'COM054', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('회갑', '회갑', 'Y', '03', 'COM054', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('사망', '사망', 'Y', '04', 'COM054', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('출산', '출산', 'Y', '05', 'COM054', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '99', 'COM054', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('우수사원', '우수사원', 'Y', '01', 'COM055', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('우수팀', '우수팀', 'Y', '02', 'COM055', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '99', 'COM055', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('연차휴가', '연차휴가', 'Y', '01', 'COM056', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('반차휴가', '반차휴가', 'Y', '02', 'COM056', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('무급휴가', '무급휴가', 'Y', '03', 'COM056', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('유급휴가', '유급휴가', 'Y', '04', 'COM056', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('대체휴가', '대체휴가', 'Y', '05', 'COM056', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '99', 'COM056', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('회의', '회의', 'Y', '1', 'COM057', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('방문', '방문', 'Y', '2', 'COM057', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('세미나', '세미나', 'Y', '3', 'COM057', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '4', 'COM057', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('반복없음', '당일', 'Y', '1', 'COM058', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('매일', '매일', 'Y', '2', 'COM058', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('매주', '매주', 'Y', '3', 'COM058', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('매월', '매월', 'Y', '4', 'COM058', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('높음', '높음', 'Y', '1', 'COM059', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('보통', '보통', 'Y', '2', 'COM059', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('낮음', '낮음', 'Y', '3', 'COM059', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('주간보고', '주간보고', 'Y', '1', 'COM060', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('월간보고', '월간보고', 'Y', '2', 'COM060', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('경조신청', '경조신청', 'N', '001', 'COM061', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('포상신청', '포상신청', 'N', '002', 'COM061', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('휴가신청', '휴가신청', 'N', '003', 'COM061', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('행사신청', '행사신청', 'N', '004', 'COM061', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('재실', '재실', 'Y', '1', 'COM061', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('자리비움', '자리비움', 'Y', '2', 'COM061', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('회의중', '회의중', 'Y', '3', 'COM061', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('출장중', '출장중', 'Y', '4', 'COM061', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('휴가중', '휴가중', 'Y', '5', 'COM061', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Continue ', 'Continue ', 'Y', '100', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Switching Protocols ', 'Switching Protocols ', 'Y', '101', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('OK ', 'OK ', 'Y', '200', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Created ', 'Created ', 'Y', '201', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Accepted ', 'Accepted ', 'Y', '202', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Non-Authoritative Information ', 'Non-Authoritative Information ', 'Y', '203', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('No Content ', 'No Content ', 'Y', '204', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Reset Content ', 'Reset Content ', 'Y', '205', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Partial Content ', 'Partial Content ', 'Y', '206', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Multiple Choices ', 'Multiple Choices ', 'Y', '300', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Moved Permanently ', 'Moved Permanently ', 'Y', '301', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Found ', 'Found ', 'Y', '302', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('See Other ', 'See Other ', 'Y', '303', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Not Modified ', 'Not Modified ', 'Y', '304', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Use Proxy ', 'Use Proxy ', 'Y', '305', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Temporary Redirect ', 'Temporary Redirect ', 'Y', '307', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Bad Request ', 'Bad Request ', 'Y', '400', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Unauthorized ', 'Unauthorized ', 'Y', '401', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Forbidden ', 'Forbidden ', 'Y', '403', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Not Found ', 'Not Found ', 'Y', '404', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Method Not Allowed ', 'Method Not Allowed ', 'Y', '405', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Not Acceptable ', 'Not Acceptable ', 'Y', '406', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Proxy Authentication Required ', 'Proxy Authentication Required ', 'Y', '407', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Request Timeout ', 'Request Timeout ', 'Y', '408', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Conflict ', 'Conflict ', 'Y', '409', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Gone ', 'Gone ', 'Y', '410', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Length Required ', 'Length Required ', 'Y', '411', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Precondition Failed ', 'Precondition Failed ', 'Y', '412', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Request Entity Too Large ', 'Request Entity Too Large ', 'Y', '413', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Request URI Too Long ', 'Request URI Too Long ', 'Y', '414', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Unsupported Media Type ', 'Unsupported Media Type ', 'Y', '415', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Requested Range Not Satisfiable ', 'Requested Range Not Satisfiable ', 'Y', '416', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Expectation Failed ', 'Expectation Failed ', 'Y', '417', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Internal Server Error ', 'Internal Server Error ', 'Y', '500', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Not Implemented ', 'Not Implemented ', 'Y', '501', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Bad Gateway ', 'Bad Gateway ', 'Y', '502', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Service Unavailable ', 'Service Unavailable ', 'Y', '503', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Gateway Timeout ', 'Gateway Timeout ', 'Y', '504', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('HTTP Version Not Supported ', 'HTTP Version Not Supported ', 'Y', '505', 'COM062', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Runnable', 'Runnable', 'Y', '100', 'COM063', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Sleeping', 'Sleeping', 'Y', '200', 'COM063', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Swapped', 'Swapped', 'Y', '300', 'COM063', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Zombie', 'Zombie', 'Y', '400', 'COM063', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Stopped', 'Stopped', 'Y', '500', 'COM063', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('웹 서버', '웹 서버', 'Y', '01', 'COM064', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('WAS', 'WAS', 'Y', '02', 'COM064', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('DB 서버', 'DB 서버', 'Y', '03', 'COM064', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Mail 서버', 'Mail 서버', 'Y', '04', 'COM064', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('DNS 서버', 'DNS 서버', 'Y', '05', 'COM064', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타 서버', '기타 서버', 'Y', '99', 'COM064', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('네트워크 장애', '네트워크 장애', 'Y', '01', 'COM065', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('하드웨어 장애', '하드웨어 장애', 'Y', '02', 'COM065', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('어플리케이션 장애', '어플리케이션 장애', 'Y', '03', 'COM065', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('서비스 장애', '서비스 장애', 'Y', '04', 'COM065', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('모니터링 장애', '모니터링 장애', 'Y', '05', 'COM065', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('정전', '정전', 'Y', '06', 'COM065', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('화재', '화재', 'Y', '07', 'COM065', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('홍수', '홍수', 'Y', '08', 'COM065', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타 장애', '기타 장애', 'Y', '99', 'COM065', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('CPU', 'CPU', 'Y', '01', 'COM066', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('메모리', '메모리', 'Y', '02', 'COM066', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('서버', '서버', 'Y', '01', 'COM067', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('라우터', '라우터', 'Y', '02', 'COM067', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('스위치', '스위치', 'Y', '03', 'COM067', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('PC', 'PC', 'Y', '04', 'COM067', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('프린터', '프린터', 'Y', '05', 'COM067', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '99', 'COM067', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('접수', '접수', 'Y', 'A', 'COM068', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('완료', '완료', 'Y', 'C', 'COM068', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('요청', '요청', 'Y', 'R', 'COM068', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('생일', '생일', 'Y', '01', 'COM069', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기념', '기념', 'N', '02', 'COM069', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('결혼', '결혼', 'Y', '03', 'COM069', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('탄생', '탄생', 'Y', '04', 'COM069', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('축하', '축하', 'Y', '05', 'COM069', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('출장', '출장', 'Y', '06', 'COM069', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('퇴원', '퇴원', 'Y', '07', 'COM069', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '99', 'COM069', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('본관1층', '본관1층', 'Y', '01', 'COM070', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('본관2층', '본관2층', 'Y', '02', 'COM070', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('본관3층', '본관3층', 'Y', '03', 'COM070', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('본관4층', '본관4층', 'Y', '04', 'COM070', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('본관5층', '본관5층', 'Y', '05', 'COM070', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('별관1층', '별관1층', 'Y', '06', 'COM070', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('별관2층', '별관2층', 'Y', '07', 'COM070', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '99', 'COM070', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('전기시설', '전기시설', 'Y', '01', 'COM071', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('소등상태', '소등상태', 'Y', '02', 'COM071', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('방화요소', '방화요소', 'Y', '03', 'COM071', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('소방시설', '소방시설', 'Y', '04', 'COM071', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('비상 KEY', '비상 KEY', 'Y', '05', 'COM071', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('시건장치', '시건장치', 'Y', '06', 'COM071', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '99', 'COM071', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('정상', '정상', 'Y', '01', 'COM072', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('오류', '오류', 'Y', '02', 'COM072', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('중지', '중지', 'Y', '03', 'COM072', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '09', 'COM072', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('본인', '본인', 'Y', '01', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('배우자', '배우자', 'Y', '02', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('자녀', '자녀', 'Y', '03', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('부친', '부친', 'Y', '04', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('모친', '모친', 'Y', '05', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('배우자부친', '배우자부친', 'Y', '06', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('배우자모친', '배우자모친', 'Y', '07', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('조부', '조부', 'Y', '08', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('조모', '조모', 'Y', '09', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('형제자매(본인)', '형제자매(본인)', 'Y', '10', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('외조부', '외조부', 'Y', '11', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('외조모', '외조모', 'Y', '12', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('백숙부', '백숙부', 'Y', '13', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('백숙모', '백숙모', 'Y', '14', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('형제자매(배우자)', '형제자매(배우자)', 'Y', '15', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '99', 'COM073', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일요일', '일요일', 'Y', '1', 'COM074', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('월요일', '월요일', 'Y', '2', 'COM074', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('화요일', '화요일', 'Y', '3', 'COM074', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('수요일', '수요일', 'Y', '4', 'COM074', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('목요일', '목요일', 'Y', '5', 'COM074', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('금요일', '금요일', 'Y', '6', 'COM074', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('토요일', '토요일', 'Y', '7', 'COM074', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('경조신청', '경조신청', 'Y', '001', 'COM075', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('포상신청', '포상신청', 'Y', '002', 'COM075', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('휴가신청', '휴가신청', 'Y', '003', 'COM075', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('행사신청', '행사신청', 'Y', '004', 'COM075', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('정상', '정상', 'Y', '01', 'COM076', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('비정상', '비정상', 'Y', '02', 'COM076', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('수행중', '수행중', 'Y', '03', 'COM076', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('저장중', '저장중', 'Y', 'APP000', 'KMS000', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('검토중', '검토중', 'Y', 'APP001', 'KMS000', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('협조중', '협조중', 'Y', 'APP002', 'KMS000', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('전결중', '전결중', 'Y', 'APP003', 'KMS000', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('참조중', '참조중', 'Y', 'APP004', 'KMS000', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('결재완료', '결재완료', 'Y', 'APP005', 'KMS000', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('결재실패', '결재실패', 'Y', 'APP099', 'KMS000', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('작성자', '작성자', 'Y', 'APR000', 'KMS001', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('검토자', '검토자', 'Y', 'APR001', 'KMS001', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('협조자', '협조자', 'Y', 'APR002', 'KMS001', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('전결자', '전결자', 'Y', 'APR003', 'KMS001', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('참조자', '참조자', 'Y', 'APR004', 'KMS001', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('처리담당자', '처리담당자', 'Y', 'APR005', 'KMS001', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('고졸', '고졸', 'Y', '1', 'KMS002', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('초대졸', '초대졸', 'Y', '2', 'KMS002', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('대졸', '대졸', 'Y', '3', 'KMS002', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('대학원졸', '대학원졸', 'Y', '4', 'KMS002', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('없음', '없음', 'N', '00', 'KMS003', '2011-12-01', NULL, '2011-12-01', NULL, 'Y', '', '', '', NULL, 110),
	('사장', '사장', 'Y', '01', 'KMS003', '2011-12-01', NULL, '2011-12-01', NULL, 'N', '', '', '', NULL, 0),
	('부사장', '부사장', 'Y', '02', 'KMS003', '2011-12-01', NULL, '2011-12-01', NULL, 'N', '', '', '', NULL, 10),
	('이사', '이사', 'Y', '03', 'KMS003', '2011-12-01', NULL, '2011-12-01', NULL, 'N', '', '', '', NULL, 40),
	('부장', '부장', 'Y', '04', 'KMS003', '2011-12-01', NULL, '2011-12-01', NULL, 'Y', '', '', '', NULL, 60),
	('차장', '차장', 'Y', '06', 'KMS003', '2011-12-01', NULL, '2011-12-01', NULL, 'Y', '', '', '', NULL, 70),
	('과장', '과장', 'Y', '07', 'KMS003', '2011-12-01', NULL, '2011-12-01', NULL, 'Y', '', '', '', NULL, 80),
	('대리', '대리', 'Y', '09', 'KMS003', '2011-12-01', NULL, '2011-12-01', NULL, 'Y', '', '', '', NULL, 90),
	('사원', '사원', 'Y', '10', 'KMS003', '2011-12-01', NULL, '2011-12-01', NULL, 'Y', '', '', '', NULL, 100),
	('상무', '상무', 'Y', '11', 'KMS003', '2011-12-01', NULL, '2011-12-01', NULL, 'N', '', '', '', NULL, 30),
	('전무', '전무', 'Y', '12', 'KMS003', '2011-12-01', NULL, '2011-12-01', NULL, 'N', '', '', '', NULL, 20),
	('수석', '수석', 'Y', '13', 'KMS003', '2011-12-01', NULL, '2015-01-02', NULL, 'Y', NULL, NULL, NULL, NULL, 50),
	('대표', '대표', 'Y', '14', 'KMS003', '2020-01-22', NULL, '2020-01-22', NULL, '', '', '', '', NULL, 5),
	('22시', '22시', 'Y', '22', 'KMS004', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('본사20층', '에이스2001호', 'Y', '1', 'KMS005', '2011-12-01', NULL, '2011-12-01', NULL, '서울 구로구 구로3동 222-14 에이스하이엔드타워 2차 20층', NULL, NULL, NULL, NULL, 0),
	('법정공휴일', '법정공휴일', 'Y', 'H', 'KMS006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('임시공휴일', '임시공휴일', 'Y', 'I', 'KMS006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('회사공휴일', '회사공휴일', 'Y', 'J', 'KMS006', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('도전하는사람들', '도사', 'Y', 'dosanet', 'KMS007', '2011-12-01', NULL, '2011-12-01', NULL, '도사', NULL, NULL, NULL, NULL, 10),
	('아니오', '아니오', 'Y', 'N', 'KMS008', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 1),
	('예', '예', 'Y', 'Y', 'KMS008', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('누구나', 'ALL', 'Y', 'ALL', 'KMS009', '2011-12-01', NULL, '2011-12-01', NULL, '', '', '', '', NULL, 1),
	('불가능', 'NO', 'Y', 'N', 'KMS009', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 2),
	('투입인력만', 'YES', 'Y', 'Y', 'KMS009', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('종료', '종료', 'Y', 'E', 'KMS010', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('진행', '진행', 'Y', 'P', 'KMS010', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('중단', '중단', 'Y', 'S', 'KMS010', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('부서장', '부서장', 'Y', 'H', 'KMS011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('보직없음', '일반', 'Y', 'N', 'KMS011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('부서장대행', '부서장대행', 'Y', 'S', 'KMS011', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('인금인상률', '인금인상률', 'Y', '0.05', 'KMS012', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('조기출근시간', '8', 'Y', '8', 'KMS013', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('출근시간', '9', 'Y', '9', 'KMS014', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('매출원가', '매출원가', 'Y', 'C', 'KMS015', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('판관비', '판관비', 'Y', 'E', 'KMS015', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('업무경비', '업무경비', 'Y', '10', 'KMS016', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('자기개발비', '자기개발비', 'Y', '11', 'KMS016', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('회식비', '회식비', 'N', '12', 'KMS016', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('상품매입', '상품매입', 'Y', '13', 'KMS016', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('만료', NULL, 'Y', 'E', 'KMS017', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('분실', NULL, 'Y', 'L', 'KMS017', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('정상', NULL, 'Y', 'N', 'KMS017', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('정지', NULL, 'Y', 'S', 'KMS017', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('IP9', '0.0.0', 'Y', '0:0:0:0:0:0:1', 'KMS018', '2012-10-09', 'ArvinHmdev', '2012-10-09', NULL, NULL, NULL, NULL, NULL, NULL, 9),
	('IP10', '127.0.0.1', 'Y', '127.0.0.1', 'KMS018', '2011-12-01', 'ArvinHmdev', '2012-12-18', NULL, NULL, NULL, NULL, NULL, NULL, 10),
	('IP4', '172.16.30', 'Y', '172.16.30', 'KMS018', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 4),
	('IP5', '172.16.31', 'Y', '172.16.31', 'KMS018', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 5),
	('IP6', '172.16.32', 'Y', '172.16.32', 'KMS018', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 6),
	('IP7', '172.16.33', 'Y', '172.16.33', 'KMS018', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 7),
	('IP8', '172.16.34', 'Y', '172.16.34', 'KMS018', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 8),
	('IP3', '175.198.119', 'Y', '175.198.119', 'KMS018', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 3),
	('IP11', '210.91.32', 'Y', '210.91.32', 'KMS018', '2013-03-14', 'ArvinHmdev', '2013-03-14', NULL, NULL, NULL, NULL, NULL, NULL, 11),
	('IP2', '222.112.151', 'Y', '222.112.151', 'KMS018', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 2),
	('IP13', '222.112.231', 'Y', '222.112.231', 'KMS018', '2014-08-21', 'dwkim', '2014-08-21', NULL, NULL, NULL, NULL, NULL, NULL, 13),
	('IP1', '222.112.235', 'Y', '222.112.235', 'KMS018', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 1),
	('IP14', '61.74.186.177', 'Y', '61.74.186.177', 'KMS018', '2021-09-01', NULL, '2021-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('게시물작성', '5', 'Y', 'C1', 'KMS019', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('덧글작성', '1', 'Y', 'C2', 'KMS019', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일일업무보고작성', '2', 'Y', 'R1', 'KMS019', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('일일업무보고작성(300자 초과)', '5', 'Y', 'R2', 'KMS019', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('접속하기', 'http://vcc.dosanet.co.kr/VCC/dosa/booking/index.do', 'Y', 'Connect', 'KMS020', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Android', 'http://222.112.235.250:6010/mvuc/app/ANDROID/lastest/download.xml', 'Y', 'Download_Androi', 'KMS020', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('IOS', 'itms-services://?action=download-manifest&amp;url=http://222.112.235.250:6010/mvuc/app/IOS/plist.xml', 'Y', 'Download_IOS', 'KMS020', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('PC', 'http://222.112.235.251:6010/chorusvc/app/chorusvc/PC/download.xml', 'Y', 'Download_PC', 'KMS020', '2011-12-01', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('입금', '입금', 'Y', 'D', 'KMS021', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('대체입금', '대체입금', 'Y', 'RD', 'KMS021', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('대체출금', '대체출금', 'Y', 'RW', 'KMS021', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('출금', '출금', 'Y', 'W', 'KMS021', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('유지보수', 'D', 'Y', 'AS', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', 'W', 'Y', 'EL', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', 'D', 'Y', 'ET', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('FINANCIAL', '', 'Y', 'FI', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('상품', 'D', 'Y', 'GD', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('매입원가', 'W', 'Y', 'IN', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('인건비', 'W', 'Y', 'LB', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('판권', 'D', 'Y', 'LC', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('관리비', 'W', 'Y', 'MT', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('SALES', '', 'Y', 'SA', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('솔루션판매', 'D', 'Y', 'SL', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('용역', 'D', 'Y', 'SV', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('TRANSFER', '', 'Y', 'TR', 'KMS022', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('현금', 'dosanet', 'Y', 'CASH', 'KMS023', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '5', 'KMS024', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 70),
	('일반상담', '일반상담', 'Y', '1', 'KMS025', '2012-06-22', NULL, '2014-03-14', NULL, '', '', '', '', NULL, 20),
	('영업문의', '영업문의', 'Y', '2', 'KMS025', '2012-06-22', NULL, '2014-03-14', NULL, '', '', '', '', NULL, 30),
	('장애처리', '장애처리', 'Y', '3', 'KMS025', '2012-06-22', NULL, '2014-03-14', NULL, '', '', '', '', NULL, 10),
	('화상상담', '화상상담', 'N', '4', 'KMS025', '2012-06-22', NULL, '2014-03-14', NULL, '', '', '', '', NULL, NULL),
	('기타', '기타', 'Y', '5', 'KMS025', '2012-06-22', NULL, '2014-03-14', NULL, '', '', '', '', NULL, 40),
	('유저수변경', '유저수변경', 'N', '6', 'KMS025', '2012-06-22', NULL, '2014-03-14', NULL, '', '', '', '', NULL, NULL),
	('재고', '0', 'Y', '0', 'KMS026', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('판매', '1', 'Y', '1', 'KMS026', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('데모', '2', 'Y', '2', 'KMS026', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('수리', '3', 'Y', '3', 'KMS026', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '4', 'Y', '4', 'KMS026', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('재입고', '5', 'Y', '5', 'KMS026', '2012-06-11', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('PC', 'PC', 'Y', '1', 'KMS027', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Mobile(AOS)', 'Mobile(AOS)', 'Y', '2', 'KMS027', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('Mobile(IOS)', 'Mobile(IOS)', 'Y', '3', 'KMS027', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('MAC', 'MAC', 'Y', '4', 'KMS027', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('WEB', 'WEB', 'Y', '5', 'KMS027', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('SERVER', 'SERVER', 'Y', '6', 'KMS027', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '7', 'KMS027', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('접수', '접수', 'Y', '1', 'KMS028', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('처리중', '처리중', 'Y', '2', 'KMS028', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('완료', '완료', 'Y', '3', 'KMS028', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('만족', '만족', 'Y', '1', 'KMS029', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('보통', '보통', 'Y', '2', 'KMS029', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('불만족', '불만족', 'Y', '3', 'KMS029', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('매우불만족', '매우불만족', 'Y', '4', 'KMS029', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('Black', 'Black', 'Y', '5', 'KMS029', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('완료', '완료', 'Y', '1', 'KMS030', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('열람중', '열람중', 'Y', '2', 'KMS030', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('codec', 'codec', 'Y', '1', 'KMS031', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('camera', 'camera', 'Y', '2', 'KMS031', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('phone', 'phone', 'Y', '3', 'KMS031', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('mic pod', 'mic', 'Y', '4', 'KMS031', '2012-06-22', NULL, '2011-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	('회사코드 없음', '사원정보에 회사코드 입력안됨', 'Y', '0', 'KMS032', '2012-10-29', NULL, '2013-01-03', NULL, '', '', '', '', NULL, 0),
	('도전하는사람들', '㈜도전하는사람들<br>대표이사 송태현, 정현석  (직인)<br>서울 구로구 디지털로 26길, 61 2001호(에이스하이엔드타워2차)', 'Y', '1', 'KMS032', '2012-10-29', NULL, '2013-01-03', NULL, '', '', '', '', NULL, 0),
	('고졸', '고졸', 'Y', '01', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('전문대재학', '전문대재학', 'Y', '02', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('전문대졸업', '전문대졸업', 'Y', '03', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('전문대중퇴', '전문대중퇴', 'Y', '04', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('대학재학', '대학재학', 'Y', '05', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('대학졸업', '대학졸업', 'Y', '06', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('대학수료', '대학수료', 'Y', '07', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('대학중퇴', '대학중퇴', 'Y', '08', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('석사재학', '석사재학', 'Y', '09', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('석사졸업', '석사졸업', 'Y', '10', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('석사수료', '석사수료', 'Y', '11', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('석사중퇴', '석사중퇴', 'Y', '12', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('박사재학', '박사재학', 'Y', '13', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('박사졸업', '박사졸업', 'Y', '14', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('박사수료', '박사수료', 'Y', '15', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('박사중퇴', '박사중퇴', 'Y', '16', 'KMS033', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('제시', '제시', 'Y', '1', 'KMS034', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('동의', '동의', 'Y', '2', 'KMS034', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('면담', '면담', 'Y', '3', 'KMS034', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('연봉협상 시작일', '0106', 'Y', '0', 'KMS035', '2012-11-02', NULL, '2021-01-05', NULL, '', '', '', '', NULL, NULL),
	('연봉협상 종료일', '0107', 'Y', '1', 'KMS035', '2012-11-02', NULL, '2021-01-25', NULL, '', '', '', '', NULL, NULL),
	('연봉협상 진행중 YN', 'N', 'Y', '2', 'KMS035', '2012-11-02', NULL, '2021-01-25', NULL, '', '', '', '', NULL, NULL),
	('연봉관리 제외 사용자번호', '2, 173, 111, 1001, 485', 'Y', '1', 'KMS036', '2012-11-02', NULL, '2019-01-03', NULL, '', '', '', '', NULL, NULL),
	('한마음 시스템 점검중 YN', 'N', 'Y', '0', 'KMS037', '2012-11-02', NULL, '2013-01-03', NULL, '', '', '', '', NULL, NULL),
	('한마음 시스템 점검기간', '2012년 12월 26일 13:30~24:00', 'Y', '1', 'KMS037', '2012-11-02', NULL, '2013-01-03', NULL, '', '', '', '', NULL, NULL),
	('한마음 시스템 점검사유', '조직정보 업데이트 및 프로젝트 이관, 년도변경 작업', 'Y', '2', 'KMS037', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('관리자 공통코드 관리', 'KMS032, KMS035, KMS036, KMS037', 'Y', '1', 'KMS038', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('근태관리 이사진 제외여부 YN', 'N', 'Y', '1', 'KMS039', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('근태관리 제외 사용자번호', '2, 173', 'Y', '2', 'KMS039', '2012-11-02', NULL, '2012-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('팀장경비 최상위 프로젝트코드', 'PRJ_0000000000000833', 'Y', '1', 'KMS040', '2012-11-02', NULL, '2012-11-02', NULL, '1000000000', NULL, NULL, NULL, NULL, NULL),
	('특별근태적용 회사코드', 'ssomon', 'Y', '1', 'KMS041', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('적용시작', '20130325', 'Y', '2', 'KMS041', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('적용종료', '20130331', 'Y', '3', 'KMS041', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('출근시간', '09:30:00', 'Y', '4', 'KMS041', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '5', 'KMS042', '2013-08-01', '178', '2013-08-01', '178', NULL, NULL, NULL, NULL, NULL, NULL),
	('전화', '전화', 'Y', '1', 'KMS043', '2014-04-07', NULL, '2014-04-07', NULL, NULL, NULL, NULL, NULL, NULL, 10),
	('이메일', '이메일', 'Y', '2', 'KMS043', '2014-04-07', NULL, '2014-04-07', NULL, NULL, NULL, NULL, NULL, NULL, 20),
	('카톡', '카톡', 'Y', '3', 'KMS043', '2014-04-07', NULL, '2014-04-07', NULL, NULL, NULL, NULL, NULL, NULL, 30),
	('기타', '기타', 'Y', '4', 'KMS043', '2014-04-07', NULL, '2014-04-07', NULL, NULL, NULL, NULL, NULL, NULL, 40),
	('내부', '내부', 'Y', '0', 'KMS044', '2015-04-02', NULL, '2015-04-02', NULL, NULL, NULL, NULL, NULL, NULL, 10),
	('외부', '외부', 'Y', '1', 'KMS044', '2015-04-02', NULL, '2015-04-02', NULL, NULL, NULL, NULL, NULL, NULL, 20),
	('보다', '보다', 'Y', '1', 'KMS045', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('프로그램 설치', '프로그램 설치', 'Y', '1', 'KMS046', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('로그인(계정)', '로그인(계정)', 'Y', '2', 'KMS046', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('개설/입장', '개설/입장', 'Y', '3', 'KMS046', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('품질(네트워크)', '품질(네트워크)', 'Y', '4', 'KMS046', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('비디오', '비디오', 'Y', '5', 'KMS046', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('오디오', '오디오', 'Y', '6', 'KMS046', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('문서공유', '문서공유', 'Y', '7', 'KMS046', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('기타', '기타', 'Y', '8', 'KMS046', '2021-07-23', NULL, '2021-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

CREATE TABLE IF NOT EXISTS `comtecopseq` (
  `TABLE_NAME` varchar(20) NOT NULL,
  `NEXT_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `comtecopseq` (`TABLE_NAME`, `NEXT_ID`) VALUES
	('ADBKUSER_ID', 1),
	('ADBK_ID', 1),
	('ADMINIST_WORD_ID', 1),
	('ADMIN_CODE_OPERT', 1),
	('BANNER_ID', 1),
	('BBS_ID', 1),
	('CLB_ID', 1),
	('CMMNTY_ID', 1),
	('CNSLT_ID', 1),
	('CNTC_ID', 1),
	('CNTC_MESSAGE_ID', 1),
	('CNTNTS_ID', 1),
	('COMTECOPSEQ', 1),
	('CPYRHT_ID', 1),
	('DIARY_ID', 1),
	('DUS_ID', 1),
	('EVENTINFO_ID', 1),
	('EXTRLHRINFO_ID', 1),
	('FAQ_ID', 1),
	('FILE_ID', 1),
	('GROUP_ID', 1),
	('HPCM_ID', 1),
	('INDVDL_INFO_ID', 1),
	('INSTT_CODE_OPERT', 1),
	('INSTT_ID', 1),
	('ISG_ID', 1),
	('ITEM_ID', 1),
	('LOGINLOG_ID', 1),
	('LSI_ID', 1),
	('MAILMSG_ID', 1),
	('MSI_ID', 1),
	('MTG_ID', 1),
	('NCRD_ID', 1),
	('NEWS_ID', 1),
	('ONLINE_MUL_ID', 1),
	('POLL_IEM_ID', 1),
	('POLL_MGR_ID', 1),
	('POLL_RUT_ID', 1),
	('POPUP_ID', 1),
	('QA_ID', 1),
	('QESITM_', 1),
	('QESRSPNS_ID', 1),
	('QESTNR_QESITM_ID', 1),
	('QESTNR_RPD_ID', 1),
	('QUSTNRQESTN_ID', 1),
	('QUSTNRTMPLA_ID', 1),
	('RECOMEND_SITE_ID', 1),
	('RESTDE_ID', 1),
	('ROLE_ID', 1),
	('RS_ID', 1),
	('SCHDUL_ID', 1),
	('SCRAP_ID', 1),
	('SITE_ID', 1),
	('SMS_ID', 1),
	('SRCHWRD_ID', 1),
	('SRCHWRD_MANAGEID', 1),
	('SRCHWRD_MANAGE_I', 1),
	('SVC_ID', 1),
	('SYSLOG_ID', 1),
	('SYS_ID', 1),
	('TEST1', 1),
	('TMPLAT_ID', 1),
	('TRSMRCVLOG_ID', 1),
	('UNITY_LINK_ID', 1),
	('USE_STPLAT_ID', 1),
	('USRCNFRM_ID', 1),
	('WEBLOG_ID', 1),
	('WORD_ID', 1),
	('APPROVAL_ID', 1),
	('MAIL_ID', 1),
	('NOTE_ID', 1),
	('Schedule_ID', 1),
	('Banner_ID', 1),
	('Expansion_ID', 1),
	('ORGAN_ID', 1),
	('SCORE_ID', 1),
	('WS_ID', 1),
	('PRJ_ID', 1),
	('TASK_ID', 1),
	('BUSINESS_CONTACT_ID', 1),
	('ACCOUNT_ID', 1),
	('CUST_ID', 1),
	('PRESET_ID', 1),
	('EXP_ID', 1),
	('MEETING_ROOM_ID', 1),
	('MISSION_ID', 1),
	('PRODUCT_ID', 1),
	('PART_ID', 1),
	('REQUEST_ID', 1),
	('OUTPUT_ID', 1);

CREATE TABLE IF NOT EXISTS `comtnauthorrolerelate` (
  `AUTHOR_CODE` varchar(30) NOT NULL,
  `ROLE_CODE` varchar(50) NOT NULL DEFAULT '',
  `CREAT_DT` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `comtnbbs` (
  `NTT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `BBS_ID` char(20) NOT NULL,
  `NTCR_ID` varchar(20) DEFAULT NULL,
  `SORT_ORDR` decimal(8,0) DEFAULT NULL COMMENT '정렬인자',
  `NTCR_NM` varchar(20) DEFAULT NULL,
  `PASSWORD` varchar(2000) DEFAULT NULL,
  `NTT_SJ` varchar(2400) DEFAULT NULL,
  `NTT_CN` mediumtext DEFAULT NULL,
  `INQIRE_CO` decimal(9,0) DEFAULT NULL COMMENT '조회수',
  `USE_AT` char(1) NOT NULL,
  `NTCE_BGNDE` char(8) DEFAULT NULL,
  `NTCE_ENDDE` char(8) DEFAULT NULL,
  `FRST_REGISTER_PNTTM` datetime NOT NULL,
  `LAST_UPDUSR_PNTTM` datetime DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) NOT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `REPLY_AT` char(1) DEFAULT NULL,
  `PARNTS` decimal(10,0) DEFAULT NULL,
  `NTT_NO` decimal(10,0) DEFAULT NULL,
  `REPLY_LC` decimal(8,0) DEFAULT NULL,
  `ATCH_FILE_ID` char(20) DEFAULT NULL,
  `EX_CHK` char(1) DEFAULT NULL COMMENT '토론게시판 종료 여부:YN || 건의/제안 상태: 검토중E 평가보류H 채택C 기각R 처리완료F',
  `EX_CHK_TM` datetime DEFAULT NULL COMMENT '토론게시판 토론종료 시간',
  `EX_DT` varchar(8) DEFAULT NULL COMMENT '경조사게시판 날짜',
  `EX_HM` varchar(4) DEFAULT NULL COMMENT '경조사게시판 시간',
  `ORGNZT_ID` char(20) DEFAULT NULL COMMENT '주간업무보고용',
  `PRJ_ID` char(20) DEFAULT NULL COMMENT '프로젝트게시판용',
  `MOBILE_REG_CHK` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL COMMENT '모바일에서 게시글 등록 여부',
  `COMPANY` char(5) DEFAULT NULL COMMENT '회사자료 - 회사구분',
  `boardID` int(10) DEFAULT NULL COMMENT '구NKMS데이터이전',
  PRIMARY KEY (`NTT_ID`,`BBS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `comtnbbsmaster` (
  `BBS_ID` char(20) NOT NULL,
  `BBS_TY_CODE` char(6) NOT NULL,
  `LAST_UPDUSR_PNTTM` date DEFAULT NULL,
  `USE_AT` char(1) NOT NULL,
  `FRST_REGISTER_PNTTM` date NOT NULL,
  `FRST_REGISTER_ID` varchar(20) NOT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `BBS_ATTRB_CODE` char(6) NOT NULL,
  `BBS_NM` varchar(120) NOT NULL,
  `REPLY_POSBL_AT` char(1) DEFAULT NULL,
  `FILE_ATCH_POSBL_AT` char(1) NOT NULL,
  `POSBL_ATCH_FILE_NUMBER` decimal(2,0) NOT NULL,
  `POSBL_ATCH_FILE_SIZE` varchar(8) DEFAULT NULL,
  `BBS_INTRCN` varchar(2400) DEFAULT NULL,
  `TMPLAT_ID` char(20) DEFAULT NULL,
  PRIMARY KEY (`BBS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `comtnbbsmaster` (`BBS_ID`, `BBS_TY_CODE`, `LAST_UPDUSR_PNTTM`, `USE_AT`, `FRST_REGISTER_PNTTM`, `FRST_REGISTER_ID`, `LAST_UPDUSR_ID`, `BBS_ATTRB_CODE`, `BBS_NM`, `REPLY_POSBL_AT`, `FILE_ATCH_POSBL_AT`, `POSBL_ATCH_FILE_NUMBER`, `POSBL_ATCH_FILE_SIZE`, `BBS_INTRCN`, `TMPLAT_ID`) VALUES
	('BBSMSTR_000000000001', 'COMM', NULL, 'Y', '2011-12-01', '1', NULL, 'COMMON', '자유게시판', 'Y', 'Y', 3, '', '자유게시판', '1'),
	('BBSMSTR_000000000002', 'ADMN', NULL, 'Y', '2011-12-01', '1', NULL, 'COMMON', '관리자게시판', 'Y', 'Y', 3, NULL, '관리자게시판', '1'),
	('BBSMSTR_000000000003', 'ADMN', NULL, 'Y', '2015-02-12', 'dwkim', NULL, 'COMMON', '도움말툴팁게시판', 'N', 'N', 3, NULL, '도움말툴팁게시판', '1'),
	('BBSMSTR_000000000028', 'EVNT', NULL, 'Y', '2012-07-09', '1', NULL, 'IMAGES', '한마음이벤트-이미지게시판', 'Y', 'Y', 10, NULL, '한마음이벤트-이미지게시판', '1'),
	('BBSMSTR_000000000029', 'COMM', NULL, 'Y', '2011-12-01', '1', NULL, 'DISCUS', '토론', 'Y', 'Y', 3, '', '토론', '1'),
	('BBSMSTR_000000000030', 'COMM', NULL, 'Y', '2011-12-01', '1', NULL, 'SCHDL', '경조사', 'Y', 'Y', 3, '', '경조사', '1'),
	('BBSMSTR_000000000031', 'SPRT', NULL, 'Y', '2011-12-01', '1', NULL, 'COMMON', '공지사항', 'Y', 'Y', 3, '', '공지사항', '1'),
	('BBSMSTR_000000000033', 'SPRT', NULL, 'Y', '2011-12-01', '1', NULL, 'COMMON', '알림공지', 'Y', 'Y', 3, NULL, '알림공지', '1'),
	('BBSMSTR_000000000034', 'COMM', NULL, 'Y', '2012-09-10', '1', NULL, 'COMMON', '개발TIP', 'Y', 'Y', 3, NULL, '개발TIP', NULL),
	('BBSMSTR_000000000050', 'SPRT', NULL, 'Y', '2012-04-09', '1', NULL, 'COMMON', '회사자료', 'Y', 'Y', 3, NULL, '회사자료', NULL),
	('BBSMSTR_000000000051', 'SPRT', NULL, 'Y', '2012-09-10', '1', NULL, 'COMMON', '솔루션자료', 'Y', 'Y', 3, NULL, '솔루션자료', NULL),
	('BBSMSTR_000000000052', 'SPRT', NULL, 'Y', '2012-09-10', '1', NULL, 'COMMON', '각종양식', 'Y', 'Y', 3, NULL, '각종양식', NULL),
	('BBSMSTR_000000000053', 'SPRT', NULL, 'Y', '2012-09-10', '1', NULL, 'COMMON', '업무처리절차', 'Y', 'Y', 3, NULL, '업무처리절차', NULL),
	('BBSMSTR_000000000061', 'SPRT', NULL, 'Y', '2011-12-01', '1', NULL, 'SGST', '한마음 개선요청', 'Y', 'Y', 3, '', 'KMS개선요청', '1'),
	('BBSMSTR_000000000062', 'SPRT', NULL, 'Y', '2011-12-01', '1', NULL, 'SGST', '건의/제안', 'Y', 'Y', 3, NULL, '건의/제안', '1'),
	('BBSMSTR_000000000071', 'COOP', NULL, 'Y', '2011-12-01', '1', NULL, 'WKRPRT', '주간업무보고', 'Y', 'Y', 3, '', '주간업무보고', '1'),
	('BBSMSTR_000000000072', 'COOP', NULL, 'Y', '2011-12-01', '1', NULL, 'PRJBBS', '프로젝트게시판', 'Y', 'Y', 3, '', '프로젝트게시판', '1'),
	('BBSMSTR_000000000073', 'COMM', NULL, 'Y', '2011-12-01', '1', NULL, 'COMMON', '테스트', 'Y', 'Y', 3, NULL, '테스트', '1'),
	('BBSMSTR_000000000080', 'EXPS', NULL, 'Y', '2012-03-05', '1', NULL, 'SGST', '화상회의 차기버전 기능개선 요청', 'Y', 'Y', 3, NULL, '화상회의 차기버전에 대한 임직원 여러분들의 기능개선 의견을 접수하고 처리하기 위한 게시판입니다.', '1'),
	('BBSMSTR_000000000081', 'COMM', NULL, 'Y', '2013-09-23', '1', NULL, 'COMMON', '상품정보', 'Y', 'Y', 3, NULL, '상품정보', '1'),
	('BBSMSTR_000000000082', 'COMM', NULL, 'Y', '2013-11-15', '1', NULL, 'GOODMO', '첫출근 인사말', 'N', 'N', 0, NULL, '첫출근 인사말', '1'),
	('BBSMSTR_000000000083', 'COMM', NULL, 'Y', '2014-02-13', '1', NULL, 'COMMON', '제안게시판', 'Y', 'Y', 3, NULL, '제안게시판', '1'),
	('BBSMSTR_000000000085', 'COMM', NULL, 'Y', '2017-08-01', '2', NULL, 'SOLBBS', '솔루션 게시판', 'Y', 'Y', 3, NULL, '솔루션에 관한 정보를 공유하는 게시판입니다', '1');

CREATE TABLE IF NOT EXISTS `comtnbbsuse` (
  `FRST_REGISTER_PNTTM` date DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) NOT NULL,
  `LAST_UPDUSR_PNTTM` date DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `USE_AT` char(1) NOT NULL,
  `REGIST_SE_CODE` char(6) DEFAULT NULL,
  `BBS_ID` char(20) NOT NULL,
  `TRGET_ID` char(20) NOT NULL,
  KEY `NewIndex1` (`BBS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `comtnbbsuse` (`FRST_REGISTER_PNTTM`, `FRST_REGISTER_ID`, `LAST_UPDUSR_PNTTM`, `LAST_UPDUSR_ID`, `USE_AT`, `REGIST_SE_CODE`, `BBS_ID`, `TRGET_ID`) VALUES
	('2011-12-01', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000001', 'SYSTEM_DEFAULT_BOARD'),
	('2011-12-01', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000031', 'SYSTEM_DEFAULT_BOARD'),
	('2011-12-01', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000029', 'SYSTEM_DEFAULT_BOARD'),
	('2011-12-01', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000030', 'SYSTEM_DEFAULT_BOARD'),
	('2011-12-01', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000032', 'SYSTEM_DEFAULT_BOARD'),
	('2011-12-01', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000072', 'SYSTEM_DEFAULT_BOARD'),
	('2011-12-01', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000071', 'SYSTEM_DEFAULT_BOARD'),
	('2011-12-01', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000061', 'SYSTEM_DEFAULT_BOARD'),
	('2011-12-01', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000033', 'SYSTEM_DEFAULT_BOARD'),
	('2011-12-01', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000062', 'SYSTEM_DEFAULT_BOARD'),
	('2011-12-01', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000002', 'SYSTEM_DEFAULT_BOARD'),
	('2012-07-09', '1', NULL, NULL, 'Y', 'REGC01', 'BBSMSTR_000000000028', 'SYSTEM_DEFAULT_BOARD');

CREATE TABLE IF NOT EXISTS `comtncomment` (
  `COMMENT_NO` bigint(20) NOT NULL AUTO_INCREMENT,
  `NTT_ID` decimal(20,0) NOT NULL,
  `BBS_ID` char(20) NOT NULL,
  `WRTER_NO` int(11) DEFAULT NULL,
  `PASSWORD` varchar(2000) DEFAULT NULL,
  `COMMENT_CN` mediumtext NOT NULL,
  `USE_AT` char(1) NOT NULL,
  `FRST_REGISTER_PNTTM` datetime NOT NULL,
  `LAST_UPDUSR_PNTTM` datetime DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) NOT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `ATCH_FILE_ID` char(20) DEFAULT NULL,
  PRIMARY KEY (`COMMENT_NO`),
  KEY `NewIndex1` (`NTT_ID`,`BBS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `comtnfile` (
  `CREAT_DT` date NOT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `ATCH_FILE_ID` char(20) NOT NULL,
  KEY `IDX_ATCH_FILE_ID` (`ATCH_FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `comtnfiledetail` (
  `FILE_SN` varchar(10) NOT NULL,
  `FILE_STRE_COURS` varchar(2000) NOT NULL,
  `STRE_FILE_NM` varchar(255) NOT NULL,
  `ORIGNL_FILE_NM` varchar(255) DEFAULT NULL,
  `FILE_EXTSN` varchar(20) NOT NULL,
  `FILE_MG` decimal(8,0) DEFAULT NULL,
  `FILE_CN` mediumtext DEFAULT NULL,
  `ATCH_FILE_ID` char(20) NOT NULL,
  KEY `IDX_ATCH_FILE_ID` (`ATCH_FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `comtnroleinfo` (
  `ROLE_CODE` varchar(50) NOT NULL,
  `ROLE_NM` varchar(50) DEFAULT NULL,
  `ROLE_PTN` varchar(300) DEFAULT NULL,
  `ROLE_DC` varchar(100) DEFAULT NULL,
  `ROLE_TYP` varchar(50) DEFAULT NULL,
  `ROLE_SORT` int(11) DEFAULT NULL,
  `ROLE_CREAT_DE` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `comtnroles_hierarchy` (
  `PARENT_ROLE` varchar(30) NOT NULL,
  `CHILD_ROLE` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `comtnroles_hierarchy` (`PARENT_ROLE`, `CHILD_ROLE`) VALUES
	('ROLE_ANONYMOUS', 'IS_AUTHENTICATED_ANONYMOUSLY'),
	('IS_AUTHENTICATED_REMEMBERED', 'IS_AUTHENTICATED_FULLY'),
	('IS_AUTHENTICATED_ANONYMOUSLY', 'IS_AUTHENTICATED_REMEMBERED'),
	('ROLE_USER', 'ROLE_ADMIN'),
	('IS_AUTHENTICATED_FULLY', 'ROLE_RESTRICTED'),
	('ROLE_RESTRICTED', 'ROLE_USER');

DELIMITER //
CREATE FUNCTION `FN_CREATE_ORGAN_FNM`(argOrgnztId VARCHAR(20)) RETURNS varchar(500) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
DECLARE orgnztFullNm VARCHAR(500);    
DECLARE orgnztNm VARCHAR(100);
DECLARE prntOrgnztId VARCHAR(100);
DECLARE sn VARCHAR(1000);
SET orgnztFullNm = '';
   SELECT FN_ORGAN_TREE(ORGNZT_ID)
    INTO   sn
    FROM   TBL_ORGNZT 
    WHERE  ORGNZT_ID = argOrgnztId;
    #최상위 3개부서는 자기 이름이 나오도록
IF LENGTH(SN)<=21 THEN SET SN = argOrgnztId; END IF;
IF LENGTH(SN)>21 THEN SET SN = SUBSTR(SN,22); END IF;
WHILE LENGTH(sn)>=20 DO
	SET prntOrgnztId = SUBSTR(sn,1,20);
	SET SN = SUBSTR(sn,22);
	
	SELECT ORGNZT_NM
	INTO OrgnztNm
	FROM TBL_ORGNZT
	WHERE ORGNZT_ID = prntOrgnztId;
	
	SET orgnztFullNm = CONCAT(orgnztFullNm,OrgnztNm," ");
END WHILE;
 SET orgnztFullNm = SUBSTR(orgnztFullNm,1,LENGTH(orgnztFullNm)-1); #LENGTH에서 한글은 3으로 치는 버그있음. 결국 마지막 공백 안잘림
 RETURN  orgnztFullNm;
  
 END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_CREATE_ORGAN_FNM2`(argOrgnztId VARCHAR(20)) RETURNS varchar(500) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
DECLARE orgnztFullNm VARCHAR(500);    
DECLARE orgnztNm VARCHAR(100);
DECLARE prntOrgnztId VARCHAR(100);
DECLARE sn VARCHAR(1000);
SET orgnztFullNm = '';
   SELECT FN_ORGAN_TREE(ORGNZT_ID)
    INTO   sn
    FROM   TBL_ORGNZT 
    WHERE  ORGNZT_ID = argOrgnztId;
    #최상위 3개부서는 자기 이름이 나오도록
IF LENGTH(SN)<=21 THEN SET SN = argOrgnztId; END IF;
IF LENGTH(SN)>21 THEN SET SN = SUBSTR(SN,22); END IF;
WHILE LENGTH(sn)>=20 DO
	SET prntOrgnztId = SUBSTR(sn,1,20);
	SET SN = SUBSTR(sn,22);
	
	SELECT ORGNZT_NM
	INTO OrgnztNm
	FROM TBL_ORGNZT
	WHERE ORGNZT_ID = prntOrgnztId;
	
	SET orgnztFullNm = CONCAT(orgnztFullNm," > ",OrgnztNm);
END WHILE;
 SET orgnztFullNm = SUBSTR(orgnztFullNm,4,LENGTH(orgnztFullNm));
 RETURN  orgnztFullNm;
  
 END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_CREATE_PRJ_CD`($prjId VARCHAR(20)) RETURNS varchar(500) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
    
DECLARE $prjCd VARCHAR(500);
DECLARE $snm VARCHAR(500);
DECLARE $num VARCHAR(500);
DECLARE $prntPrjId VARCHAR(20);
SET $prjCd = '';
SELECT PRNT_PRJ_ID
INTO $prntPrjId
FROM TBL_PRJ
WHERE PRJ_ID = $prjId;
CASE 
WHEN $prjId = $prntPrjId
THEN 
	SELECT b.ORGNZT_SNM, b.CUR_MAX_PRJ_CD
	INTO   $snm, $num
	FROM  TBL_PRJ a 
	INNER JOIN TBL_ORGNZT AS b
		ON a.ORGNZT_ID = b.ORGNZT_ID
	WHERE  a.PRJ_ID = $prjId;
	SET $prjCd = CONCAT($snm,"-",$num);
	
ELSE
	SELECT PRJ_CD, CUR_MAX_PRJ_CD
	INTO $snm, $num
	FROM TBL_PRJ
	WHERE PRJ_ID = $prntPrjId;
	SET $prjCd = CONCAT($snm,".",$num);
END CASE;
RETURN $prjCd;
  
 END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_DATE_LIST`($sDate CHAR(8), $eDate CHAR(8)) RETURNS text CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	WHILE ($sDate <= $eDate) DO
		INSERT INTO TBL_CALENDAR_DATA
		(
			CAL_YEAR, CAL_MONTH, CAL_DAY, CAL_DATE
		) VALUES (
			SUBSTRING($sDate,1,4),SUBSTRING($sDate,5,6),SUBSTRING($sDate,7,8),$sDate
		);
		
		SET $sDate = DATE_FORMAT(DATE_ADD($sDate, INTERVAL 1 DAY), '%Y%m%d');
	END WHILE;
	
	return 1;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_DEFAULT_PRJ_ID`($ORGNZT_ID CHAR(20)) RETURNS char(20) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE defaultPrjId CHAR(20);
	DECLARE orgnztId CHAR(20) DEFAULT $ORGNZT_ID;
	IF orgnztId IS NULL OR orgnztId = ''
	THEN SET orgnztId = 'ORGAN_00000000000000';
	END IF;
	
	SELECT DEFAULT_PRJ_ID
	INTO defaultPrjId
	FROM TBL_ORGNZT
	WHERE ORGNZT_ID = orgnztId;
	
	WHILE defaultPrjId IS NULL OR defaultPrjId = '' DO
		SELECT ORG_UP
		INTO orgnztId
		FROM TBL_ORGNZT
		WHERE ORGNZT_ID = orgnztId;
		
		SELECT DEFAULT_PRJ_ID
		INTO defaultPrjId
		FROM TBL_ORGNZT
		WHERE ORGNZT_ID = orgnztId;
	END WHILE;
	RETURN defaultPrjId;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_BUDGET_PRJ`($prjId VARCHAR(20)) RETURNS varchar(20) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN    
DECLARE $curPrjId VARCHAR(20);
DECLARE $prntPrjId VARCHAR(20);
DECLARE $budgetExceedRule CHAR(1);
DECLARE $ctr int;
SET $ctr = 0;
SET $curPrjId =$prjId;
firstLoop : LOOP
	SELECT PRNT_PRJ_ID, BUDGET_EXCEED_RULE
	INTO $prntPrjId, $budgetExceedRule
	FROM TBL_PRJ
	WHERE PRJ_ID = $curPrjId;
	
	IF "Y"=$budgetExceedRule OR $curPrjId = $prntPrjId 
	THEN 
		RETURN $curPrjId;	
	ELSE
		SET $curPrjId = $prntPrjId;
	END IF;
	
	#무한루프 방지 40단계 이상 돌면 에러
	SET $ctr = $ctr + 1;
	IF $ctr > 40 THEN
		RETURN 'ERROR';
	END IF;
END LOOP firstLoop;
 END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_COMPID_HISTORY`($USER_NO INT, $yyyymmdd CHAR(8)) RETURNS varchar(20) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result VARCHAR(20) DEFAULT '';
	
	SELECT
		IFNULL(a.AFT_COMP_ID, '')
	INTO result
	FROM
		TBL_POSITION_HISTORY a
	WHERE
		a.USER_NO = $USER_NO
		AND a.CHNG_DT <= $yyyymmdd
	ORDER BY a.CHNG_DT DESC, a.NO DESC
	LIMIT 1;
	
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_COMPNM_HISTORY`($USER_NO INT, $yyyymmdd CHAR(8)) RETURNS varchar(60) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result VARCHAR(60) DEFAULT '';
	
	SELECT
		IFNULL(b.CODE_NM, '')
	INTO result
	FROM
		TBL_POSITION_HISTORY a
		LEFT JOIN COMTCCMMNDETAILCODE b
			ON a.AFT_COMP_ID = b.CODE
			AND b.CODE_ID = 'KMS007'
	WHERE
		a.USER_NO = $USER_NO
		AND a.CHNG_DT <= $yyyymmdd
	ORDER BY a.CHNG_DT DESC, a.NO DESC
	LIMIT 1;
	
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_DATE`($yyyymm CHAR(6), $d INT) RETURNS char(8) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE ddInt INT DEFAULT IFNULL($d, 1);
	DECLARE dd CHAR(2) DEFAULT LPAD(ddInt, 2, '0');
	DECLARE yyyymmdd CHAR(8) DEFAULT CONCAT($yyyymm, dd);
	
	WHILE (DATE_FORMAT(yyyymmdd, '%Y%m%d') IS NULL) DO
		SET ddInt = ddInt - 1;
		SET dd = LPAD(ddInt,2,'0');
		SET yyyymmdd = CONCAT($yyyymm, dd);
	END WHILE;
	
	RETURN CONCAT($yyyymm, dd);
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_DECIDER`($templtId char(20),$userNo int(11)) RETURNS varchar(1000) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
    DECLARE $rule1 int;
    DECLARE $rule2 INT;
    DECLARE $rule3 INT;
    DECLARE $rule4 INT;
    DECLARE $rule5 INT;
    DECLARE $sn varchar(500);
    DECLARE $orgId varchar(20);
     DECLARE $orgCnt int;
    DECLARE $deciderMix varchar(20);
    DECLARE $reviewerMix varchar(500);
    DECLARE $reviewerMixs VARCHAR(500);
    DECLARE $aa int;
    SET $deciderMix = "";
    SET $reviewerMix = "";
    SET $reviewerMixs = "";
    SELECT 
	DECIDER_RULE1
	,DECIDER_RULE2
	,DECIDER_RULE3
	,DECIDER_RULE4
	,DECIDER_RULE5
    INTO 
	$rule1, $rule2, $rule3,$rule4,$rule5
    FROM TBL_EAPP_DOCTYP
    WHERE TEMPLT_ID = $templtId;
	
    SELECT CONCAT(FN_ORGAN_TREE(ORGNZT_ID),'/'), FN_STR_COUNT(CONCAT(FN_ORGAN_TREE(ORGNZT_ID),'/'),'/')
    INTO $sn, $orgCnt
    FROM TBL_USERINFO
    WHERE
	NO = $userNo;
    
   CASE WHEN $rule1 = 1
    THEN
	WHILE LENGTH($sn)>20 DO
		
		SET $orgId = SUBSTR($sn,1,20);
		SET $sn = SUBSTR($sn,22);
		INSERT INTO TBL_LOG (name,value) values('orgId',$orgId);
		CASE  
			WHEN $rule2 = 0 THEN
				SELECT CONCAT(USER_NM,"(",USER_ID,")")
				INTO $deciderMix
				FROM TBL_USERINFO a
				WHERE ORGNZT_ID = $orgId
					AND (POSITION = 'H' OR POSITION = 'S')
				ORDER BY POSITION ASC
				LIMIT 0,1;
				IF $deciderMix !="" THEN SET $rule2 = $rule2 -1; END if;
				
			WHEN $rule2 < 0 THEN
				SELECT CONCAT(USER_NM,"(",USER_ID,")")
				INTO $reviewerMix
				FROM TBL_USERINFO a
				WHERE ORGNZT_ID = $orgId
					AND (POSITION = 'H' OR POSITION = 'S')
				ORDER BY POSITION ASC
				LIMIT 0,1;
				IF $reviewerMix !="" && LOCATE($reviewerMixs, $reviewerMix) >0
					THEN set $reviewerMixs = CONCAT($reviewerMixs,$reviewerMix,",");
				END IF;     
		END CASE ;
		
	END WHILE;
    ELSE
	SET $aa = 1 + 21 * ($orgCnt - ($rule3 +1));
	SET $sn = SUBSTR($sn, 1 + 21 * ($orgCnt - ($rule3 +1)));
    END cASE;
    
    RETURN CONCAT($deciderMix,"/",$reviewerMixs);
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_EXP`($id VARCHAR(20),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			EXP_SPEND COST
		FROM TBL_EAPP_EXP a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		# includeResult check
		AND (($includeResultBool = TRUE AND b.DOC_STAT IN ('APP001','APP002','APP003')) OR b.NEW_AT = 1)
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		INNER JOIN TBL_ACCOUNT d ON a.ACC_ID = d.ACC_ID
		INNER JOIN TBL_ACCOUNT e ON d.PRNT_ACC_ID = e.ACC_ID AND e.PRNT_TYP = 'E'
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR EXP_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR EXP_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR c.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR c.PRJ_ID = $id)
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR c.ORGNZT_ID = $id )
		
		UNION ALL
		
		SELECT
			 a.COST AS COST
		FROM TBL_EAPP_HOL a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		# includeResult check
		AND (($includeResultBool = TRUE AND b.DOC_STAT IN ('APP001','APP002','APP003')) OR b.NEW_AT = 1)
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR a.ST_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR a.ST_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR c.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR c.PRJ_ID = $id)
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR c.ORGNZT_ID = $id )
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_EXP_ARR`($id VARCHAR(400),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			EXP_SPEND COST
		FROM TBL_EAPP_EXP a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		# includeResult check
		AND (($includeResultBool = TRUE AND b.DOC_STAT IN ('APP001','APP002','APP003')) OR b.NEW_AT = 1)
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		INNER JOIN TBL_ACCOUNT d ON a.ACC_ID = d.ACC_ID
		INNER JOIN TBL_ACCOUNT e ON d.PRNT_ACC_ID = e.ACC_ID AND e.PRNT_TYP = 'E'
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR EXP_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR EXP_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, c.PRJ_ID) = 1)
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',c.PRJ_ID,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',c.ORGNZT_ID,'%'))
		
		UNION ALL
		
		SELECT
			 a.COST AS COST
		FROM TBL_EAPP_HOL a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		# includeResult check
		AND (($includeResultBool = TRUE AND b.DOC_STAT IN ('APP001','APP002','APP003')) OR b.NEW_AT = 1)
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR a.ST_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR a.ST_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, c.PRJ_ID) = 1)
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',c.PRJ_ID,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',c.ORGNZT_ID,'%'))
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_LABOR`($id VARCHAR(20), $YEAR CHAR(4), $MONTH CHAR(2)
	, $includeResult CHAR(1), $common CHAR(1), $sub CHAR(1), $total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	#인건비 관련 쿼리는 크게 FN_GET_LABOR 와 FN_GET_LABOR_ARR 실시간, FN_GET_SALARY 세 가지 Functions
	SELECT		
		IFNULL(SUM(PRJ_SALARY),0) AS SALARY
	INTO
		$result
	FROM (
		SELECT
			DR.PRJ_ID AS PRJ_ID
			#,YM
			, SUBSTR(DR.WRITE_DATE, 5, 2)
			, DR.WRITER_NO AS USER_NO
			, IF(IFNULL(SAL_USER.SALARY2, 0) = 0, IFNULL(SAL_USER.SALARY1, IFNULL(SAL_RANK.SALARY, 0))	, SAL_USER.SALARY2) AS USER_SALARY
			, IFNULL(SUM(IFNULL(DR.WORK_HOUR, 0)), 0) AS PRJ_TM
			, IFNULL(IFNULL(SUM(IFNULL(DR.WORK_HOUR, 0)), 0) / TMP.WORK_HOUR_SUM, 0)
			#* IFNULL(ARS.USER_WORK_DAY / ARS.TOTAL_WORK_DAY, 0) #2013-03-22 사장님 지시로 제거. 중도 입사 퇴사 휴직 월급여 조정은 경영기획실에서 입력
			* IF(IFNULL(SAL_USER.SALARY2, 0) = 0, IFNULL(SAL_USER.SALARY1, IFNULL(SAL_RANK.SALARY, 0))	, SAL_USER.SALARY2) AS PRJ_SALARY
		FROM
			hm_daily_result DR
			INNER JOIN TBL_PRJ PRJ
				ON PRJ.PRJ_ID = DR.PRJ_ID
				#sub check
				AND ($subBool1 = TRUE OR PRJ.ORG_PRJ_TREE LIKE CONCAT('%', $id, '%'))
				AND ($subBool1 = FALSE OR $subBool2 = TRUE OR PRJ.PRJ_ID = $id)
				AND ($subBool1 = FALSE OR $subBool2 = FALSE OR PRJ.ORGNZT_ID = $id)
			INNER JOIN TBL_USERINFO USR
				ON DR.WRITER_NO = USR.NO
			LEFT JOIN TBL_USER_SALARY SAL_USER
				ON DR.WRITER_NO = SAL_USER.USER_NO
				AND SAL_USER.YEAR = $YEAR #2013
				#total check
				#AND IF(FALSE = TRUE, SAL_USER.MONTH <= LPAD('02', 2, '0'), SAL_USER.MONTH = LPAD('02', 2, '0'))
				AND IF($totalBool = TRUE, SAL_USER.MONTH <= LPAD($MONTH, 2, '0'), SAL_USER.MONTH = LPAD($MONTH, 2, '0'))
				AND SAL_USER.MONTH = SUBSTR(DR.WRITE_DATE, 5, 2)
			LEFT JOIN TBL_RANK_SALARY SAL_RANK
				ON USR.RANK_ID = SAL_RANK.RANK_CODE
				AND SAL_RANK.YEAR = $YEAR #2013
				#total check
				#AND IF(FALSE = TRUE, SAL_RANK.MONTH <= LPAD('02', 2, '0'), SAL_RANK.MONTH = LPAD('02', 2, '0'))
				AND IF($totalBool = TRUE, SAL_RANK.MONTH <= LPAD($MONTH, 2, '0'), SAL_RANK.MONTH = LPAD($MONTH, 2, '0'))
				AND SAL_RANK.MONTH = SUBSTR(DR.WRITE_DATE, 5, 2)
			JOIN (
				SELECT 
					dr2.WRITER_NO						AS WRITER_NO,
					SUM(dr2.WORK_HOUR)				AS WORK_HOUR_SUM
				FROM hm_daily_result dr2
				WHERE
					TRUE
					AND SUBSTR(dr2.WRITE_DATE, 1, 6) = CONCAT($YEAR , LPAD($MONTH, 2, '0'))
				GROUP BY dr2.WRITER_NO
				) TMP
				ON DR.WRITER_NO = TMP.WRITER_NO
		WHERE
			DR.WORK_HOUR > 0
			#total check
			#AND IF(FALSE = TRUE, DR.DAY_REPORT_DT BETWEEN CONCAT('2013', '0000') AND CONCAT('2013', LPAD('02', 2, '0'), '31'), 	DR.DAY_REPORT_DT LIKE CONCAT('2013', LPAD('02', 2, '0'), '%'))							
			AND IF($totalBool = TRUE, DR.WRITE_DATE BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31'),	DR.WRITE_DATE LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))							
		GROUP BY
			DR.WRITER_NO, SUBSTR(DR.WRITE_DATE, 5, 2), PRJ_ID
						
	) T;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_LABOR_ARR`($id VARCHAR(400), $YEAR CHAR(4), $MONTH CHAR(2)
	, $includeResult CHAR(1), $common CHAR(1), $sub CHAR(1), $total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT		
		IFNULL(SUM(PRJ_SALARY),0) AS SALARY
	INTO
		$result
	FROM (
		SELECT
			DR.PRJ_ID AS PRJ_ID
			#,YM				
			, SUBSTR(DR.WRITE_DATE, 5, 2)
			, DR.WRITER_NO AS USER_NO
			, IF(IFNULL(SAL_USER.SALARY2, 0) = 0, IFNULL(SAL_USER.SALARY1, IFNULL(SAL_RANK.SALARY, 0))	, SAL_USER.SALARY2) AS USER_SALARY
			, IFNULL(SUM(IFNULL(DR.WORK_HOUR, 0)), 0) AS PRJ_TM
			, IFNULL(IFNULL(SUM(IFNULL(DR.WORK_HOUR, 0)), 0) / TMP.WORK_HOUR_SUM, 0)
			#* IFNULL(ARS.USER_WORK_DAY / ARS.TOTAL_WORK_DAY, 0) #2013-03-22 사장님 지시로 제거. 중도 입사 퇴사 휴직 월급여 조정은 경영기획실에서 입력
			* IF(IFNULL(SAL_USER.SALARY2, 0) = 0, IFNULL(SAL_USER.SALARY1, IFNULL(SAL_RANK.SALARY, 0))	, SAL_USER.SALARY2) AS PRJ_SALARY
		FROM
			hm_daily_result DR
			INNER JOIN TBL_PRJ PRJ
				ON PRJ.PRJ_ID = DR.PRJ_ID
				#sub check
				#AND ($subBool1 = TRUE OR PRJ.ORG_PRJ_TREE LIKE CONCAT('%', $id, '%'))
				#AND ($subBool1 = FALSE OR $subBool2 = TRUE OR PRJ.PRJ_ID = $id)
				#AND ($subBool1 = FALSE OR $subBool2 = FALSE OR PRJ.ORGNZT_ID = $id)
				AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, prj.PRJ_ID) = 1)
				AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, prj.PRJ_ID) = 1)
				AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%', prj.PRJ_ID, '%'))
				AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%', prj.ORGNZT_ID, '%'))				
			INNER JOIN TBL_USERINFO USR
				ON DR.WRITER_NO = USR.NO
			LEFT JOIN TBL_USER_SALARY SAL_USER
				ON DR.WRITER_NO = SAL_USER.USER_NO
				AND SAL_USER.YEAR = $YEAR #2013
				#total check
				#AND IF(FALSE = TRUE, SAL_USER.MONTH <= LPAD('02', 2, '0'), SAL_USER.MONTH = LPAD('02', 2, '0'))
				AND IF($totalBool = TRUE, SAL_USER.MONTH <= LPAD($MONTH, 2, '0'), SAL_USER.MONTH = LPAD($MONTH, 2, '0'))
				AND SAL_USER.MONTH = SUBSTR(DR.WRITE_DATE, 5, 2)			
			LEFT JOIN TBL_RANK_SALARY SAL_RANK
				ON USR.RANK_ID = SAL_RANK.RANK_CODE
				AND SAL_RANK.YEAR = $YEAR #2013
				#total check
				#AND IF(FALSE = TRUE, SAL_RANK.MONTH <= LPAD('02', 2, '0'), SAL_RANK.MONTH = LPAD('02', 2, '0'))
				AND IF($totalBool = TRUE, SAL_RANK.MONTH <= LPAD($MONTH, 2, '0'), SAL_RANK.MONTH = LPAD($MONTH, 2, '0'))
				AND SAL_RANK.MONTH = SUBSTR(DR.WRITE_DATE, 5, 2)		
			JOIN (
				SELECT 
					dr2.WRITER_NO						AS WRITER_NO,
					SUM(dr2.WORK_HOUR)				AS WORK_HOUR_SUM
				FROM hm_daily_result dr2
				WHERE
					TRUE
					AND SUBSTR(dr2.WRITE_DATE, 1, 6) = CONCAT($YEAR , LPAD($MONTH, 2, '0'))
				GROUP BY dr2.WRITER_NO
				) TMP
				ON DR.WRITER_NO = TMP.WRITER_NO
		WHERE
			DR.WORK_HOUR > 0
			#total check
			#AND IF(FALSE = TRUE, DR.DAY_REPORT_DT BETWEEN CONCAT('2013', '0000') AND CONCAT('2013', LPAD('02', 2, '0'), '31'), 	DR.DAY_REPORT_DT LIKE CONCAT('2013', LPAD('02', 2, '0'), '%'))										
			AND IF($totalBool = TRUE, DR.WRITE_DATE BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31'),	DR.WRITE_DATE LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))							
		GROUP BY
			DR.WRITER_NO, SUBSTR(DR.WRITE_DATE, 5, 2), PRJ_ID
						
	) T;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_LABOR_ARR_bak`($id VARCHAR(400),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT		
		IFNULL(SUM(SALARY),0) AS SALARY
	INTO $result
	FROM
		(
		SELECT
			J.PRJ_ID, J.USER_NO,
			J.CAL_MONTH AS MNTH,
			IFNULL(SUM(IFNULL(J.DAY_REPORT_TM,0)) / L.TM, 0) * IFNULL(N.DT_CNT / M.ALL_DT_CNT, 0) * IFNULL(K.SALARY, 0) AS SALARY
		FROM
			(
				SELECT
					cal.CAL_MONTH,
					usr.NO AS USER_NO,
					IFNULL(SUM(a.DAY_REPORT_TM),0) AS DAY_REPORT_TM,
					c.PRJ_ID AS PRJ_ID
				FROM
					(
						TBL_CALENDAR_DATA cal,
						TBL_USERINFO usr
					)
					INNER JOIN TBL_ATTEND_CHECK chk
						ON
							usr.NO = chk.USER_NO
							AND cal.CAL_DATE = chk.ATTEND_DT
							AND (chk.ATTEND_CD !="VC" OR chk.ATTEND_CD IS NULL)
					INNER JOIN TBL_DAY_REPORT a
						ON
							cal.CAL_DATE = a.DAY_REPORT_DT
							AND usr.NO = a.USER_NO
					LEFT JOIN TBL_SCHEDULE b
						ON
							b.SCHE_TYP IN ('H','I','J')
							AND cal.CAL_YEAR = b.SCHE_YEAR
							AND cal.CAL_MONTH = b.SCHE_MONTH
							AND cal.CAL_DAY = b.SCHE_DATE
					INNER JOIN TBL_TASK c ON a.TASK_ID = c.TASK_ID
					INNER JOIN TBL_PRJ d ON c.PRJ_ID = d.PRJ_ID
				WHERE
					CAL_YEAR = $YEAR
					AND DAYOFWEEK(cal.CAL_DATE) IN (2,3,4,5,6)
					AND b.SCHE_ID IS NULL
					AND a.DAY_REPORT_TM > 0
					#total check
					AND ($totalBool = TRUE OR cal.CAL_MONTH  = LPAD($MONTH,2,'0'))
					AND ($totalBool = FALSE OR cal.CAL_MONTH BETWEEN '00' AND LPAD($MONTH,2,'0'))
					#sub check
					AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, d.PRJ_ID) = 1)
					AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',d.PRJ_ID,'%'))
					AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',d.ORGNZT_ID,'%'))
				GROUP BY CAL_MONTH, usr.NO, PRJ_ID
			) J
			LEFT JOIN (
				SELECT
					a.NO AS USER_NO
					,IFNULL(b.SALARY1 + (b.SALARY2*2) + (b.SALARY3*3), c.SALARY) AS SALARY
					,IFNULL(b.MONTH, c.MONTH) AS MONTH
				FROM
					TBL_USERINFO a
					LEFT JOIN TBL_USER_SALARY b ON a.NO = b.USER_NO AND b.YEAR = $YEAR
					LEFT JOIN TBL_RANK_SALARY c ON a.RANK_ID = c.RANK_CODE AND c.YEAR = $YEAR AND (b.MONTH = c.MONTH OR b.MONTH IS NULL)
			) K ON J.USER_NO = K.USER_NO AND J.CAL_MONTH = K.MONTH
			LEFT JOIN (
				SELECT
					USER_NO, CAL_MONTH AS MNTH, SUM(DAY_REPORT_TM) AS TM
				FROM (
					SELECT
						cal.CAL_MONTH, usr.NO AS USER_NO,
						IFNULL(SUM(a.DAY_REPORT_TM),0) AS DAY_REPORT_TM
					FROM
						(
							TBL_CALENDAR_DATA cal,
							TBL_USERINFO usr
						)
						INNER JOIN TBL_ATTEND_CHECK chk
							ON
								usr.NO = chk.USER_NO
								AND cal.CAL_DATE = chk.ATTEND_DT
								AND (chk.ATTEND_CD NOT IN ('VC') OR chk.ATTEND_CD IS NULL)
						INNER JOIN TBL_DAY_REPORT a ON cal.CAL_DATE = a.DAY_REPORT_DT AND usr.NO = a.USER_NO
						LEFT JOIN TBL_SCHEDULE b ON b.SCHE_TYP IN ('H','I','J') AND cal.CAL_YEAR = b.SCHE_YEAR AND cal.CAL_MONTH = b.SCHE_MONTH AND cal.CAL_DAY = b.SCHE_DATE
					WHERE
						cal.CAL_YEAR = $YEAR
						AND DAYOFWEEK(cal.CAL_DATE) IN (2,3,4,5,6)
						AND b.SCHE_ID IS NULL
						AND a.DAY_REPORT_TM > 0
					GROUP BY CAL_MONTH, usr.NO
				) P
				GROUP BY USER_NO, MNTH
			) L ON J.USER_NO = L.USER_NO AND J.CAL_MONTH = L.MNTH
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO,
					cal.CAL_MONTH AS MNTH,
					COUNT(DISTINCT cal.CAL_DATE) AS ALL_DT_CNT
				FROM
					(
						TBL_CALENDAR_DATA cal,
						TBL_USERINFO usr
					)
					LEFT JOIN TBL_SCHEDULE b ON b.SCHE_TYP IN ('H','I','J') AND cal.CAL_YEAR = b.SCHE_YEAR AND cal.CAL_MONTH = b.SCHE_MONTH AND cal.CAL_DAY = b.SCHE_DATE
				WHERE
					cal.CAL_YEAR = $YEAR
					AND DAYOFWEEK(cal.CAL_DATE) IN (2,3,4,5,6)
					AND DATEDIFF(SYSDATE(), cal.CAL_DATE) >= 0
					AND b.SCHE_ID IS NULL
				GROUP BY usr.NO, cal.CAL_MONTH
			) M ON J.USER_NO = M.USER_NO AND J.CAL_MONTH = M.MNTH
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO,
					SUBSTRING(a.ATTEND_DT,5,2) AS MNTH,
					COUNT(DISTINCT a.NO) AS DT_CNT
				FROM
					TBL_USERINFO usr
					LEFT JOIN TBL_ATTEND_CHECK a ON usr.NO = a.USER_NO
					LEFT JOIN TBL_SCHEDULE b ON b.SCHE_TYP IN ('H','I','J') AND a.ATTEND_DT = CONCAT(b.SCHE_YEAR, b.SCHE_MONTH, b.SCHE_DATE)
				WHERE
					SUBSTRING(a.ATTEND_DT,1,4) = $YEAR
					AND DAYOFWEEK(a.ATTEND_DT) IN (2,3,4,5,6)
					AND DATEDIFF(SYSDATE(), a.ATTEND_DT) >= 0
					AND b.SCHE_ID IS NULL
				GROUP BY usr.NO, SUBSTRING(a.ATTEND_DT,5,2)
			) N ON J.USER_NO = N.USER_NO AND J.CAL_MONTH = N.MNTH
		GROUP BY PRJ_ID, USER_NO, MNTH
	) T;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_LABOR_ARR_bak2`($id VARCHAR(400),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT		
		IFNULL(SUM(PRJ_SALARY),0) AS SALARY
	INTO
		$result
	FROM
	(
		SELECT
			prjInput.PRJ_ID AS PRJ_ID, 
			prjInput.MONTH AS MNTH,
			prjInput.USER_NO AS USER_NO,
			IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS USER_SALARY,
			prjInput.TM AS PRJ_TM,
			totalInput.TM AS TOT_TM,
			userWorkDay.DT_CNT AS DT_CNT,
			totalWorkDay.ALL_DT_CNT AS ALL_DT_CNT,
			IFNULL(prjInput.TM / totalInput.TM, 0) * IFNULL(userWorkDay.DT_CNT / totalWorkDay.ALL_DT_CNT, 0) * IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS PRJ_SALARY
		FROM
			(
				SELECT
					A.USER_NO AS USER_NO, 
					A.MNTH AS MONTH, 
					A.DAY_REPORT_TM - IFNULL(B.DAY_REPORT_TM, 0) AS TM,
					A.PRJ_ID AS PRJ_ID
				FROM 
					(
						SELECT
							usr.NO AS USER_NO,
							cal.CAL_MONTH AS MNTH, 
							IFNULL(SUM(IFNULL(a.DAY_REPORT_TM, 0)),0) AS DAY_REPORT_TM,
							c.PRJ_ID AS PRJ_ID
						FROM
							(
								TBL_CALENDAR_DATA cal,
								TBL_USERINFO usr
							)
							INNER JOIN TBL_DAY_REPORT a
								ON usr.NO = a.USER_NO
								AND SUBSTRING(a.DAY_REPORT_DT ,1,4) = $YEAR 
								AND DAYOFWEEK(a.DAY_REPORT_DT ) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.DAY_REPORT_DT ) >= 0
								AND cal.CAL_DATE = a.DAY_REPORT_DT 
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_ATTEND_CHECK chk
								ON usr.NO = chk.USER_NO
								AND cal.CAL_DATE = chk.ATTEND_DT
							INNER JOIN TBL_TASK c ON a.TASK_ID = c.TASK_ID
							INNER JOIN TBL_PRJ d ON c.PRJ_ID = d.PRJ_ID
						WHERE
							cal.CAL_YEAR = $YEAR
							#sub check
							AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, d.PRJ_ID) = 1)
							AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',d.PRJ_ID,'%'))
							AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',d.ORGNZT_ID,'%'))
						GROUP BY USER_NO, MNTH, PRJ_ID
					) A
					LEFT JOIN (
						SELECT
							usr.NO AS USER_NO,
							cal.CAL_MONTH AS MNTH, 
							IFNULL(SUM(IFNULL(a.DAY_REPORT_TM, 0)),0) AS DAY_REPORT_TM,
							c.PRJ_ID AS PRJ_ID
						FROM
							(
								TBL_CALENDAR_DATA cal,
								TBL_USERINFO usr
							)
							INNER JOIN TBL_DAY_REPORT a
								ON usr.NO = a.USER_NO
								AND SUBSTRING(a.DAY_REPORT_DT ,1,4) = $YEAR 
								AND DAYOFWEEK(a.DAY_REPORT_DT ) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.DAY_REPORT_DT ) >= 0
								AND cal.CAL_DATE = a.DAY_REPORT_DT 
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_ATTEND_CHECK chk
								ON usr.NO = chk.USER_NO
								AND cal.CAL_DATE = chk.ATTEND_DT
							INNER JOIN TBL_SCHEDULE b 
								ON b.SCHE_TYP IN ('H','I','J') 
								AND b.DELETE_YN = 'N'
								AND cal.CAL_YEAR = b.SCHE_YEAR 
								AND cal.CAL_MONTH = b.SCHE_MONTH 
								AND cal.CAL_DAY = b.SCHE_DATE
							INNER JOIN TBL_TASK c ON a.TASK_ID = c.TASK_ID
							INNER JOIN TBL_PRJ d ON c.PRJ_ID = d.PRJ_ID
						WHERE
							cal.CAL_YEAR = $YEAR
							#sub check
							AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, d.PRJ_ID) = 1)
							AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',d.PRJ_ID,'%'))
							AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',d.ORGNZT_ID,'%'))
						GROUP BY USER_NO, MNTH, PRJ_ID
					) B ON A.USER_NO = B.USER_NO AND A.MNTH = B.MNTH AND A.PRJ_ID = B.PRJ_ID
				GROUP BY USER_NO, MONTH, PRJ_ID
			) prjInput
			LEFT JOIN (
				SELECT
					a.NO AS USER_NO
					,b.SALARY1 + (b.SALARY2*2) + (b.SALARY3*3) AS SALARY
					,b.MONTH AS MONTH
				FROM
					TBL_USERINFO a
					INNER JOIN TBL_USER_SALARY b
						ON a.NO = b.USER_NO
						AND b.YEAR = $YEAR
			) userSalary ON prjInput.USER_NO = userSalary.USER_NO AND prjInput.MONTH = userSalary.MONTH
			LEFT JOIN (
				SELECT
					a.NO AS USER_NO
					,b.SALARY AS SALARY
					,b.MONTH AS MONTH
				FROM
					TBL_USERINFO a
					INNER JOIN TBL_RANK_SALARY b
						ON a.RANK_ID = b.RANK_CODE
						AND b.YEAR = $YEAR
			) rankSalary ON prjInput.USER_NO = rankSalary.USER_NO AND prjInput.MONTH = rankSalary.MONTH
			LEFT JOIN (
				SELECT
					a.USER_NO AS USER_NO, 
					a.MNTH AS MNTH, 
					a.DAY_REPORT_TM - IFNULL(b.DAY_REPORT_TM, 0) AS TM
				FROM 
					(
						SELECT
							usr.NO AS USER_NO,
							cal.CAL_MONTH AS MNTH, 
							IFNULL(SUM(a.DAY_REPORT_TM),0) AS DAY_REPORT_TM
						FROM
							(
								TBL_CALENDAR_DATA cal,
								TBL_USERINFO usr
							)
							INNER JOIN TBL_DAY_REPORT a
								ON usr.NO = a.USER_NO
								AND SUBSTRING(a.DAY_REPORT_DT ,1,4) = $YEAR 
								AND DAYOFWEEK(a.DAY_REPORT_DT ) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.DAY_REPORT_DT ) >= 0
								AND cal.CAL_DATE = a.DAY_REPORT_DT 
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_ATTEND_CHECK chk
								ON usr.NO = chk.USER_NO
								AND cal.CAL_DATE = chk.ATTEND_DT
						WHERE
							cal.CAL_YEAR = $YEAR
						GROUP BY USER_NO, MNTH
					) a
					LEFT JOIN (
						SELECT
							usr.NO AS USER_NO,
							cal.CAL_MONTH AS MNTH, 
							IFNULL(SUM(a.DAY_REPORT_TM),0) AS DAY_REPORT_TM
						FROM
							(
								TBL_CALENDAR_DATA cal,
								TBL_USERINFO usr
							)
							INNER JOIN TBL_DAY_REPORT a
								ON usr.NO = a.USER_NO
								AND SUBSTRING(a.DAY_REPORT_DT ,1,4) = $YEAR 
								AND DAYOFWEEK(a.DAY_REPORT_DT ) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.DAY_REPORT_DT ) >= 0
								AND cal.CAL_DATE = a.DAY_REPORT_DT 
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_ATTEND_CHECK chk
								ON usr.NO = chk.USER_NO
								AND cal.CAL_DATE = chk.ATTEND_DT
							INNER JOIN TBL_SCHEDULE b 
								ON b.SCHE_TYP IN ('H','I','J') 
								AND b.DELETE_YN = 'N'
								AND cal.CAL_YEAR = b.SCHE_YEAR 
								AND cal.CAL_MONTH = b.SCHE_MONTH 
								AND cal.CAL_DAY = b.SCHE_DATE
						WHERE
							cal.CAL_YEAR = $YEAR
						GROUP BY USER_NO, MNTH
					) b ON a.USER_NO = b.USER_NO AND a.MNTH = b.MNTH
				GROUP BY USER_NO, MNTH
			) totalInput ON prjInput.USER_NO = totalInput.USER_NO AND prjInput.MONTH = totalInput.MNTH
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO,
					cal.CAL_MONTH AS MNTH,
					COUNT(DISTINCT cal.CAL_DATE) AS ALL_DT_CNT
				FROM
					(
						TBL_CALENDAR_DATA cal,
						TBL_USERINFO usr
					)
					LEFT JOIN TBL_SCHEDULE b
						ON b.SCHE_TYP IN ('H','I','J') 
						AND b.DELETE_YN = 'N'
						AND cal.CAL_YEAR = b.SCHE_YEAR 
						AND cal.CAL_MONTH = b.SCHE_MONTH 
						AND cal.CAL_DAY = b.SCHE_DATE
				WHERE
					cal.CAL_YEAR = $YEAR
					AND DAYOFWEEK(cal.CAL_DATE) IN (2,3,4,5,6)
					AND DATEDIFF(SYSDATE(), cal.CAL_DATE) >= 0
					AND b.SCHE_ID IS NULL
				GROUP BY usr.NO, cal.CAL_MONTH
			) totalWorkDay ON prjInput.USER_NO = totalWorkDay.USER_NO AND prjInput.MONTH = totalWorkDay.MNTH
			LEFT JOIN (
				SELECT
					a.USER_NO AS USER_NO,
					a.MNTH AS MNTH,
					a.ATTEND_CNT - IFNULL(b.HOL_ATTEND_CNT, 0) AS DT_CNT
				FROM
					(
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(a.ATTEND_DT,5,2) AS MNTH,
							COUNT(DISTINCT a.NO) AS ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK a 
								ON usr.NO = a.USER_NO 
								AND SUBSTRING(a.ATTEND_DT,1,4) = $YEAR 
								AND DAYOFWEEK(a.ATTEND_DT) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.ATTEND_DT) >= 0
						GROUP BY USER_NO, MNTH
					) a
					LEFT JOIN (
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(a.ATTEND_DT,5,2) AS MNTH,
							COUNT(DISTINCT a.NO) AS HOL_ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK a 
								ON usr.NO = a.USER_NO 
								AND SUBSTRING(a.ATTEND_DT,1,4) = $YEAR 
								AND DAYOFWEEK(a.ATTEND_DT) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.ATTEND_DT) >= 0
							INNER JOIN TBL_SCHEDULE b 
								ON a.ATTEND_DT = CONCAT(b.SCHE_YEAR, b.SCHE_MONTH, b.SCHE_DATE)
								AND b.SCHE_TYP IN ('H','I','J') 
								AND b.DELETE_YN = 'N'
						GROUP BY USER_NO, MNTH
					) b ON a.USER_NO = b.USER_NO AND a.MNTH = b.MNTH
			) userWorkDay ON prjInput.USER_NO = userWorkDay.USER_NO AND prjInput.MONTH = userWorkDay.MNTH
		WHERE
			#total check
			IF($totalBool = TRUE, prjInput.MONTH BETWEEN '00' AND LPAD($MONTH,2,'0'), prjInput.MONTH = LPAD($MONTH,2,'0'))
		GROUP BY USER_NO, MNTH, PRJ_ID
	) T ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_LABOR_ARR_bak3`($id VARCHAR(400),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT		
		IFNULL(SUM(PRJ_SALARY),0) AS SALARY
	INTO
		$result
	FROM
	(
		SELECT
			prjInput.PRJ_ID AS PRJ_ID, 
			prjInput.MONTH AS MNTH,
			prjInput.USER_NO AS USER_NO,
			IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS USER_SALARY,
			prjInput.TM AS PRJ_TM,
			totalInput.TM AS TOT_TM,
			userWorkDay.DT_CNT AS DT_CNT,
			totalWorkDay.ALL_DT_CNT AS ALL_DT_CNT,
			IFNULL(prjInput.TM / totalInput.TM, 0) * IFNULL(userWorkDay.DT_CNT / totalWorkDay.ALL_DT_CNT, 0) * IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS PRJ_SALARY
		FROM
			(
				SELECT
					A.USER_NO AS USER_NO, 
					A.MNTH AS MONTH, 
					A.DAY_REPORT_TM - IFNULL(B.DAY_REPORT_TM, 0) AS TM,
					A.PRJ_ID AS PRJ_ID
				FROM 
					(
						SELECT
							chk.USER_NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MNTH, 
							IFNULL(SUM(IFNULL(a.DAY_REPORT_TM, 0)), 0) AS DAY_REPORT_TM,
							c.PRJ_ID AS PRJ_ID
						FROM
							TBL_ATTEND_CHECK chk
							INNER JOIN TBL_DAY_REPORT a
								ON a.USER_NO = chk.USER_NO
								AND a.DAY_REPORT_DT = chk.ATTEND_DT
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_TASK c ON a.TASK_ID = c.TASK_ID
							INNER JOIN TBL_PRJ d ON c.PRJ_ID = d.PRJ_ID
								#sub check
								AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, d.PRJ_ID) = 1)
								AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',d.PRJ_ID,'%'))
								AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',d.ORGNZT_ID,'%'))
						WHERE
							SUBSTRING(chk.ATTEND_DT, 1, 4) = $YEAR
							#total check
							AND IF($totalBool = TRUE, SUBSTRING(chk.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(chk.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
							AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6)
						GROUP BY
							USER_NO, MNTH, PRJ_ID
					) A
					LEFT JOIN (
						SELECT
							chk.USER_NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MNTH, 
							IFNULL(SUM(IFNULL(a.DAY_REPORT_TM, 0)), 0) AS DAY_REPORT_TM,
							c.PRJ_ID AS PRJ_ID
						FROM
							TBL_ATTEND_CHECK chk
							INNER JOIN TBL_DAY_REPORT a
								ON a.USER_NO = chk.USER_NO
								AND a.DAY_REPORT_DT = chk.ATTEND_DT
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_SCHEDULE b
								ON b.SCHE_TYP IN ('H', 'I', 'J') 
								AND b.DELETE_YN = 'N'
								AND chk.ATTEND_DT = CONCAT(b.SCHE_YEAR, b.SCHE_MONTH, b.SCHE_DATE)
							INNER JOIN TBL_TASK c ON a.TASK_ID = c.TASK_ID
							INNER JOIN TBL_PRJ d ON c.PRJ_ID = d.PRJ_ID
								#sub check
								AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, d.PRJ_ID) = 1)
								AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',d.PRJ_ID,'%'))
								AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',d.ORGNZT_ID,'%'))
						WHERE
							SUBSTRING(chk.ATTEND_DT, 1, 4) = $YEAR
							#total check
							AND IF($totalBool = TRUE, SUBSTRING(chk.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(chk.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
							AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6)
						GROUP BY USER_NO, MNTH, PRJ_ID
					) B ON A.USER_NO = B.USER_NO AND A.MNTH = B.MNTH AND A.PRJ_ID = B.PRJ_ID
				GROUP BY USER_NO, MONTH, PRJ_ID
			) prjInput
			LEFT JOIN (
				SELECT
					a.NO AS USER_NO
					,b.SALARY1 + (b.SALARY2 * 2) + (b.SALARY3 * 3) AS SALARY
					,b.MONTH AS MONTH
				FROM
					TBL_USERINFO a
					INNER JOIN TBL_USER_SALARY b
						ON a.NO = b.USER_NO
						AND b.YEAR = $YEAR
						#total check
						AND IF($totalBool = TRUE, b.MONTH <= LPAD($MONTH,2,'0'), b.MONTH = LPAD($MONTH,2,'0'))
			) userSalary ON prjInput.USER_NO = userSalary.USER_NO AND prjInput.MONTH = userSalary.MONTH
			LEFT JOIN (
				SELECT
					a.NO AS USER_NO
					,b.SALARY AS SALARY
					,b.MONTH AS MONTH
				FROM
					TBL_USERINFO a
					INNER JOIN TBL_RANK_SALARY b
						ON a.RANK_ID = b.RANK_CODE
						AND b.YEAR = $YEAR
						#total check
						AND IF($totalBool = TRUE, b.MONTH <= LPAD($MONTH,2,'0'), b.MONTH = LPAD($MONTH,2,'0'))
			) rankSalary ON prjInput.USER_NO = rankSalary.USER_NO AND prjInput.MONTH = rankSalary.MONTH
			LEFT JOIN (
				SELECT
					a.USER_NO AS USER_NO, 
					a.MNTH AS MNTH, 
					a.DAY_REPORT_TM - IFNULL(b.DAY_REPORT_TM, 0) AS TM
				FROM 
					(
						SELECT
							chk.USER_NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MNTH, 
							IFNULL(SUM(a.DAY_REPORT_TM), 0) AS DAY_REPORT_TM
						FROM
							TBL_ATTEND_CHECK chk
							INNER JOIN TBL_DAY_REPORT a
								ON a.USER_NO = chk.USER_NO
								AND a.DAY_REPORT_DT = chk.ATTEND_DT
								AND a.DAY_REPORT_TM > 0
						WHERE
							SUBSTRING(chk.ATTEND_DT, 1, 4) = $YEAR
							#total check
							AND IF($totalBool = TRUE, SUBSTRING(chk.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(chk.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
							AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6)
						GROUP BY USER_NO, MNTH
					) a
					LEFT JOIN (
						SELECT
							chk.USER_NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MNTH, 
							IFNULL(SUM(a.DAY_REPORT_TM), 0) AS DAY_REPORT_TM
						FROM
							TBL_ATTEND_CHECK chk
							INNER JOIN TBL_DAY_REPORT a
								ON a.USER_NO = chk.USER_NO
								AND a.DAY_REPORT_DT = chk.ATTEND_DT
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_SCHEDULE b
								ON b.SCHE_TYP IN ('H', 'I', 'J') 
								AND b.DELETE_YN = 'N'
								AND chk.ATTEND_DT = CONCAT(b.SCHE_YEAR, b.SCHE_MONTH, b.SCHE_DATE)
						WHERE
							SUBSTRING(chk.ATTEND_DT, 1, 4) = $YEAR
							#total check
							AND IF($totalBool = TRUE, SUBSTRING(chk.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(chk.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
							AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6)
						GROUP BY USER_NO, MNTH
					) b ON a.USER_NO = b.USER_NO AND a.MNTH = b.MNTH
				GROUP BY USER_NO, MNTH
			) totalInput ON prjInput.USER_NO = totalInput.USER_NO AND prjInput.MONTH = totalInput.MNTH
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO,
					cal.CAL_MONTH AS MNTH,
					COUNT(DISTINCT cal.CAL_DATE) AS ALL_DT_CNT
				FROM
					(
						TBL_CALENDAR_DATA cal,
						TBL_USERINFO usr
					)
					LEFT JOIN TBL_SCHEDULE b
						ON b.SCHE_TYP IN ('H', 'I', 'J') 
						AND b.DELETE_YN = 'N'
						AND cal.CAL_YEAR = b.SCHE_YEAR 
						AND cal.CAL_MONTH = b.SCHE_MONTH 
						AND cal.CAL_DAY = b.SCHE_DATE
				WHERE
					cal.CAL_YEAR = $YEAR
					#total check
					AND IF($totalBool = TRUE, cal.CAL_MONTH <= LPAD($MONTH,2,'0'), cal.CAL_MONTH = LPAD($MONTH,2,'0'))
					AND DAYOFWEEK(cal.CAL_DATE) IN (2, 3, 4, 5, 6)
					AND DATEDIFF(SYSDATE(), cal.CAL_DATE) >= 0
					AND b.SCHE_ID IS NULL
				GROUP BY usr.NO, cal.CAL_MONTH
			) totalWorkDay ON prjInput.USER_NO = totalWorkDay.USER_NO AND prjInput.MONTH = totalWorkDay.MNTH
			LEFT JOIN (
				SELECT
					a.USER_NO AS USER_NO,
					a.MNTH AS MNTH,
					a.ATTEND_CNT - IFNULL(b.HOL_ATTEND_CNT, 0) AS DT_CNT
				FROM
					(
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(a.ATTEND_DT, 5, 2) AS MNTH,
							COUNT(DISTINCT a.NO) AS ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK a 
								ON usr.NO = a.USER_NO 
								AND SUBSTRING(a.ATTEND_DT, 1, 4) = $YEAR 
								#total check
								AND IF($totalBool = TRUE, SUBSTRING(a.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(a.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
								AND DAYOFWEEK(a.ATTEND_DT) IN (2, 3, 4, 5, 6) 
						GROUP BY USER_NO, MNTH
					) a
					LEFT JOIN (
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(a.ATTEND_DT, 5, 2) AS MNTH,
							COUNT(DISTINCT a.NO) AS HOL_ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK a 
								ON usr.NO = a.USER_NO 
								AND SUBSTRING(a.ATTEND_DT, 1, 4) = $YEAR 
								#total check
								AND IF($totalBool = TRUE, SUBSTRING(a.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(a.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
								AND DAYOFWEEK(a.ATTEND_DT) IN (2, 3, 4, 5, 6) 
							INNER JOIN TBL_SCHEDULE b 
								ON a.ATTEND_DT = CONCAT(b.SCHE_YEAR, b.SCHE_MONTH, b.SCHE_DATE)
								AND b.SCHE_TYP IN ('H', 'I', 'J') 
								AND b.DELETE_YN = 'N'
						GROUP BY USER_NO, MNTH
					) b ON a.USER_NO = b.USER_NO AND a.MNTH = b.MNTH
			) userWorkDay ON prjInput.USER_NO = userWorkDay.USER_NO AND prjInput.MONTH = userWorkDay.MNTH
		WHERE
			#total check
			IF(TRUE = TRUE, prjInput.MONTH <= LPAD($MONTH,2,'0'), prjInput.MONTH = LPAD($MONTH,2,'0'))
		GROUP BY USER_NO, MNTH, PRJ_ID
	) T ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_LABOR_ARR_bak4`($id VARCHAR(400), $YEAR CHAR(4), $MONTH CHAR(2)
	, $includeResult CHAR(1), $common CHAR(1), $sub CHAR(1), $total CHAR(1)) RETURNS bigint(20)
BEGIN
	#2013-03-29 백업 FN_GET_LABOR_bak4 와 TBL_PRJ #sub check 조건 부분만 다름
	DECLARE $result BIGINT(20);
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT		
		IFNULL(SUM(PRJ_SALARY),0) AS SALARY
	INTO
		$result
	FROM
	(
		SELECT
			prjInput.PRJ_ID AS PRJ_ID, 
			prjInput.MONTH AS MONTH,
			prjInput.USER_NO AS USER_NO,
			IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS USER_SALARY,
			prjInput.TM AS PRJ_TM,
			totalInput.TM AS TOT_TM,
			userWorkDay.DT_CNT AS DT_CNT,
			totalWorkDay.ALL_DT_CNT AS ALL_DT_CNT,
			IFNULL(prjInput.TM / totalInput.TM, 0) 
			* IFNULL(userWorkDay.DT_CNT / totalWorkDay.ALL_DT_CNT, 0) 
			* IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS PRJ_SALARY
		FROM
			(
				SELECT
					dr.USER_NO AS USER_NO,
					SUBSTRING(dr.DAY_REPORT_DT, 5, 2) AS MONTH, 
					IFNULL(SUM(IFNULL(dr.DAY_REPORT_TM, 0)), 0) AS TM,
					task.PRJ_ID AS PRJ_ID
				FROM
					TBL_DAY_REPORT dr
					INNER JOIN TBL_TASK task
						ON dr.TASK_ID = task.TASK_ID
					INNER JOIN TBL_PRJ prj
						ON task.PRJ_ID = prj.PRJ_ID
						#sub check
						AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, prj.PRJ_ID) = 1)
						AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%', prj.PRJ_ID, '%'))
						AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%', prj.ORGNZT_ID, '%'))
				WHERE
					dr.DAY_REPORT_TM > 0
					#total check
					AND IF($totalBool = TRUE, dr.DAY_REPORT_DT BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31')
						, dr.DAY_REPORT_DT LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))
				GROUP BY
					USER_NO, MONTH, PRJ_ID
			) prjInput
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO
					,sal.SALARY1 + (sal.SALARY2 * 2) + (sal.SALARY3 * 3) AS SALARY
					,sal.MONTH AS MONTH
				FROM
					TBL_USERINFO usr
					INNER JOIN TBL_USER_SALARY sal
						ON usr.NO = sal.USER_NO
						AND sal.YEAR = $YEAR
						#total check
						AND IF($totalBool = TRUE, sal.MONTH <= LPAD($MONTH, 2, '0'), sal.MONTH = LPAD($MONTH, 2, '0'))
			) userSalary 
				ON prjInput.USER_NO = userSalary.USER_NO 
				AND prjInput.MONTH = userSalary.MONTH
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO
					,sal.SALARY AS SALARY
					,sal.MONTH AS MONTH
				FROM
					TBL_USERINFO usr
					INNER JOIN TBL_RANK_SALARY sal
						ON usr.RANK_ID = sal.RANK_CODE
						AND sal.YEAR = $YEAR
						#total check
						AND IF($totalBool = TRUE, sal.MONTH <= LPAD($MONTH, 2, '0'), sal.MONTH = LPAD($MONTH, 2, '0'))
			) rankSalary 
				ON prjInput.USER_NO = rankSalary.USER_NO 
				AND prjInput.MONTH = rankSalary.MONTH
			LEFT JOIN (
				SELECT
					dr.USER_NO AS USER_NO,
					SUBSTRING(dr.DAY_REPORT_DT, 5, 2) AS MONTH, 
					IFNULL(SUM(IFNULL(dr.DAY_REPORT_TM, 0)), 0) AS TM
				FROM
					TBL_DAY_REPORT dr
				WHERE
					dr.DAY_REPORT_TM > 0
					#total check
					AND IF($totalBool = TRUE, dr.DAY_REPORT_DT BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31')
						, dr.DAY_REPORT_DT LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))
				GROUP BY
					USER_NO, MONTH
			) totalInput 
				ON prjInput.USER_NO = totalInput.USER_NO 
				AND prjInput.MONTH = totalInput.MONTH
			LEFT JOIN (
				SELECT
					SUBSTRING(chk.ATTEND_DT, 5, 2) AS MONTH,
					COUNT(DISTINCT chk.ATTEND_DT) AS ALL_DT_CNT
				FROM
					(
						SELECT
							ATTEND_DT
						FROM
							TBL_ATTEND_CHECK
						WHERE
							DAYOFWEEK(ATTEND_DT) IN (2, 3, 4, 5, 6)
							#total check
							AND IF($totalBool = TRUE, ATTEND_DT BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31')
								, ATTEND_DT LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))
						GROUP BY
							ATTEND_DT
					) chk
					LEFT JOIN TBL_SCHEDULE sch
						ON sch.SCHE_TYP IN ('H', 'I', 'J') 
						AND sch.DELETE_YN = 'N'
						AND chk.ATTEND_DT = CONCAT(sch.SCHE_YEAR, sch.SCHE_MONTH, sch.SCHE_DATE)
				WHERE
					sch.SCHE_ID IS NULL
				GROUP BY MONTH
			) totalWorkDay 
				ON prjInput.MONTH = totalWorkDay.MONTH
			LEFT JOIN (
				SELECT
					A.USER_NO AS USER_NO,
					A.MONTH AS MONTH,
					A.ATTEND_CNT - IFNULL(B.HOL_ATTEND_CNT, 0) AS DT_CNT
				FROM
					(
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MONTH,
							COUNT(DISTINCT chk.NO) AS ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK chk 
								ON usr.NO = chk.USER_NO 
								AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6) 
								#total check
								AND IF($totalBool = TRUE, chk.ATTEND_DT BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31')
									, chk.ATTEND_DT LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))
						GROUP BY USER_NO, MONTH
					) A
					LEFT JOIN (
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MONTH,
							COUNT(DISTINCT chk.NO) AS HOL_ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK chk 
								ON usr.NO = chk.USER_NO 
								AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6) 
								#total check
								AND IF($totalBool = TRUE, chk.ATTEND_DT BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31')
									, chk.ATTEND_DT LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))
							INNER JOIN TBL_SCHEDULE sch 
								ON sch.SCHE_TYP IN ('H', 'I', 'J') 
								AND sch.DELETE_YN = 'N'
								AND chk.ATTEND_DT = CONCAT(sch.SCHE_YEAR, sch.SCHE_MONTH, sch.SCHE_DATE)
						GROUP BY USER_NO, MONTH
					) B ON A.USER_NO = B.USER_NO AND A.MONTH = B.MONTH
			) userWorkDay 
				ON prjInput.USER_NO = userWorkDay.USER_NO 
				AND prjInput.MONTH = userWorkDay.MONTH
		WHERE
			#total check
			IF($totalBool = TRUE, prjInput.MONTH <= LPAD($MONTH, 2, '0')
				, prjInput.MONTH = LPAD($MONTH, 2, '0'))
		GROUP BY USER_NO, MONTH, PRJ_ID
	) T;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_LABOR_bak`($id VARCHAR(20),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT		
		IFNULL(SUM(SALARY),0) AS SALARY
	INTO $result
	FROM
		(
		SELECT
			J.PRJ_ID, J.USER_NO,
			J.CAL_MONTH AS MNTH,
			IFNULL(SUM(IFNULL(J.DAY_REPORT_TM,0)) / L.TM, 0) * IFNULL(N.DT_CNT / M.ALL_DT_CNT, 0) * IFNULL(K.SALARY, 0) AS SALARY
		FROM
			(
				SELECT
					cal.CAL_MONTH,
					usr.NO AS USER_NO,
					IFNULL(SUM(a.DAY_REPORT_TM),0) AS DAY_REPORT_TM,
					c.PRJ_ID AS PRJ_ID
				FROM
					(
						TBL_CALENDAR_DATA cal,
						TBL_USERINFO usr
					)
					INNER JOIN TBL_ATTEND_CHECK chk
						ON
							usr.NO = chk.USER_NO
							AND cal.CAL_DATE = chk.ATTEND_DT
							AND (chk.ATTEND_CD !="VC" OR chk.ATTEND_CD IS NULL)
					INNER JOIN TBL_DAY_REPORT a
						ON
							cal.CAL_DATE = a.DAY_REPORT_DT
							AND usr.NO = a.USER_NO
					LEFT JOIN TBL_SCHEDULE b
						ON
							b.SCHE_TYP IN ('H','I','J')
							AND cal.CAL_YEAR = b.SCHE_YEAR
							AND cal.CAL_MONTH = b.SCHE_MONTH
							AND cal.CAL_DAY = b.SCHE_DATE
					INNER JOIN TBL_TASK c ON a.TASK_ID = c.TASK_ID
					INNER JOIN TBL_PRJ d ON c.PRJ_ID = d.PRJ_ID
				WHERE
					CAL_YEAR = $YEAR
					AND DAYOFWEEK(cal.CAL_DATE) IN (2,3,4,5,6)
					AND b.SCHE_ID IS NULL
					AND a.DAY_REPORT_TM > 0
					#total check
					AND ($totalBool = TRUE OR cal.CAL_MONTH  = LPAD($MONTH,2,'0'))
					AND ($totalBool = FALSE OR cal.CAL_MONTH BETWEEN '00' AND LPAD($MONTH,2,'0'))
					#sub check
					AND ($subBool1 = TRUE OR d.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
					AND ($subBool1 = FALSE OR $subBool2 = TRUE OR d.PRJ_ID = $id)
					AND ($subBool1 = FALSE OR $subBool2 = FALSE OR d.ORGNZT_ID = $id )
				GROUP BY CAL_MONTH, usr.NO, PRJ_ID
			) J
			LEFT JOIN (
				SELECT
					a.NO AS USER_NO
					,IFNULL(b.SALARY1 + (b.SALARY2*2) + (b.SALARY3*3), c.SALARY) AS SALARY
					,IFNULL(b.MONTH, c.MONTH) AS MONTH
				FROM
					TBL_USERINFO a
					LEFT JOIN TBL_USER_SALARY b ON a.NO = b.USER_NO AND b.YEAR = $YEAR
					LEFT JOIN TBL_RANK_SALARY c ON a.RANK_ID = c.RANK_CODE AND c.YEAR = $YEAR AND (b.MONTH = c.MONTH OR b.MONTH IS NULL)
			) K ON J.USER_NO = K.USER_NO AND J.CAL_MONTH = K.MONTH
			LEFT JOIN (
				SELECT
					USER_NO, CAL_MONTH AS MNTH, SUM(DAY_REPORT_TM) AS TM
				FROM (
					SELECT
						cal.CAL_MONTH, usr.NO AS USER_NO,
						IFNULL(SUM(a.DAY_REPORT_TM),0) AS DAY_REPORT_TM
					FROM
						(
							TBL_CALENDAR_DATA cal,
							TBL_USERINFO usr
						)
						INNER JOIN TBL_ATTEND_CHECK chk
							ON
								usr.NO = chk.USER_NO
								AND cal.CAL_DATE = chk.ATTEND_DT
								AND (chk.ATTEND_CD NOT IN ('VC') OR chk.ATTEND_CD IS NULL)
						INNER JOIN TBL_DAY_REPORT a ON cal.CAL_DATE = a.DAY_REPORT_DT AND usr.NO = a.USER_NO
						LEFT JOIN TBL_SCHEDULE b ON b.SCHE_TYP IN ('H','I','J') AND cal.CAL_YEAR = b.SCHE_YEAR AND cal.CAL_MONTH = b.SCHE_MONTH AND cal.CAL_DAY = b.SCHE_DATE
					WHERE
						cal.CAL_YEAR = $YEAR
						AND DAYOFWEEK(cal.CAL_DATE) IN (2,3,4,5,6)
						AND b.SCHE_ID IS NULL
						AND a.DAY_REPORT_TM > 0
					GROUP BY CAL_MONTH, usr.NO
				) P
				GROUP BY USER_NO, MNTH
			) L ON J.USER_NO = L.USER_NO AND J.CAL_MONTH = L.MNTH
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO,
					cal.CAL_MONTH AS MNTH,
					COUNT(DISTINCT cal.CAL_DATE) AS ALL_DT_CNT
				FROM
					(
						TBL_CALENDAR_DATA cal,
						TBL_USERINFO usr
					)
					LEFT JOIN TBL_SCHEDULE b ON b.SCHE_TYP IN ('H','I','J') AND cal.CAL_YEAR = b.SCHE_YEAR AND cal.CAL_MONTH = b.SCHE_MONTH AND cal.CAL_DAY = b.SCHE_DATE
				WHERE
					cal.CAL_YEAR = $YEAR
					AND DAYOFWEEK(cal.CAL_DATE) IN (2,3,4,5,6)
					AND DATEDIFF(SYSDATE(), cal.CAL_DATE) >= 0
					AND b.SCHE_ID IS NULL
				GROUP BY usr.NO, cal.CAL_MONTH
			) M ON J.USER_NO = M.USER_NO AND J.CAL_MONTH = M.MNTH
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO,
					SUBSTRING(a.ATTEND_DT,5,2) AS MNTH,
					COUNT(DISTINCT a.NO) AS DT_CNT
				FROM
					TBL_USERINFO usr
					LEFT JOIN TBL_ATTEND_CHECK a ON usr.NO = a.USER_NO
					LEFT JOIN TBL_SCHEDULE b ON b.SCHE_TYP IN ('H','I','J') AND a.ATTEND_DT = CONCAT(b.SCHE_YEAR, b.SCHE_MONTH, b.SCHE_DATE)
				WHERE
					SUBSTRING(a.ATTEND_DT,1,4) = $YEAR
					AND DAYOFWEEK(a.ATTEND_DT) IN (2,3,4,5,6)
					AND DATEDIFF(SYSDATE(), a.ATTEND_DT) >= 0
					AND b.SCHE_ID IS NULL
				GROUP BY usr.NO, SUBSTRING(a.ATTEND_DT,5,2)
			) N ON J.USER_NO = N.USER_NO AND J.CAL_MONTH = N.MNTH
		GROUP BY PRJ_ID, USER_NO, MNTH
	) T;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_LABOR_bak2`($id VARCHAR(20),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT		
		IFNULL(SUM(PRJ_SALARY),0) AS SALARY
	INTO
		$result
	FROM
	(
		SELECT
			prjInput.PRJ_ID AS PRJ_ID, 
			prjInput.MONTH AS MNTH,
			prjInput.USER_NO AS USER_NO,
			IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS USER_SALARY,
			prjInput.TM AS PRJ_TM,
			totalInput.TM AS TOT_TM,
			userWorkDay.DT_CNT AS DT_CNT,
			totalWorkDay.ALL_DT_CNT AS ALL_DT_CNT,
			IFNULL(prjInput.TM / totalInput.TM, 0) * IFNULL(userWorkDay.DT_CNT / totalWorkDay.ALL_DT_CNT, 0) * IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS PRJ_SALARY
		FROM
			(
				SELECT
					A.USER_NO AS USER_NO, 
					A.MNTH AS MONTH, 
					A.DAY_REPORT_TM - IFNULL(B.DAY_REPORT_TM, 0) AS TM,
					A.PRJ_ID AS PRJ_ID
				FROM 
					(
						SELECT
							usr.NO AS USER_NO,
							cal.CAL_MONTH AS MNTH, 
							IFNULL(SUM(IFNULL(a.DAY_REPORT_TM, 0)),0) AS DAY_REPORT_TM,
							c.PRJ_ID AS PRJ_ID
						FROM
							(
								TBL_CALENDAR_DATA cal,
								TBL_USERINFO usr
							)
							INNER JOIN TBL_DAY_REPORT a
								ON usr.NO = a.USER_NO
								AND SUBSTRING(a.DAY_REPORT_DT ,1,4) = $YEAR 
								AND DAYOFWEEK(a.DAY_REPORT_DT ) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.DAY_REPORT_DT ) >= 0
								AND cal.CAL_DATE = a.DAY_REPORT_DT 
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_ATTEND_CHECK chk
								ON usr.NO = chk.USER_NO
								AND cal.CAL_DATE = chk.ATTEND_DT
							INNER JOIN TBL_TASK c ON a.TASK_ID = c.TASK_ID
							INNER JOIN TBL_PRJ d ON c.PRJ_ID = d.PRJ_ID
						WHERE
							cal.CAL_YEAR = $YEAR
							#sub check
							AND ($subBool1 = TRUE OR d.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
							AND ($subBool1 = FALSE OR $subBool2 = TRUE OR d.PRJ_ID = $id)
							AND ($subBool1 = FALSE OR $subBool2 = FALSE OR d.ORGNZT_ID = $id)
						GROUP BY USER_NO, MNTH, PRJ_ID
					) A
					LEFT JOIN (
						SELECT
							usr.NO AS USER_NO,
							cal.CAL_MONTH AS MNTH, 
							IFNULL(SUM(IFNULL(a.DAY_REPORT_TM, 0)),0) AS DAY_REPORT_TM,
							c.PRJ_ID AS PRJ_ID
						FROM
							(
								TBL_CALENDAR_DATA cal,
								TBL_USERINFO usr
							)
							INNER JOIN TBL_DAY_REPORT a
								ON usr.NO = a.USER_NO
								AND SUBSTRING(a.DAY_REPORT_DT ,1,4) = $YEAR 
								AND DAYOFWEEK(a.DAY_REPORT_DT ) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.DAY_REPORT_DT ) >= 0
								AND cal.CAL_DATE = a.DAY_REPORT_DT 
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_ATTEND_CHECK chk
								ON usr.NO = chk.USER_NO
								AND cal.CAL_DATE = chk.ATTEND_DT
							INNER JOIN TBL_SCHEDULE b 
								ON b.SCHE_TYP IN ('H','I','J') 
								AND b.DELETE_YN = 'N'
								AND cal.CAL_YEAR = b.SCHE_YEAR 
								AND cal.CAL_MONTH = b.SCHE_MONTH 
								AND cal.CAL_DAY = b.SCHE_DATE
							INNER JOIN TBL_TASK c ON a.TASK_ID = c.TASK_ID
							INNER JOIN TBL_PRJ d ON c.PRJ_ID = d.PRJ_ID
						WHERE
							cal.CAL_YEAR = $YEAR
							#sub check
							AND ($subBool1 = TRUE OR d.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
							AND ($subBool1 = FALSE OR $subBool2 = TRUE OR d.PRJ_ID = $id)
							AND ($subBool1 = FALSE OR $subBool2 = FALSE OR d.ORGNZT_ID = $id)
						GROUP BY USER_NO, MNTH, PRJ_ID
					) B ON A.USER_NO = B.USER_NO AND A.MNTH = B.MNTH AND A.PRJ_ID = B.PRJ_ID
				GROUP BY USER_NO, MONTH, PRJ_ID
			) prjInput
			LEFT JOIN (
				SELECT
					a.NO AS USER_NO
					,b.SALARY1 + (b.SALARY2*2) + (b.SALARY3*3) AS SALARY
					,b.MONTH AS MONTH
				FROM
					TBL_USERINFO a
					INNER JOIN TBL_USER_SALARY b
						ON a.NO = b.USER_NO
						AND b.YEAR = $YEAR
			) userSalary ON prjInput.USER_NO = userSalary.USER_NO AND prjInput.MONTH = userSalary.MONTH
			LEFT JOIN (
				SELECT
					a.NO AS USER_NO
					,b.SALARY AS SALARY
					,b.MONTH AS MONTH
				FROM
					TBL_USERINFO a
					INNER JOIN TBL_RANK_SALARY b
						ON a.RANK_ID = b.RANK_CODE
						AND b.YEAR = $YEAR
			) rankSalary ON prjInput.USER_NO = rankSalary.USER_NO AND prjInput.MONTH = rankSalary.MONTH
			LEFT JOIN (
				SELECT
					a.USER_NO AS USER_NO, 
					a.MNTH AS MNTH, 
					a.DAY_REPORT_TM - IFNULL(b.DAY_REPORT_TM, 0) AS TM
				FROM 
					(
						SELECT
							usr.NO AS USER_NO,
							cal.CAL_MONTH AS MNTH, 
							IFNULL(SUM(a.DAY_REPORT_TM),0) AS DAY_REPORT_TM
						FROM
							(
								TBL_CALENDAR_DATA cal,
								TBL_USERINFO usr
							)
							INNER JOIN TBL_DAY_REPORT a
								ON usr.NO = a.USER_NO
								AND SUBSTRING(a.DAY_REPORT_DT ,1,4) = $YEAR 
								AND DAYOFWEEK(a.DAY_REPORT_DT ) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.DAY_REPORT_DT ) >= 0
								AND cal.CAL_DATE = a.DAY_REPORT_DT 
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_ATTEND_CHECK chk
								ON usr.NO = chk.USER_NO
								AND cal.CAL_DATE = chk.ATTEND_DT
						WHERE
							cal.CAL_YEAR = $YEAR
						GROUP BY USER_NO, MNTH
					) a
					LEFT JOIN (
						SELECT
							usr.NO AS USER_NO,
							cal.CAL_MONTH AS MNTH, 
							IFNULL(SUM(a.DAY_REPORT_TM),0) AS DAY_REPORT_TM
						FROM
							(
								TBL_CALENDAR_DATA cal,
								TBL_USERINFO usr
							)
							INNER JOIN TBL_DAY_REPORT a
								ON usr.NO = a.USER_NO
								AND SUBSTRING(a.DAY_REPORT_DT ,1,4) = $YEAR 
								AND DAYOFWEEK(a.DAY_REPORT_DT ) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.DAY_REPORT_DT ) >= 0
								AND cal.CAL_DATE = a.DAY_REPORT_DT 
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_ATTEND_CHECK chk
								ON usr.NO = chk.USER_NO
								AND cal.CAL_DATE = chk.ATTEND_DT
							INNER JOIN TBL_SCHEDULE b 
								ON b.SCHE_TYP IN ('H','I','J') 
								AND b.DELETE_YN = 'N'
								AND cal.CAL_YEAR = b.SCHE_YEAR 
								AND cal.CAL_MONTH = b.SCHE_MONTH 
								AND cal.CAL_DAY = b.SCHE_DATE
						WHERE
							cal.CAL_YEAR = $YEAR
						GROUP BY USER_NO, MNTH
					) b ON a.USER_NO = b.USER_NO AND a.MNTH = b.MNTH
				GROUP BY USER_NO, MNTH
			) totalInput ON prjInput.USER_NO = totalInput.USER_NO AND prjInput.MONTH = totalInput.MNTH
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO,
					cal.CAL_MONTH AS MNTH,
					COUNT(DISTINCT cal.CAL_DATE) AS ALL_DT_CNT
				FROM
					(
						TBL_CALENDAR_DATA cal,
						TBL_USERINFO usr
					)
					LEFT JOIN TBL_SCHEDULE b
						ON b.SCHE_TYP IN ('H','I','J') 
						ANd b.DELETE_YN = 'N'
						AND cal.CAL_YEAR = b.SCHE_YEAR 
						AND cal.CAL_MONTH = b.SCHE_MONTH 
						AND cal.CAL_DAY = b.SCHE_DATE
				WHERE
					cal.CAL_YEAR = $YEAR
					AND DAYOFWEEK(cal.CAL_DATE) IN (2,3,4,5,6)
					AND DATEDIFF(SYSDATE(), cal.CAL_DATE) >= 0
					AND b.SCHE_ID IS NULL
				GROUP BY usr.NO, cal.CAL_MONTH
			) totalWorkDay ON prjInput.USER_NO = totalWorkDay.USER_NO AND prjInput.MONTH = totalWorkDay.MNTH
			LEFT JOIN (
				SELECT
					a.USER_NO AS USER_NO,
					a.MNTH AS MNTH,
					a.ATTEND_CNT - IFNULL(b.HOL_ATTEND_CNT, 0) AS DT_CNT
				FROM
					(
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(a.ATTEND_DT,5,2) AS MNTH,
							COUNT(DISTINCT a.NO) AS ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK a 
								ON usr.NO = a.USER_NO 
								AND SUBSTRING(a.ATTEND_DT,1,4) = $YEAR 
								AND DAYOFWEEK(a.ATTEND_DT) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.ATTEND_DT) >= 0
						GROUP BY USER_NO, MNTH
					) a
					LEFT JOIN (
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(a.ATTEND_DT,5,2) AS MNTH,
							COUNT(DISTINCT a.NO) AS HOL_ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK a 
								ON usr.NO = a.USER_NO 
								AND SUBSTRING(a.ATTEND_DT,1,4) = $YEAR 
								AND DAYOFWEEK(a.ATTEND_DT) IN (2,3,4,5,6) 
								AND DATEDIFF(SYSDATE(), a.ATTEND_DT) >= 0
							INNER JOIN TBL_SCHEDULE b 
								ON a.ATTEND_DT = CONCAT(b.SCHE_YEAR, b.SCHE_MONTH, b.SCHE_DATE)
								AND b.SCHE_TYP IN ('H','I','J') 
								AND b.DELETE_YN = 'N'
						GROUP BY USER_NO, MNTH
					) b ON a.USER_NO = b.USER_NO AND a.MNTH = b.MNTH
			) userWorkDay ON prjInput.USER_NO = userWorkDay.USER_NO AND prjInput.MONTH = userWorkDay.MNTH
		WHERE
			#total check
			IF($totalBool = TRUE, prjInput.MONTH BETWEEN '00' AND LPAD($MONTH,2,'0'), prjInput.MONTH = LPAD($MONTH,2,'0'))
		GROUP BY USER_NO, MNTH, PRJ_ID
	) T ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_LABOR_bak3`($id VARCHAR(20),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT		
		IFNULL(SUM(PRJ_SALARY),0) AS SALARY
	INTO
		$result
	FROM
	(
		SELECT
			prjInput.PRJ_ID AS PRJ_ID, 
			prjInput.MONTH AS MNTH,
			prjInput.USER_NO AS USER_NO,
			IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS USER_SALARY,
			prjInput.TM AS PRJ_TM,
			totalInput.TM AS TOT_TM,
			userWorkDay.DT_CNT AS DT_CNT,
			totalWorkDay.ALL_DT_CNT AS ALL_DT_CNT,
			IFNULL(prjInput.TM / totalInput.TM, 0) * IFNULL(userWorkDay.DT_CNT / totalWorkDay.ALL_DT_CNT, 0) * IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS PRJ_SALARY
		FROM
			(
				SELECT
					A.USER_NO AS USER_NO, 
					A.MNTH AS MONTH, 
					A.DAY_REPORT_TM - IFNULL(B.DAY_REPORT_TM, 0) AS TM,
					A.PRJ_ID AS PRJ_ID
				FROM 
					(
						SELECT
							chk.USER_NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MNTH, 
							IFNULL(SUM(IFNULL(a.DAY_REPORT_TM, 0)), 0) AS DAY_REPORT_TM,
							c.PRJ_ID AS PRJ_ID
						FROM
							TBL_ATTEND_CHECK chk
							INNER JOIN TBL_DAY_REPORT a
								ON a.USER_NO = chk.USER_NO
								AND a.DAY_REPORT_DT = chk.ATTEND_DT
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_TASK c ON a.TASK_ID = c.TASK_ID
							INNER JOIN TBL_PRJ d ON c.PRJ_ID = d.PRJ_ID
								#sub check
								AND ($subBool1 = TRUE OR d.ORG_PRJ_TREE LIKE CONCAT('%', $id, '%'))
								AND ($subBool1 = FALSE OR $subBool2 = TRUE OR d.PRJ_ID = $id)
								AND ($subBool1 = FALSE OR $subBool2 = FALSE OR d.ORGNZT_ID = $id)
						WHERE
							SUBSTRING(chk.ATTEND_DT, 1, 4) = $YEAR
							#total check
							AND IF($totalBool = TRUE, SUBSTRING(chk.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(chk.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
							AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6)
						GROUP BY
							USER_NO, MNTH, PRJ_ID
					) A
					LEFT JOIN (
						SELECT
							chk.USER_NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MNTH, 
							IFNULL(SUM(IFNULL(a.DAY_REPORT_TM, 0)), 0) AS DAY_REPORT_TM,
							c.PRJ_ID AS PRJ_ID
						FROM
							TBL_ATTEND_CHECK chk
							INNER JOIN TBL_DAY_REPORT a
								ON a.USER_NO = chk.USER_NO
								AND a.DAY_REPORT_DT = chk.ATTEND_DT
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_SCHEDULE b
								ON b.SCHE_TYP IN ('H', 'I', 'J') 
								AND b.DELETE_YN = 'N'
								AND chk.ATTEND_DT = CONCAT(b.SCHE_YEAR, b.SCHE_MONTH, b.SCHE_DATE)
							INNER JOIN TBL_TASK c ON a.TASK_ID = c.TASK_ID
							INNER JOIN TBL_PRJ d ON c.PRJ_ID = d.PRJ_ID
								#sub check
								AND ($subBool1 = TRUE OR d.ORG_PRJ_TREE LIKE CONCAT('%', $id, '%'))
								AND ($subBool1 = FALSE OR $subBool2 = TRUE OR d.PRJ_ID = $id)
								AND ($subBool1 = FALSE OR $subBool2 = FALSE OR d.ORGNZT_ID = $id)
						WHERE
							SUBSTRING(chk.ATTEND_DT, 1, 4) = $YEAR
							#total check
							AND IF($totalBool = TRUE, SUBSTRING(chk.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(chk.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
							AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6)
						GROUP BY USER_NO, MNTH, PRJ_ID
					) B ON A.USER_NO = B.USER_NO AND A.MNTH = B.MNTH AND A.PRJ_ID = B.PRJ_ID
				GROUP BY USER_NO, MONTH, PRJ_ID
			) prjInput
			LEFT JOIN (
				SELECT
					a.NO AS USER_NO
					,b.SALARY1 + (b.SALARY2 * 2) + (b.SALARY3 * 3) AS SALARY
					,b.MONTH AS MONTH
				FROM
					TBL_USERINFO a
					INNER JOIN TBL_USER_SALARY b
						ON a.NO = b.USER_NO
						AND b.YEAR = $YEAR
						#total check
						AND IF($totalBool = TRUE, b.MONTH <= LPAD($MONTH,2,'0'), b.MONTH = LPAD($MONTH,2,'0'))
			) userSalary ON prjInput.USER_NO = userSalary.USER_NO AND prjInput.MONTH = userSalary.MONTH
			LEFT JOIN (
				SELECT
					a.NO AS USER_NO
					,b.SALARY AS SALARY
					,b.MONTH AS MONTH
				FROM
					TBL_USERINFO a
					INNER JOIN TBL_RANK_SALARY b
						ON a.RANK_ID = b.RANK_CODE
						AND b.YEAR = $YEAR
						#total check
						AND IF($totalBool = TRUE, b.MONTH <= LPAD($MONTH,2,'0'), b.MONTH = LPAD($MONTH,2,'0'))
			) rankSalary ON prjInput.USER_NO = rankSalary.USER_NO AND prjInput.MONTH = rankSalary.MONTH
			LEFT JOIN (
				SELECT
					a.USER_NO AS USER_NO, 
					a.MNTH AS MNTH, 
					a.DAY_REPORT_TM - IFNULL(b.DAY_REPORT_TM, 0) AS TM
				FROM 
					(
						SELECT
							chk.USER_NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MNTH, 
							IFNULL(SUM(a.DAY_REPORT_TM), 0) AS DAY_REPORT_TM
						FROM
							TBL_ATTEND_CHECK chk
							INNER JOIN TBL_DAY_REPORT a
								ON a.USER_NO = chk.USER_NO
								AND a.DAY_REPORT_DT = chk.ATTEND_DT
								AND a.DAY_REPORT_TM > 0
						WHERE
							SUBSTRING(chk.ATTEND_DT, 1, 4) = $YEAR
							#total check
							AND IF($totalBool = TRUE, SUBSTRING(chk.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(chk.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
							AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6)
						GROUP BY USER_NO, MNTH
					) a
					LEFT JOIN (
						SELECT
							chk.USER_NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MNTH, 
							IFNULL(SUM(a.DAY_REPORT_TM), 0) AS DAY_REPORT_TM
						FROM
							TBL_ATTEND_CHECK chk
							INNER JOIN TBL_DAY_REPORT a
								ON a.USER_NO = chk.USER_NO
								AND a.DAY_REPORT_DT = chk.ATTEND_DT
								AND a.DAY_REPORT_TM > 0
							INNER JOIN TBL_SCHEDULE b
								ON b.SCHE_TYP IN ('H', 'I', 'J') 
								AND b.DELETE_YN = 'N'
								AND chk.ATTEND_DT = CONCAT(b.SCHE_YEAR, b.SCHE_MONTH, b.SCHE_DATE)
						WHERE
							SUBSTRING(chk.ATTEND_DT, 1, 4) = $YEAR
							#total check
							AND IF($totalBool = TRUE, SUBSTRING(chk.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(chk.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
							AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6)
						GROUP BY USER_NO, MNTH
					) b ON a.USER_NO = b.USER_NO AND a.MNTH = b.MNTH
				GROUP BY USER_NO, MNTH
			) totalInput ON prjInput.USER_NO = totalInput.USER_NO AND prjInput.MONTH = totalInput.MNTH
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO,
					cal.CAL_MONTH AS MNTH,
					COUNT(DISTINCT cal.CAL_DATE) AS ALL_DT_CNT
				FROM
					(
						TBL_CALENDAR_DATA cal,
						TBL_USERINFO usr
					)
					LEFT JOIN TBL_SCHEDULE b
						ON b.SCHE_TYP IN ('H', 'I', 'J') 
						AND b.DELETE_YN = 'N'
						AND cal.CAL_YEAR = b.SCHE_YEAR 
						AND cal.CAL_MONTH = b.SCHE_MONTH 
						AND cal.CAL_DAY = b.SCHE_DATE
				WHERE
					cal.CAL_YEAR = $YEAR
					#total check
					AND IF($totalBool = TRUE, cal.CAL_MONTH <= LPAD($MONTH,2,'0'), cal.CAL_MONTH = LPAD($MONTH,2,'0'))
					AND DAYOFWEEK(cal.CAL_DATE) IN (2, 3, 4, 5, 6)
					AND DATEDIFF(SYSDATE(), cal.CAL_DATE) >= 0
					AND b.SCHE_ID IS NULL
				GROUP BY usr.NO, cal.CAL_MONTH
			) totalWorkDay ON prjInput.USER_NO = totalWorkDay.USER_NO AND prjInput.MONTH = totalWorkDay.MNTH
			LEFT JOIN (
				SELECT
					a.USER_NO AS USER_NO,
					a.MNTH AS MNTH,
					a.ATTEND_CNT - IFNULL(b.HOL_ATTEND_CNT, 0) AS DT_CNT
				FROM
					(
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(a.ATTEND_DT, 5, 2) AS MNTH,
							COUNT(DISTINCT a.NO) AS ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK a 
								ON usr.NO = a.USER_NO 
								AND SUBSTRING(a.ATTEND_DT, 1, 4) = $YEAR 
								#total check
								AND IF($totalBool = TRUE, SUBSTRING(a.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(a.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
								AND DAYOFWEEK(a.ATTEND_DT) IN (2, 3, 4, 5, 6) 
						GROUP BY USER_NO, MNTH
					) a
					LEFT JOIN (
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(a.ATTEND_DT, 5, 2) AS MNTH,
							COUNT(DISTINCT a.NO) AS HOL_ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK a 
								ON usr.NO = a.USER_NO 
								AND SUBSTRING(a.ATTEND_DT, 1, 4) = $YEAR 
								#total check
								AND IF($totalBool = TRUE, SUBSTRING(a.ATTEND_DT, 5, 2) <= LPAD($MONTH,2,'0'), SUBSTRING(a.ATTEND_DT, 5, 2) = LPAD($MONTH,2,'0'))
								AND DAYOFWEEK(a.ATTEND_DT) IN (2, 3, 4, 5, 6) 
							INNER JOIN TBL_SCHEDULE b 
								ON a.ATTEND_DT = CONCAT(b.SCHE_YEAR, b.SCHE_MONTH, b.SCHE_DATE)
								AND b.SCHE_TYP IN ('H', 'I', 'J') 
								AND b.DELETE_YN = 'N'
						GROUP BY USER_NO, MNTH
					) b ON a.USER_NO = b.USER_NO AND a.MNTH = b.MNTH
			) userWorkDay ON prjInput.USER_NO = userWorkDay.USER_NO AND prjInput.MONTH = userWorkDay.MNTH
		WHERE
			#total check
			IF(TRUE = TRUE, prjInput.MONTH <= LPAD($MONTH,2,'0'), prjInput.MONTH = LPAD($MONTH,2,'0'))
		GROUP BY USER_NO, MNTH, PRJ_ID
	) T;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_LABOR_bak4`($id VARCHAR(20), $YEAR CHAR(4), $MONTH CHAR(2)
	, $includeResult CHAR(1), $common CHAR(1), $sub CHAR(1), $total CHAR(1)) RETURNS bigint(20)
BEGIN
	#2013-03-12 백업
	DECLARE $result BIGINT(20);
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT		
		IFNULL(SUM(PRJ_SALARY),0) AS SALARY
	INTO
		$result
	FROM
	(
		SELECT
			prjInput.PRJ_ID AS PRJ_ID, 
			prjInput.MONTH AS MONTH,
			prjInput.USER_NO AS USER_NO,
			IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS USER_SALARY,
			prjInput.TM AS PRJ_TM,
			totalInput.TM AS TOT_TM,
			userWorkDay.DT_CNT AS DT_CNT,
			totalWorkDay.ALL_DT_CNT AS ALL_DT_CNT,
			IFNULL(prjInput.TM / totalInput.TM, 0) 
			* IFNULL(userWorkDay.DT_CNT / totalWorkDay.ALL_DT_CNT, 0) 
			* IFNULL(userSalary.SALARY, IFNULL(rankSalary.SALARY, 0)) AS PRJ_SALARY
		FROM
			(
				SELECT
					dr.USER_NO AS USER_NO,
					SUBSTRING(dr.DAY_REPORT_DT, 5, 2) AS MONTH, 
					IFNULL(SUM(IFNULL(dr.DAY_REPORT_TM, 0)), 0) AS TM,
					task.PRJ_ID AS PRJ_ID
				FROM
					TBL_DAY_REPORT dr
					INNER JOIN TBL_TASK task
						ON dr.TASK_ID = task.TASK_ID
					INNER JOIN TBL_PRJ prj
						ON task.PRJ_ID = prj.PRJ_ID
						#sub check
						AND ($subBool1 = TRUE OR prj.ORG_PRJ_TREE LIKE CONCAT('%', $id, '%'))
						AND ($subBool1 = FALSE OR $subBool2 = TRUE OR prj.PRJ_ID = $id)
						AND ($subBool1 = FALSE OR $subBool2 = FALSE OR prj.ORGNZT_ID = $id)
				WHERE
					dr.DAY_REPORT_TM > 0
					#total check
					AND IF($totalBool = TRUE, dr.DAY_REPORT_DT BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31')
						, dr.DAY_REPORT_DT LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))
				GROUP BY
					USER_NO, MONTH, PRJ_ID
			) prjInput
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO
					,sal.SALARY1 + (sal.SALARY2 * 2) + (sal.SALARY3 * 3) AS SALARY
					,sal.MONTH AS MONTH
				FROM
					TBL_USERINFO usr
					INNER JOIN TBL_USER_SALARY sal
						ON usr.NO = sal.USER_NO
						AND sal.YEAR = $YEAR
						#total check
						AND IF($totalBool = TRUE, sal.MONTH <= LPAD($MONTH, 2, '0'), sal.MONTH = LPAD($MONTH, 2, '0'))
			) userSalary 
				ON prjInput.USER_NO = userSalary.USER_NO 
				AND prjInput.MONTH = userSalary.MONTH
			LEFT JOIN (
				SELECT
					usr.NO AS USER_NO
					,sal.SALARY AS SALARY
					,sal.MONTH AS MONTH
				FROM
					TBL_USERINFO usr
					INNER JOIN TBL_RANK_SALARY sal
						ON usr.RANK_ID = sal.RANK_CODE
						AND sal.YEAR = $YEAR
						#total check
						AND IF($totalBool = TRUE, sal.MONTH <= LPAD($MONTH, 2, '0'), sal.MONTH = LPAD($MONTH, 2, '0'))
			) rankSalary 
				ON prjInput.USER_NO = rankSalary.USER_NO 
				AND prjInput.MONTH = rankSalary.MONTH
			LEFT JOIN (
				SELECT
					dr.USER_NO AS USER_NO,
					SUBSTRING(dr.DAY_REPORT_DT, 5, 2) AS MONTH, 
					IFNULL(SUM(IFNULL(dr.DAY_REPORT_TM, 0)), 0) AS TM
				FROM
					TBL_DAY_REPORT dr
				WHERE
					dr.DAY_REPORT_TM > 0
					#total check
					AND IF($totalBool = TRUE, dr.DAY_REPORT_DT BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31')
						, dr.DAY_REPORT_DT LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))
				GROUP BY
					USER_NO, MONTH
			) totalInput 
				ON prjInput.USER_NO = totalInput.USER_NO 
				AND prjInput.MONTH = totalInput.MONTH
			LEFT JOIN (
				SELECT
					SUBSTRING(chk.ATTEND_DT, 5, 2) AS MONTH,
					COUNT(DISTINCT chk.ATTEND_DT) AS ALL_DT_CNT
				FROM
					(
						SELECT
							ATTEND_DT
						FROM
							TBL_ATTEND_CHECK
						WHERE
							DAYOFWEEK(ATTEND_DT) IN (2, 3, 4, 5, 6)
							#total check
							AND IF($totalBool = TRUE, ATTEND_DT BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31')
								, ATTEND_DT LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))
						GROUP BY
							ATTEND_DT
					) chk
					LEFT JOIN TBL_SCHEDULE sch
						ON sch.SCHE_TYP IN ('H', 'I', 'J') 
						AND sch.DELETE_YN = 'N'
						AND chk.ATTEND_DT = CONCAT(sch.SCHE_YEAR, sch.SCHE_MONTH, sch.SCHE_DATE)
				WHERE
					sch.SCHE_ID IS NULL
				GROUP BY MONTH
			) totalWorkDay 
				ON prjInput.MONTH = totalWorkDay.MONTH
			LEFT JOIN (
				SELECT
					A.USER_NO AS USER_NO,
					A.MONTH AS MONTH,
					A.ATTEND_CNT - IFNULL(B.HOL_ATTEND_CNT, 0) AS DT_CNT
				FROM
					(
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MONTH,
							COUNT(DISTINCT chk.NO) AS ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK chk 
								ON usr.NO = chk.USER_NO 
								AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6) 
								#total check
								AND IF($totalBool = TRUE, chk.ATTEND_DT BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31')
									, chk.ATTEND_DT LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))
						GROUP BY USER_NO, MONTH
					) A
					LEFT JOIN (
						SELECT
							usr.NO AS USER_NO,
							SUBSTRING(chk.ATTEND_DT, 5, 2) AS MONTH,
							COUNT(DISTINCT chk.NO) AS HOL_ATTEND_CNT
						FROM
							TBL_USERINFO usr
							INNER JOIN TBL_ATTEND_CHECK chk 
								ON usr.NO = chk.USER_NO
								AND DAYOFWEEK(chk.ATTEND_DT) IN (2, 3, 4, 5, 6) 
								#total check
								AND IF($totalBool = TRUE, chk.ATTEND_DT BETWEEN CONCAT($YEAR, '0000') AND CONCAT($YEAR, LPAD($MONTH, 2, '0'), '31')
									, chk.ATTEND_DT LIKE CONCAT($YEAR, LPAD($MONTH, 2, '0'), '%'))
							INNER JOIN TBL_SCHEDULE sch 
								ON sch.SCHE_TYP IN ('H', 'I', 'J') 
								AND sch.DELETE_YN = 'N'
								AND chk.ATTEND_DT = CONCAT(sch.SCHE_YEAR, sch.SCHE_MONTH, sch.SCHE_DATE)				
						GROUP BY USER_NO, MONTH
					) B ON A.USER_NO = B.USER_NO AND A.MONTH = B.MONTH
			) userWorkDay 
				ON prjInput.USER_NO = userWorkDay.USER_NO 
				AND prjInput.MONTH = userWorkDay.MONTH
		WHERE
			#total check
			IF($totalBool = TRUE, prjInput.MONTH <= LPAD($MONTH, 2, '0')
				, prjInput.MONTH = LPAD($MONTH, 2, '0'))
		GROUP BY USER_NO, MONTH, PRJ_ID
	) T;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_MEMBER_ABSENT_PERIOD`($USER_NO INT) RETURNS varchar(4) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result VARCHAR(4) DEFAULT '0';
			
	SELECT
	 SUM(ABSENT_PERIOD) AS ABSENT_PERIOD
	INTO result
	FROM (
		SELECT
		 *, PERIOD_DIFF(IFNULL(LEFT(CHNG_DT2, 6), REPLACE(LEFT(CURDATE(),7), '-', ''))
			, LEFT(CHNG_DT,6)) ABSENT_PERIOD
		FROM(
			#휴직 - 복귀 기간
		SELECT USER_NO, CHNG_CODE, CHNG_DT, 
			(SELECT MIN(CHNG_DT)
			   FROM TBL_POSITION_HISTORY
			  WHERE NO > A.NO
			    AND CHNG_CODE = 'BK'
			    AND USER_NO = $USER_NO) AS CHNG_DT2
		FROM 	TBL_POSITION_HISTORY A
		WHERE   CHNG_CODE = 'LV'
		AND 	USER_NO = $USER_NO
		  
		UNION ALL
		#퇴사 - 재입사 기간
		SELECT USER_NO, CHNG_CODE, CHNG_DT, 
			(SELECT MIN(CHNG_DT)
			   FROM TBL_POSITION_HISTORY
			  WHERE NO > A.NO
			    AND CHNG_CODE = 'RE'
			    AND USER_NO = $USER_NO) AS CHNG_DT2
		FROM 	TBL_POSITION_HISTORY A
		WHERE   CHNG_CODE = 'RT'
		AND 	USER_NO = $USER_NO
		) A		
	) A
	GROUP BY A.USER_NO
	;
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_MEMBER_AGE`($USER_NO INT, $yyyymmdd CHAR(8)) RETURNS varchar(4) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result VARCHAR(4) DEFAULT '';
	IF($yyyymmdd = '')
	THEN 
		SET $yyyymmdd = CURDATE()+0; 	
	END IF;
	
	SELECT
		IFNULL(
			(YEAR($yyyymmdd)-YEAR(BIRTH)) - (RIGHT($yyyymmdd,4)<RIGHT(BIRTH,4))
			,999 
		) AS AGE
	INTO result
	FROM
		TBL_USERINFO A
		INNER JOIN (
			SELECT
				NO, USER_NM, IHIDNUM, BRTH, 
				IF(IFNULL(BRTH, '')=''
					,IF(IFNULL(LEFT(IHIDNUM,6), '')=''
						,'10010101'
						,IF(LEFT(IHIDNUM,2)<20
							,CONCAT('20',LEFT(IHIDNUM,6))
							,CONCAT('19',LEFT(IHIDNUM,6))
						)
					)
				, BRTH) AS BIRTH
			FROM
				TBL_USERINFO
		) B
		ON A.NO = B.NO
	WHERE A.NO = $USER_NO
	;
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_MEMBER_AGE_KOR`($USER_NO INT, $yyyymmdd CHAR(8)) RETURNS varchar(4) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result VARCHAR(4) DEFAULT '';
	IF($yyyymmdd = '')
	THEN 
		SET $yyyymmdd = CURDATE()+0; 	
	END IF;
	
	SELECT
		IFNULL(
			(YEAR($yyyymmdd)-YEAR(BIRTH)) + 1
			,999 
		) AS AGE
	INTO result
	FROM
		TBL_USERINFO A
		INNER JOIN (
			SELECT
				NO, USER_NM, IHIDNUM, BRTH, 
				IF(IFNULL(BRTH, '')=''
					,IF(IFNULL(LEFT(IHIDNUM,6), '')=''
						,'10010101'
						,IF(LEFT(IHIDNUM,2)<20
							,CONCAT('20',LEFT(IHIDNUM,6))
							,CONCAT('19',LEFT(IHIDNUM,6))
						)
					)
				, BRTH) AS BIRTH
			FROM
				TBL_USERINFO
		) B
		ON A.NO = B.NO
	WHERE A.NO = $USER_NO
	;
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_MEMBER_WORK_PERIOD`($USER_NO INT) RETURNS varchar(4) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result VARCHAR(4) DEFAULT '';
		
	
	SELECT
		PERIOD_DIFF(LEFT(CURDATE()+0, 6), LEFT(A.COMPIN_DT,6))  - FN_GET_MEMBER_ABSENT_PERIOD(NO) AS WORK_PERIOD
	INTO result
	FROM
		TBL_USERINFO A
 	WHERE A.NO = $USER_NO	
	;
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_ORGID_HISTORY`($USER_NO INT, $yyyymmdd CHAR(8)) RETURNS char(20) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result CHAR(20) DEFAULT 'ORGAN_STD_ORGAN_CODE';
	
	SELECT
		IFNULL(a.AFT_ORGNZT_ID, 'ORGAN_STD_ORGAN_CODE')
	INTO result
	FROM
		TBL_POSITION_HISTORY a
	WHERE
		a.USER_NO = $USER_NO
		AND a.CHNG_DT <= $yyyymmdd
	ORDER BY a.CHNG_DT DESC, a.NO DESC
	LIMIT 1;
	
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_ORGNM_HISTORY`($USER_NO INT, $yyyymmdd CHAR(8)) RETURNS varchar(500) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result VARCHAR(500) DEFAULT '';
	
	SELECT
		IFNULL(a.AFT_ORGNZT_NM, '')
	INTO result
	FROM
		TBL_POSITION_HISTORY a
	WHERE
		a.USER_NO = $USER_NO
		AND a.CHNG_DT <= $yyyymmdd
	ORDER BY a.CHNG_DT DESC, a.NO DESC
	LIMIT 1;
	
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_PLAN_EXP`($id VARCHAR(20),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 COST
		FROM TBL_PLAN_EXP a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR EXP_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR EXP_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR c.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR c.PRJ_ID = $id)
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR c.ORGNZT_ID = $id )
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_PLAN_EXP_ARR`($id VARCHAR(400),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 COST
		FROM TBL_PLAN_EXP a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR EXP_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR EXP_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, c.PRJ_ID) = 1)
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',c.PRJ_ID,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',c.ORGNZT_ID,'%'))
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_PLAN_LABOR`($id VARCHAR(20),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN;
	DECLARE $totalBool BOOLEAN;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 COST AS COST
		FROM TBL_PLAN_LABOR a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR LABOR_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR LABOR_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR c.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR c.PRJ_ID = $id)
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR c.ORGNZT_ID = $id )
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_PLAN_LABOR_ARR`($id VARCHAR(400),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN;
	DECLARE $totalBool BOOLEAN;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 COST AS COST
		FROM TBL_PLAN_LABOR a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR LABOR_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR LABOR_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, c.PRJ_ID) = 1)
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',c.PRJ_ID,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',c.ORGNZT_ID,'%'))
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_POSITIONNM_HISTORY`($USER_NO INT, $yyyymmdd CHAR(8)) RETURNS varchar(200) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result VARCHAR(200) DEFAULT '';
	
	SELECT
		CASE
			WHEN a.AFT_POSITION = 'H' THEN a.AFT_POSITION_NM
			WHEN a.AFT_POSITION = 'S' THEN a.AFT_POSITION_NM
			ELSE ( SELECT CODE_NM FROM COMTCCMMNDETAILCODE WHERE CODE_ID = 'KMS011' AND CODE = a.AFT_POSITION )
		END
	INTO result
	FROM
		TBL_POSITION_HISTORY a
	WHERE
		a.USER_NO = $USER_NO
		AND a.CHNG_DT <= $yyyymmdd
	ORDER BY a.CHNG_DT DESC, a.NO DESC
	LIMIT 1;
	
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_POSITION_HISTORY`($USER_NO INT, $yyyymmdd CHAR(8)) RETURNS char(1) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result CHAR(1) DEFAULT 'N';
	
	SELECT
		IFNULL(a.AFT_POSITION, 'N')
	INTO result
	FROM
		TBL_POSITION_HISTORY a
	WHERE
		a.USER_NO = $USER_NO
		AND a.CHNG_DT <= $yyyymmdd
	ORDER BY a.CHNG_DT DESC, a.NO DESC
	LIMIT 1;
	
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_PURCHASE_IN`($id VARCHAR(20),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $commonBool1 BOOLEAN; 
	DECLARE $commonBool2 BOOLEAN; 
	DECLARE $commonBool3 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	SET $commonBool1 = TRUE;
	SET $commonBool2 = TRUE;
	SET $commonBool3 = TRUE;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	CASE 
		WHEN $common='A'
		THEN SET $commonBool1 = FALSE;
		WHEN $common='Y'
		THEN SET $commonBool2 = FALSE;
		WHEN $common='N'
		THEN SET $commonBool3 = FALSE;
	END CASE;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 a.COST COST
		FROM TBL_PURCHASE_IN a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.SALES_PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR PURCHASE_IN_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR PURCHASE_IN_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR c.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR c.PRJ_ID = $id)
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR c.ORGNZT_ID = $id )
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		#common check
		AND ($commonBool1= TRUE OR 1=1)
		AND ($commonBool2= TRUE OR a.TYP='C')
		AND ($commonBool3= TRUE OR a.TYP!='C' OR a.TYP IS NULL)
		
		UNION ALL 
		SELECT
			COST AS COST
		FROM TBL_PURCHASE_IN_LABOR a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.SALES_PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR PURCHASE_IN_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR PURCHASE_IN_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR c.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR c.PRJ_ID = $id)
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR c.ORGNZT_ID = $id )
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')	
		#common check
		AND ($commonBool1= TRUE OR 1=1)
		AND ($commonBool2= TRUE OR 1=2)
		AND ($commonBool3= TRUE OR 1=1)	
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_PURCHASE_IN_ARR`($id VARCHAR(400),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $commonBool1 BOOLEAN; 
	DECLARE $commonBool2 BOOLEAN; 
	DECLARE $commonBool3 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	SET $commonBool1 = TRUE;
	SET $commonBool2 = TRUE;
	SET $commonBool3 = TRUE;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	CASE 
		WHEN $common='A'
		THEN SET $commonBool1 = FALSE;
		WHEN $common='Y'
		THEN SET $commonBool2 = FALSE;
		WHEN $common='N'
		THEN SET $commonBool3 = FALSE;
	END CASE;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 a.COST COST
		FROM TBL_PURCHASE_IN a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.SALES_PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR PURCHASE_IN_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR PURCHASE_IN_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, c.PRJ_ID) = 1)
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',c.PRJ_ID,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',c.ORGNZT_ID,'%'))
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		#common check
		AND ($commonBool1= TRUE OR 1=1)
		AND ($commonBool2= TRUE OR a.TYP='C')
		AND ($commonBool3= TRUE OR a.TYP!='C' OR a.TYP IS NULL)
		
		UNION ALL 
		SELECT
			COST AS COST
		FROM TBL_PURCHASE_IN_LABOR a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.SALES_PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR PURCHASE_IN_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR PURCHASE_IN_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, c.PRJ_ID) = 1)
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',c.PRJ_ID,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',c.ORGNZT_ID,'%'))
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')	
		#common check
		AND ($commonBool1= TRUE OR 1=1)
		AND ($commonBool2= TRUE OR 1=2)
		AND ($commonBool3= TRUE OR 1=1)	
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_PURCHASE_OUT`($id VARCHAR(20),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 a.COST COST
		FROM TBL_PURCHASE_OUT a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR PURCHASE_OUT_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR PURCHASE_OUT_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR c.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR c.PRJ_ID = $id)
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR c.ORGNZT_ID = $id )
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_PURCHASE_OUT_ARR`($id VARCHAR(400),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 a.COST COST
		FROM TBL_PURCHASE_OUT a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR PURCHASE_OUT_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR PURCHASE_OUT_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, c.PRJ_ID) = 1)
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',c.PRJ_ID,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',c.ORGNZT_ID,'%'))
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_RANKID_HISTORY`($USER_NO INT, $yyyymmdd CHAR(8)) RETURNS char(20) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result CHAR(20) DEFAULT '00';
	
	SELECT
		IFNULL(a.AFT_RANK_ID, '00')
	INTO result
	FROM
		TBL_POSITION_HISTORY a
	WHERE
		a.USER_NO = $USER_NO
		AND a.CHNG_DT <= $yyyymmdd
	ORDER BY a.CHNG_DT DESC, a.NO DESC
	LIMIT 1;
	
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_RANKNM_HISTORY`($USER_NO INT, $yyyymmdd CHAR(8)) RETURNS varchar(60) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE result VARCHAR(60) DEFAULT '';
	
	SELECT
		IFNULL(b.CODE_NM, '')
	INTO result
	FROM
		TBL_POSITION_HISTORY a
		LEFT JOIN COMTCCMMNDETAILCODE b
			ON a.AFT_RANK_ID = b.CODE
			AND b.CODE_ID = 'KMS003'
	WHERE
		a.USER_NO = $USER_NO
		AND a.CHNG_DT <= $yyyymmdd
	ORDER BY a.CHNG_DT DESC, a.NO DESC
	LIMIT 1;
	
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_SALARY`($userNo int(11), $year varchar(4),$month VARCHAR(2)) RETURNS int(11)
BEGIN
	DECLARE $salary INT(20);
	
	#NO, YEAR, MONTH 세 컬럼이 PK
	SELECT 
		#CAST( (SALARY1 + SALARY2*2 + SALARY3*3)  AS SIGNED ) AS SALARY #2013-05-13 SALARY2는 변동 인건비로 용도 변경
		CAST(SALARY1 AS SIGNED)
	INTO $salary
	FROM 
		TBL_USER_SALARY A
	WHERE
		A.USER_NO = $userNo
		AND A.YEAR = $YEAR
		AND A.MONTH = $MONTH		
	;
	
	#해당 데이터가 없는 경우 가장 나중것
	IF $salary IS NULL	
	THEN
	
	SELECT 
		#CAST( (SALARY1 + SALARY2*2 + SALARY3*3)  AS SIGNED ) AS SALARY #2013-05-13 SALARY2는 변동 인건비로 용도 변경
		CAST(SALARY1 AS SIGNED) AS SALARY
	INTO $salary
	FROM 
		TBL_USER_SALARY A
	WHERE
		A.USER_NO = $userNo
	ORDER BY 
		A.YEAR DESC
		, A.MONTH DESC
	LIMIT 0, 1;
	
	END IF;	
	
	#없는 경우 직급별 인건비 테이블에서 불러옴. 여기서도 상승률은 무시
	IF $salary IS NULL	
	THEN
	
	SELECT 
		#CAST((SALARY * POW(IF(DISPLACE<0, 1-PERCENT, 1+ PERCENT),ABS_YEAR)) AS SIGNED ) AS SALARY 
		CAST(SALARY AS SIGNED ) AS SALARY 
	INTO $salary
	FROM (
		SELECT 
			ABS($YEAR - YEAR) AS ABS_YEAR
			, ($YEAR-YEAR) AS DISPLACE
			, SALARY
			, b.CODE PERCENT
		FROM 
			TBL_RANK_SALARY a
			INNER JOIN TBL_USERINFO c
				ON a.RANK_CODE = c.RANK_ID
			LEFT OUTER JOIN COMTCCMMNDETAILCODE b
				ON b.CODE_ID = 'KMS012'
		WHERE
			c.NO = $userNo
			AND a.MONTH = $month
		ORDER BY 
			ABS($YEAR - YEAR) ASC , YEAR DESC
		LIMIT 0,1
		) a;
	END IF;
  
	IF $salary IS NULL 
	THEn set $salary = 0;
	END IF;
	RETURN $salary;
    
    
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_SALARY_bak`($userNo int(11), $year varchar(4),$month VARCHAR(2)) RETURNS int(11)
BEGIN
	#2013년 3월 26일에 백업
	#기존 방식에서 마지막 입력월 금액 그대로 불러오는 방식으로 변경
	DECLARE $salary INT(20);
	SELECT 
		CAST((SALARY * POW(IF(DISPLACE<0, 1-PERCENT, 1+ PERCENT),ABS_YEAR)) AS SIGNED ) 
	INTO $salary
	FROM (
		SELECT 
			ABS($YEAR - YEAR) AS ABS_YEAR
			, ($YEAR-YEAR) AS DISPLACE
			, (SALARY1 + SALARY2*2 + SALARY3*3) AS SALARY
			, b.CODE PERCENT
		FROM 
			TBL_USER_SALARY a
			LEFT OUTER JOIN COMTCCMMNDETAILCODE b
				ON b.CODE_ID = 'KMS012'
		WHERE
			a.USER_NO = $userNo
			AND a.MONTH = $month
		ORDER BY 
			ABS($YEAR - YEAR) ASC , YEAR DESC
		LIMIT 0,1
	) a;
	IF $salary IS NULL 
	
	THEN
	
	SELECT 
		CAST((SALARY * POW(IF(DISPLACE<0, 1-PERCENT, 1+ PERCENT),ABS_YEAR)) AS SIGNED ) AS SALARY 
	INTO $salary
	FROM (
		SELECT 
			ABS($YEAR - YEAR) AS ABS_YEAR
			, ($YEAR-YEAR) AS DISPLACE
			, SALARY
			, b.CODE PERCENT
		FROM 
			TBL_RANK_SALARY a
			INNER JOIN TBL_USERINFO c
				ON a.RANK_CODE = c.RANK_ID
			LEFT OUTER JOIN COMTCCMMNDETAILCODE b
				ON b.CODE_ID = 'KMS012'
		WHERE
			c.NO = $userNo
			AND a.MONTH = $month
		ORDER BY 
			ABS($YEAR - YEAR) ASC , YEAR DESC
		LIMIT 0,1
		) a;
	END IF;
  
	IF $salary IS NULL 
	THEn set $salary = 0;
	END IF;
	RETURN $salary;
    
    
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_SALES_IN`($id VARCHAR(20),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $commonBool1 BOOLEAN; 
	DECLARE $commonBool2 BOOLEAN; 
	DECLARE $commonBool3 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	SET $commonBool1 = TRUE;
	SET $commonBool2 = TRUE;
	SET $commonBool3 = TRUE;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	CASE 
		WHEN $common='A'
		THEN SET $commonBool1 = FALSE;
		WHEN $common='Y'
		THEN SET $commonBool2 = FALSE;
		WHEN $common='N'
		THEN SET $commonBool3 = FALSE;
	END CASE;
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 a.COST COST
		FROM TBL_PURCHASE_IN a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		#반려문서 제외
		AND B.DOC_STAT != 'APP099'
		INNER JOIN TBL_PRJ c
		ON a.PURCHASE_PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR PURCHASE_IN_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR PURCHASE_IN_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR c.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR c.PRJ_ID = $id)
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR c.ORGNZT_ID = $id )
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		#common check
		AND ($commonBool1= TRUE OR a.TYP= a.TYP)
		AND ($commonBool2= TRUE OR a.TYP='C')
		AND ($commonBool3= TRUE OR a.TYP!='C')
		UNION ALL 
		SELECT
			COST AS COST
		FROM TBL_PURCHASE_IN_LABOR a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		#반려문서 제외
		AND B.DOC_STAT != 'APP099'
		INNER JOIN TBL_PRJ c
		ON a.PURCHASE_PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR PURCHASE_IN_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR PURCHASE_IN_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR c.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR c.PRJ_ID = $id)
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR c.ORGNZT_ID = $id )
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		#common check
		AND ($commonBool1= TRUE OR 1=1)
		AND ($commonBool2= TRUE OR 1=2)
		AND ($commonBool3= TRUE OR 1=1)	
		
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_SALES_IN_ARR`($id VARCHAR(400),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $commonBool1 BOOLEAN; 
	DECLARE $commonBool2 BOOLEAN; 
	DECLARE $commonBool3 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	SET $commonBool1 = TRUE;
	SET $commonBool2 = TRUE;
	SET $commonBool3 = TRUE;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	CASE 
		WHEN $common='A'
		THEN SET $commonBool1 = FALSE;
		WHEN $common='Y'
		THEN SET $commonBool2 = FALSE;
		WHEN $common='N'
		THEN SET $commonBool3 = FALSE;
	END CASE;
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 a.COST COST
		FROM TBL_PURCHASE_IN a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1		
		#반려문서 제외
		AND B.DOC_STAT != 'APP099'
		INNER JOIN TBL_PRJ c
		ON a.PURCHASE_PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR PURCHASE_IN_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR PURCHASE_IN_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, c.PRJ_ID) = 1)
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',c.PRJ_ID,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',c.ORGNZT_ID,'%'))
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		#common check
		AND ($commonBool1= TRUE OR a.TYP= a.TYP)
		AND ($commonBool2= TRUE OR a.TYP='C')
		AND ($commonBool3= TRUE OR a.TYP!='C')
		UNION ALL 
		SELECT
			COST AS COST
		FROM TBL_PURCHASE_IN_LABOR a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.PURCHASE_PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR PURCHASE_IN_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR PURCHASE_IN_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, c.PRJ_ID) = 1)
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',c.PRJ_ID,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',c.ORGNZT_ID,'%'))
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		#common check
		AND ($commonBool1= TRUE OR 1=1)
		AND ($commonBool2= TRUE OR 1=2)
		AND ($commonBool3= TRUE OR 1=1)	
		
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_SALES_OUT`($id VARCHAR(20),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 a.COST COST
		FROM TBL_SALES a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR SALES_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR SALES_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR c.ORG_PRJ_TREE LIKE CONCAT('%',$id,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR c.PRJ_ID = $id)
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR c.ORGNZT_ID = $id )
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_GET_SALES_OUT_ARR`($id VARCHAR(400),$YEAR CHAR(4), $MONTH CHAR(2), $includeResult CHAR(1),$common CHAR(1), $sub CHAR(1),$total CHAR(1)) RETURNS bigint(20)
BEGIN
	DECLARE $result BIGINT(20);
	DECLARE $includeResultBool BOOLEAN;
	DECLARE $subBool1 BOOLEAN;
	DECLARE $subBool2 BOOLEAN; 
	DECLARE $totalBool BOOLEAN;
	IF($includeResult='Y')
	THEN SET $includeResultBool = TRUE;
	ELSE SET $includeResultBool = FALSE;
	END IF;
	
	IF($sub='Y')
	THEN 
		SET $subBool1 = FALSE; 
		SET $subBool2 = TRUE;
	ELSE
		SET $subBool1 = TRUE;
		IF ('ORG' = SUBSTR($id,1,3))
		THEN SET $subBool2 =  TRUE;
		ELSE SET $subBool2 =  FALSE;
		END IF;
	END IF;
	
	IF($total='Y')
	THEN SET $totalBool = TRUE;
	ELSE SET $totalBool = FALSE;
	END IF;
	
	SELECT IFNULL(SUM(COST),0)
	INTO $result
	FROM
	(
		SELECT
			 a.COST COST
		FROM TBL_SALES a
		INNER JOIN TBL_EAPP_DOC b
		ON a.DOC_ID = b.DOC_ID
		AND b.NEW_AT = 1
		INNER JOIN TBL_PRJ c
		ON a.PRJ_ID = c.PRJ_ID
		WHERE 1=1
		#total check
		AND ($totalBool = TRUE OR SALES_DT LIKE CONCAT($YEAR,LPAD($MONTH,2,'0'),'%'))
		AND ($totalBool = FALSE OR SALES_DT BETWEEN CONCAT($YEAR,'0000') AND CONCAT($YEAR,LPAD($MONTH,2,'0'),31))
		#sub check
		AND ($subBool1 = TRUE OR FN_IS_PRNT_ARR($id, c.PRJ_ID) =1)
		AND ($subBool1 = FALSE OR $subBool2 = TRUE OR $id LIKE CONCAT('%',c.PRJ_ID,'%'))
		AND ($subBool1 = FALSE OR $subBool2 = FALSE OR $id LIKE CONCAT('%',c.ORGNZT_ID,'%'))
		#decideYn check
		AND ($includeResultBool = TRUE OR DECIDE_YN  ='Y')
		
	) a ;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_HOL_SALARY_bak`($USER_NO INT, $yyyymmdd CHAR(8)) RETURNS int(11)
BEGIN
	DECLARE yyyy INT DEFAULT CONVERT(SUBSTRING($yyyymmdd,1,4), UNSIGNED);
	DECLARE mm INT DEFAULT CONVERT(SUBSTRING($yyyymmdd,5,2), UNSIGNED);
	
	DECLARE result INT DEFAULT 0;
	
	SELECT GREATEST(IFNULL(b.SALARY,0), IFNULL(c.SALARY,0), IFNULL(d.SALARY,0))
	INTO result
	FROM TBL_USERINFO a
	LEFT JOIN TBL_USER_HOL_SALARY b ON a.NO = b.USER_NO AND b.YEAR = yyyy AND b.MONTH = mm
	LEFT JOIN TBL_RANK_HOL_SALARY c ON a.RANK_ID = c.RANK_CODE AND c.YEAR = yyyy AND c.MONTH = mm
	LEFT JOIN TBL_POS_HOL_SALARY d ON a.POSITION = d.POSITION_CODE AND d.YEAR = yyyy AND d.MONTH = mm
	WHERE a.NO = $USER_NO;
	
	
	RETURN result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_IS_AT_WORK`($userNo INT, $dt CHAR(8)) RETURNS char(1) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE $result CHAR(1) DEFAULT 'N';
	SELECT
		IF(pos.CHNG_CODE IN ('EN', 'RE', 'BK'), 'Y', IF(pos.CHNG_DT = $dt, 'Y', 'N'))
	INTO
		$result
	FROM
		TBL_POSITION_HISTORY pos
	WHERE
		pos.USER_NO = $userNo
		AND pos.CHNG_CODE IN ('EN', 'RE', 'BK', 'RT', 'LV')
		AND pos.CHNG_DT <= $dt
	ORDER BY
		pos.CHNG_DT DESC
	LIMIT 1;
	
	RETURN $result;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_IS_HOLIDAY`($searchDate VARCHAR(8)) RETURNS char(1) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
	DECLARE $result char(1);
	
	SELECT
		CASE
			WHEN DAYOFWEEK($searchDate) = 1 THEN 1
			WHEN DAYOFWEEK($searchDate) = 7 THEN 1
			WHEN COUNT(*) >= 1 THEN 1
			ELSE 0
		END AS IS_HOLIDAY
	INTO
		$result
	FROM
		TBL_SCHEDULE
	WHERE
		SCHE_TYP IN ('H','I','J')
		AND DELETE_YN = 'N'
		AND SCHE_DATE_ALL = $searchDate
	;
	RETURN $result;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_IS_PRNT`($prntId VARCHAR(20), $childId VARCHAR(20)) RETURNS char(1) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
  DECLARE $tempPrnt1 VARCHAR(20);
  DECLARE $tempPrnt2 VARCHAR(20);
  
  
  IF(SUBSTRING($childId,1,3)="ORG" && SUBSTRING($prntId,1,3)="PRJ")
  	THEN RETURN 0;
  ELSEIF($prntId = $childId)
  	THEN RETURN 1;
  END IF;
  
  WHILE(TRUE) DO
  
  	IF SUBSTRING($childId,1,3)="PRJ" 
    THEN #프로젝트일 경우
    
      SELECT PRNT_PRJ_ID, ORGNZT_ID
      INTO $tempPrnt1, $tempPrnt2
      FROM TBL_PRJ
      WHERE PRJ_ID = $childId;
      
      IF($prntId = $tempPrnt1) 
      THEN 
      	RETURN 1;
      
      ELSEIF($tempPrnt1 = $childId)  #최상위 프로젝트
      THEN  
          IF($prntId = $tempPrnt2)
              THEN RETURN 1;
          ELSE SET $childId = $tempPrnt2;
          END IF; 
      ELSE
          SET $childId = $tempPrnt1;
      END IF;
      
	ELSE #부서일 경우
     
      SELECT ORG_UP
      INTO $tempPrnt1
      FROM TBL_ORGNZT
      WHERE ORGNZT_ID = $childId;
        
      IF($prntId = $tempPrnt1) 
          THEN RETURN 1;
      ELSEIF($childId = $tempPrnt1)
          THEN RETURN 0;
      ELSE
          SET $childId = $tempPrnt1;
      END IF;
    END IF;
    
  END WHILE;
  
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_IS_PRNT_ARR`($prntArr VARCHAR(400), $childId VARCHAR(20)) RETURNS char(1) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
  DECLARE $prntId VARCHAR(20);
  DECLARE $strNum INT;
  DECLARE $endNum INT;
  DECLARE $tstNum INT;
  DECLARE $tempPrnt1 VARCHAR(20);
  DECLARE $tempPrnt2 VARCHAR(20);
  DECLARE $loopVar BOOLEAN;  
  DECLARE $sn VARCHAR(400);  
  
  SET $strNum = 1;
  
  
  WHILE($strNum <= LENGTH($prntArr)) DO
	SET $prntId = SUBSTRING($prntArr,$strNum,20);
	IF SUBSTR($prntId, 1, 3) ='PRJ'
	THEN 
		SELECT ORG_PRJ_TREE
		INTO $sn
		FROM TBL_PRJ
		WHERE PRJ_ID = $childId;
		
		IF $sn LIKE CONCAT('%',$prntId,'%') 
		THEN RETURN 1;
		ELSE SET $strNum = $strNum + 21;
		END IF;
	ELSE
		SELECT ORG_TREE
		INTO $sn
		FROM TBL_ORGNZT
		WHERE ORGNZT_ID = $prntId;
		IF $sn LIKE CONCAT('%',$childId,'%') 
		THEN RETURN 1;
		ELSE SET $strNum = $strNum + 21;
		END IF;
	END IF;
	  
	  
  END WHILE;
  
  RETURN 0;
  
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_MAKE_PRJ_FNM`(prjNm varchar(200),
prjCd VARCHAR(200)
) RETURNS varchar(400) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
RETURN CONCAT("[",prjCd,"] ",prjNm)//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_MISSION_TREE`(Arg_TagId VARCHAR(25)) RETURNS varchar(500) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
    
DECLARE is_tagpath VARCHAR(500);
DECLARE is_tag_id VARCHAR(25);
DECLARE is_Higherid VARCHAR(25);
  SET is_tag_id = arg_Tagid;
  SET is_tagpath = '';
  SET is_Higherid = '';
   SELECT PRNT_MISSION_ID
    INTO   is_Higherid
    FROM   TBL_MISSION
    WHERE  MISSION_ID = is_tag_id;
  
  WHILE is_tag_id!=is_Higherid DO
  SET   is_tagpath = CONCAT_WS('/', is_Higherid, is_tagpath );		
  SET   is_tag_id  = is_Higherid;
    SELECT PRNT_MISSION_ID
    INTO   is_Higherid
    FROM   TBL_MISSION
    WHERE  MISSION_ID = is_tag_id;
    
  END WHILE;
  
  SET   is_tagpath = CONCAT(is_tagpath, arg_Tagid);
  RETURN   is_tagpath;
  
    END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_ORGAN_LOW_TREE`(Arg_TagId VARCHAR(20)) RETURNS varchar(4000) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN

  DECLARE done INT DEFAULT 0;
  DECLARE vLowerId VARCHAR(20);
  DECLARE vLowerIdPath VARCHAR(4000);

  # orgnzt_id 의 하위 조직들
  DECLARE cur1 CURSOR FOR
    SELECT orgnzt_id
      FROM TBL_ORGNZT
     where ORG_UP = Arg_TagId
       and use_yn = 'Y';
  
  # 커서가 마지막에 도착할 떄의 상태값
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  

  SET vLowerIdPath = Arg_TagId;

  open cur1;
  read_loop: LOOP
  
    FETCH cur1 INTO vLowerId;
    
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    SET vLowerIdPath = CONCAT(vLowerIdPath, ',', FN_ORGAN_LOW_TREE2(vLowerId));
        
  END LOOP; 

  RETURN   vLowerIdPath;

END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_ORGAN_LOW_TREE2`(Arg_TagId VARCHAR(20)) RETURNS varchar(4000) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN

  DECLARE done INT DEFAULT 0;
  DECLARE vLowerId VARCHAR(20);
  DECLARE vLowerIdPath VARCHAR(4000);

  # orgnzt_id 의 하위 조직들
  DECLARE cur1 CURSOR FOR
    SELECT orgnzt_id
      FROM TBL_ORGNZT
     where ORG_UP = Arg_TagId
       and use_yn = 'Y';
  
  # 커서가 마지막에 도착할 떄의 상태값
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  

  SET vLowerIdPath = Arg_TagId;

  open cur1;
  read_loop: LOOP
  
    FETCH cur1 INTO vLowerId;
    
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    SET vLowerIdPath = CONCAT(vLowerIdPath, ',', FN_ORGAN_LOW_TREE3(vLowerId));
        
  END LOOP; 

  RETURN   vLowerIdPath;

END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_ORGAN_LOW_TREE3`(Arg_TagId VARCHAR(20)) RETURNS varchar(4000) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN

  DECLARE done INT DEFAULT 0;
  DECLARE vLowerId VARCHAR(20);
  DECLARE vLowerIdPath VARCHAR(4000);

  # orgnzt_id 의 하위 조직들
  DECLARE cur1 CURSOR FOR
    SELECT orgnzt_id
      FROM TBL_ORGNZT
     where ORG_UP = Arg_TagId
       and use_yn = 'Y';
  
  # 커서가 마지막에 도착할 떄의 상태값
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  

  SET vLowerIdPath = Arg_TagId;

  open cur1;
  read_loop: LOOP
  
    FETCH cur1 INTO vLowerId;
    
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    SET vLowerIdPath = CONCAT(vLowerIdPath, ',', vLowerId);
        
  END LOOP; 

  RETURN   vLowerIdPath;

END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_ORGAN_TREE`(Arg_TagId VARCHAR(20)) RETURNS varchar(500) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
    
  DECLARE is_tagpath VARCHAR(500);
  DECLARE is_tag_id VARCHAR(20);
  DECLARE is_Higherid VARCHAR(20);
    
  SET is_tag_id = arg_Tagid;
  SET is_tagpath = '';
  SET is_Higherid ='';
   SELECT ORG_UP
    INTO   is_Higherid
    FROM   TBL_ORGNZT
    WHERE  ORGNZT_ID = is_tag_id;
    
  WHILE is_tag_id!=is_Higherid DO  
    SET   is_tagpath = CONCAT_WS('/', is_Higherid, is_tagpath );
    SET   is_tag_id  = is_Higherid;
   
    SELECT ORG_UP
    INTO   is_Higherid
    FROM   TBL_ORGNZT
    WHERE  ORGNZT_ID = is_tag_id;   
    
  END WHILE;
  
  SET   is_tagpath = CONCAT(CONVERT(is_tagpath USING euckr), CONVERT(arg_Tagid USING euckr) );
  RETURN   is_tagpath;
  
    END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_ORGAN_TREE_ORD`(Arg_TagId VARCHAR(20)) RETURNS varchar(500) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
    
DECLARE is_tagpath VARCHAR(500);
  DECLARE is_tag_id VARCHAR(20);
  DECLARE is_Higherid VARCHAR(20);
  DECLARE is_ORD INT;
    
  SET is_tag_id = arg_Tagid;
  SET is_tagpath = '';
  SET is_Higherid ='';
   SELECT ORG_UP, ORD
    INTO   is_Higherid, IS_ORD
    FROM   TBL_ORGNZT
    WHERE  ORGNZT_ID = is_tag_id;
  
  #2014-03-26 프로젝트보다 조직이 뒤에 나오도록 정렬조건 추가. 프로젝트는 P, 조직은 R로 정함
  WHILE is_tag_id!=is_Higherid DO  
   SET   is_tagpath = CONCAT(is_Higherid, '/R', LPAD(IS_ORD, 3, 0), is_tagpath );
   SET   is_tag_id  = is_Higherid;      
    SELECT ORG_UP, ORD
    INTO   is_Higherid, IS_ORD
    FROM   TBL_ORGNZT
    WHERE  ORGNZT_ID = is_tag_id;        
  END WHILE;  
  
  SET   is_tagpath = CONCAT(LPAD(IS_ORD, 3, 0), is_tagpath );  
  SET   is_tagpath = CONCAT(CONVERT(is_tagpath USING euckr), CONVERT(arg_Tagid USING euckr) );
  RETURN   is_tagpath;
  
    END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_ORGAN_TREE_UP`(Arg_TagId VARCHAR(20)) RETURNS varchar(500) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
    
  DECLARE is_tagpath VARCHAR(500);
  DECLARE is_tag_id VARCHAR(20);
  DECLARE is_Higherid VARCHAR(20);
    
  SET is_tag_id = arg_Tagid;
  SET is_tagpath = '';
  SET is_Higherid ='';
   SELECT ORG_UP
    INTO   is_Higherid
    FROM   TBL_ORGNZT
    WHERE  ORGNZT_ID = is_tag_id;
    
  WHILE is_tag_id!=is_Higherid DO  
    SET   is_tagpath = CONCAT_WS('/', is_Higherid, is_tagpath );
    SET   is_tag_id  = is_Higherid;
   
    SELECT ORG_UP
    INTO   is_Higherid
    FROM   TBL_ORGNZT
    WHERE  ORGNZT_ID = is_tag_id;   
    
  END WHILE;
  

  RETURN   is_tagpath;
  
    END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_PRJ_TREE`(Arg_TagId VARCHAR(20)) RETURNS varchar(500) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
    
DECLARE is_tagpath VARCHAR(500);
  DECLARE is_tag_id VARCHAR(20);
  DECLARE is_Higherid VARCHAR(20);
  SET is_tag_id = arg_Tagid;
  SET is_tagpath = '';
  SET is_Higherid ='';
   SELECT PRNT_PRJ_ID
    INTO   is_Higherid
    FROM   TBL_PRJ
    WHERE  PRJ_ID = is_tag_id;
  
  WHILE is_tag_id!=is_Higherid DO
  SET   is_tagpath = CONCAT_WS('/', is_Higherid, is_tagpath );
    SET   is_tag_id  = is_Higherid;
    SELECT PRNT_PRJ_ID
    INTO   is_Higherid
    FROM   TBL_PRJ
    WHERE  PRJ_ID = is_tag_id;
    
    
  END WHILE;
  
  SET   is_tagpath = CONCAT(is_tagpath, arg_Tagid);
  RETURN   is_tagpath;
  
    END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_PRJ_TREE_ORD`(Arg_TagId VARCHAR(20)) RETURNS varchar(500) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
    
DECLARE is_tagpath VARCHAR(500);
  DECLARE is_tag_id VARCHAR(20);
  DECLARE is_Higherid VARCHAR(20);
  DECLARE is_ORD INT;
  
  SET is_tag_id = arg_Tagid;
  SET is_tagpath = '';
  SET is_Higherid ='';
   SELECT PRNT_PRJ_ID, ORD
    INTO   is_Higherid, IS_ORD
    FROM   TBL_PRJ
    WHERE  PRJ_ID = is_tag_id;
    
  #2014-03-26 프로젝트보다 조직이 뒤에 나오도록 정렬조건 추가. 프로젝트는 P, 조직은 R로 정함
  WHILE is_tag_id!=is_Higherid DO
   SET   is_tagpath = CONCAT(is_Higherid, '/P', LPAD(IS_ORD, 3, 0), is_tagpath );  
   SET   is_tag_id  = is_Higherid;    
    SELECT PRNT_PRJ_ID, ORD
    INTO   is_Higherid, IS_ORD
    FROM   TBL_PRJ
    WHERE  PRJ_ID = is_tag_id;
  END WHILE;
  
  SET   is_tagpath = CONCAT('P', LPAD(IS_ORD, 3, 0), is_tagpath );  
  SET   is_tagpath = CONCAT(is_tagpath, arg_Tagid);
  RETURN   is_tagpath;
  
    END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_STR_COUNT`(inputdata varchar(1000), searchStr varchar(250)) RETURNS int(11)
BEGIN
    declare q int(11) DEFAULT 0;
    set q = char_length(inputdata) - char_length(replace(inputdata,searchStr,''));
    RETURN q;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_SUM_REMAIN_EXP_PLAN`($prjId VARCHAR(20)) RETURNS bigint(20)
BEGIN    
DECLARE $prntPrjId VARCHAR(20);
DECLARE $curPrjId VARCHAR(20);
DECLARE $budgetExceedRule char(1);
DECLARE $alreadyUse bigINT(20);
DECLARE $planExp bigINT(20);
declare $budgetPrjId varchar(20);
SET $alreadyUse = 0;
SET $planExp  = 0;
SET $curPrjId =$prjId;
select FN_GET_BUDGET_PRJ($curPrjId)
INTO $budgetPrjId;
select BUDGET_EXCEED_RULE
INTO $budgetExceedRule
FROM TBL_PRJ
WHERE PRJ_ID = $budgetExceedRule;
IF $budgetExceedRule = 'N'
THEN RETURN 10000000000;
END IF;
SELECT IFNULL(SUM(EXP_SPEND),0)
INTO $alreadyUse
FROM V_EAPP_EXP EXP #휴잉근무수당도 봐야 하므로 view에서 뽑아옴.
INNER JOIN TBL_EAPP_DOC DOC
ON EXP.DOC_ID = DOC.DOC_ID
INNER JOIN TBL_ACCOUNT ACC
ON EXP.ACC_ID = ACC.ACC_ID
INNER JOIN TBL_ACCOUNT PRNT
ON ACC.PRNT_ACC_ID = PRNT.ACC_ID
WHERE DOC.NEW_AT = 1
	AND FN_GET_BUDGET_PRJ(EXP.PRJ_ID) = $budgetPrjId
	AND PRNT.PRNT_TYP = 'E';
SELECT IFNULL(SUM(COST),0)
	INTO $planExp
	FROM TBL_PLAN_EXP a
	INNER JOIN TBL_EAPP_DOC b
	ON a.DOC_ID = b.DOC_ID
	WHERE 
		a.PRJ_ID = $budgetPrjId
		AND b.NEW_AT = 1;		
RETURN $planExp - $alreadyUse;
 END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `FN_TREE_PATH`(Arg_TagId VARCHAR(20)) RETURNS varchar(500) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN
    
DECLARE is_tagpath VARCHAR(500);
  DECLARE is_tag_id VARCHAR(20);
  DECLARE is_Higherid VARCHAR(20);
    
  SET is_tag_id = arg_Tagid;
  SET is_tagpath = '';
  SET is_Higherid ='';
   SELECT ORG_UP
    INTO   is_Higherid
    FROM   TBL_ORGNZT
    WHERE  ORGNZT_ID = is_tag_id;
    
  WHILE is_tag_id!=is_Higherid DO
  
   SET   is_tagpath = CONCAT_WS('/',is_Higherid ,is_tagpath );
   SET   is_tag_id  = is_Higherid;
   
    SELECT ORG_UP
    INTO   is_Higherid
    FROM   TBL_ORGNZT
    WHERE  ORGNZT_ID = is_tag_id;
    
   
   
    
  END WHILE;
  
  SET   is_tagpath = CONCAT(CONVERT(is_tagpath USING euckr),CONVERT(arg_Tagid USING euckr) );
  RETURN   is_tagpath;
  
    END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `hm_daily_plan` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `WRITE_DATE` varchar(8) NOT NULL COMMENT '작성일',
  `WRITER_NO` int(11) NOT NULL COMMENT '작성자 user no',
  `REG_DATETIME` datetime DEFAULT NULL COMMENT '작성일시/수정일시',
  `CONTENTS` text DEFAULT NULL COMMENT '내용',
  `FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일 ID',
  PRIMARY KEY (`NO`),
  UNIQUE KEY `IDX_WRITEDATE_WRITENO` (`WRITE_DATE`,`WRITER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=92947 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_daily_result` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `DR_NO` int(11) DEFAULT NULL COMMENT 'DailyReport No',
  `PRJ_ID` varchar(20) DEFAULT NULL COMMENT '프로젝트ID',
  `WORK_HOUR` tinyint(4) DEFAULT 0 COMMENT '투입시간',
  `CONTENTS` text DEFAULT NULL,
  `REG_DATETIME` datetime DEFAULT NULL COMMENT '등록일시',
  `FILE_ID` varchar(20) DEFAULT NULL,
  `WRITER_NO` int(11) NOT NULL COMMENT '작성자 user no',
  `WRITE_DATE` varchar(8) NOT NULL COMMENT '작성기준일',
  `REQ_NO` int(10) DEFAULT NULL COMMENT '요구사항 번호',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`WRITER_NO`),
  KEY `PRJ_ID` (`PRJ_ID`),
  KEY `WRITE_DATE` (`WRITE_DATE`),
  KEY `인덱스 5` (`WRITER_NO`,`PRJ_ID`,`WRITE_DATE`)
) ENGINE=InnoDB AUTO_INCREMENT=166949 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_invoice` (
  `INVOICE_ID` varchar(20) NOT NULL,
  `TITLE` varchar(200) NOT NULL COMMENT '제목',
  `CUST_COMPANY_NAME` varchar(200) NOT NULL,
  `CUST_CEO_NAME` varchar(100) NOT NULL,
  `CUST_BUSI_NO` char(14) NOT NULL COMMENT '사업자등록번호',
  `CUST_BUSI_TYPE` varchar(100) NOT NULL,
  `CUST_BUSI_KIND` varchar(100) NOT NULL,
  `CUST_ADDRESS` varchar(1000) NOT NULL COMMENT '주소',
  `CUST_EMAIL_1` varchar(100) DEFAULT NULL,
  `CUST_NAME_1` varchar(100) DEFAULT NULL,
  `CUST_TELNO_1` varchar(100) DEFAULT NULL,
  `CUST_EMAIL_2` varchar(100) DEFAULT NULL,
  `CUST_NAME_2` varchar(100) DEFAULT NULL,
  `CUST_TELNO_2` varchar(100) DEFAULT NULL,
  `CUST_EMAIL_3` varchar(100) DEFAULT NULL,
  `CUST_NAME_3` varchar(100) DEFAULT NULL,
  `CUST_TELNO_3` varchar(100) DEFAULT NULL,
  `CUST_EMAIL_4` varchar(100) DEFAULT NULL,
  `CUST_NAME_4` varchar(100) DEFAULT NULL,
  `CUST_TELNO_4` varchar(100) DEFAULT NULL,
  `CUST_EMAIL_5` varchar(100) DEFAULT NULL,
  `CUST_NAME_5` varchar(100) DEFAULT NULL,
  `CUST_TELNO_5` varchar(100) DEFAULT NULL,
  `TAX_ZERO` char(1) DEFAULT NULL COMMENT 'Y:영세율, N:영세율X',
  `TOTAL_PRICE` bigint(20) NOT NULL,
  `TOTAL_VAT` bigint(20) NOT NULL,
  `TOTAL_SUM` bigint(20) NOT NULL,
  `PUBLISH_TYPE` char(1) DEFAULT NULL COMMENT '1:청구, 2:영수',
  `PUBLISH_CO_ACRONYM` varchar(10) DEFAULT NULL COMMENT '발행회사코드:도사, 새하',
  `PUBLISH_REQ_DATE` char(8) DEFAULT NULL COMMENT '발행요청일',
  `WRITE_USER_NO` int(11) NOT NULL COMMENT '작성자(발행요청자) user no',
  `WRITE_DATETIME` datetime DEFAULT NULL COMMENT '작성일시',
  `PUBLISH_USER_NO` int(11) DEFAULT NULL COMMENT '발행자 user no',
  `PUBLISH_DATETIME` datetime DEFAULT NULL COMMENT '실제발행된일시',
  `STATUST` char(1) DEFAULT NULL COMMENT 'N:미발행, Y:발행완료, C:취소',
  `USE_AT` char(1) DEFAULT 'Y' COMMENT '사용: 삭제되면 N',
  `ATTACH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일',
  `COMMENT` varchar(2000) DEFAULT NULL COMMENT '비고',
  `COLLECT_EXPECT_DATE` varchar(10) DEFAULT NULL COMMENT '수금예상일',
  `TOTAL_COLLECT` bigint(20) NOT NULL DEFAULT 0 COMMENT '수금액',
  `DELETE_DATETIME` datetime DEFAULT NULL COMMENT '삭제일시',
  `DELETE_USER_NO` int(11) DEFAULT NULL COMMENT '삭제한 사람',
  `STATUS` int(11) DEFAULT 2 COMMENT '0: 취소, 1: 발행요청, 2: 발행, 4: 수금중, 8: 수금완료, 16: 초과수금',
  PRIMARY KEY (`INVOICE_ID`),
  KEY `IDX_WRITE_USER_NO` (`WRITE_USER_NO`),
  KEY `IDX_USE_AT` (`USE_AT`),
  KEY `IDX_STATUS` (`STATUST`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_invoice_collect` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `INVOICE_ID` varchar(20) DEFAULT NULL,
  `COLLECT_USER_NO` int(11) DEFAULT NULL COMMENT '수금을 확인한 사람',
  `COLLECT_DATE` varchar(10) DEFAULT NULL,
  `COLLECT` bigint(20) DEFAULT NULL COMMENT '수금액(부가세 포함)',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '특이사항',
  `TYPE` tinyint(4) DEFAULT 1 COMMENT '1:현금, 2:어음, 3:기타',
  `BOND_PRJ_NO` int(11) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `FK_COLLECT_INVOICEID` (`INVOICE_ID`),
  CONSTRAINT `FK_hm_invoice_collect_hm_invoice` FOREIGN KEY (`INVOICE_ID`) REFERENCES `hm_invoice` (`INVOICE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31571 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_invoice_contents` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `INVOICE_ID` varchar(20) DEFAULT NULL COMMENT '계산서ID',
  `PRODUCT_NAME` varchar(100) DEFAULT NULL,
  `PRICE` bigint(20) NOT NULL COMMENT '가격',
  `VAT` bigint(20) NOT NULL COMMENT '부가세',
  `SUM` bigint(20) NOT NULL COMMENT '부가세 포함금액',
  `NOTE` varchar(4000) DEFAULT NULL COMMENT '비고',
  `USE_AT` char(1) DEFAULT 'Y' COMMENT '삭제여부',
  `CONTAIN_VAT` char(1) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`INVOICE_ID`),
  KEY `NewIndex2` (`USE_AT`)
) ENGINE=InnoDB AUTO_INCREMENT=75078 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_invoice_project` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `INVOICE_ID` varchar(20) NOT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `PRICE` bigint(14) NOT NULL DEFAULT 0 COMMENT '공급가액',
  `USE_AT` char(1) DEFAULT 'Y' COMMENT '삭제여부',
  `SUM` bigint(20) DEFAULT 0 COMMENT '부가세 포함금액',
  `COLLECT` bigint(20) DEFAULT 0 COMMENT '수금액',
  `BOND_MANAGE_YN` char(1) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`INVOICE_ID`),
  KEY `NewIndex2` (`PRJ_ID`),
  KEY `NewIndex3` (`USE_AT`)
) ENGINE=InnoDB AUTO_INCREMENT=75361 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_product` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `PRODUCT_CODE` varchar(20) DEFAULT NULL COMMENT '제품 코드',
  `PRODUCT_NM` varchar(255) DEFAULT NULL COMMENT '제품 이름',
  `PRODUCT_CN` text DEFAULT NULL COMMENT '제품 설명',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '등록자 NO',
  `ADMIN_NO` int(20) DEFAULT NULL COMMENT '관리자',
  `USE_AT` varchar(2) DEFAULT 'Y' COMMENT '사용여부 YN',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬 순서',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `MOD_DT` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_product_part` (
  `NO` int(10) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `PART_NM` varchar(255) DEFAULT NULL COMMENT '수성품 이름',
  `NICK_NAME` varchar(20) DEFAULT NULL COMMENT '짧게부르는 이름',
  `PART_CN` text DEFAULT NULL COMMENT '구성품 설명',
  `USE_AT` varchar(2) DEFAULT 'Y' COMMENT '사용여부 YN',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬 순서',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `MOD_DT` datetime DEFAULT NULL COMMENT '수정일',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '작성자',
  `ADMIN_NO` int(10) DEFAULT NULL COMMENT '관리자',
  `TYPE` char(1) DEFAULT NULL COMMENT 'P:part, M:module',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_product_relation` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `OWNER_NO` int(11) NOT NULL,
  `SUB_NO` int(11) NOT NULL,
  `TYPE` char(1) DEFAULT NULL COMMENT 'P:part, M:module',
  `SORT_NO` int(11) DEFAULT 1,
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_product_version` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `PART_NO` int(10) DEFAULT NULL COMMENT 'FK 구성품',
  `VERSION` varchar(20) DEFAULT NULL,
  `VERSION_NAME` varchar(100) DEFAULT NULL,
  `WRITER_NO` int(11) DEFAULT NULL,
  `REG_DATETIME` datetime DEFAULT NULL,
  `PUBLISH_DATE` varchar(10) DEFAULT NULL,
  `UPGRADE_NOTE` text DEFAULT NULL COMMENT '수정변경사항',
  `INTERFACE_NOTE` text DEFAULT NULL COMMENT '인터페이스 변경정보',
  `SOURCE_NOTE` text DEFAULT NULL COMMENT '소스관련 정보',
  `DOCUMENT_NOTE` text DEFAULT NULL COMMENT '산출물 정보',
  `INTERFACE_CHANGE` char(1) DEFAULT 'N' COMMENT 'Y:변경됨, N:변경되지 않음',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_request` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `REQ_ID` varchar(10) NOT NULL COMMENT '요구사항 식별자: yy-1',
  `REQ_TYPE` tinyint(4) DEFAULT NULL COMMENT '1:커스터마이징, 2:오류수정, 3:기능개선, 4:기능추가',
  `TITLE` varchar(100) NOT NULL,
  `CONTENTS` mediumtext DEFAULT NULL,
  `PRIORITY` tinyint(4) DEFAULT NULL COMMENT '우선순위: 1:긴급, 2:중요, 4:보통 8: 여유',
  `STATUS` tinyint(4) DEFAULT NULL,
  `WRITER_NO` int(11) DEFAULT NULL,
  `MANAGER_NO` int(11) DEFAULT NULL,
  `DUE_DATE` char(8) DEFAULT NULL,
  `REG_DATETIME` datetime DEFAULT NULL,
  `FINISH_DATETIME` datetime DEFAULT NULL,
  `PRODUCT_ID` varchar(30) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL COMMENT '관련프로젝트 ID',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL,
  `MAIN_MANAGER` varchar(100) DEFAULT NULL COMMENT '주 담당자',
  `MODIFYER_NO` int(11) DEFAULT NULL COMMENT '수정자 ID',
  `MODIFYER_NAME` varchar(100) DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_request_receive` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `USER_NO` int(11) NOT NULL COMMENT '담당자 번호',
  `USER_ID` varchar(20) NOT NULL COMMENT '담당자 아이디',
  `USER_NM` varchar(60) NOT NULL COMMENT '담당자 이름',
  `REQ_ID` varchar(10) NOT NULL COMMENT '요구사항 식별자 :yy-1',
  `COMPLETE_STATUS` int(11) NOT NULL DEFAULT 0 COMMENT '요구사항 완료 & 미완료 값(미완료 :0, 완료:1)',
  `COMPLETE_DATETIME` varchar(50) DEFAULT NULL COMMENT '요구사항 완료 시간',
  PRIMARY KEY (`NO`),
  KEY `USER_NO` (`USER_NO`),
  KEY `REQ_ID` (`REQ_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=87372 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `hm_request_task` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `REQ_NO` int(11) NOT NULL COMMENT '요구사항 FK',
  `TASK_ID` varchar(10) NOT NULL COMMENT '작업 ID',
  `TITLE` varchar(100) DEFAULT NULL,
  `CONTENTS` text DEFAULT NULL,
  `WRITER_NO` int(11) DEFAULT NULL,
  `WORKER_NO` int(11) DEFAULT NULL,
  `STATUS` tinyint(4) DEFAULT 0 COMMENT '상태 : 1: 생성,  2: 처리중,  3: 처리완료',
  `REG_DATETIME` datetime NOT NULL,
  `START_DATETIME` datetime DEFAULT NULL COMMENT '작업시작일시',
  `FINISH_DATETIME` datetime DEFAULT NULL COMMENT '작업완료일시',
  `TASK_TYPE` tinyint(2) NOT NULL COMMENT '작업의 종류 : 1: 분석,  2: 설계,  3: 구현 4: 시험 5: 오류처리  6: 연구',
  `PRIORITY` tinyint(4) NOT NULL COMMENT '우선순위: 1:긴급, 2:중요, 4:보통 8: 여유',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=870 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `imgtemp` (
  `ORG_CODE` varchar(7) NOT NULL,
  `ERNCSL_SE` varchar(2) NOT NULL,
  `IMG_INFO` blob NOT NULL,
  `IMG_TYPE` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `nk_board` (
  `boardID` int(10) NOT NULL AUTO_INCREMENT,
  `folderID` int(10) DEFAULT NULL,
  `thread` int(10) DEFAULT NULL,
  `depth` int(10) DEFAULT NULL,
  `parentID` int(10) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `writerID` varchar(100) DEFAULT NULL,
  `userName` varchar(100) DEFAULT NULL,
  `writeDate` datetime DEFAULT NULL,
  `rcount` int(5) DEFAULT 0,
  `content` mediumtext DEFAULT NULL,
  `type` int(4) DEFAULT NULL,
  `commentCount` int(11) DEFAULT NULL,
  `ownerID` varchar(20) NOT NULL DEFAULT '',
  `scrapID` varchar(20) NOT NULL DEFAULT '',
  `scrapDate` datetime DEFAULT NULL,
  `scrapCount` int(11) DEFAULT 0,
  `category` varchar(15) DEFAULT NULL,
  `company` varchar(5) DEFAULT 'dosa',
  PRIMARY KEY (`boardID`),
  KEY `folderID` (`folderID`),
  KEY `writerID` (`writerID`),
  KEY `ownerID` (`ownerID`),
  KEY `thread` (`thread`),
  KEY `company` (`company`)
) ENGINE=MyISAM AUTO_INCREMENT=10309 DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_board` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_board` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_boardcomment` (
  `commentID` int(11) NOT NULL AUTO_INCREMENT,
  `boardID` int(11) DEFAULT NULL,
  `userID` varchar(100) DEFAULT NULL,
  `userName` varchar(100) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `regDate` datetime DEFAULT NULL,
  PRIMARY KEY (`commentID`),
  KEY `boardID` (`boardID`)
) ENGINE=MyISAM AUTO_INCREMENT=36693 DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_boardcomment` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_boardcomment` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_boardfile` (
  `fileNo` int(11) NOT NULL DEFAULT 0,
  `boardID` int(11) DEFAULT NULL,
  `fileName` varchar(255) DEFAULT NULL,
  `tempFileName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`fileNo`),
  KEY `boardID` (`boardID`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_boardfile` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_boardfile` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_category` (
  `categoryCode` varchar(50) NOT NULL DEFAULT '',
  `categoryName` varchar(100) DEFAULT NULL,
  `division` int(4) DEFAULT NULL,
  PRIMARY KEY (`categoryCode`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_category` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_change` (
  `changeID` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(100) DEFAULT NULL,
  `serialNo` varchar(100) DEFAULT NULL,
  `changeInputDate` date DEFAULT NULL,
  `changeOutDate` date DEFAULT NULL,
  `place` varchar(100) DEFAULT NULL,
  `stockDivision` varchar(100) DEFAULT NULL,
  `purpose` varchar(100) DEFAULT NULL,
  `charge` varchar(100) DEFAULT NULL,
  `etc` text DEFAULT NULL,
  PRIMARY KEY (`changeID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_change` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_change` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_delete` (
  `serialNo` varchar(100) NOT NULL DEFAULT '',
  `deleteDate` datetime DEFAULT NULL,
  PRIMARY KEY (`serialNo`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_delete` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_delete` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_info` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `serialNo` varchar(100) DEFAULT NULL,
  `itemCode` varchar(50) DEFAULT NULL,
  `outDate` date DEFAULT NULL,
  `returnDate` date DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `reseller` varchar(100) DEFAULT NULL,
  `enduser` varchar(100) DEFAULT NULL,
  `installPlace` varchar(100) DEFAULT NULL,
  `itemPrice` int(11) DEFAULT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_info` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_input` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `inputDate` datetime DEFAULT NULL,
  `itemCode` varchar(20) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `inputPlace` varchar(50) DEFAULT NULL,
  `outDate` datetime DEFAULT NULL,
  `company` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM AUTO_INCREMENT=451 DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_input` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_input` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_input2` (
  `stockIdx` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(25) DEFAULT NULL,
  `serialNo` varchar(50) NOT NULL DEFAULT '',
  `categoryCode` varchar(50) DEFAULT NULL,
  `boxSerialNo` varchar(50) DEFAULT NULL,
  `itemCode` varchar(50) DEFAULT NULL,
  `inputDate` date DEFAULT NULL,
  `itemPrice` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `inputPlace` varchar(25) DEFAULT NULL,
  `docIdx` int(11) DEFAULT NULL,
  `expenseDocIdx` int(11) DEFAULT NULL,
  `expenseApproval` int(11) DEFAULT 1,
  `status` int(11) DEFAULT NULL,
  `tempSaver` int(11) DEFAULT -1,
  `projectCode` varchar(10) DEFAULT NULL,
  `taskIdx` int(11) DEFAULT NULL,
  `isSerialChanged` int(11) DEFAULT NULL,
  PRIMARY KEY (`stockIdx`)
) ENGINE=MyISAM AUTO_INCREMENT=3501 DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_input2` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_input2` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_inputtest` (
  `serialNo` varchar(100) NOT NULL DEFAULT '',
  `testDate` date DEFAULT NULL,
  `check1_1` enum('Y','N') DEFAULT 'N',
  `check2_1` enum('Y','N') DEFAULT 'N',
  `check2_2` enum('Y','N') DEFAULT 'N',
  `check2_3` enum('Y','N') DEFAULT 'N',
  `check2_4` enum('Y','N') DEFAULT 'N',
  `check3_1` enum('Y','N') DEFAULT 'N',
  `check3_2` enum('Y','N') DEFAULT 'N',
  `check3_3` enum('Y','N') DEFAULT 'N',
  `check3_4` enum('Y','N') DEFAULT 'N',
  `check4_1` enum('Y','N') DEFAULT 'N',
  `check4_2` enum('Y','N') DEFAULT 'N',
  `check4_3` enum('Y','N') DEFAULT 'N',
  `check4_4` enum('Y','N') DEFAULT 'N',
  `check5_1` enum('Y','N') DEFAULT 'N',
  `check5_2` enum('Y','N') DEFAULT 'N',
  `check5_3` enum('Y','N') DEFAULT 'N',
  `check5_4` enum('Y','N') DEFAULT 'N',
  `check5_5` enum('Y','N') DEFAULT 'N',
  `note1_1` text DEFAULT NULL,
  `note2_1` text DEFAULT NULL,
  `note2_2` text DEFAULT NULL,
  `note2_3` text DEFAULT NULL,
  `note2_4` text DEFAULT NULL,
  `note3_1` text DEFAULT NULL,
  `note3_2` text DEFAULT NULL,
  `note3_3` text DEFAULT NULL,
  `note3_4` text DEFAULT NULL,
  `note4_1` text DEFAULT NULL,
  `note4_2` text DEFAULT NULL,
  `note4_3` text DEFAULT NULL,
  `note4_4` text DEFAULT NULL,
  `note5_1` text DEFAULT NULL,
  `note5_2` text DEFAULT NULL,
  `note5_3` text DEFAULT NULL,
  `note5_4` text DEFAULT NULL,
  `note5_5` text DEFAULT NULL,
  PRIMARY KEY (`serialNo`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_inputtest` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_inputtest` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_install` (
  `hwSerialNo` varchar(100) DEFAULT NULL,
  `swSerialNo` varchar(100) DEFAULT NULL,
  `installDate` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_install` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_install` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_item` (
  `itemCode` varchar(50) NOT NULL DEFAULT '',
  `itemName` varchar(100) DEFAULT NULL,
  `categoryCode` varchar(50) DEFAULT NULL,
  `itemPrice` int(11) DEFAULT NULL,
  `itemDesc` text DEFAULT NULL,
  `serialCode` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`itemCode`),
  KEY `categoryCode` (`categoryCode`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_item` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_out` (
  `serialNo` varchar(100) NOT NULL DEFAULT '',
  `outDate` date DEFAULT NULL,
  `installPlace` varchar(100) DEFAULT NULL,
  `reseller` varchar(100) DEFAULT NULL,
  `enduser` varchar(100) DEFAULT NULL,
  `saleIdx` int(11) DEFAULT NULL,
  `projectCode` varchar(20) DEFAULT NULL,
  `taskIdx` int(11) DEFAULT NULL,
  `itemCode` varchar(50) DEFAULT NULL,
  `salePrice` int(10) DEFAULT NULL,
  `regYN` enum('Y','N') DEFAULT 'N',
  `tempYN` enum('Y','N') DEFAULT 'N',
  `taxDate` date DEFAULT NULL,
  `taxIdx` int(11) DEFAULT NULL,
  PRIMARY KEY (`serialNo`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_out` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_out` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_product` (
  `stockIdx` int(11) NOT NULL AUTO_INCREMENT,
  `p_idx` int(11) DEFAULT NULL,
  `userId` varchar(50) DEFAULT NULL,
  `serialNo` varchar(100) NOT NULL DEFAULT '',
  `boxSerialNo` varchar(100) DEFAULT NULL,
  `inputDate` date DEFAULT NULL,
  `outputDate` date DEFAULT NULL,
  `categoryCode` varchar(50) DEFAULT NULL,
  `itemCode` varchar(50) DEFAULT NULL,
  `status` int(4) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `itemPrice` int(11) DEFAULT NULL,
  `inputPlace` varchar(100) DEFAULT NULL,
  `month` varchar(50) DEFAULT NULL,
  `expenseApproval` int(11) DEFAULT NULL,
  `expenseDocIdx` int(11) DEFAULT NULL,
  `reseller` varchar(100) DEFAULT NULL,
  `enduser` varchar(100) DEFAULT NULL,
  `installplace` varchar(100) DEFAULT NULL,
  `projectCode` varchar(30) DEFAULT NULL,
  `taskIdx` int(20) DEFAULT NULL,
  PRIMARY KEY (`stockIdx`),
  KEY `categoryCode` (`categoryCode`)
) ENGINE=MyISAM AUTO_INCREMENT=5007 DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_product` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_stock_sales` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `projectCode` varchar(20) DEFAULT NULL,
  `taskIdx` int(11) DEFAULT NULL,
  `itemCode` varchar(20) DEFAULT NULL,
  `salePrice` int(11) DEFAULT NULL COMMENT '매출금액',
  `regYN` enum('Y','N') DEFAULT 'N' COMMENT '전자결재등록여부',
  `taxDate` date DEFAULT NULL COMMENT '세금계산서일자',
  `account` varchar(50) DEFAULT NULL COMMENT '거래처',
  `taxPrice` int(11) DEFAULT NULL COMMENT '매출세금계산서금액',
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_stock_sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_stock_sales` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `nk_user` (
  `serialNo` varchar(10) DEFAULT NULL,
  `userID` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(100) DEFAULT NULL,
  `userLevel` int(3) DEFAULT NULL,
  `teamID` varchar(5) DEFAULT NULL,
  `gradeCode` varchar(5) DEFAULT NULL,
  `userName` varchar(100) NOT NULL DEFAULT '',
  `englishName` varchar(50) NOT NULL DEFAULT '',
  `emailAddr` varchar(100) DEFAULT NULL,
  `dutyplaceNumber` varchar(50) DEFAULT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `mobileNumber` varchar(50) DEFAULT NULL,
  `msnAddr` varchar(100) DEFAULT NULL,
  `nateAddr` varchar(100) DEFAULT NULL,
  `imageFileName` varchar(100) DEFAULT NULL,
  `introduction` text DEFAULT NULL,
  `status` int(4) DEFAULT NULL,
  `vacationCount1` varchar(5) DEFAULT NULL,
  `vacationCount2` varchar(5) DEFAULT NULL,
  `jumin` varchar(13) DEFAULT NULL,
  `birthday` varchar(20) DEFAULT NULL,
  `birthDivision` int(4) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `enteringDate` varchar(8) DEFAULT NULL,
  `leaveDate` varchar(8) DEFAULT NULL,
  `business` text DEFAULT NULL,
  `tCode` double(11,2) DEFAULT NULL,
  `stationLeader` enum('Y','N') DEFAULT NULL,
  `carNumber` varchar(20) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `jikgun` varchar(3) DEFAULT NULL,
  `companyCode` varchar(20) DEFAULT NULL,
  `ssoKey` varchar(150) DEFAULT NULL,
  `extension` varchar(20) DEFAULT NULL,
  `driverType` varchar(10) DEFAULT '',
  PRIMARY KEY (`userID`),
  KEY `userName` (`userName`),
  KEY `status` (`status`),
  KEY `teamID` (`teamID`),
  KEY `companyCode` (`companyCode`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr COLLATE=euckr_korean_ci;

/*!40000 ALTER TABLE `nk_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `nk_user` ENABLE KEYS */;

DELIMITER //
CREATE PROCEDURE `PR_INSERT_NEWYEAR_SELFDEV_USR`()
BEGIN    
    
INSERT INTO TBL_SELFDEV_USR (
	USER_NO
	, YEAR
	, PERCENT
	, DESCRIPTION
	, REG_DT
	)
(
	SELECT
		e.NO USER_NO
		, e.CUR_YEAR YEAR
		, e.INC_RATIO PERCENT
		, '장기근속 할증' DESCRIPTION # 비율 조정 사유 (필요시 수정)
		, NOW() REG_DT
	FROM
		(
			SELECT
				d.*
				, SUBSTRING(NOW(), 1, 4) CUR_YEAR
				, ROUND(d.FULL_UP * (200000/20000) + d.RATIO_UP * d.RATIO_YN / 100 * (200000/20000)) * 20000 INC_AMOUNT # 2만원 단위로 반올림, 할증 기준금액 : 20만원
				, FLOOR(((ROUND(d.FULL_UP * (200000/20000) + d.RATIO_UP * d.RATIO_YN / 100 * (200000/20000)) * 20000) / 1000000 + 1) * 100) INC_RATIO # 기본 한도 : 100만원
			FROM
				(
					SELECT
						a.NO
						, a.USER_ID
						, a.USER_NM
						, a.COMPIN_DT
						, b.PERIOD PERIOD
						, FLOOR((SUBSTRING(b.PERIOD, 1, 4) - 1) / 3) FULL_UP
						, IF(FLOOR(SUBSTRING(b.PERIOD, 1, 4) % 3) = 0, 1, 0) RATIO_YN
						, FLOOR(SUBSTRING(b.PERIOD, 5, 2) * 100 / 12) RATIO_UP
					FROM 
						TBL_USERINFO a
						INNER JOIN (
							SELECT
								c.*,
								IF(
									SUBSTRING(c.COMPIN_DT, 7, 2) = '01', # 매월 1일에 입사한 경우에 대한 보정 (12월1일~12월31일 근무의 경우 0개월30일이 아니라 1개월0일임)
									LPAD(CONCAT(SUBSTRING(REPLACE(NOW(), '-', ''), 1, 4), '1301') - c.COMPIN_DT, 8, '0'), # month += 1, day = 0
									LPAD(CONCAT(SUBSTRING(REPLACE(NOW(), '-', ''), 1, 4), '1231') - c.COMPIN_DT, 8, '0')
								) PERIOD
							FROM
								TBL_USERINFO c
						) b ON b.NO = a.NO
							AND A.WORK_ST != 'R'
							AND b.PERIOD > '00030000' # 올해 연말 기준으로 3년 이상 근속한 경우
							
				) d
			WHERE
				d.FULL_UP > 0 OR d.RATIO_UP > 0
			ORDER BY d.PERIOD DESC
		) e
	WHERE NOT EXISTS (
		SELECT * FROM TBL_SELFDEV_USR f
		WHERE
			f.USER_NO = e.NO
			AND f.YEAR = e.CUR_YEAR
		)
)
;
    END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_NEWYEAR_SELFDEV_USR`()
BEGIN    
    
INSERT INTO TBL_SELFDEV_USR (
	USER_NO
	, YEAR
	, PERCENT
	, DESCRIPTION
	, REG_DT
	)
(
	SELECT
		e.NO USER_NO
		, e.CUR_YEAR YEAR
		, e.INC_RATIO PERCENT
		, '장기근속 할증' DESCRIPTION # 비율 조정 사유 (필요시 수정)
		, NOW() REG_DT
	FROM
		(
			SELECT
				d.*
				, SUBSTRING(NOW(), 1, 4) CUR_YEAR
				, ROUND(d.FULL_UP * (200000/20000) + d.RATIO_UP * d.RATIO_YN / 100 * (200000/20000)) * 20000 INC_AMOUNT # 2만원 단위로 반올림, 할증 기준금액 : 20만원
				, FLOOR(((ROUND(d.FULL_UP * (200000/20000) + d.RATIO_UP * d.RATIO_YN / 100 * (200000/20000)) * 20000) / 1000000 + 1) * 100) INC_RATIO # 기본 한도 : 100만원
			FROM
				(
					SELECT
						a.NO
						, a.USER_ID
						, a.USER_NM
						, a.COMPIN_DT
						, b.PERIOD PERIOD
						, FLOOR((SUBSTRING(b.PERIOD, 1, 4) - 1) / 3) FULL_UP
						, IF(FLOOR(SUBSTRING(b.PERIOD, 1, 4) % 3) = 0, 1, 0) RATIO_YN
						, FLOOR(SUBSTRING(b.PERIOD, 5, 2) * 100 / 12) RATIO_UP
					FROM 
						TBL_USERINFO a
						INNER JOIN (
							SELECT
								c.*,
								IF(
									SUBSTRING(c.COMPIN_DT, 7, 2) = '01', # 매월 1일에 입사한 경우에 대한 보정 (12월1일~12월31일 근무의 경우 0개월30일이 아니라 1개월0일임)
									LPAD(CONCAT(SUBSTRING(REPLACE(NOW(), '-', ''), 1, 4), '1301') - c.COMPIN_DT, 8, '0'), # month += 1, day = 0
									LPAD(CONCAT(SUBSTRING(REPLACE(NOW(), '-', ''), 1, 4), '1231') - c.COMPIN_DT, 8, '0')
								) PERIOD
							FROM
								TBL_USERINFO c
						) b ON b.NO = a.NO
							AND A.WORK_ST != 'R'
							AND b.PERIOD > '00030000' # 올해 연말 기준으로 3년 이상 근속한 경우
							
				) d
			WHERE
				d.FULL_UP > 0 OR d.RATIO_UP > 0
			ORDER BY d.PERIOD DESC
		) e
	WHERE NOT EXISTS (
		SELECT * FROM TBL_SELFDEV_USR f
		WHERE
			f.USER_NO = e.NO
			AND f.YEAR = e.CUR_YEAR
		)
)
;
    END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_ATTEND_REPORT_SUM`()
BEGIN
	INSERT INTO
		TBL_ATTEND_REPORT_SUM (
			USER_NO
			, YM
			, TOTAL_WORK_DAY 
			, USER_WORK_DAY 	
			, TOTAL_INPUT
			, MOD_DT
		)
	SELECT
		USER_NO, YM, ALL_DT_CNT, DT_CNT, TM, LOCALTIME()
	FROM
		(
		SELECT
			totalInput.USER_NO, totalInput.YM, totalInput.TM
			,totalWorkDay.ALL_DT_CNT, userWorkDay.DT_CNT
		FROM 	(
				SELECT
					dr.USER_NO AS USER_NO
					,DAY_REPORT_YM AS YM
					,IFNULL(SUM(IFNULL(dr.DAY_REPORT_TM, 0)), 0) AS TM
				FROM
					TBL_DAY_REPORT dr					
				WHERE
					dr.DAY_REPORT_TM > 0
					#총근무시간에서 휴일은 제외
					AND DR.IS_HOLIDAY = 0
				GROUP BY
					DAY_REPORT_YM, USER_NO
			) totalInput
			LEFT JOIN (			
				SELECT
					ATTEND_YM AS YM,
					COUNT(DISTINCT ATTEND_DT) AS ALL_DT_CNT
				FROM
					TBL_ATTEND_CHECK
				WHERE
					IS_HOLIDAY = 0	
				GROUP BY
					ATTEND_YM				
			) totalWorkDay
				ON totalInput.YM = totalWorkDay.YM
			LEFT JOIN (
				SELECT
					USER_NO AS USER_NO,
					ATTEND_YM AS YM,
					COUNT(DISTINCT NO) AS DT_CNT
				FROM
					TBL_ATTEND_CHECK
				WHERE
					IS_HOLIDAY = 0	
				GROUP BY
					ATTEND_YM, USER_NO			
			) userWorkDay
				ON userWorkDay.YM = totalWorkDay.YM
				AND userWorkDay.USER_NO = totalInput.USER_NO
	) SRC
	
	ON DUPLICATE KEY
	UPDATE
		TOTAL_WORK_DAY = SRC.ALL_DT_CNT
		, USER_WORK_DAY = SRC. DT_CNT
		, TOTAL_INPUT = SRC.TM		
		, MOD_DT = LOCALTIME()
	;
	
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_All`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	CALL PR_RENEW_ATTEND_REPORT_SUM();
	CALL PR_Renew_Restotal_SalesOut(p_year, p_month);
	CALL PR_Renew_Restotal_SalesOutEst(p_year, p_month);
	CALL PR_Renew_Restotal_SalesIn(p_year, p_month);
	CALL PR_Renew_Restotal_SalesInEst(p_year, p_month);
	CALL PR_Renew_Restotal_PurchaseOut(p_year, p_month);
	CALL PR_Renew_Restotal_PurchaseOutEst(p_year, p_month);
	CALL PR_Renew_Restotal_PurchaseInNomral(p_year, p_month);
	CALL PR_Renew_Restotal_PurchaseInNomralEst(p_year, p_month);
	CALL PR_Renew_Restotal_PurchaseInCommon(p_year, p_month);
	
	CALL PR_Renew_Restotal_PlanLabor(p_year, p_month);
	CALL PR_Renew_Restotal_PlanLaborEst(p_year, p_month);
	CALL PR_Renew_Restotal_Labor(p_year, p_month);
	CALL PR_Renew_Restotal_PlanExp(p_year, p_month);
	CALL PR_Renew_Restotal_PlanExpEst(p_year, p_month);
	CALL PR_Renew_Restotal_Exp(p_year, p_month);
	CALL PR_Renew_Restotal_ExpEst(p_year, p_month);
	
	CALL PR_Renew_Restotal_StartEndDate();
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_All2`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	CALL PR_Renew_Restotal_SalesOut2(p_year, p_month);
	CALL PR_Renew_Restotal_SalesIn2(p_year, p_month);
	CALL PR_Renew_Restotal_PurchaseOut2(p_year, p_month);
	CALL PR_Renew_Restotal_PurchaseInNomral2(p_year, p_month);
	CALL PR_Renew_Restotal_PurchaseInCommon2(p_year, p_month);
	
	CALL PR_Renew_Restotal_PlanLabor2(p_year, p_month);
	CALL PR_Renew_Restotal_Labor2(p_year, p_month);
	CALL PR_Renew_Restotal_PlanExp2(p_year, p_month);
	CALL PR_Renew_Restotal_Exp2(p_year, p_month);
	
	CALL PR_Renew_Restotal_StartEndDate2();
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_Exp`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, EXP
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_EAPP_EXP a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.EXP_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
					
				UNION ALL
				
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_EAPP_HOL a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.ST_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, EXP = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_Exp2`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, EXP
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_EAPP_EXP a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.EXP_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
					
				UNION ALL
				
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_EAPP_HOL a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.ST_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		EXP = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_ExpEst`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, EXP_EST
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_EAPP_EXP a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND (b.DOC_STAT IN ('APP001', 'APP002', 'APP003') OR b.NEW_AT = 1)
				WHERE
					a.EXP_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
					
				UNION ALL
				
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_EAPP_HOL a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND (b.DOC_STAT IN ('APP001', 'APP002', 'APP003') OR b.NEW_AT = 1)
				WHERE
					a.ST_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, EXP_EST = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_Labor`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, LABOR	
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DR_PRJ_ID = NULL, 0, FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, drPrj.PRJ_ID AS DR_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					dr.PRJ_ID AS PRJ_ID		
				FROM hm_daily_result dr	
				WHERE
					dr.WORK_HOUR > 0
					AND SUBSTR(dr.WRITE_DATE, 1, 6) = CONCAT(p_year, LPAD(p_month, 2, '0'))
				GROUP BY PRJ_ID
			) drPrj
				ON allPrj.PRJ_ID = drPrj.PRJ_ID
		GROUP BY SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, LABOR = IF(src.DR_PRJ_ID = NULL, 0, FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_Labor2`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, LABOR	
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DR_PRJ_ID = NULL, 0, FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, drPrj.PRJ_ID AS DR_PRJ_ID
		FROM
			TBL_PRJ allPrj
			JOIN (
				SELECT
					dr.PRJ_ID AS PRJ_ID		
				FROM hm_daily_result dr	
				WHERE
					dr.WORK_HOUR > 0
					AND SUBSTR(dr.WRITE_DATE, 1, 6) = CONCAT(p_year, LPAD(p_month, 2, '0'))
				GROUP BY PRJ_ID
			) drPrj
				ON allPrj.PRJ_ID = drPrj.PRJ_ID
		GROUP BY SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		LABOR = IF(src.DR_PRJ_ID = NULL, 0, FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PlanExp`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PLAN_EXP
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_PLAN_EXP a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.EXP_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, PLAN_EXP = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PlanExp2`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PLAN_EXP
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_PLAN_EXP a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.EXP_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		PLAN_EXP = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PlanExpEst`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PLAN_EXP_EST
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_PLAN_EXP a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.EXP_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, PLAN_EXP_EST = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PlanLabor`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PLAN_LABOR
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_PLAN_LABOR a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.LABOR_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, PLAN_LABOR = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PlanLabor2`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PLAN_LABOR
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_PLAN_LABOR a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.LABOR_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		PLAN_LABOR = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PlanLaborEst`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PLAN_LABOR_EST
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_PLAN_LABOR a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.LABOR_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, PLAN_LABOR_EST = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PLAN_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PurchaseInCommon`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PURCHASE_IN_COMMON
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'Y', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.SALES_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, PURCHASE_IN_COMMON = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'Y', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PurchaseInCommon2`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PURCHASE_IN_COMMON
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'Y', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			JOIN (
				SELECT
					a.SALES_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		PURCHASE_IN_COMMON = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'Y', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PurchaseInNomral`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PURCHASE_IN_NORMAL
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.SALES_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
					
				UNION ALL
				
				SELECT
					a.SALES_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN_LABOR a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, PURCHASE_IN_NORMAL = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PurchaseInNomral2`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PURCHASE_IN_NORMAL
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			JOIN (
				SELECT
					a.SALES_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
					
				UNION ALL
				
				SELECT
					a.SALES_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN_LABOR a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		PURCHASE_IN_NORMAL = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PurchaseInNomralEst`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PURCHASE_IN_NORMAL_EST
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.SALES_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
					
				UNION ALL
				
				SELECT
					a.SALES_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN_LABOR a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, PURCHASE_IN_NORMAL_EST = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PurchaseOut`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PURCHASE_OUT
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_OUT a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.PURCHASE_OUT_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, PURCHASE_OUT = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PurchaseOut2`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PURCHASE_OUT
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_OUT a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.PURCHASE_OUT_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		PURCHASE_OUT = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_PurchaseOutEst`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PURCHASE_OUT_EST
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_OUT a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.PURCHASE_OUT_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, PURCHASE_OUT_EST = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_PURCHASE_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_SalesIn`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, SALES_IN
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'A', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PURCHASE_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
						#반려문서 제외
						AND B.DOC_STAT != 'APP099'
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
					
				UNION ALL
				
				SELECT
					a.PURCHASE_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN_LABOR a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
						#반려문서 제외
						AND B.DOC_STAT != 'APP099'
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, SALES_IN = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'A', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_SalesIn2`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, SALES_IN
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'A', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			JOIN (
				SELECT
					a.PURCHASE_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
						#반려문서 제외
						AND B.DOC_STAT != 'APP099'
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
					
				UNION ALL
				
				SELECT
					a.PURCHASE_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN_LABOR a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
						#반려문서 제외
						AND B.DOC_STAT != 'APP099'
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		SALES_IN = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'A', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_SalesInEst`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, SALES_IN_EST
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'A', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PURCHASE_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
						#반려문서 제외
						AND B.DOC_STAT != 'APP099'
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
					
				UNION ALL
				
				SELECT
					a.PURCHASE_PRJ_ID AS PRJ_ID		
				FROM
					TBL_PURCHASE_IN_LABOR a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
						#반려문서 제외
						AND B.DOC_STAT != 'APP099'
				WHERE
					a.PURCHASE_IN_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, SALES_IN_EST = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'A', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_SalesOut`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, SALES_OUT
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_SALES a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.SALES_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, SALES_OUT = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_SalesOut2`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, SALES_OUT
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_SALES a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.SALES_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		SALES_OUT = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_SalesOutEst`(p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, SALES_OUT_EST
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, LOCALTIME()
	FROM (
		SELECT
			p_year AS SRC_YEAR
			, LPAD(p_month, 2, '0') AS SRC_MONTH
			, allPrj.PRJ_ID AS SRC_PRJ_ID
			, docPrj.PRJ_ID AS DOC_PRJ_ID
		FROM
			TBL_PRJ allPrj
			LEFT JOIN (
				SELECT
					a.PRJ_ID AS PRJ_ID		
				FROM
					TBL_SALES a
					INNER JOIN TBL_EAPP_DOC b
						ON a.DOC_ID = b.DOC_ID
						AND b.NEW_AT = 1
				WHERE
					a.SALES_DT LIKE CONCAT(p_year, LPAD(p_month, 2, '0'), '%')
				GROUP BY
					PRJ_ID
			) docPrj
				ON allPrj.PRJ_ID = docPrj.PRJ_ID
		GROUP BY
			SRC_PRJ_ID
	) src
	
	ON DUPLICATE KEY
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, SALES_OUT_EST = IF(src.DOC_PRJ_ID = NULL, 0, FN_GET_SALES_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N'))
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_StartEndDate`()
BEGIN
	UPDATE
		TBL_PRJ_RESULT_TOTAL AS A
		INNER JOIN
		TBL_PRJ AS B
		ON A.PRJ_ID = B.PRJ_ID
	SET
		A.ST_DT = B.ST_DT,
		A.COMP_DUE_DT = B.COMP_DUE_DT,
		A.COMP_DT = DATE_FORMAT(B.COMP_DT, '%Y%m%d')
		;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_StartEndDate2`()
BEGIN
	UPDATE
		TBL_PRJ_RESULT AS A
		INNER JOIN
		TBL_PRJ AS B
		ON A.PRJ_ID = B.PRJ_ID
	SET
		A.ST_DT = B.ST_DT,
		A.COMP_DUE_DT = B.COMP_DUE_DT,
		A.COMP_DT = DATE_FORMAT(B.COMP_DT, '%Y%m%d')
		;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_StartEndDate_Prj`(p_prj_id CHAR(20))
BEGIN
	UPDATE
		TBL_PRJ_RESULT_TOTAL AS A
		INNER JOIN
		TBL_PRJ AS B
		ON A.PRJ_ID = B.PRJ_ID
	SET
		A.ST_DT = B.ST_DT,
		A.COMP_DUE_DT = B.COMP_DUE_DT,
		A.COMP_DT = DATE_FORMAT(B.COMP_DT, '%Y%m%d')
	WHERE
		B.PRJ_ID = p_prj_id
		;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Renew_Restotal_StartEndDate_Prj2`(p_prj_id CHAR(20))
BEGIN
	UPDATE
		TBL_PRJ_RESULT AS A
		INNER JOIN
		TBL_PRJ AS B
		ON A.PRJ_ID = B.PRJ_ID
	SET
		A.ST_DT = B.ST_DT,
		A.COMP_DUE_DT = B.COMP_DUE_DT,
		A.COMP_DT = DATE_FORMAT(B.COMP_DT, '%Y%m%d')
	WHERE
		B.PRJ_ID = p_prj_id
		;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_UPDATE_DAY_REPORT_MONTH_TOTAL_TM`()
BEGIN
	#TBL_DAY_REPORT 테이블에 인건비 집계 기준이 되는 MONTH_TOTAL_TM 값을 전체 업데이트
	#MONTH_TOTAL_TM 값은 일일업무보고가 CUD 될 때 JAVA 서버에서 업데이트해서 유지
	UPDATE
		TBL_DAY_REPORT dr
		INNER JOIN (
			SELECT USER_NO, DAY_REPORT_YM,  IFNULL(SUM(IFNULL(dr.DAY_REPORT_TM, 0)), 0) TM
			FROM TBL_DAY_REPORT dr
			WHERE DR.IS_HOLIDAY = 0
			GROUP BY USER_NO, DAY_REPORT_YM 
		) A
		ON DR.USER_NO = A.USER_NO
		AND DR.DAY_REPORT_YM = A.DAY_REPORT_YM
	SET 
		MONTH_TOTAL_TM = A.TM
	;
	
    END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_UPDATE_EAPP_DOC_STATUS`()
BEGIN
	#TBL_EAPP_DOC 테이블 STATUS 값 UPDATE #트리거 때문에 STATUS 직접 수정은 불가함
	UPDATE
		TBL_EAPP_DOC B
	SET
		B.STATUS = IF( B.NEW_AT = 0 AND b.DOC_STAT IN ('APP001', 'APP002', 'APP003')
				, 1
				,IF( B.NEW_AT = 1 AND B.DOC_STAT IN ('APP004', 'APP005')
					, 2
					, IF( B.NEW_AT = 0 #AND B.DOC_STAT IN ('APP004', 'APP005', 'APP000', 'APP099')
						, 3, 4
					)
				)
			) 
		;
	#TBL_EAPP_DOC_UPDATE 트리거로 TBL_EAPP_EXP 테이블 STATUS 값 UPDATE
	#TBL_EAPP_EXP_UPDATE 트리거로 TBL_CARD_SPEND 테이블 STATUS 값 UPDATE
	
    END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_UPDATE_EAPP_SALES_PRJ`(docId CHAR(20), bfrPrjId CHAR(20), aftPrjId CHAR(20))
BEGIN
	#종합매출 보고서 프로젝트 이동할 때 작업할것
	#종합매출 매출정보
	UPDATE
		TBL_EAPP_TOT_SALES
	SET SALES_PRJ_ID = aftPrjId
	WHERE
		DOC_ID = docId
		AND SALES_PRJ_ID = bfrPrjId
	;
	#프로젝트 매출건 검색 조건
	UPDATE
		TBL_SALES
	SET PRJ_ID = aftPrjId
	WHERE
		DOC_ID = docId
		AND PRJ_ID = bfrPrjId
	;
	#판관비 계획
	UPDATE
		TBL_PLAN_EXP
	SET PRJ_ID = aftPrjId
	WHERE
		DOC_ID = docId
		AND TYP = 'S'
		AND PRJ_ID = bfrPrjId
	;
	#인건비 계획 = 수행프로젝트
	UPDATE
		TBL_PLAN_LABOR
	SET PRJ_ID = aftPrjId
	WHERE
		DOC_ID = docId
		AND PRJ_ID = bfrPrjId
	;
	#사내매입
	UPDATE
		TBL_PURCHASE_IN
	SET SALES_PRJ_ID = aftPrjId
	WHERE
		DOC_ID = docId
		AND SALES_PRJ_ID = bfrPrjId
	;
	#사내매입 인건비
	UPDATE
		TBL_PURCHASE_IN_LABOR
	SET SALES_PRJ_ID = aftPrjId
	WHERE
		DOC_ID = docId
		AND SALES_PRJ_ID = bfrPrjId
	;
	#사외매입
	UPDATE
		TBL_PURCHASE_OUT
	SET PRJ_ID = aftPrjId
	WHERE
		DOC_ID = docId
		AND PRJ_ID = bfrPrjId
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_UPDATE_IS_HOLIDAY`(DT CHAR(8))
BEGIN
		
	#근태기록, 업무기록 휴일여부 업데이트. 전체 업데이트는 2013년초 기준 20초. 1년에 20초
	UPDATE
		TBL_ATTEND_CHECK
	SET
		IS_HOLIDAY = FN_IS_HOLIDAY(ATTEND_DT)
	WHERE
		ATTEND_DT LIKE CONCAT(DT, '%')
	;
	
	UPDATE
		TBL_DAY_REPORT
	SET
		IS_HOLIDAY = FN_IS_HOLIDAY(DAY_REPORT_DT)
	WHERE
		DAY_REPORT_DT LIKE CONCAT(DT, '%')
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_Exp_By_Doc`(p_docId CHAR(20), p_parentId CHAR(20), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, EXP_EST
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					b.SRC_YEAR AS SRC_YEAR
					, b.SRC_MONTH AS SRC_MONTH
					, b.SRC_PRJ_ID AS SRC_PRJ_ID
				FROM
					(
						SELECT
							LPAD(SUBSTRING(IFNULL(a.EXP_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.EXP_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_EAPP_EXP a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
						UNION ALL
						SELECT
							LPAD(SUBSTRING(IFNULL(a.ST_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.ST_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_EAPP_HOL a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
					) b
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, EXP_EST = FN_GET_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, EXP
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					b.SRC_YEAR AS SRC_YEAR
					, b.SRC_MONTH AS SRC_MONTH
					, b.SRC_PRJ_ID AS SRC_PRJ_ID
				FROM
					(
						SELECT
							LPAD(SUBSTRING(IFNULL(a.EXP_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.EXP_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_EAPP_EXP a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
						UNION ALL
						SELECT
							LPAD(SUBSTRING(IFNULL(a.ST_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.ST_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_EAPP_HOL a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
					) b
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, EXP = FN_GET_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_Exp_By_Param`(p_prjId CHAR(20), p_year CHAR(4), p_month CHAR(2), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, EXP_EST
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_EXP(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, EXP_EST = FN_GET_EXP(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, EXP
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_EXP(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, EXP = FN_GET_EXP(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_Labor_By_Delete_DayReport`(p_userNo INT, p_taskId CHAR(20), p_dayReportDt CHAR(8))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, LABOR
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, LOCALTIME()
	FROM
		(
			# 업무보고 삭제시 인건비를 다시 계산해야 하는 프로젝트
			# - 삭제한 업무보고 날짜가 포함된 월에 업무보고를 입력한 모든 프로젝트
			# - 삭제한 업무보고 날짜가 포함된 월의 해당 업무보고 프로젝트 (해당 월에 한건만 남아있던 것을 삭제하는 경우에 대한 처리)
			SELECT
				a.SRC_YEAR AS SRC_YEAR
				, a.SRC_MONTH AS SRC_MONTH
				, a.SRC_PRJ_ID AS SRC_PRJ_ID
			FROM
				(
					SELECT
						LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
						, LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
						, IFNULL(task.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
					FROM
						TBL_DAY_REPORT dr
						INNER JOIN TBL_TASK task
							ON dr.TASK_ID = task.TASK_ID
					WHERE
						dr.USER_NO = p_userNo
						AND SUBSTRING(dr.DAY_REPORT_DT, 1, 6) = SUBSTRING(p_dayReportDt, 1, 6)
					
					UNION ALL
					SELECT
						LPAD(SUBSTRING(IFNULL(p_dayReportDt, ''), 1, 4), 4, '?') AS SRC_YEAR
						, LPAD(SUBSTRING(IFNULL(p_dayReportDt, ''), 5, 2), 2, '?') AS SRC_MONTH
						, IFNULL(task.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
					FROM
						TBL_TASK task
					WHERE
						task.TASK_ID = p_taskId
				) a
			GROUP BY
				SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
		) src
	
	ON DUPLICATE KEY
	
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, LABOR = FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_Labor_By_Delete_Task`(p_taskId CHAR(20), p_prjId CHAR(20))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, LABOR
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, LOCALTIME()
	FROM
		(
			# task 삭제시 인건비를 다시 계산해야 하는 프로젝트
			# - 삭제된 task에 대해 사용자가 업무보고를 입력한 모든 월을 대상으로 해당 월에 사용자가 업무보고를 입력한 모든 프로젝트들
			# - 동일한 월을 대상으로 삭제된 task의 프로젝트
			SELECT
				a.SRC_YEAR AS SRC_YEAR
				, a.SRC_MONTH AS SRC_MONTH
				, a.SRC_PRJ_ID AS SRC_PRJ_ID
			FROM
				(
					SELECT
						LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
						, LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
						, IFNULL(task.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
					FROM
						(
							SELECT
								LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 1, 4), 4, '?') AS P_YEAR
								, LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 5, 2), 2, '?') AS P_MONTH
								, dr.USER_NO AS P_USER
							FROM
								TBL_DAY_REPORT dr
							WHERE
								dr.TASK_ID = p_taskId
							GROUP BY
								P_YEAR, P_MONTH, P_USER
						) period
						INNER JOIN TBL_DAY_REPORT dr
							ON period.P_USER = dr.USER_NO
							AND period.P_YEAR = SUBSTRING(dr.DAY_REPORT_DT, 1, 4)
							AND period.P_MONTH = SUBSTRING(dr.DAY_REPORT_DT, 5, 2)
						INNER JOIN TBL_TASK task
							ON dr.TASK_ID = task.TASK_ID
					UNION ALL
					SELECT
						LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
						, LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
						, IFNULL(p_prjId, 'PRJ_????????????????') AS SRC_PRJ_ID
					FROM
						TBL_DAY_REPORT dr
					WHERE
						dr.TASK_ID = p_taskId
				) a
			GROUP BY
				SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
		) src
	
	ON DUPLICATE KEY
	
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, LABOR = FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_Labor_By_Doc`(p_docId CHAR(20), p_parentId CHAR(20))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, LABOR
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, LOCALTIME()
	FROM
		(
			# 결재문서 변경시 인건비를 다시 계산해야 하는 프로젝트
			# - 인건비 계산에 영향을 주는 결재문서는 휴가신청서 밖에 없음
			#   . 신청한 휴가기간 내에 해당 사용자가 이미 작성한 일일업무보고가 있는 경우 (이미 작성된 업무보고가 인건비반영에 무효가 됨)
			#   . 무효화된 업무보고 날짜가 포함된 월에 업무보고를 입력한 모든 프로젝트
			SELECT
				LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
				, LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
				, IFNULL(task.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
			FROM
				(
					SELECT
						LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 1, 4), 4, '?') AS YEAR
						, LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 5, 2), 2, '?') AS MONTH
						, dr.USER_NO AS USER_NO
					FROM
						TBL_EAPP_VAC vac
						INNER JOIN TBL_EAPP_DOC doc
							ON vac.DOC_ID = doc.DOC_ID
							AND (
								doc.DOC_ID = p_docId
								OR doc.DOC_ID = p_parentId
							)
						INNER JOIN TBL_DAY_REPORT dr
							ON doc.WRITER_NO = dr.USER_NO
							AND vac.ST_DT <= dr.DAY_REPORT_DT
							AND vac.ED_DT >= dr.DAY_REPORT_DT
						INNER JOIN TBL_TASK task
							ON dr.TASK_ID = task.TASK_ID
					GROUP BY
						YEAR, MONTH, USER_NO
				) target
				INNER JOIN TBL_DAY_REPORT dr
					ON target.USER_NO = dr.USER_NO
					AND SUBSTRING(dr.DAY_REPORT_DT, 1, 6) = CONCAT(target.YEAR, target.MONTH)
				INNER JOIN TBL_TASK task
					ON dr.TASK_ID = task.TASK_ID
			GROUP BY
				SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
		) src
	
	ON DUPLICATE KEY
	
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, LABOR = FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_Labor_By_Insert_DayReport`(p_userNo INT, p_dayReportDt CHAR(8))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, LABOR
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, LOCALTIME()
	FROM
		(
			# 업무보고 작성시
			# 해당 월에 해당 사용자가 업무보고를 입력한 적이 있는 프로젝트들에 대해 인건비 다시 계산
			SELECT
				LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
				, LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
				, IFNULL(task.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
			FROM
				TBL_DAY_REPORT dr
				INNER JOIN TBL_TASK task
					ON dr.TASK_ID = task.TASK_ID
			WHERE
				dr.USER_NO = p_userNo
				AND SUBSTRING(dr.DAY_REPORT_DT, 1, 6) = SUBSTRING(p_dayReportDt, 1, 6)
			GROUP BY
				SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
		) src
	
	ON DUPLICATE KEY
	
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, LABOR = FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_Labor_By_Param`(p_prjId CHAR(20), p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, LABOR
			, MOD_DT
		)
	VALUES
		(
			CONCAT(p_year, '-', p_month, '-', p_prjId)
			, p_year
			, p_month
			, p_prjId
			, FN_GET_LABOR(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
			, LOCALTIME()
		)
	ON DUPLICATE KEY
	UPDATE
		YEAR = p_year
		, MONTH = p_month
		, PRJ_ID = p_prjId
		, LABOR = FN_GET_LABOR(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_Labor_By_Update_DayReport`(p_userNo INT, p_oldTaskId CHAR(20), p_oldDayReportDt CHAR(8), p_newDayReportDt CHAR(8))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, LABOR
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, LOCALTIME()
	FROM
		(
			# 업무보고 수정시 인건비를 다시 계산해야 하는 프로젝트
			# - 업무보고 수정 이전/이후의 날짜가 포함된 월에 업무보고를 입력한 모든 프로젝트
			# - 업무보고 수정 이전 월의 해당 업무보고 프로젝트 (해당 월에 한건만 남아있던 것을 수정해서 다른달로 날짜를 옮기는 경우에 대한 처리)
			SELECT
				a.SRC_YEAR AS SRC_YEAR
				, a.SRC_MONTH AS SRC_MONTH
				, a.SRC_PRJ_ID AS SRC_PRJ_ID
			FROM
				(
					SELECT
						LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
						, LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
						, IFNULL(task.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
					FROM
						TBL_DAY_REPORT dr
						INNER JOIN TBL_TASK task
							ON dr.TASK_ID = task.TASK_ID
					WHERE
						dr.USER_NO = p_userNo
						AND (
							SUBSTRING(dr.DAY_REPORT_DT, 1, 6) = SUBSTRING(p_oldDayReportDt, 1, 6)
							OR SUBSTRING(dr.DAY_REPORT_DT, 1, 6) = SUBSTRING(p_newDayReportDt, 1, 6)
						)
					
					UNION ALL
					SELECT
						LPAD(SUBSTRING(IFNULL(p_oldDayReportDt, ''), 1, 4), 4, '?') AS SRC_YEAR
						, LPAD(SUBSTRING(IFNULL(p_oldDayReportDt, ''), 5, 2), 2, '?') AS SRC_MONTH
						, IFNULL(task.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
					FROM
						TBL_TASK task
					WHERE
						task.TASK_ID = p_oldTaskId
				) a
			GROUP BY
				SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
		) src
	
	ON DUPLICATE KEY
	
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, LABOR = FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_Labor_By_Update_Task`(p_taskId CHAR(20), p_oldPrjId CHAR(20), p_newPrjId CHAR(20))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, LABOR
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, LOCALTIME()
	FROM
		(
			# task 수정시
			# - 해당 task에 업무보고가 입력된 모든 월을 대상으로 task 수정 이전/이후의 프로젝트에 대해 인건비를 다시 계산
			SELECT
				a.SRC_YEAR AS SRC_YEAR
				, a.SRC_MONTH AS SRC_MONTH
				, a.SRC_PRJ_ID AS SRC_PRJ_ID
			FROM
				(
					SELECT
						LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
						, LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
						, IFNULL(p_newPrjId, 'PRJ_????????????????') AS SRC_PRJ_ID
					FROM
						TBL_TASK task
						INNER JOIN TBL_DAY_REPORT dr
							ON task.TASK_ID = dr.TASK_ID
					WHERE
						task.TASK_ID = p_taskId
					
					UNION ALL
					SELECT
						LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
						, LPAD(SUBSTRING(IFNULL(dr.DAY_REPORT_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
						, IFNULL(p_oldPrjId, 'PRJ_????????????????') AS SRC_PRJ_ID
					FROM
						TBL_TASK task
						INNER JOIN TBL_DAY_REPORT dr
							ON task.TASK_ID = dr.TASK_ID
					WHERE
						task.TASK_ID = p_taskId
				) a
			GROUP BY
				SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
		) src
	
	ON DUPLICATE KEY
	
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, LABOR = FN_GET_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_PlanExp_By_Doc`(p_docId CHAR(20), p_parentId CHAR(20), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PLAN_EXP_EST
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_PLAN_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					LPAD(SUBSTRING(IFNULL(a.EXP_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
					, LPAD(SUBSTRING(IFNULL(a.EXP_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
					, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
				FROM
					TBL_PLAN_EXP a
				WHERE
					a.DOC_ID = p_docId
					OR a.DOC_ID = p_parentId
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, PLAN_EXP_EST = FN_GET_PLAN_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PLAN_EXP
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_PLAN_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					LPAD(SUBSTRING(IFNULL(a.EXP_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
					, LPAD(SUBSTRING(IFNULL(a.EXP_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
					, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
				FROM
					TBL_PLAN_EXP a
				WHERE
					a.DOC_ID = p_docId
					OR a.DOC_ID = p_parentId
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, PLAN_EXP = FN_GET_PLAN_EXP(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_PlanExp_By_Param`(p_prjId CHAR(20), p_year CHAR(4), p_month CHAR(2), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PLAN_EXP_EST
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_PLAN_EXP(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, PLAN_EXP_EST = FN_GET_PLAN_EXP(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PLAN_EXP
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_PLAN_EXP(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, PLAN_EXP = FN_GET_PLAN_EXP(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_PlanLabor_By_Doc`(p_docId CHAR(20), p_parentId CHAR(20), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PLAN_LABOR_EST
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_PLAN_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					LPAD(SUBSTRING(IFNULL(a.LABOR_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
					, LPAD(SUBSTRING(IFNULL(a.LABOR_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
					, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
				FROM
					TBL_PLAN_LABOR a
				WHERE
					a.DOC_ID = p_docId
					OR a.DOC_ID = p_parentId
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, PLAN_LABOR_EST = FN_GET_PLAN_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PLAN_LABOR
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_PLAN_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					LPAD(SUBSTRING(IFNULL(a.LABOR_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
					, LPAD(SUBSTRING(IFNULL(a.LABOR_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
					, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
				FROM
					TBL_PLAN_LABOR a
				WHERE
					a.DOC_ID = p_docId
					OR a.DOC_ID = p_parentId
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, PLAN_LABOR = FN_GET_PLAN_LABOR(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_PlanLabor_By_Param`(p_prjId CHAR(20), p_year CHAR(4), p_month CHAR(2), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PLAN_LABOR_EST
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_PLAN_LABOR(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, PLAN_LABOR_EST = FN_GET_PLAN_LABOR(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PLAN_LABOR
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_PLAN_LABOR(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, PLAN_LABOR = FN_GET_PLAN_LABOR(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_PurchaseInCommon_By_Doc`(p_docId CHAR(20), p_parentId CHAR(20))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PURCHASE_IN_COMMON
			, MOD_DT
		)
	SELECT
		CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
		, src.SRC_YEAR
		, src.SRC_MONTH
		, src.SRC_PRJ_ID
		, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'Y', 'N', 'N')
		, LOCALTIME()
	FROM
		(
			SELECT
				LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
				, LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
				, IFNULL(a.SALES_PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
			FROM
				TBL_PURCHASE_IN a
			WHERE
				a.DOC_ID = p_docId
				OR a.DOC_ID = p_parentId
			GROUP BY
				SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
		) src
	
	ON DUPLICATE KEY
	
	UPDATE
		YEAR = src.SRC_YEAR
		, MONTH = src.SRC_MONTH
		, PRJ_ID = src.SRC_PRJ_ID
		, PURCHASE_IN_COMMON = FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'Y', 'N', 'N')
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_PurchaseInCommon_By_Param`(p_prjId CHAR(20), p_year CHAR(4), p_month CHAR(2))
BEGIN
	INSERT INTO
		TBL_PRJ_RESULT_TOTAL (
			ID
			, YEAR
			, MONTH
			, PRJ_ID
			, PURCHASE_IN_COMMON
			, MOD_DT
		)
	VALUES
		(
			CONCAT(p_year, '-', p_month, '-', p_prjId)
			, p_year
			, p_month
			, p_prjId
			, FN_GET_PURCHASE_IN(p_prjId, p_year, p_month, 'N', 'Y', 'N', 'N')
			, LOCALTIME()
		)
	ON DUPLICATE KEY
	UPDATE
		YEAR = p_year
		, MONTH = p_month
		, PRJ_ID = p_prjId
		, PURCHASE_IN_COMMON = FN_GET_PURCHASE_IN(p_prjId, p_year, p_month, 'N', 'Y', 'N', 'N')
		, MOD_DT = LOCALTIME()
	;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_PurchaseInNormal_By_Doc`(p_docId CHAR(20), p_parentId CHAR(20), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PURCHASE_IN_NORMAL_EST
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					b.SRC_YEAR AS SRC_YEAR
					, b.SRC_MONTH AS SRC_MONTH
					, b.SRC_PRJ_ID AS SRC_PRJ_ID
				FROM
					(
						SELECT
							LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.SALES_PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_PURCHASE_IN a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
						UNION ALL
						SELECT
							LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.SALES_PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_PURCHASE_IN_LABOR a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
					) b
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, PURCHASE_IN_NORMAL_EST = FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PURCHASE_IN_NORMAL
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					b.SRC_YEAR AS SRC_YEAR
					, b.SRC_MONTH AS SRC_MONTH
					, b.SRC_PRJ_ID AS SRC_PRJ_ID
				FROM
					(
						SELECT
							LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.SALES_PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_PURCHASE_IN a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
						UNION ALL
						SELECT
							LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.SALES_PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_PURCHASE_IN_LABOR a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
					) b
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, PURCHASE_IN_NORMAL = FN_GET_PURCHASE_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_PurchaseInNormal_By_Param`(p_prjId CHAR(20), p_year CHAR(4), p_month CHAR(2), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PURCHASE_IN_NORMAL_EST
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_PURCHASE_IN(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, PURCHASE_IN_NORMAL_EST = FN_GET_PURCHASE_IN(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PURCHASE_IN_NORMAL
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_PURCHASE_IN(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, PURCHASE_IN_NORMAL = FN_GET_PURCHASE_IN(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_PurchaseOut_By_Doc`(p_docId CHAR(20), p_parentId CHAR(20), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PURCHASE_OUT_EST
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_PURCHASE_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					LPAD(SUBSTRING(IFNULL(a.PURCHASE_OUT_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
					, LPAD(SUBSTRING(IFNULL(a.PURCHASE_OUT_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
					, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
				FROM
					TBL_PURCHASE_OUT a
				WHERE
					a.DOC_ID = p_docId
					OR a.DOC_ID = p_parentId
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, PURCHASE_OUT_EST = FN_GET_PURCHASE_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PURCHASE_OUT
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_PURCHASE_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					LPAD(SUBSTRING(IFNULL(a.PURCHASE_OUT_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
					, LPAD(SUBSTRING(IFNULL(a.PURCHASE_OUT_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
					, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
				FROM
					TBL_PURCHASE_OUT a
				WHERE
					a.DOC_ID = p_docId
					OR a.DOC_ID = p_parentId
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, PURCHASE_OUT = FN_GET_PURCHASE_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_PurchaseOut_By_Param`(p_prjId CHAR(20), p_year CHAR(4), p_month CHAR(2), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PURCHASE_OUT_EST
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_PURCHASE_OUT(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, PURCHASE_OUT_EST = FN_GET_PURCHASE_OUT(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, PURCHASE_OUT
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_PURCHASE_OUT(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, PURCHASE_OUT = FN_GET_PURCHASE_OUT(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_SalesIn_By_Doc`(p_docId CHAR(20), p_parentId CHAR(20), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, SALES_IN_EST
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_SALES_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'A', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					b.SRC_YEAR AS SRC_YEAR
					, b.SRC_MONTH AS SRC_MONTH
					, b.SRC_PRJ_ID AS SRC_PRJ_ID
				FROM
					(
						SELECT
							LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.PURCHASE_PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_PURCHASE_IN a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
						UNION ALL
						SELECT
							LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.PURCHASE_PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_PURCHASE_IN_LABOR a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
					) b
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, SALES_IN_EST = FN_GET_SALES_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'A', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, SALES_IN
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_SALES_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'A', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					b.SRC_YEAR AS SRC_YEAR
					, b.SRC_MONTH AS SRC_MONTH
					, b.SRC_PRJ_ID AS SRC_PRJ_ID
				FROM
					(
						SELECT
							LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.PURCHASE_PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_PURCHASE_IN a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
						UNION ALL
						SELECT
							LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
							, LPAD(SUBSTRING(IFNULL(a.PURCHASE_IN_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
							, IFNULL(a.PURCHASE_PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
						FROM
							TBL_PURCHASE_IN_LABOR a
						WHERE
							a.DOC_ID = p_docId
							OR a.DOC_ID = p_parentId
					) b
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, SALES_IN = FN_GET_SALES_IN(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'A', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_SalesIn_By_Param`(p_prjId CHAR(20), p_year CHAR(4), p_month CHAR(2), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, SALES_IN_EST
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_SALES_IN(p_prjId, p_year, p_month, 'Y', 'A', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, SALES_IN_EST = FN_GET_SALES_IN(p_prjId, p_year, p_month, 'Y', 'A', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, SALES_IN
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_SALES_IN(p_prjId, p_year, p_month, 'N', 'A', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, SALES_IN = FN_GET_SALES_IN(p_prjId, p_year, p_month, 'N', 'A', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_SalesOut_By_Doc`(p_docId CHAR(20), p_parentId CHAR(20), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, SALES_OUT_EST
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_SALES_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					LPAD(SUBSTRING(IFNULL(a.SALES_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
					, LPAD(SUBSTRING(IFNULL(a.SALES_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
					, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
				FROM
					TBL_SALES a
				WHERE
					a.DOC_ID = p_docId
					OR a.DOC_ID = p_parentId
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, SALES_OUT_EST = FN_GET_SALES_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, SALES_OUT
				, MOD_DT
			)
		SELECT
			CONCAT(src.SRC_YEAR, '-', src.SRC_MONTH, '-', src.SRC_PRJ_ID)
			, src.SRC_YEAR
			, src.SRC_MONTH
			, src.SRC_PRJ_ID
			, FN_GET_SALES_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, LOCALTIME()
		FROM
			(
				SELECT
					LPAD(SUBSTRING(IFNULL(a.SALES_DT, ''), 1, 4), 4, '?') AS SRC_YEAR
					, LPAD(SUBSTRING(IFNULL(a.SALES_DT, ''), 5, 2), 2, '?') AS SRC_MONTH
					, IFNULL(a.PRJ_ID, 'PRJ_????????????????') AS SRC_PRJ_ID
				FROM
					TBL_SALES a
				WHERE
					a.DOC_ID = p_docId
					OR a.DOC_ID = p_parentId
				GROUP BY
					SRC_YEAR, SRC_MONTH, SRC_PRJ_ID
			) src
		
		ON DUPLICATE KEY
		
		UPDATE
			YEAR = src.SRC_YEAR
			, MONTH = src.SRC_MONTH
			, PRJ_ID = src.SRC_PRJ_ID
			, SALES_OUT = FN_GET_SALES_OUT(src.SRC_PRJ_ID, src.SRC_YEAR, src.SRC_MONTH, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `PR_Update_ResTotal_SalesOut_By_Param`(p_prjId CHAR(20), p_year CHAR(4), p_month CHAR(2), p_expectYn CHAR(1))
BEGIN
	IF (p_expectYn = 'Y')
	THEN
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, SALES_OUT_EST
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_SALES_OUT(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, SALES_OUT_EST = FN_GET_SALES_OUT(p_prjId, p_year, p_month, 'Y', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	ELSE
		INSERT INTO
			TBL_PRJ_RESULT_TOTAL (
				ID
				, YEAR
				, MONTH
				, PRJ_ID
				, SALES_OUT
				, MOD_DT
			)
		VALUES
			(
				CONCAT(p_year, '-', p_month, '-', p_prjId)
				, p_year
				, p_month
				, p_prjId
				, FN_GET_SALES_OUT(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
				, LOCALTIME()
			)
		ON DUPLICATE KEY
		UPDATE
			YEAR = p_year
			, MONTH = p_month
			, PRJ_ID = p_prjId
			, SALES_OUT = FN_GET_SALES_OUT(p_prjId, p_year, p_month, 'N', 'N', 'N', 'N')
			, MOD_DT = LOCALTIME()
		;
	END IF;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION `SPLIT_STRING`(x text,
delim varchar(32),
pos int
) RETURNS text CHARSET utf8mb3 COLLATE utf8mb3_general_ci
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
delim, '')//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `tbl_account` (
  `ACC_ID` varchar(20) NOT NULL,
  `ACC_NM` varchar(50) DEFAULT NULL,
  `ACC_LV` int(1) DEFAULT NULL COMMENT '1,2',
  `PRNT_ACC_ID` varchar(20) DEFAULT NULL,
  `ACC_CT` varchar(500) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL COMMENT '''Y'',''N''',
  `ACC_ORD` int(5) DEFAULT NULL,
  `PRNT_TYP` char(1) DEFAULT NULL COMMENT '상위계정에서만 사용 E-판관비 C-원가',
  `CHILD_TYP` char(2) DEFAULT NULL COMMENT '하위계정에서만 사용. 10-업무경비 11-회식비 12-자기개발비 13-상품매입',
  PRIMARY KEY (`ACC_ID`),
  KEY `NewIndex1` (`PRNT_ACC_ID`),
  KEY `NewIndex2` (`PRNT_TYP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `tbl_account` (`ACC_ID`, `ACC_NM`, `ACC_LV`, `PRNT_ACC_ID`, `ACC_CT`, `USE_AT`, `ACC_ORD`, `PRNT_TYP`, `CHILD_TYP`) VALUES
	('ACC_0000000000000001', '복리후생비', 1, 'ACC_0000000000000001', NULL, 'Y', 0, 'E', NULL),
	('ACC_0000000000000002', '감가상각비', 1, 'ACC_0000000000000002', NULL, 'Y', 1, 'E', NULL),
	('ACC_0000000000000003', '지급수수료', 1, 'ACC_0000000000000003', NULL, 'Y', 2, 'E', NULL),
	('ACC_0000000000000004', '상품매입', 1, 'ACC_0000000000000004', NULL, 'Y', 3, 'C', NULL),
	('ACC_0000000000000005', '차량유지비', 1, 'ACC_0000000000000005', NULL, 'Y', 4, 'E', NULL),
	('ACC_0000000000000006', '운반비', 1, 'ACC_0000000000000006', NULL, 'Y', 5, 'E', NULL),
	('ACC_0000000000000007', '광고선전비', 1, 'ACC_0000000000000007', NULL, 'Y', 6, 'E', NULL),
	('ACC_0000000000000008', '접대비', 1, 'ACC_0000000000000008', NULL, 'Y', 7, 'E', NULL),
	('ACC_0000000000000009', '보험료', 1, 'ACC_0000000000000009', NULL, 'Y', 8, 'E', NULL),
	('ACC_0000000000000010', '소모품비', 1, 'ACC_0000000000000010', NULL, 'Y', 9, 'E', NULL),
	('ACC_0000000000000011', '이자비용', 1, 'ACC_0000000000000011', NULL, 'Y', 10, 'E', NULL),
	('ACC_0000000000000012', '사무비', 1, 'ACC_0000000000000012', NULL, 'Y', 11, 'E', NULL),
	('ACC_0000000000000013', '수선비', 1, 'ACC_0000000000000013', NULL, 'Y', 12, 'E', NULL),
	('ACC_0000000000000014', '지급임차료', 1, 'ACC_0000000000000014', NULL, 'Y', 13, 'E', NULL),
	('ACC_0000000000000015', '세금과공과', 1, 'ACC_0000000000000015', NULL, 'Y', 14, 'E', NULL),
	('ACC_0000000000000016', '건물관리비', 1, 'ACC_0000000000000016', NULL, 'Y', 15, 'E', NULL),
	('ACC_0000000000000017', '여비교통비', 1, 'ACC_0000000000000017', NULL, 'Y', 16, 'E', NULL),
	('ACC_0000000000000018', '통신비', 1, 'ACC_0000000000000018', NULL, 'Y', 17, 'E', NULL),
	('ACC_0000000000000019', '야근식대', 2, 'ACC_0000000000000001', '야근식대', 'Y', 18, 'E', '10'),
	('ACC_0000000000000020', '회식대', 2, 'ACC_0000000000000001', '회식대', 'Y', 19, 'E', '10'),
	('ACC_0000000000000021', '음료대', 2, 'ACC_0000000000000001', '음료대', 'Y', 20, 'E', '10'),
	('ACC_0000000000000022', '경조금', 2, 'ACC_0000000000000001', '경조금', 'Y', 21, 'E', '10'),
	('ACC_0000000000000023', '직원선물비', 2, 'ACC_0000000000000001', '직원선물비', 'Y', 22, 'E', '10'),
	('ACC_0000000000000024', '행사비', 2, 'ACC_0000000000000001', '행사비', 'Y', 23, 'E', '10'),
	('ACC_0000000000000025', '자기개발비', 2, 'ACC_0000000000000001', '자기개발비', 'Y', 24, 'E', '11'),
	('ACC_0000000000000026', '감가상각', 2, 'ACC_0000000000000002', '감가상각', 'Y', 25, 'E', '10'),
	('ACC_0000000000000027', '유형자산처분손실', 2, 'ACC_0000000000000002', '유형자산처분손실', 'N', 26, 'E', '10'),
	('ACC_0000000000000028', '기타수수료', 2, 'ACC_0000000000000003', '기타수수료', 'Y', 27, 'E', '10'),
	('ACC_0000000000000029', '외주비(계산서)', 2, 'ACC_0000000000000004', '외주용역비', 'Y', 28, 'C', '13'),
	('ACC_0000000000000030', '재고매입', 2, 'ACC_0000000000000004', '재고매입', 'Y', 29, 'C', '13'),
	('ACC_0000000000000031', '납품장비', 2, 'ACC_0000000000000004', '납품장비', 'Y', 30, 'C', '13'),
	('ACC_0000000000000041', '차량수선비', 2, 'ACC_0000000000000005', '차량수선비', 'Y', 33, 'E', '10'),
	('ACC_0000000000000042', '송달,퀵', 2, 'ACC_0000000000000006', '송달,퀵', 'Y', 34, 'E', '10'),
	('ACC_0000000000000043', '매체광고비', 2, 'ACC_0000000000000007', '광고선전비', 'Y', 35, 'E', '10'),
	('ACC_0000000000000044', '기타', 2, 'ACC_0000000000000007', '기타', 'Y', 36, 'E', '10'),
	('ACC_0000000000000045', '회의비', 2, 'ACC_0000000000000008', '회의비', 'Y', 37, 'E', '10'),
	('ACC_0000000000000046', '국내접대비', 2, 'ACC_0000000000000008', '국내접대비', 'Y', 38, 'E', '10'),
	('ACC_0000000000000047', '보증보험료', 2, 'ACC_0000000000000009', '보증보험료', 'Y', 39, 'E', '10'),
	('ACC_0000000000000048', '자동차보험료', 2, 'ACC_0000000000000009', '자동차보험료', 'Y', 40, 'E', '10'),
	('ACC_0000000000000049', '화재보험료', 2, 'ACC_0000000000000009', '화재보험료', 'N', 41, 'E', '10'),
	('ACC_0000000000000050', '기타', 2, 'ACC_0000000000000009', '기타', 'Y', 42, 'E', '10'),
	('ACC_0000000000000051', '원가성소모품', 2, 'ACC_0000000000000010', '원가성소모품', 'Y', 43, 'E', '10'),
	('ACC_0000000000000052', '전산소모품', 2, 'ACC_0000000000000010', '전산소모품', 'Y', 44, 'E', '10'),
	('ACC_0000000000000053', 'S/W', 2, 'ACC_0000000000000010', 'S/W', 'Y', 45, 'E', '10'),
	('ACC_0000000000000054', '기타', 2, 'ACC_0000000000000010', '기타', 'Y', 46, 'E', '10'),
	('ACC_0000000000000055', '대출', 2, 'ACC_0000000000000011', '대출', 'Y', 47, 'E', '10'),
	('ACC_0000000000000056', '사무용품비', 2, 'ACC_0000000000000012', '사무용품비', 'Y', 48, 'E', '10'),
	('ACC_0000000000000057', '도서인쇄비', 2, 'ACC_0000000000000012', '도서인쇄비', 'Y', 49, 'E', '10'),
	('ACC_0000000000000058', '기타', 2, 'ACC_0000000000000012', '기타', 'Y', 50, 'E', '10'),
	('ACC_0000000000000059', '건물,비품', 2, 'ACC_0000000000000013', '건물,비품', 'Y', 51, 'E', '10'),
	('ACC_0000000000000060', '토지건물', 2, 'ACC_0000000000000014', '토지건물', 'Y', 52, 'E', '10'),
	('ACC_0000000000000061', '기타', 2, 'ACC_0000000000000014', '기타', 'Y', 53, 'E', '10'),
	('ACC_0000000000000062', '과태료', 2, 'ACC_0000000000000015', '과태료', 'Y', 54, 'E', '10'),
	('ACC_0000000000000063', '재산세', 2, 'ACC_0000000000000015', '재산세', 'Y', 55, 'E', '10'),
	('ACC_0000000000000064', '사업소세', 2, 'ACC_0000000000000015', '사업소세', 'N', 56, 'E', '10'),
	('ACC_0000000000000065', '인지세', 2, 'ACC_0000000000000015', '인지세', 'Y', 57, 'E', '10'),
	('ACC_0000000000000066', '면허세', 2, 'ACC_0000000000000015', '면허세', 'Y', 58, 'E', '10'),
	('ACC_0000000000000067', '자동차세', 2, 'ACC_0000000000000015', '자동차세', 'Y', 59, 'E', '10'),
	('ACC_0000000000000068', '기타', 2, 'ACC_0000000000000015', '기타', 'Y', 60, 'E', '10'),
	('ACC_0000000000000069', '전력비', 2, 'ACC_0000000000000016', '전력비', 'Y', 61, 'E', '10'),
	('ACC_0000000000000070', '상하수도료', 2, 'ACC_0000000000000016', '상하수도료', 'Y', 62, 'E', '10'),
	('ACC_0000000000000071', '기타', 2, 'ACC_0000000000000016', '기타', 'Y', 63, 'E', '10'),
	('ACC_0000000000000072', '개인차량유류비', 2, 'ACC_0000000000000017', '개인차량유류비', 'Y', 64, 'E', '10'),
	('ACC_0000000000000073', '시내외교통비', 2, 'ACC_0000000000000017', '시내외교통비', 'Y', 65, 'E', '10'),
	('ACC_0000000000000074', '국내출장비', 2, 'ACC_0000000000000017', '국내출장비', 'Y', 66, 'E', '10'),
	('ACC_0000000000000075', '해외출장비', 2, 'ACC_0000000000000017', '해외출장비', 'Y', 67, 'E', '10'),
	('ACC_0000000000000076', '전화요금', 2, 'ACC_0000000000000018', '전화요금', 'Y', 68, 'E', '10'),
	('ACC_0000000000000077', '전용회선', 2, 'ACC_0000000000000018', '전용회선', 'Y', 69, 'E', '10'),
	('ACC_0000000000000078', '휴대폰요금', 2, 'ACC_0000000000000018', '휴대폰요금', 'Y', 70, 'E', '10'),
	('ACC_0000000000000079', '우편대', 2, 'ACC_0000000000000018', '우편대', 'Y', 71, 'E', '10'),
	('ACC_0000000000000081', '외주비(소득)', 2, 'ACC_0000000000000004', '외주용역비 중 사업소득 처리한것을 선택합니다.', 'Y', 72, 'C', '13'),
	('ACC_0000000000000091', '차량리스료', 2, 'ACC_0000000000000005', '차량리스료', 'Y', 73, 'E', '10'),
	('ACC_0000000000000092', '교육훈련비', 1, 'ACC_0000000000000092', NULL, 'Y', 74, 'E', NULL),
	('ACC_0000000000000093', '교육비(지원대상)', 2, 'ACC_0000000000000092', '교육비(국비지원대상)', 'Y', 75, 'E', '10'),
	('ACC_0000000000000094', '교육비(비지원대상)', 2, 'ACC_0000000000000092', '교육비(비지원대상)', 'Y', 76, 'E', '10'),
	('ACC_0000000000000101', '인력추천포상', 2, 'HOLIDAY_WORK_AC_PRNT', '경력3년이상 인력추천 포상금', 'Y', 77, 'E', '10'),
	('ACC_0000000000000111', '법인차량유류비', 2, 'ACC_0000000000000017', '법인차량유류비', 'Y', 78, 'E', '10'),
	('HOLIDAY_WORK_ACCOUNT', '휴일근무수당', 2, 'HOLIDAY_WORK_AC_PRNT', '휴일근무수당', 'Y', 32, 'E', '10'),
	('HOLIDAY_WORK_AC_PRNT', '각종수당', 1, 'HOLIDAY_WORK_AC_PRNT', NULL, 'Y', 31, 'E', NULL);

CREATE TABLE IF NOT EXISTS `tbl_attend_check` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `ATTEND_CD` char(2) DEFAULT NULL COMMENT 'AT출근 EA조기출근 NT야근 OT외근 TR파견 SD출장 EN입사 LT지각 VC휴가 HD휴일근무// 미로그인은 NULL',
  `ATTEND_DT` char(8) DEFAULT NULL,
  `ATTEND_TM` time DEFAULT NULL,
  `ATTEND_IP` varchar(20) DEFAULT NULL,
  `DEBUG` char(8) DEFAULT NULL COMMENT '휴일근무 HD 입력오류 디버그용',
  `IS_HOLIDAY` char(1) NOT NULL DEFAULT '0' COMMENT '0 휴일 1 근무일',
  `ATTEND_YM` char(6) DEFAULT NULL COMMENT '트리거로 입력 년월',
  PRIMARY KEY (`NO`),
  UNIQUE KEY `NewIndex1` (`USER_NO`,`ATTEND_DT`),
  KEY `ATTEND_YM` (`ATTEND_YM`,`USER_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_attend_report_sum` (
  `USER_NO` int(11) NOT NULL COMMENT '년월별 유효근무일수, 정상근무일수, 근무시간을 미리 집계하는 테이블',
  `YM` char(6) NOT NULL COMMENT 'RESULT_TOTAL 집계에 속도 향상을 위해 쓰임',
  `TOTAL_WORK_DAY` int(11) DEFAULT NULL,
  `USER_WORK_DAY` int(11) DEFAULT NULL,
  `TOTAL_INPUT` int(11) DEFAULT NULL,
  `MOD_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`USER_NO`,`YM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_auth` (
  `AUTH_CODE` varchar(20) NOT NULL,
  `AUTH_NM` varchar(20) DEFAULT NULL,
  `AUTH_DESC` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`AUTH_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `tbl_auth` (`AUTH_CODE`, `AUTH_NM`, `AUTH_DESC`) VALUES
	('admin', '운영자', '모든 권한 (연봉관리, 권한관리, 한마음개발자, 로그인오버라이드 제외)'),
	('authadmin', '권한 관리자', '관리자페이지 권한 관리 기능(운영자 권한과 별도권한)'),
	('board', '게시판관리자', NULL),
	('bpmboard', '업무절차 게시판', '업무절차 게시판 권한 관리 기능(운영자 권한과 별도 권한)'),
	('conferenceadmin', '화상회의관리자', '화상회의 접속 URL 관리 권한'),
	('consultadmin', '상담관리담당자', '상담관리 관리자 권한(운영자 권한과 별도 권한)'),
	('dayreportadmin', '일일업무수정권자', '전 직원의 일일업무보고를 수정할 수 있음'),
	('dayreportuserlist', '업무일지 작성현황', '업무일지 작성현황 조회권한'),
	('dephead', '부서장', '본부장 (팀장 제외)'),
	('docadmin', '문서열람권자', '완결문서 열람 권한자'),
	('eapp20', '종합매출보고서', '종합매출보고서 작성권한'),
	('eapp24', '예산승인요청서', '예산승인요청서 작성권한'),
	('eapp25', '사내매출보고서', '사내매출보고서 작성권한'),
	('eapp28', '매출이관보고서', '매출이관보고서 작성권한'),
	('eappadmin', '전자결재관리자', '전자결재 관리자반려 권한 (그외 기능 추가가능)'),
	('executive', '임원', '임원'),
	('expauth', '경비지출권한', '투입되지 않은 프로젝트에 지출결의서를 상신할 수 있음'),
	('hmdev', '한마음 시스템 개발자', '한마음 시스템 개발중인 기능 사용가능'),
	('inputresult', '프로젝트별 인력투입<br>상세내역', '프로젝트별 인력투입 상세내역 조회권한'),
	('loginauth', '로그인권한', '로그인 오버라이드(운영자 권한과 별도권한)'),
	('prjtransferadmin', '프로젝트 이관 권한', '프로젝트 이관 권한'),
	('productadmin', '상품관리관리자', '상품관리 관리자 권한(운영자 권한과 별도 권한)'),
	('projectadmin', '프로젝트관리자', '프로젝트 생성, 수정, 투입인력변경 등의 권한'),
	('salauth', '연봉관리자', '연봉관리 권한 (운영자 권한과 별도권한)'),
	('taxadmin', '세금계산서담당자', '세금계산서 관련 권한');

CREATE TABLE IF NOT EXISTS `tbl_background` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `BNAME` varchar(20) DEFAULT NULL COMMENT '이름',
  `BPOSITION` varchar(30) DEFAULT NULL COMMENT '직급',
  `CAREER_DT` varchar(50) DEFAULT NULL COMMENT '경력기간',
  `AGE` varchar(20) DEFAULT NULL COMMENT '나이',
  `MILITARY_SERVICE` varchar(50) DEFAULT NULL COMMENT '병역사항에 군별',
  `MS_ST_DT` varchar(11) DEFAULT NULL COMMENT '병역기간1',
  `MS_ED_DT` varchar(11) DEFAULT NULL COMMENT '병역기간2',
  `MS_LEVEL` varchar(20) DEFAULT NULL COMMENT '계급',
  `LICENSE` varchar(200) DEFAULT NULL COMMENT '자격증',
  `SKILL` text DEFAULT NULL COMMENT '기술',
  `SBASIS` varchar(200) DEFAULT NULL COMMENT '비밀취급인가 근거',
  `SNUM` varchar(200) DEFAULT NULL COMMENT '비밀취급인가증 번호',
  `SW_LEVEL` varchar(50) DEFAULT NULL COMMENT 'SW 기술등급',
  `SABUN` char(4) DEFAULT NULL COMMENT '사번',
  `ORGNZT_ID` char(20) DEFAULT NULL,
  `USER_NO` int(11) DEFAULT NULL COMMENT 'tbl_userinfo의 pk',
  `VIEWYN` int(2) DEFAULT NULL COMMENT '삭제구분',
  `UPDAT` varchar(11) DEFAULT NULL COMMENT '업뎃날짜',
  `ATTACH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일ID',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_banner` (
  `BNR_ID` char(20) NOT NULL,
  `BNR_FILE_ID` char(20) DEFAULT NULL,
  `BNR_SJ` varchar(100) DEFAULT NULL,
  `NTCE_SDT` char(8) DEFAULT NULL,
  `NTCE_EDT` char(8) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `LINK_URL` varchar(100) DEFAULT NULL,
  `POP_YN` char(1) DEFAULT NULL,
  `BNR_CN` text DEFAULT NULL,
  `POP_WIDTH` char(4) DEFAULT NULL,
  `POP_HEIGHT` char(4) DEFAULT NULL,
  `ORD_NO` int(11) DEFAULT 0 COMMENT '배너순서(클 수록 빠름)',
  PRIMARY KEY (`BNR_ID`),
  KEY `ORD_NO` (`ORD_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_bbsread` (
  `BBS_ID` char(20) NOT NULL,
  `NTT_ID` decimal(20,0) NOT NULL DEFAULT 0,
  `USER_NO` varchar(20) NOT NULL,
  `READTIME` datetime DEFAULT NULL,
  PRIMARY KEY (`BBS_ID`,`NTT_ID`,`USER_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_bbs_image` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `NTT_ID` varchar(20) DEFAULT NULL COMMENT 'COMTNBBS의 PK (이미지 게시물의 본문)',
  `ORGNZT_ID` varchar(20) DEFAULT NULL,
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일(첨부이미지)',
  `THUMBNAIL_FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일(첨부썸네일이미지)',
  `USE_AT` char(1) DEFAULT 'Y',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_bond` (
  `BOND_ID` varchar(20) NOT NULL,
  `BOND_SJ` varchar(200) DEFAULT NULL,
  `BOND_CN` varchar(4000) DEFAULT NULL,
  `COMPANY_CD` varchar(20) DEFAULT NULL,
  `CUST_NM` varchar(200) DEFAULT NULL,
  `CUST_BUSI_NO` char(14) DEFAULT NULL,
  `CUST_ADRES` varchar(1000) DEFAULT NULL,
  `CUST_REP_NM` varchar(100) DEFAULT NULL,
  `CUST_BUSI_COND` varchar(100) DEFAULT NULL,
  `CUST_BUSI_TYP` varchar(100) DEFAULT NULL,
  `TAX_EMAIL_1` varchar(100) DEFAULT NULL,
  `TAX_USER_NM_1` varchar(100) DEFAULT NULL,
  `TAX_USER_TELNO_1` varchar(100) DEFAULT NULL,
  `TAX_EMAIL_2` varchar(100) DEFAULT NULL,
  `TAX_USER_NM_2` varchar(100) DEFAULT NULL,
  `TAX_USER_TELNO_2` varchar(100) DEFAULT NULL,
  `TAX_EMAIL_3` varchar(100) DEFAULT NULL,
  `TAX_USER_NM_3` varchar(100) DEFAULT NULL,
  `TAX_USER_TELNO_3` varchar(100) DEFAULT NULL,
  `TAX_EMAIL_4` varchar(100) DEFAULT NULL,
  `TAX_USER_NM_4` varchar(100) DEFAULT NULL,
  `TAX_USER_TELNO_4` varchar(100) DEFAULT NULL,
  `TAX_EMAIL_5` varchar(100) DEFAULT NULL,
  `TAX_USER_NM_5` varchar(100) DEFAULT NULL,
  `TAX_USER_TELNO_5` varchar(100) DEFAULT NULL,
  `PUBLISH_DATE` char(8) DEFAULT NULL,
  `BOND_TYP` char(1) DEFAULT NULL COMMENT '1:청구, 2:영수',
  `WRITE_DATE` datetime DEFAULT NULL,
  `BOND_STAT` char(1) DEFAULT NULL COMMENT 'N:미발행, Y:발행완료, C:취소',
  `WRITER_NO` varchar(20) DEFAULT NULL,
  `FNSH_TIME` datetime DEFAULT NULL,
  `FNSH_USER_NO` varchar(20) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT 'Y',
  `ATCH_FILE_ID` char(20) DEFAULT NULL,
  `ZERO_TAX_RATE` char(1) DEFAULT NULL COMMENT 'Y:영세율, N:영세율X',
  PRIMARY KEY (`BOND_ID`),
  KEY `NewIndex1` (`COMPANY_CD`),
  KEY `NewIndex2` (`BOND_STAT`),
  KEY `NewIndex3` (`USE_AT`),
  KEY `NewIndex4` (`BOND_SJ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_bond_collection` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `BOND_PRJ_NO` int(11) DEFAULT NULL,
  `COLLECTION_DATE` varchar(8) DEFAULT NULL,
  `EXPENSE` int(10) DEFAULT NULL,
  `NOTE` varchar(4000) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT 'Y',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`BOND_PRJ_NO`),
  KEY `NewIndex2` (`USE_AT`)
) ENGINE=InnoDB AUTO_INCREMENT=15306 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_bond_expense` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `BOND_ID` varchar(20) DEFAULT NULL,
  `expense` bigint(14) DEFAULT NULL,
  `NOTE` varchar(4000) DEFAULT NULL,
  `CONTAIN_VAT` char(1) DEFAULT NULL COMMENT 'Y:부가세포함, N:부가세미포함',
  `USE_AT` char(1) DEFAULT 'Y',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`BOND_ID`),
  KEY `NewIndex2` (`USE_AT`)
) ENGINE=InnoDB AUTO_INCREMENT=54675 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_bond_prj` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `BOND_ID` varchar(20) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `expense` bigint(14) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT 'Y',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`BOND_ID`),
  KEY `NewIndex2` (`PRJ_ID`),
  KEY `NewIndex3` (`USE_AT`)
) ENGINE=InnoDB AUTO_INCREMENT=55087 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_business_contact` (
  `BC_ID` char(20) NOT NULL,
  `PRJ_ID` char(20) NOT NULL,
  `BC_SJ` varchar(200) DEFAULT NULL,
  `BC_CN` mediumtext DEFAULT NULL,
  `ATTACH_FILE_ID` char(20) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `MOD_DT` datetime DEFAULT NULL,
  `SMS_YN` char(1) DEFAULT NULL COMMENT 'Y 전송 N 전송안함 F 전송실패',
  `INTEREST_YN` char(1) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `COMMENT_YN` char(1) DEFAULT 'Y' COMMENT '덧글작성 허용',
  `PUSH_YN` char(1) DEFAULT NULL COMMENT 'Y 전송 N 정송안함',
  PRIMARY KEY (`BC_ID`),
  KEY `NewIndex1` (`PRJ_ID`),
  KEY `USE_AT` (`USE_AT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_business_contact_comment` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `BC_ID` char(20) NOT NULL,
  `BC_COMMENT_CN` text DEFAULT NULL,
  `ATTACH_FILE_ID` char(20) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `UDT_DT` datetime DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`BC_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=196049 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_business_contact_recieve` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `BC_ID` char(20) NOT NULL,
  `RECIEVE_TYP` char(2) DEFAULT NULL COMMENT 'RE수신자 RF참조자',
  `READTIME` datetime DEFAULT NULL,
  `INTEREST_YN` char(1) DEFAULT NULL,
  `TASK` char(1) DEFAULT '0' COMMENT '수기작업 플래그 0 - 손안댐 1 - 손 댄 레코드',
  `ALARM_YN` char(1) DEFAULT 'Y' COMMENT '알람 ON/OFF',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`BC_ID`),
  KEY `NewIndex2` (`USER_NO`),
  KEY `NewIndex3` (`RECIEVE_TYP`)
) ENGINE=InnoDB AUTO_INCREMENT=884931 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_business_process_manual` (
  `BPM_NO` int(10) NOT NULL,
  `SUBJECT` varchar(100) DEFAULT NULL,
  `USE_STATUS` char(1) DEFAULT NULL,
  `SUGGEST_STATUS` char(1) DEFAULT NULL,
  `GUBUN_NO` int(10) DEFAULT NULL,
  `CONTENT` mediumtext DEFAULT NULL,
  `ATCH_FILE_ID` char(20) DEFAULT NULL,
  `ATCH_FILE_ID2` char(20) DEFAULT NULL,
  `READ_COUNT` int(10) DEFAULT NULL,
  `SORT_ORDER` int(10) DEFAULT NULL,
  `DEL_YN` char(1) DEFAULT NULL,
  `INST_ID` varchar(20) DEFAULT NULL,
  `INST_DATE` datetime DEFAULT NULL,
  `CHG_ID` varchar(20) DEFAULT NULL,
  `CHG_DATE` datetime DEFAULT NULL,
  `HIDDEN_YN` char(1) DEFAULT NULL,
  PRIMARY KEY (`BPM_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_business_process_manual_comment` (
  `COMMENT_NO` int(10) NOT NULL,
  `BPM_NO` int(10) DEFAULT NULL,
  `COMMENT` mediumtext DEFAULT NULL,
  `INST_ID` varchar(20) DEFAULT NULL,
  `INST_DATE` datetime DEFAULT NULL,
  `CHG_ID` varchar(20) DEFAULT NULL,
  `CHG_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`COMMENT_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_business_process_manual_gubun` (
  `GUBUN_NO` int(10) NOT NULL,
  `GUBUN_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`GUBUN_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_business_process_manual_read` (
  `READ_NO` int(10) DEFAULT NULL,
  `BPM_NO` int(10) DEFAULT NULL,
  `READ_TIME` datetime DEFAULT NULL,
  `USER_ID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_business_process_manual_suggest` (
  `SUGGEST_NO` int(10) NOT NULL,
  `BPM_NO` int(10) DEFAULT NULL,
  `CONTENT` mediumtext DEFAULT NULL,
  `SUGGEST_STATUS` char(1) DEFAULT NULL,
  `INST_ID` varchar(20) DEFAULT NULL,
  `INST_DATE` datetime DEFAULT NULL,
  `CHG_ID` varchar(20) DEFAULT NULL,
  `CHG_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`SUGGEST_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_business_sector` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `BUSI_SECTOR_NM` varchar(50) NOT NULL,
  `BUSI_SECTOR_VAL` text NOT NULL,
  `BUSI_SECTOR_YEAR` int(4) NOT NULL,
  `BUSI_SECTOR_ORD` int(11) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_calendar_data` (
  `CAL_YEAR` char(4) DEFAULT NULL,
  `CAL_MONTH` char(2) DEFAULT NULL,
  `CAL_DAY` char(2) DEFAULT NULL,
  `CAL_DATE` char(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`CAL_DATE`),
  UNIQUE KEY `NewIndex1` (`CAL_YEAR`,`CAL_MONTH`,`CAL_DAY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_call` (
  `CALL_NO` int(11) NOT NULL,
  `CALL_TYPE` int(11) NOT NULL DEFAULT 0 COMMENT '0 : 단순연락',
  `TITLE` varchar(200) DEFAULT NULL,
  `CONTENTS` text DEFAULT NULL,
  `ATTACH_FILE_ID` varchar(50) DEFAULT NULL,
  `OWNER_NO` int(11) NOT NULL,
  `REG_DATETIME` datetime DEFAULT current_timestamp(),
  `MOD_DATETIME` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `REQ_DATE` date DEFAULT NULL COMMENT '업무처리 완료요청일',
  `STATUS` int(11) NOT NULL DEFAULT 0,
  `PRJ_NO` int(11) DEFAULT 0 COMMENT '관련 프로젝트',
  `PRJ_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`CALL_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;


CREATE TABLE IF NOT EXISTS `tbl_call_interest` (
  `INTEREST_NO` int(11) NOT NULL AUTO_INCREMENT,
  `CALL_NO` int(11) NOT NULL,
  `USER_NO` int(11) NOT NULL,
  `REG_DATETIME` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`INTEREST_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_call_reply` (
  `REPLY_NO` int(11) NOT NULL AUTO_INCREMENT,
  `CALL_NO` int(11) NOT NULL,
  `USER_NO` int(11) NOT NULL,
  `CONTENTS` mediumtext DEFAULT NULL,
  `REG_DATETIME` datetime DEFAULT current_timestamp(),
  `ATTACH_FILE_ID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`REPLY_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=295113 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_call_tmp` (
  `NO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_call_user` (
  `CALL_NO` int(11) NOT NULL,
  `USER_NO` int(11) NOT NULL,
  `USER_TYPE` int(11) NOT NULL COMMENT '사용자 타입 (0 : 작성자, 1 : 수신자, 2 : 처리자)',
  `IS_READ` char(1) NOT NULL DEFAULT 'N' COMMENT '읽음여부',
  `READ_DATETIME` datetime DEFAULT NULL COMMENT '읽은시간',
  `IS_FINISH` char(1) NOT NULL DEFAULT 'N' COMMENT '완료여부',
  `FINISH_DATETIME` datetime DEFAULT NULL COMMENT '완료시간',
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=249039 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=COMPACT;


CREATE TABLE IF NOT EXISTS `tbl_call_user_copy` (
  `CALL_NO` int(11) NOT NULL,
  `USER_NO` int(11) NOT NULL,
  `USER_TYPE` int(11) NOT NULL COMMENT '사용자 타입 (0 : 작성자, 1 : 수신자, 2 : 처리자)',
  `IS_READ` char(1) NOT NULL DEFAULT 'N' COMMENT '읽음여부',
  `READ_DATETIME` datetime DEFAULT NULL COMMENT '읽은시간',
  `IS_FINISH` char(1) NOT NULL DEFAULT 'N' COMMENT '완료여부',
  `FINISH_DATETIME` datetime DEFAULT NULL COMMENT '완료시간',
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=249039 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=COMPACT;


CREATE TABLE IF NOT EXISTS `tbl_car` (
  `CAR_ID` varchar(50) NOT NULL,
  `CAR_TYP` varchar(50) DEFAULT NULL,
  `USER_TYP` char(1) DEFAULT NULL COMMENT 'C:공용 / U:특정사용자',
  `USER_NO` int(11) DEFAULT NULL,
  `INS_COMP` varchar(20) DEFAULT NULL,
  `INS_CALL_NO` varchar(40) DEFAULT NULL,
  `INS_EDATE` char(8) DEFAULT NULL,
  `INS_AGE` int(11) DEFAULT NULL,
  `INS_LIC_TYP` char(1) DEFAULT NULL COMMENT 'A:1종대형 B:1종보통 C:2종보통',
  `COMPNY_ID` varbinary(20) DEFAULT NULL,
  `IMG_FILE_ID` char(20) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `CAR_ORD` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`CAR_ID`),
  UNIQUE KEY `CAR_ORD` (`CAR_ORD`),
  KEY `NewIndex1` (`USE_AT`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_card` (
  `CARD_ID` varchar(19) NOT NULL,
  `EXPIRY_YEAR` int(4) DEFAULT NULL,
  `EXPIRY_MONTH` int(2) DEFAULT NULL,
  `COMPANY_CD` varchar(20) DEFAULT NULL,
  `LIMIT_SPEND` int(11) DEFAULT NULL,
  `STAT` char(1) DEFAULT NULL COMMENT '정상 -N, 분실 - L, 만료 - E, 정지 - S',
  `CARD_CT` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`CARD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_card_history` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `CARD_ID` varchar(19) DEFAULT NULL,
  `USER_NO` int(11) DEFAULT NULL COMMENT '//NULL로 등록된 경우 회수된 경우임.',
  `ST_DT` datetime DEFAULT NULL,
  `ED_DT` datetime DEFAULT NULL COMMENT '//NULL인 것이 최신값임.',
  `NOTE` text DEFAULT NULL,
  `FIRST_REGISTER` char(1) DEFAULT 'N' COMMENT '카드첫등록 Y 최초등록 N 재등록 트리거로 관리',
  PRIMARY KEY (`NO`),
  KEY `CARD_ID` (`CARD_ID`,`ST_DT`,`FIRST_REGISTER`),
  KEY `ST_DT` (`ST_DT`,`ED_DT`),
  KEY `ED_DT` (`ED_DT`),
  KEY `CARD_ID_IDX` (`CARD_ID`),
  KEY `ST_DT_IDX` (`ST_DT`),
  KEY `USER_NO` (`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=1233 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_card_spend` (
  `CARD_SPEND_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '키값',
  `RECEIVE_INFO_TYP` varchar(20) DEFAULT NULL COMMENT '수신정보구분코드',
  `CARD_ID` char(19) DEFAULT NULL COMMENT '카드번호',
  `CARD_TYP` varchar(10) DEFAULT NULL COMMENT '카드종류',
  `PAY_ACCOUNT_NUMBER` varchar(50) DEFAULT NULL COMMENT '결제계좌번호',
  `PAY_BANK_NM` varchar(20) DEFAULT NULL COMMENT '결제계좌은행명',
  `SPECIFIER_NM` varchar(100) DEFAULT NULL COMMENT '지정자한글명',
  `DOMESTIC_FOREIGN` varchar(20) DEFAULT NULL COMMENT '국내외사용구분',
  `APPROVAL_NO` varchar(100) DEFAULT NULL COMMENT '승인번호',
  `APPROVAL_DT` varchar(10) DEFAULT NULL COMMENT '승인일자',
  `APPROVAL_TM` varchar(8) DEFAULT NULL COMMENT '승인시간',
  `SALES_TYP` varchar(10) DEFAULT NULL COMMENT '매출종류',
  `APPROVED_SPEND` int(11) DEFAULT NULL COMMENT '승인금액(원화)',
  `APPROVED_SPEND_FOREIGN_CURRENCY` int(11) DEFAULT NULL COMMENT '승인금액(외화)',
  `SPEND_SIGN_CD` varchar(100) DEFAULT NULL COMMENT '금액SIGN코드',
  `REAL_SPEND` int(11) DEFAULT NULL COMMENT '거래금액(원화)',
  `SURTAX` int(11) DEFAULT NULL COMMENT '부가세',
  `SERVICE_CHARGE` int(11) DEFAULT NULL COMMENT '봉사료',
  `INSTALLMENT_PERIOD` varchar(10) DEFAULT NULL COMMENT '할부기간',
  `EXCHANGE_RATE` varchar(100) DEFAULT NULL COMMENT '외화거래일환율',
  `EXCHANGE_NATION_CD` varchar(100) DEFAULT NULL COMMENT '외화거래국가코드',
  `EXCHANGE_NATION_NM` varchar(100) DEFAULT NULL COMMENT '외화거래국가명',
  `STORE_BUSINESS_NO` varchar(20) DEFAULT NULL COMMENT '가맹점사업자번호',
  `STORE_BUSINESS_NM` varchar(100) DEFAULT NULL COMMENT '가맹점명',
  `STORE_BUSINESS_TYP` varchar(100) DEFAULT NULL COMMENT '가맹점종류',
  `STORE_ZIP_CD` varchar(10) DEFAULT NULL COMMENT '가맹점우편번호',
  `STORE_ADDRESS1` varchar(100) DEFAULT NULL COMMENT '가맹점주소1',
  `STORE_ADDRESS2` varchar(100) DEFAULT NULL COMMENT '가맹점주소2',
  `STORE_PHONE_NUMBER` varchar(100) DEFAULT NULL COMMENT '가맹점전화번호',
  `ACCOUNT_CD` varchar(100) DEFAULT NULL COMMENT '회계코드',
  `ACCOUNT_NM` varchar(100) DEFAULT NULL COMMENT '회계코드명',
  `HEADQUATER_NM` varchar(100) DEFAULT NULL COMMENT '본부명',
  `DEPARTMENT_NM` varchar(100) DEFAULT NULL COMMENT '부서명',
  `EXP_ID` varchar(20) DEFAULT NULL,
  `APPROVAL_YEAR` varchar(4) DEFAULT NULL COMMENT '승인년도 트리거입력 : 입력트리거만 있으니 업데이트시 아래 속성들 확인',
  `APPROVAL_MONTH` int(2) DEFAULT NULL COMMENT '승인월 트리거입력',
  `APPROVAL_DTTM` datetime DEFAULT NULL COMMENT '승인일자시간 트리거입력',
  `STATUS` char(1) NOT NULL DEFAULT '3' COMMENT 'DOC_ID FK 문서 상태 : 1 - 상신후결재과정(APP001, APP002, APP003 AND NEW_AT=0) 2 - 전결승인후 (APP004, APP005 AND NEW_AT=1) 3 - 무효(APP000, APP099, NEW_AT=0 수정기안 취소기안) 4 - 예외(발생하면 안됨)',
  PRIMARY KEY (`CARD_SPEND_NO`),
  KEY `NewIndex1` (`CARD_ID`),
  KEY `NewIndex2` (`APPROVAL_DT`),
  KEY `YEARMONTH` (`APPROVAL_YEAR`,`APPROVAL_MONTH`),
  KEY `APPROVAL_DTTM` (`APPROVAL_DTTM`),
  KEY `STATUS` (`STATUS`)
) ENGINE=InnoDB AUTO_INCREMENT=109474 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_card_spend_20161229` (
  `CARD_SPEND_NO` int(11) NOT NULL DEFAULT 0 COMMENT '키값',
  `RECEIVE_INFO_TYP` varchar(20) DEFAULT NULL COMMENT '수신정보구분코드',
  `CARD_ID` char(19) DEFAULT NULL COMMENT '카드번호',
  `CARD_TYP` varchar(10) DEFAULT NULL COMMENT '카드종류',
  `PAY_ACCOUNT_NUMBER` varchar(50) DEFAULT NULL COMMENT '결제계좌번호',
  `PAY_BANK_NM` varchar(20) DEFAULT NULL COMMENT '결제계좌은행명',
  `SPECIFIER_NM` varchar(100) DEFAULT NULL COMMENT '지정자한글명',
  `DOMESTIC_FOREIGN` varchar(20) DEFAULT NULL COMMENT '국내외사용구분',
  `APPROVAL_NO` varchar(100) DEFAULT NULL COMMENT '승인번호',
  `APPROVAL_DT` varchar(10) DEFAULT NULL COMMENT '승인일자',
  `APPROVAL_TM` varchar(8) DEFAULT NULL COMMENT '승인시간',
  `SALES_TYP` varchar(10) DEFAULT NULL COMMENT '매출종류',
  `APPROVED_SPEND` int(11) DEFAULT NULL COMMENT '승인금액(원화)',
  `APPROVED_SPEND_FOREIGN_CURRENCY` int(11) DEFAULT NULL COMMENT '승인금액(외화)',
  `SPEND_SIGN_CD` varchar(100) DEFAULT NULL COMMENT '금액SIGN코드',
  `REAL_SPEND` int(11) DEFAULT NULL COMMENT '거래금액(원화)',
  `SURTAX` int(11) DEFAULT NULL COMMENT '부가세',
  `SERVICE_CHARGE` int(11) DEFAULT NULL COMMENT '봉사료',
  `INSTALLMENT_PERIOD` varchar(10) DEFAULT NULL COMMENT '할부기간',
  `EXCHANGE_RATE` varchar(100) DEFAULT NULL COMMENT '외화거래일환율',
  `EXCHANGE_NATION_CD` varchar(100) DEFAULT NULL COMMENT '외화거래국가코드',
  `EXCHANGE_NATION_NM` varchar(100) DEFAULT NULL COMMENT '외화거래국가명',
  `STORE_BUSINESS_NO` varchar(20) DEFAULT NULL COMMENT '가맹점사업자번호',
  `STORE_BUSINESS_NM` varchar(100) DEFAULT NULL COMMENT '가맹점명',
  `STORE_BUSINESS_TYP` varchar(100) DEFAULT NULL COMMENT '가맹점종류',
  `STORE_ZIP_CD` varchar(10) DEFAULT NULL COMMENT '가맹점우편번호',
  `STORE_ADDRESS1` varchar(100) DEFAULT NULL COMMENT '가맹점주소1',
  `STORE_ADDRESS2` varchar(100) DEFAULT NULL COMMENT '가맹점주소2',
  `STORE_PHONE_NUMBER` varchar(100) DEFAULT NULL COMMENT '가맹점전화번호',
  `ACCOUNT_CD` varchar(100) DEFAULT NULL COMMENT '회계코드',
  `ACCOUNT_NM` varchar(100) DEFAULT NULL COMMENT '회계코드명',
  `HEADQUATER_NM` varchar(100) DEFAULT NULL COMMENT '본부명',
  `DEPARTMENT_NM` varchar(100) DEFAULT NULL COMMENT '부서명',
  `EXP_ID` varchar(20) DEFAULT NULL,
  `APPROVAL_YEAR` varchar(4) DEFAULT NULL COMMENT '승인년도 트리거입력 : 입력트리거만 있으니 업데이트시 아래 속성들 확인',
  `APPROVAL_MONTH` int(2) DEFAULT NULL COMMENT '승인월 트리거입력',
  `APPROVAL_DTTM` datetime DEFAULT NULL COMMENT '승인일자시간 트리거입력',
  `STATUS` char(1) NOT NULL DEFAULT '3' COMMENT 'DOC_ID FK 문서 상태 : 1 - 상신후결재과정(APP001, APP002, APP003 AND NEW_AT=0) 2 - 전결승인후 (APP004, APP005 AND NEW_AT=1) 3 - 무효(APP000, APP099, NEW_AT=0 수정기안 취소기안) 4 - 예외(발생하면 안됨)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_career` (
  `CNO` int(11) NOT NULL AUTO_INCREMENT,
  `PRJ_ID` varchar(200) DEFAULT NULL COMMENT '사업명',
  `CST_DT` char(8) DEFAULT NULL COMMENT '참여기간 FROM',
  `CED_DT` char(8) DEFAULT NULL COMMENT '참여기간 TO',
  `BUSINESS` varchar(200) DEFAULT NULL COMMENT '담당업무',
  `CORDER` varchar(100) DEFAULT NULL COMMENT '발주처',
  `ETC` varchar(1000) DEFAULT NULL COMMENT '기타(비고)',
  `SABUN` char(4) DEFAULT NULL,
  `USER_NO` int(11) DEFAULT NULL,
  PRIMARY KEY (`CNO`)
) ENGINE=InnoDB AUTO_INCREMENT=792 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_career_edu` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `SCHOOL_NAME` varchar(30) DEFAULT NULL COMMENT '학교명',
  `MAJOR` varchar(30) DEFAULT NULL COMMENT '전공',
  `ST_DT` varchar(11) DEFAULT NULL COMMENT '학업 시작일',
  `ED_DT` varchar(11) DEFAULT NULL COMMENT '학업 종료일',
  `GRADUATION_YN` varchar(20) DEFAULT NULL COMMENT '졸업유무',
  `USER_NO` int(11) DEFAULT NULL COMMENT 'FK',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=4570 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_career_license` (
  `NO` int(20) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `LICENSE_NM` varchar(200) DEFAULT NULL COMMENT '자격증 종목및등급',
  `ISSUED_ORG` varchar(200) DEFAULT NULL COMMENT '발급기관',
  `LICENSE_NO` varchar(200) DEFAULT NULL COMMENT '자격등록번호',
  `PASSED_DATE` char(8) DEFAULT NULL COMMENT '합격년월일',
  `USER_NO` int(8) DEFAULT NULL COMMENT 'FK',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=3418 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_career_main` (
  `USER_NO` int(11) NOT NULL COMMENT 'PK, FK FROM TBL_USERINFO',
  `CAREER_DT` varchar(50) DEFAULT NULL COMMENT '경력기간 시작일',
  `MILITARY_SERVICE` varchar(50) DEFAULT NULL COMMENT '병역사항에 군별',
  `MS_ST_DT` varchar(11) DEFAULT NULL COMMENT '병역기간 시작일자',
  `MS_ED_DT` varchar(11) DEFAULT NULL COMMENT '병역기간 종료일자',
  `MS_LEVEL` varchar(20) DEFAULT NULL COMMENT '전역 계급',
  `SECURITY_BASIS` varchar(200) DEFAULT NULL COMMENT '비밀취급인가 근거',
  `SECURITY_NO` varchar(200) DEFAULT NULL COMMENT '비밀취급인가증 번호',
  `SW_LEVEL` varchar(50) DEFAULT NULL COMMENT 'SW 기술등급',
  `DELETE_YN` char(1) DEFAULT NULL COMMENT '삭제구분 - Y 삭제 N 미삭제 정상조회',
  `UP_DT` varchar(11) DEFAULT NULL COMMENT '업데이트 날짜',
  `ATCH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일ID',
  `SKILL_LANG` varchar(2000) DEFAULT NULL COMMENT '기술 - 개발언어',
  `SKILL_DBMS` varchar(2000) DEFAULT NULL COMMENT '기술 - DBMS',
  `SKILL_TOOL` varchar(2000) DEFAULT NULL COMMENT '기술 - TOOL',
  `SKILL_OS` varchar(2000) DEFAULT NULL COMMENT '기술 - OS',
  PRIMARY KEY (`USER_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_career_skill` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `PRJ_NM` varchar(200) DEFAULT NULL COMMENT '사업명',
  `ST_DT` char(8) DEFAULT NULL COMMENT '참여기간 FROM',
  `ED_DT` char(8) DEFAULT NULL COMMENT '참여기간 TO',
  `TASK` varchar(200) DEFAULT NULL COMMENT '담당업무',
  `CLIENT_NM` varchar(100) DEFAULT NULL COMMENT '발주처',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '기타(비고)',
  `USER_NO` int(11) DEFAULT NULL COMMENT 'FK',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=24090 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_career_train` (
  `NO` int(20) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `TRAIN_NM` varchar(200) DEFAULT NULL COMMENT '교육과정명',
  `TRAIN_ORG_NM` varchar(200) DEFAULT NULL COMMENT '교육기관명',
  `ST_DT` char(8) DEFAULT NULL COMMENT '교육기간 시작일',
  `ED_DT` char(8) DEFAULT NULL COMMENT '교육기간 종료일',
  `TRAIN_NO` varchar(200) DEFAULT NULL COMMENT '수료번호',
  `USER_NO` int(11) DEFAULT NULL COMMENT 'FK',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=1486 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_career_work` (
  `NO` int(20) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `COMPANY_NM` varchar(200) DEFAULT NULL COMMENT '회사',
  `ST_DT` char(8) DEFAULT NULL COMMENT '근무기간 입사일',
  `ED_DT` char(8) DEFAULT NULL COMMENT '근무기간 퇴사일',
  `TASK` varchar(200) DEFAULT NULL COMMENT '담당업무',
  `ORGNZT_NM` varchar(200) DEFAULT NULL COMMENT '부서',
  `RANK_NM` varchar(200) DEFAULT NULL COMMENT '직위',
  `USER_NO` int(11) DEFAULT NULL COMMENT 'FK',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=6260 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_car_fix` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `CAR_ID` varchar(20) NOT NULL,
  `FIX_DATE` char(8) DEFAULT NULL,
  `USER_NO` int(11) DEFAULT NULL,
  `RUN_LENGTH` int(11) DEFAULT NULL,
  `FIX_ITEM` varchar(500) DEFAULT NULL,
  `FIX_ITEM_DETAIL` text DEFAULT NULL,
  `FIX_NOTE` text DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`CAR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_car_reservation` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `CAR_ID` varchar(20) NOT NULL,
  `USER_NO` int(11) NOT NULL,
  `WRITER_NO` int(11) NOT NULL,
  `ST_DT` char(8) DEFAULT NULL,
  `ST_TM` int(11) DEFAULT NULL,
  `ED_DT` char(8) DEFAULT NULL,
  `ED_TM` int(11) DEFAULT NULL,
  `PURPOSE` char(1) DEFAULT NULL COMMENT 'W:업무용 P:개인사용',
  `DESTINATION` varchar(200) DEFAULT NULL,
  `RUN_LENGTH` int(11) DEFAULT NULL,
  `RSV_NOTE` text DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`CAR_ID`),
  KEY `NewIndex2` (`USER_NO`),
  KEY `NewIndex3` (`ST_DT`),
  KEY `NewIndex4` (`ED_DT`),
  KEY `NewIndex5` (`WRITER_NO`),
  KEY `NewIndex6` (`ST_TM`),
  KEY `NewIndex7` (`ED_TM`)
) ENGINE=InnoDB AUTO_INCREMENT=2333 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_consult` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `CUST_NO` int(11) DEFAULT NULL COMMENT '고객테이블PK',
  `CUST_MANAGER` varchar(100) DEFAULT NULL COMMENT '고객명',
  `CUST_TELNO` varchar(15) DEFAULT NULL COMMENT '고객연락처',
  `TYP` char(2) DEFAULT NULL COMMENT '구분',
  `SERVICE_TYP` char(2) DEFAULT NULL COMMENT '상담분류',
  `ERROR_TYP` char(2) DEFAULT NULL COMMENT '장애항목',
  `Q_CN` varchar(4000) DEFAULT NULL COMMENT '문의내용',
  `A_CN` varchar(4000) DEFAULT NULL COMMENT '답변내용',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록시각',
  `MOD_DT` datetime DEFAULT NULL COMMENT '수정시각',
  `SMS_YN` char(1) DEFAULT NULL COMMENT 'SMS알림',
  `WRITER_NO` int(11) DEFAULT NULL COMMENT '사용자테이블(TBL_USERINFO)  PK',
  `JIRA_YN` char(1) DEFAULT NULL COMMENT '지라등록여부',
  `JIRA_CODE` varchar(20) DEFAULT NULL COMMENT '지라코드',
  `STATE` char(2) DEFAULT NULL COMMENT '상태',
  `COMPLETE_DATE` date DEFAULT NULL COMMENT '완료날짜',
  `COMPLETE_TM` int(2) DEFAULT NULL COMMENT '완료시각',
  `SATISFACTION` char(2) DEFAULT NULL COMMENT '만족도',
  `USE_AT` char(1) DEFAULT 'Y' COMMENT '이용여부,삭제여부(Y:이용중/N:삭제)',
  `CONSULT_NO` varchar(20) DEFAULT NULL COMMENT '상담번호',
  `CUST_NM` varchar(100) DEFAULT NULL COMMENT '고객사이름',
  `ISSUE_YN` char(1) DEFAULT NULL COMMENT '내부이슈',
  `END_DATE` date DEFAULT NULL COMMENT '마감예정',
  `S_CN` varchar(4000) DEFAULT NULL COMMENT '특이사항',
  `user_nm` varchar(20) DEFAULT NULL COMMENT '작성자',
  `user_list` varchar(4000) DEFAULT NULL COMMENT '담당자들',
  `file_nm` varchar(200) DEFAULT NULL,
  `real_file_nm` varchar(200) DEFAULT NULL,
  `user_list2` varchar(4000) DEFAULT NULL COMMENT '참조자들',
  `consult_nm` varchar(30) DEFAULT NULL,
  `CUST_EMAIL` varchar(50) DEFAULT NULL COMMENT '고객이메일',
  `REQUEST_ID` varchar(200) DEFAULT NULL COMMENT '요청사항ID',
  `RECEIVE_TYP` char(2) DEFAULT NULL COMMENT '접수방법',
  `CONTACT_DT` datetime DEFAULT NULL COMMENT '연락시한',
  `compny_id` varchar(20) DEFAULT NULL COMMENT '소속회사',
  `COMP_CN` text DEFAULT NULL COMMENT '조치사항',
  `COMP_FILE_ID` varchar(20) DEFAULT NULL COMMENT '완료 첨부파일',
  `COMP_DURATION` int(3) DEFAULT 0 COMMENT '소요시간',
  `DETAIL_TYP` varchar(2) DEFAULT NULL COMMENT '장애항목세부',
  PRIMARY KEY (`NO`),
  KEY `CUST_NO` (`CUST_NO`),
  KEY `consult_no` (`CONSULT_NO`),
  KEY `typ` (`TYP`),
  KEY `service_typ` (`SERVICE_TYP`),
  KEY `jira` (`JIRA_YN`),
  KEY `issue` (`ISSUE_YN`),
  KEY `writer_no` (`WRITER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=3444 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='상담관리';


CREATE TABLE IF NOT EXISTS `tbl_consult_comment` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) DEFAULT NULL,
  `CONSULT_NO` varchar(20) DEFAULT NULL,
  `CN` mediumtext DEFAULT NULL,
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `UDT_DT` datetime DEFAULT NULL,
  `USE_AT` char(1) DEFAULT 'Y',
  `USER_NM` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `consult_no` (`CONSULT_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=57971 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='상담관리 댓글';


CREATE TABLE IF NOT EXISTS `tbl_consult_customer` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `CUST_NM` varchar(200) DEFAULT NULL COMMENT '고객사',
  `CUST_MANAGER` varchar(100) DEFAULT NULL COMMENT '담당자',
  `CUST_TELNO` varchar(15) DEFAULT NULL COMMENT '연락처',
  `TYP` char(2) DEFAULT NULL COMMENT '유형',
  `LOAD_DT` char(8) DEFAULT NULL COMMENT '최초탑재일',
  `IP1` varchar(20) DEFAULT NULL COMMENT '서버아이피1',
  `IP2` varchar(20) DEFAULT NULL,
  `IP3` varchar(20) DEFAULT NULL,
  `IP4` varchar(20) DEFAULT NULL,
  `IP5` varchar(20) DEFAULT NULL,
  `DB1` varchar(20) DEFAULT NULL COMMENT 'DB아이피1',
  `DB2` varchar(20) DEFAULT NULL,
  `DB3` varchar(20) DEFAULT NULL,
  `DB4` varchar(20) DEFAULT NULL,
  `DB5` varchar(20) DEFAULT NULL,
  `REMOTE_INFO` varchar(1000) DEFAULT NULL COMMENT '원격접속정보',
  `ETC_INFO` varchar(1000) DEFAULT NULL COMMENT '기타정보',
  `USE_AT` varchar(2) DEFAULT NULL COMMENT '사용여부',
  `CUST_EMAIL` varchar(50) DEFAULT NULL COMMENT '이메일',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=2958 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='상담관리 고객사';


CREATE TABLE IF NOT EXISTS `tbl_consult_recieve` (
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `USER_NO` int(11) DEFAULT NULL COMMENT '사용자테이블PK',
  `CONSULT_NO` varchar(20) DEFAULT NULL COMMENT '상담테이블PK',
  `RECIEVE_TYP` char(3) DEFAULT NULL COMMENT '읽기 상태()',
  `READ_TM` datetime DEFAULT NULL COMMENT '읽은 시각',
  `INTEREST_YN` char(1) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `user_no` (`USER_NO`),
  KEY `consult_no` (`CONSULT_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=1268670 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='상담관리 담당자/참조자';


CREATE TABLE IF NOT EXISTS `tbl_contract` (
  `NO` int(20) NOT NULL AUTO_INCREMENT,
  `WRITER_NO` int(20) DEFAULT NULL,
  `WRITE_DATE` datetime DEFAULT NULL,
  `LAST_UPDATE_DATE` datetime DEFAULT NULL,
  `TYP` char(1) DEFAULT NULL,
  `SJ` varchar(200) DEFAULT NULL,
  `CN` varchar(4000) DEFAULT NULL,
  `COMPANY_CD` varchar(20) DEFAULT NULL,
  `CONTRACT_DATE` char(8) DEFAULT NULL,
  `CONTRACT_START_DATE` char(8) DEFAULT NULL,
  `CONTRACT_END_DATE` char(8) DEFAULT NULL,
  `NM` varchar(200) DEFAULT NULL,
  `BUSI_NO` varchar(14) DEFAULT NULL,
  `REP_NM` varchar(100) DEFAULT NULL,
  `ADRES` varchar(1000) DEFAULT NULL,
  `PHONE` varchar(100) DEFAULT NULL,
  `EXPENSE` int(10) DEFAULT NULL,
  `CONTAIN_VAT` char(1) DEFAULT NULL,
  `ATCH_FILE_ID` char(20) DEFAULT NULL,
  `ORGNZT_ID` varchar(20) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `RESULT_REGISTER` char(1) DEFAULT 'N',
  `USE_AT` char(1) DEFAULT 'Y',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_contract_auth` (
  `NO` int(20) NOT NULL AUTO_INCREMENT,
  `CONTRACT_NO` int(20) DEFAULT NULL,
  `USER_NO` int(20) DEFAULT NULL,
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_current_user` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(20) DEFAULT NULL,
  `LAST_CONNECT_TIME` datetime DEFAULT NULL COMMENT '현재 접속자. JSP에서 1분마다 타이머로 갱신하고 현재시각 1분 이내 데이터만 뽑아서 현재 접속자 찾음',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`),
  KEY `NewIndex2` (`LAST_CONNECT_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `tbl_current_user` (`NO`, `USER_NO`, `LAST_CONNECT_TIME`) VALUES
	(1, 1, '2023-11-21 16:36:53');

CREATE TABLE IF NOT EXISTS `tbl_customer` (
  `CUST_ID` char(20) NOT NULL,
  `CUST_NM` varchar(200) DEFAULT NULL,
  `USER_NO_REG` int(11) DEFAULT NULL,
  `USER_NO_MOD` int(11) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `MOD_DT` datetime DEFAULT NULL,
  `CUST_BUSI_NO` char(14) DEFAULT NULL,
  `CUST_REP_NM` varchar(100) DEFAULT NULL,
  `CUST_ADRES` varchar(1000) DEFAULT NULL,
  `CUST_TELNO` varchar(20) DEFAULT NULL,
  `CUST_FAXNO` varchar(20) DEFAULT NULL,
  `CUST_BUSI_COND` varchar(100) DEFAULT NULL,
  `CUST_BUSI_TYP` varchar(100) DEFAULT NULL,
  `NOTE` text DEFAULT NULL,
  `BANK_NM` varchar(100) DEFAULT NULL,
  `BANK_NO` varchar(100) DEFAULT NULL,
  `BANK_USER_NM` varchar(100) DEFAULT NULL,
  `ATCH_FILE_ID` char(20) DEFAULT NULL,
  `TAX_EMAIL_1` varchar(100) DEFAULT NULL,
  `TAX_USER_NM_1` varchar(100) DEFAULT NULL,
  `TAX_TELNO_1` varchar(100) DEFAULT NULL,
  `TAX_EMAIL_2` varchar(100) DEFAULT NULL,
  `TAX_USER_NM_2` varchar(100) DEFAULT NULL,
  `TAX_TELNO_2` varchar(100) DEFAULT NULL,
  `TAX_EMAIL_3` varchar(100) DEFAULT NULL,
  `TAX_USER_NM_3` varchar(100) DEFAULT NULL,
  `TAX_TELNO_3` varchar(100) DEFAULT NULL,
  `TAX_EMAIL_4` varchar(100) DEFAULT NULL,
  `TAX_USER_NM_4` varchar(100) DEFAULT NULL,
  `TAX_TELNO_4` varchar(100) DEFAULT NULL,
  `TAX_EMAIL_5` varchar(100) DEFAULT NULL,
  `TAX_USER_NM_5` varchar(100) DEFAULT NULL,
  `TAX_TELNO_5` varchar(100) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  PRIMARY KEY (`CUST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_customer_comment` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `CUST_ID` char(20) NOT NULL,
  `ATCH_FILE_ID` char(20) DEFAULT NULL,
  `COMMENT_CN` text DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`CUST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_customer_person` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `CUST_ID` char(20) DEFAULT NULL,
  `PERSON_NM` varchar(200) DEFAULT NULL,
  `PERSON_EMAIL` varchar(200) DEFAULT NULL,
  `PERSON_HPNO` varchar(15) DEFAULT NULL,
  `PERSON_TELNO` varchar(15) DEFAULT NULL,
  `PERSON_NOTE` text DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`CUST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_day_report` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `TASK_ID` char(20) DEFAULT NULL,
  `DAY_REPORT_DT` char(8) DEFAULT NULL,
  `DAY_REPORT_TM` int(11) DEFAULT NULL,
  `DAY_REPORT_CN` text DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `MOD_DT` datetime DEFAULT NULL,
  `IS_HOLIDAY` char(1) NOT NULL DEFAULT '0' COMMENT '0 휴일 1 근무일',
  `MONTH` char(2) DEFAULT NULL COMMENT 'JOIN 속도 향상용 월 값. 트리거로 입력',
  `DAY_REPORT_YM` char(6) DEFAULT NULL COMMENT '년월값 트리거입력',
  `MONTH_TOTAL_TM` int(11) DEFAULT NULL COMMENT '해당월 총 근무시간',
  `ATTACH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일',
  PRIMARY KEY (`NO`),
  KEY `NewIndex2` (`DAY_REPORT_DT`),
  KEY `NewIndex1` (`USER_NO`),
  KEY `NewIndex3` (`TASK_ID`),
  KEY `NewIndex4` (`DAY_REPORT_TM`),
  KEY `DAY_REPORT_YM` (`DAY_REPORT_YM`,`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=300304 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_db_schema` (
  `TABLE_SCHEMA` varchar(64) NOT NULL,
  `TABLE_NAME` varchar(64) NOT NULL,
  `COLUMN_NAME` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_dining` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `YEAR` char(4) DEFAULT NULL,
  `MONEY` int(11) DEFAULT NULL,
  `DATE` int(11) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  UNIQUE KEY `NewIndex1` (`YEAR`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_dining_add` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `ORGNZT_ID` char(20) DEFAULT NULL,
  `YYYYMM` char(6) DEFAULT NULL,
  `MONEY` int(11) DEFAULT NULL,
  `NOTE` text DEFAULT NULL,
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_budget_allocate` (
  `DOC_ID` varchar(20) DEFAULT NULL,
  `USER_NO` int(11) DEFAULT NULL,
  `YEAR` int(4) DEFAULT NULL,
  KEY `NewIndex1` (`DOC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_budget_allocate2` (
  `DOC_ID` varchar(20) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `ST_DT` varchar(8) DEFAULT NULL,
  `ED_DT` varchar(8) DEFAULT NULL,
  `DECIDE_YN` char(1) DEFAULT 'Y',
  KEY `NewIndex1` (`DOC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_business_plan` (
  `DOC_ID` char(20) DEFAULT NULL,
  `ORGNZT_ID` char(20) DEFAULT NULL,
  `SALES_OUT` bigint(20) DEFAULT 0,
  `PURCHASE_OUT` bigint(20) DEFAULT 0,
  `PURCHASE_IN` bigint(20) DEFAULT 0,
  `LABOR` bigint(20) DEFAULT 0,
  `EXPENSE` bigint(20) DEFAULT 0,
  `YYYYMM` int(6) DEFAULT NULL,
  `PLAN_YM` varchar(6) DEFAULT NULL COMMENT '계획연월 YYYYMM',
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `SALES_IN` bigint(20) DEFAULT 0,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`ORGNZT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1550 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_comment` (
  `NO` int(20) NOT NULL AUTO_INCREMENT,
  `DOC_ID` varchar(20) NOT NULL,
  `WRITER_NO` int(11) DEFAULT NULL,
  `EAPP_CT` varchar(4000) DEFAULT NULL,
  `WT_DT` datetime DEFAULT NULL,
  `FK_EAPP_READER` int(20) DEFAULT NULL,
  `APP_TYP` char(6) DEFAULT NULL,
  `STAT` char(1) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`DOC_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=514243 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_dining` (
  `DINING_NO` int(11) NOT NULL AUTO_INCREMENT,
  `EXP_ID` varchar(20) DEFAULT NULL,
  `ORGNZT_ID` varchar(20) DEFAULT NULL,
  `DINING_SPEND` int(11) DEFAULT NULL,
  PRIMARY KEY (`DINING_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_doc` (
  `DOC_ID` varchar(20) NOT NULL,
  `PARNT_ID` varchar(50) DEFAULT NULL,
  `WRITER_NO` varchar(20) DEFAULT NULL,
  `SUBJECT` varchar(200) DEFAULT NULL,
  `CONTENT` text DEFAULT NULL,
  `DOC_DT` datetime DEFAULT NULL,
  `PRE_APP_DT` datetime DEFAULT NULL,
  `DOC_STAT` varchar(10) DEFAULT NULL COMMENT 'APP000 기안대기(저장문서) APP001 검토중 APP002 협조중 APP003 전결중 APP004 참조중 APP005 완료 else(APP099) 결재실패',
  `NEW_AT` char(1) DEFAULT '0' COMMENT '유효성 : 0 - 무효 1 - 유효',
  `CNT` decimal(5,0) DEFAULT NULL,
  `RE_USE_CNT` decimal(3,0) DEFAULT NULL,
  `HANDLE_STAT` char(1) DEFAULT NULL COMMENT '0 - 미처리 1 - 처리 2 - 처리취소 3 - 처리할 필요 없음',
  `HANDLE_DT` datetime DEFAULT NULL COMMENT '경영지원실 처리일자',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL,
  `TEMPLT_ID` varchar(20) DEFAULT NULL,
  `RE_WRITE_TYP` varchar(2) DEFAULT NULL COMMENT '0 - 기본문서 1- 재기안 2- 취소',
  `REJ_CFM_STAT` char(1) DEFAULT '0',
  `PRJ_ID_DOC` varchar(20) DEFAULT NULL,
  `STATUS` char(1) NOT NULL DEFAULT '3' COMMENT '문서 상태 : 트리거로 관리 1 - 상신후결재과정(APP001, APP002, APP003 AND NEW_AT=0) 2 - 전결승인후 (APP004, APP005 AND NEW_AT=1) 3 - 무효(APP000, APP099, NEW_AT=0 수정기안 취소기안) 4 - 예외(발생하면 안됨)',
  PRIMARY KEY (`DOC_ID`),
  KEY `NewIndex2` (`WRITER_NO`),
  KEY `NewIndex3` (`DOC_STAT`),
  KEY `NewIndex4` (`NEW_AT`),
  KEY `NewIndex5` (`DOC_DT`),
  KEY `STATUS` (`STATUS`),
  KEY `DOC_STAT` (`DOC_STAT`,`HANDLE_STAT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_doctyp` (
  `TEMPLT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DOC_ORD` int(10) DEFAULT NULL,
  `DOC_SJ` varchar(200) DEFAULT NULL,
  `DECIDE_LINE_DESC` varchar(2000) DEFAULT NULL,
  `DOC_CT` varchar(2000) DEFAULT NULL,
  `DOC_ICON` varchar(200) DEFAULT NULL,
  `READER_AUTO_CMT` int(1) DEFAULT 1,
  `COOP_MIXS` varchar(200) DEFAULT NULL,
  `REFER_MIXS` varchar(200) DEFAULT NULL,
  `HANDLER_MIXS` varchar(200) DEFAULT NULL,
  `DECIDER_RULE1` int(1) DEFAULT 1,
  `DECIDER_RULE2` int(1) DEFAULT 1,
  `DECIDER_RULE3` int(1) DEFAULT 1,
  `DECIDER_RULE4` int(1) DEFAULT 1,
  `DECIDER_RULE5` varchar(1) DEFAULT '0',
  `USE_YN` char(1) DEFAULT '1',
  `DOC_SJ_BR` varchar(200) DEFAULT NULL,
  `DECIDER_MIX` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`TEMPLT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_exp` (
  `EXP_ID` varchar(20) NOT NULL,
  `DOC_ID` varchar(20) DEFAULT NULL,
  `PRESET_ID` varchar(20) DEFAULT NULL,
  `EXP_SPEND_TYP` varchar(2) DEFAULT NULL COMMENT 'PP - 개인결제 CP - 회사결제 CC - 법인카드',
  `PAYING_DUE_DATE` varchar(8) DEFAULT NULL,
  `ACC_ID` varchar(20) DEFAULT NULL COMMENT '계정과목 ID : TBL_ACCOUNT',
  `EXP_DT` varchar(8) DEFAULT NULL,
  `exp_spend` bigint(14) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `COMPANY_CD` varchar(10) DEFAULT NULL,
  `EXP_CT` text DEFAULT NULL,
  `CARD_SPEND_NO` int(11) DEFAULT NULL,
  `EXCEED_MANAGE` char(1) DEFAULT NULL COMMENT '''Y'' -> 초과,  ''N''-> 미초과',
  `EXPIRED_DATE` char(1) DEFAULT NULL COMMENT '''Y'' -> 기한초과, ''N''-> 미초과',
  `COLUMN1` varchar(500) DEFAULT NULL COMMENT '상품매입 1: 외부매입 2: 내부매입',
  `COLUMN2` varchar(500) DEFAULT NULL COMMENT 'templtId=13 상품매입 관련매출건',
  `STOCK_LIST` varchar(500) DEFAULT NULL COMMENT '재고임시저장용 칼럼(TBL_STOCK의 키값 배열)',
  `STATUS` char(1) NOT NULL DEFAULT '3' COMMENT '문서 상태 : EAPP_DOC 트리거로 관리, EAPP_DOC 값과 동기화 1 - 상신후결재과정(APP001, APP002, APP003 AND NEW_AT=0) 2 - 전결승인후 (APP004, APP005 AND NEW_AT=1) 3 - 무효(APP000, APP099, NEW_AT=0 수정기안 취소기안) 4 - 예외(발생하면 안됨)',
  `BUDGET_PRJ` varchar(20) DEFAULT NULL COMMENT '예산관리 프로젝트 : BUDGET_EXCEED_RULE 기준 FN_GET_BUDGET_PRJ. INSERT UPDATE TRIGGER로 관리',
  PRIMARY KEY (`EXP_ID`),
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`ACC_ID`),
  KEY `NewIndex3` (`EXP_DT`),
  KEY `NewIndex4` (`PRJ_ID`),
  KEY `NewIndex5` (`EXP_SPEND_TYP`),
  KEY `STATUS` (`STATUS`),
  KEY `idx_eapp_exp_card_spend_no` (`CARD_SPEND_NO`),
  KEY `NewIndex6` (`DOC_ID`,`PRJ_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_gen_sales` (
  `DOC_ID` char(20) NOT NULL,
  `SALES_SJ` varchar(100) DEFAULT NULL,
  `SALES_TYPE` int(1) NOT NULL DEFAULT 0 COMMENT '0 : 기타, 1 : 구축, 2 : 유지보수, 3 : 서비스',
  `SALES_PRODUCT` int(1) NOT NULL DEFAULT 0 COMMENT '0 : 기타, 1 : BODA, 2 : MEET',
  `SALES_PRJ_ID` char(20) DEFAULT NULL,
  `COST` bigint(11) DEFAULT NULL,
  `ST_DT` varchar(8) DEFAULT NULL,
  `DECIDE_YN` char(1) DEFAULT NULL,
  `BOND_MANAGE_YN` char(1) DEFAULT 'Y',
  `COL_DUE_DT` varchar(8) DEFAULT NULL COMMENT '최종수금예정일',
  PRIMARY KEY (`DOC_ID`),
  KEY `NewIndex1` (`SALES_PRJ_ID`),
  KEY `NewIndex2` (`ST_DT`),
  KEY `NewIndex3` (`DECIDE_YN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_hol` (
  `HOL_NO` int(11) NOT NULL AUTO_INCREMENT,
  `DOC_ID` varchar(20) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `PERIOD` double(5,2) DEFAULT NULL,
  `ST_DT` varchar(8) DEFAULT NULL,
  `ST_TM` varchar(5) DEFAULT NULL,
  `ED_DT` varchar(8) DEFAULT NULL,
  `ED_TM` varchar(5) DEFAULT NULL,
  `COST` int(11) DEFAULT NULL,
  `EXCEED_MANAGE` char(1) DEFAULT NULL COMMENT '''Y'' -> 초과,  ''N''-> 미초과',
  PRIMARY KEY (`HOL_NO`),
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`ST_DT`),
  KEY `NewIndex3` (`PRJ_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7123 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_jobg` (
  `DOC_ID` varchar(20) NOT NULL COMMENT '문서번호',
  `ORGNZT_ID` varchar(20) DEFAULT NULL COMMENT '채용부서',
  `MNG_TSK` varchar(100) DEFAULT NULL COMMENT '담당업무',
  `CAR_CD` int(1) DEFAULT NULL COMMENT '경력코드',
  `CAR_MIN_YEAR` int(2) DEFAULT NULL COMMENT '경력최소',
  `CAR_MAX_YEAR` int(2) DEFAULT NULL COMMENT '경력최대',
  `MON_PAY_MIN` int(10) DEFAULT NULL COMMENT '임금최소',
  `MON_PAY_MAX` int(10) DEFAULT NULL COMMENT '임금최대',
  `EDUCATION` varchar(200) DEFAULT NULL,
  `AGE_MIN` int(2) DEFAULT NULL COMMENT '최소연령',
  `AGE_MAX` int(2) DEFAULT NULL COMMENT '최대연령',
  `RANK_ID` varchar(200) DEFAULT NULL COMMENT '직급',
  `GEND_CD` char(1) DEFAULT NULL COMMENT '성별',
  `DSD_FR_WK` varchar(8) DEFAULT NULL COMMENT '출근희망일',
  `KEYWD` varchar(200) DEFAULT NULL COMMENT '키워드',
  `OTR_CON` varchar(2000) DEFAULT NULL COMMENT '기타조건',
  KEY `NewIndex1` (`DOC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_official` (
  `DOC_ID` varchar(20) NOT NULL,
  `OFFICIAL_ID` varchar(20) DEFAULT NULL,
  `OFFICIAL_YEAR` varchar(4) DEFAULT NULL,
  `COMPANY_ID` varchar(20) DEFAULT NULL,
  `DESTN` varchar(2000) DEFAULT NULL,
  KEY `NewIndex1` (`DOC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_preset` (
  `PRESET_ID` varchar(20) NOT NULL,
  `PRESET_NM` varchar(100) DEFAULT NULL,
  `PRESET_TYP` char(1) DEFAULT NULL COMMENT '''G'' -일반 프리셋 ''S'' - 자기개발비 D - 회식비 ',
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `ACC_ID` varchar(20) DEFAULT NULL,
  `WRITER_NO` int(10) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `PRESET_ORD` int(11) DEFAULT NULL,
  PRIMARY KEY (`PRESET_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_reader` (
  `DOC_ID` varchar(20) NOT NULL,
  `NO` int(20) NOT NULL AUTO_INCREMENT,
  `APP_TYP` varchar(20) DEFAULT NULL COMMENT '000기안자 001검토자 002협조자 003전결자 004참조자 005처리자',
  `SRCH_DT` datetime DEFAULT NULL,
  `STAT` int(10) NOT NULL,
  `READER_NO` varchar(20) DEFAULT NULL,
  `APP_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`READER_NO`),
  KEY `NewIndex3` (`APP_TYP`)
) ENGINE=InnoDB AUTO_INCREMENT=734446 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_sales_in` (
  `DOC_ID` varchar(20) NOT NULL,
  `SALES_PRJ_ID` varchar(20) NOT NULL COMMENT '팀장경비신청서 개발로 인한 PK 결정',
  `PURCHASE_PRJ_ID` varchar(20) NOT NULL COMMENT '팀장경비신청서 개발로 인한 PK 결정',
  `ST_DT` varchar(8) DEFAULT NULL,
  `ED_DT` varchar(8) DEFAULT NULL,
  `TEMPLT_ID` varchar(20) DEFAULT NULL COMMENT '템플릿ID',
  KEY `NewIndex1` (`SALES_PRJ_ID`),
  KEY `NewIndex2` (`PURCHASE_PRJ_ID`),
  KEY `NewIndex3` (`ST_DT`),
  KEY `DOC_ID` (`DOC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_tot_sales` (
  `DOC_ID` varchar(20) DEFAULT NULL,
  `SALES_SJ` varchar(200) DEFAULT NULL,
  `SALES_PRJ_ID` varchar(20) DEFAULT NULL,
  `PURCHASE_PRJ_ID` varchar(20) DEFAULT NULL,
  `COST` bigint(25) DEFAULT NULL,
  `DEPOSIT` bigint(20) DEFAULT NULL,
  `MAINTENANCE` bigint(20) DEFAULT NULL,
  `ST_DT` varchar(8) DEFAULT NULL,
  `ED_DT` varchar(8) DEFAULT NULL,
  `DECIDE_YN` char(1) DEFAULT NULL,
  `BOND_MANAGE_YN` char(1) DEFAULT 'Y',
  `COL_DUE_DT` varchar(8) DEFAULT NULL COMMENT '최종수금예정일',
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`SALES_PRJ_ID`),
  KEY `NewIndex3` (`PURCHASE_PRJ_ID`),
  KEY `NewIndex4` (`ST_DT`),
  KEY `NewIndex5` (`DECIDE_YN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_user_input` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `DOC_ID` varchar(20) DEFAULT NULL,
  `USER_NO` int(11) DEFAULT NULL,
  `ST_DT` char(8) DEFAULT NULL,
  `ED_DT` char(8) DEFAULT NULL,
  `INPUT_PERCENT` int(11) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`USER_NO`),
  KEY `NewIndex3` (`ST_DT`),
  KEY `NewIndex4` (`ED_DT`)
) ENGINE=InnoDB AUTO_INCREMENT=46704 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_eapp_vac` (
  `DOC_ID` varchar(20) NOT NULL,
  `VAC_TYP` int(20) DEFAULT NULL COMMENT '1 - 연차. 2 - 경조휴가 3 - 특별휴가 4 - 기타 5 - 하계휴가',
  `ST_DT` varchar(8) DEFAULT NULL,
  `ED_DT` varchar(8) DEFAULT NULL,
  `ST_AMPM` int(1) DEFAULT NULL,
  `ED_AMPM` int(1) DEFAULT NULL,
  `SUM_DATE` double DEFAULT NULL,
  `SYSTEM` int(1) DEFAULT NULL COMMENT '1 - 일괄휴가 시스템입력 데이터',
  `WS_PLACE` varchar(100) DEFAULT NULL COMMENT 'TBL_WORK_STATE 로 이동할 휴가행선지',
  `EAPP_WRITER_NO` varchar(20) DEFAULT NULL COMMENT 'TBL_EAPP_DOC FK',
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`ST_DT`),
  KEY `NewIndex3` (`VAC_TYP`),
  KEY `FK_TBL_EAPP_VAC` (`EAPP_WRITER_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_edu_level` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `SNAME` varchar(30) DEFAULT NULL COMMENT '학교명',
  `MAJOR` varchar(30) DEFAULT NULL COMMENT '전공',
  `EST_DT` varchar(11) DEFAULT NULL COMMENT '기간1',
  `EED_DT` varchar(11) DEFAULT NULL COMMENT '기간2',
  `GRADUATION_YN` varchar(20) DEFAULT NULL COMMENT '졸업유무',
  `SABUN` char(4) DEFAULT NULL COMMENT '사번',
  `USER_NO` int(11) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_equip` (
  `EQUIP_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '장비번호',
  `EQUIP_TYPE` varchar(20) DEFAULT NULL COMMENT '장비형태',
  `SERIAL_NO` varchar(20) DEFAULT NULL COMMENT '관리번호',
  `MODEL` varchar(100) DEFAULT NULL COMMENT '모델명',
  `CPU` varchar(100) DEFAULT NULL COMMENT 'CPU',
  `MEMORY` varchar(100) DEFAULT NULL COMMENT 'MEMORY',
  `VGA` varchar(100) DEFAULT NULL COMMENT 'VGA',
  `HDD` varchar(100) DEFAULT NULL COMMENT 'HDD',
  `ODD` varchar(100) DEFAULT NULL COMMENT 'ODD',
  `ETC` varchar(255) DEFAULT NULL COMMENT '기타',
  `STATUS` varchar(50) DEFAULT NULL COMMENT '상태 1-public 1-공용 2-personal 2-개인용 3-SERVER 3-서버용 4-수리중 5-extra 5-여분 6-disuse 6-폐기',
  `USER_ID` varchar(20) DEFAULT NULL COMMENT '담당자아이디',
  `USER_NM` varchar(60) DEFAULT NULL COMMENT '담당자명',
  `PLACE` varchar(200) DEFAULT NULL COMMENT '사용처',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `UDT_DT` datetime DEFAULT NULL COMMENT '수정일',
  `BUY_PLACE` varchar(100) DEFAULT NULL COMMENT '구입처',
  `BUY_ADDR` varchar(100) DEFAULT NULL COMMENT '구입처 주소',
  `BUY_TEL` varchar(100) DEFAULT NULL COMMENT '구입처 전화번호',
  `BUY_DT` varchar(100) DEFAULT NULL COMMENT '구입시기',
  `SIRIAL_NO` varchar(100) DEFAULT NULL COMMENT '시리얼 번호 - SERIAL_NO 인데... 허..',
  `BUY_PRICE` int(11) DEFAULT NULL,
  PRIMARY KEY (`EQUIP_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=1555 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_equip_detail` (
  `IDX` int(11) NOT NULL AUTO_INCREMENT COMMENT '장비세부일련번호',
  `EQUIP_NO` int(11) NOT NULL COMMENT '장비번호',
  `USER_ID` varchar(200) DEFAULT NULL COMMENT '사용자',
  `USER_NM` varchar(200) DEFAULT NULL COMMENT '사용자명',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일자',
  `UDT_DT` datetime DEFAULT NULL COMMENT '수정일자',
  `USE_YN` enum('Y','N') DEFAULT NULL COMMENT '사용여부',
  `TEAM_NAME` varchar(50) DEFAULT NULL COMMENT '소속',
  `PLACE` varchar(200) DEFAULT NULL COMMENT '사용처',
  `STATUS` varchar(200) DEFAULT NULL COMMENT '상태',
  `ETC` varchar(200) DEFAULT NULL COMMENT '비고',
  `USE_PURPS` varchar(200) DEFAULT NULL COMMENT '사용목적',
  PRIMARY KEY (`IDX`)
) ENGINE=InnoDB AUTO_INCREMENT=7359 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_equip_install` (
  `INSTALL_NO` int(10) NOT NULL DEFAULT 0,
  `SUBJECT` varchar(255) NOT NULL,
  `PROJECT_CODE` varchar(100) NOT NULL,
  `SOLUTION_CODE` varchar(100) NOT NULL,
  `CUSTOMER` varchar(100) NOT NULL,
  `CONTENT` mediumtext NOT NULL,
  `INST_ID` varchar(20) DEFAULT NULL,
  `INST_DATE` datetime DEFAULT NULL,
  `CHG_ID` varchar(20) DEFAULT NULL,
  `CHG_DATE` datetime DEFAULT NULL,
  `ATCHFILEID` char(20) DEFAULT NULL,
  `GUBUN_CD` char(1) DEFAULT NULL,
  `GUBUN_NUM` int(10) DEFAULT NULL,
  `DEL_YN` char(1) DEFAULT NULL,
  `REFERENCE_NO` int(10) DEFAULT NULL,
  `MODIFY_YN` char(1) DEFAULT NULL,
  PRIMARY KEY (`INSTALL_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_equip_install_detail` (
  `INSTALL_DETAIL_NO` int(10) NOT NULL,
  `INSTALL_NO` int(10) NOT NULL,
  `MNG_ID` varchar(20) DEFAULT NULL,
  `REG_DATE` datetime DEFAULT NULL,
  `COMPLETE_DATE` varchar(10) DEFAULT NULL,
  `ATCHFILEID` varchar(100) DEFAULT NULL,
  `CONTENT` mediumtext DEFAULT NULL,
  `GUBUN_CD` char(1) DEFAULT NULL,
  `DEL_YN` char(1) DEFAULT NULL,
  `GUBUN_NUM` int(10) DEFAULT NULL,
  `REG_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`INSTALL_DETAIL_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_equip_install_history` (
  `HISTORY_NO` int(10) NOT NULL,
  `INSTALL_NO` int(10) DEFAULT NULL,
  `CHG_ID` varchar(20) DEFAULT NULL,
  `CHG_DATE` datetime DEFAULT NULL,
  `SUBJECT` varchar(255) DEFAULT NULL,
  `PROJECT_CODE` varchar(100) DEFAULT NULL,
  `SOLUTION_CODE` varchar(100) DEFAULT NULL,
  `CONTENT` mediumtext DEFAULT NULL,
  `CUSTOMER` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`HISTORY_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_equip_install_read` (
  `NO` int(11) NOT NULL,
  `INSTALL_NO` int(10) DEFAULT NULL,
  `READTIME` datetime DEFAULT NULL,
  `USER_NO` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_equip_repair` (
  `IDX` int(11) NOT NULL AUTO_INCREMENT COMMENT '장비수리 일련번호',
  `EQUIP_NO` int(11) NOT NULL COMMENT '장비번호',
  `REG_NO` varchar(200) DEFAULT NULL COMMENT '등록자',
  `UDT_NO` varchar(200) DEFAULT NULL COMMENT '수정자',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일자',
  `UDT_DT` datetime DEFAULT NULL COMMENT '수정일자',
  `USE_YN` enum('Y','N') DEFAULT 'Y' COMMENT '사용여부',
  `REPAIR_DT` varchar(8) DEFAULT NULL COMMENT '수리일자',
  `COST` int(10) DEFAULT NULL COMMENT '수리비용',
  `CONTENT` varchar(2000) DEFAULT NULL COMMENT '수리내역',
  `NOTE` varchar(2000) DEFAULT NULL COMMENT '비고',
  PRIMARY KEY (`IDX`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_equip_type` (
  `TYPE_NO` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE_NAME` varchar(100) DEFAULT NULL,
  `TYPE_VALUE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`TYPE_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_expansion` (
  `EXP_ID` char(20) NOT NULL,
  `EXP_SJ` varchar(100) DEFAULT NULL,
  `EXP_CN` text DEFAULT NULL,
  `EXP_FILE_ID` char(20) DEFAULT NULL,
  `LINK_URL` varchar(1000) DEFAULT NULL,
  `POP_YN` char(1) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `SORT` int(11) DEFAULT NULL,
  `ACCESS` char(1) DEFAULT NULL,
  `ACCESS_USER_NO` varchar(2000) DEFAULT NULL,
  `POP_WIDTH` char(4) DEFAULT NULL,
  `POP_HEIGHT` char(4) DEFAULT NULL,
  PRIMARY KEY (`EXP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_expansion_use` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `EXP_ID` char(20) DEFAULT NULL,
  `EXP_ORD` int(11) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`),
  KEY `NewIndex2` (`EXP_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=496 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_fund` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT '키값',
  `date` char(8) DEFAULT NULL COMMENT '일자',
  `type` char(2) DEFAULT NULL COMMENT '구분:KMS021(입금D:deposit/출금W:widthraw/대체입금RD/대체출금RW)',
  `account` char(2) DEFAULT NULL COMMENT '현금흐름:KMS022(입금:LC판권,ET기타,AS유지보수,GD상품,SV용역,SL솔루션판매/출금:LB인건비,MT관리비,IN매입원가,EL기타)',
  `bank_book` varchar(15) DEFAULT NULL COMMENT '통장:KMS023(IBK기업은행,KB국민은행,MIRA미래에셋,SHIN신한은행,W103우리은행(103),W101우리은행(101),WCHK우리은행(당좌),WILS우리은행(일산),CASH현금)',
  `expense` bigint(14) DEFAULT NULL,
  `prj_id` varchar(20) DEFAULT NULL COMMENT '프로젝트 아이디',
  `note` text DEFAULT NULL COMMENT '내역',
  `doc_id` varchar(20) DEFAULT NULL COMMENT '전자결재문서 아이디',
  `plan` char(1) DEFAULT 'N' COMMENT '출금예정(Y:출금예정-전자결재상신시 넘어온 문서/N:일반)',
  `company_cd` varchar(10) DEFAULT NULL COMMENT '회사코드',
  `reg_date` date DEFAULT NULL COMMENT '작성일자',
  `use_at` char(1) DEFAULT 'Y' COMMENT '사용여부(Y:사용중인 자금보고/N:무효화된 자금보고)',
  `BANK_BOOK_BFR` varchar(10) DEFAULT NULL COMMENT '수기변경시 종전 통장코드',
  PRIMARY KEY (`no`),
  KEY `NewIndex1` (`prj_id`),
  KEY `NewIndex2` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=132662 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_gamescore` (
  `NO` int(11) NOT NULL COMMENT 'NO IN TBL_USERINFO',
  `USER_ID` varchar(15) DEFAULT NULL,
  `PK` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK - PK 순서가 이렇게 뒤바뀌어 있으면 대용량 데이터 처리시 퍼포먼스 이슈가 발생할 수 있음',
  `START_TM` datetime DEFAULT NULL,
  `END_TM` datetime DEFAULT NULL,
  `SCORE` int(11) DEFAULT NULL,
  `STEP` int(11) DEFAULT NULL,
  `SUM` int(11) DEFAULT NULL,
  `HINT_YN` tinyint(1) DEFAULT NULL,
  `TM_OVER_YN` int(11) DEFAULT NULL,
  PRIMARY KEY (`NO`,`PK`),
  KEY `PK` (`PK`)
) ENGINE=InnoDB AUTO_INCREMENT=648 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_hanmaum_game` (
  `NO` int(11) DEFAULT NULL,
  `PK` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NM` varchar(20) DEFAULT NULL,
  `USER_ID` varchar(20) DEFAULT NULL,
  `START_TM` date DEFAULT NULL COMMENT '게임시작시간',
  `END_TM` date DEFAULT NULL COMMENT '게임종료시간',
  `RUN_TM` date DEFAULT NULL COMMENT '게임진행시간',
  `STEP` int(11) DEFAULT NULL COMMENT '단계',
  `SCORE` int(11) DEFAULT NULL COMMENT '문항개수',
  `ORGNZT_NM` varchar(50) DEFAULT NULL COMMENT '소속팀명',
  `SUM` int(11) DEFAULT NULL COMMENT '점수',
  `HINT_YN` tinyint(1) DEFAULT NULL COMMENT '힌트사용유무',
  PRIMARY KEY (`PK`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_ip` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `BW` varchar(50) DEFAULT NULL,
  `IP` varchar(50) DEFAULT NULL,
  `IP_USER_NO` int(11) DEFAULT NULL,
  `IP_PURPOSE` varchar(50) DEFAULT NULL,
  `IP_MOD_DATE` char(16) DEFAULT NULL,
  `IP_MOD_USER_NO` int(11) DEFAULT NULL,
  PRIMARY KEY (`NO`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_login_log` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) DEFAULT NULL,
  `TM` datetime DEFAULT NULL,
  `IP` varchar(20) DEFAULT NULL,
  `MOBILE_YN` char(1) DEFAULT NULL,
  `INNERNET_YN` char(1) DEFAULT NULL,
  `CONFIRM_YN` char(1) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_mailrecieve` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `MAIL_ID` char(20) NOT NULL,
  `RECIEVE_NO` int(11) NOT NULL,
  `READ_DT` datetime DEFAULT NULL,
  `DELETE_YN` char(1) DEFAULT 'N',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`MAIL_ID`),
  KEY `DELETE_YN` (`DELETE_YN`,`READ_DT`)
) ENGINE=InnoDB AUTO_INCREMENT=39537 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_mailsend` (
  `MAIL_ID` char(20) NOT NULL,
  `SENDER_NO` int(11) NOT NULL,
  `MAIL_SJ` varchar(200) DEFAULT NULL,
  `MAIL_CN` mediumtext DEFAULT NULL,
  `MAIL_SEND` char(1) DEFAULT NULL,
  `SMS_SEND` char(1) DEFAULT NULL COMMENT 'Y-전송 Null-전송안함 F-전송실패',
  `SEND_DT` datetime DEFAULT NULL,
  `ATCH_FILE_ID` char(20) DEFAULT NULL,
  `DELETE_YN` char(1) DEFAULT 'N',
  `IS_SEND` char(1) DEFAULT 'Y' COMMENT 'Y-메일전송 N-메일저장',
  `PUSH_SEND` char(1) DEFAULT NULL,
  PRIMARY KEY (`MAIL_ID`),
  KEY `IS_SEND` (`IS_SEND`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_mail_out` (
  `REF_ID` varchar(20) NOT NULL,
  `EMAIL_ADDR` varchar(500) DEFAULT NULL,
  `SEND_FLAG` varchar(1) DEFAULT NULL COMMENT 'Y - SENT, N - NOT SENT',
  PRIMARY KEY (`REF_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_meeting_room` (
  `MT_ID` char(20) NOT NULL COMMENT '일련번호',
  `PRJ_ID` char(20) NOT NULL COMMENT '프로젝트',
  `MT_SJ` varchar(200) DEFAULT NULL COMMENT '회의제목',
  `MT_CN` mediumtext DEFAULT NULL COMMENT '회의내용',
  `ATTACH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일',
  `MT_DATE` varchar(8) DEFAULT NULL COMMENT '회의일자',
  `MT_PLACE` varchar(100) DEFAULT NULL COMMENT '회의장소',
  `MT_FRTM` varchar(2) DEFAULT NULL COMMENT '회의시작시간',
  `MT_PURPOSE` varchar(1000) DEFAULT NULL COMMENT '회의목적',
  `MT_RESULT` mediumtext DEFAULT NULL COMMENT '회의결과',
  `REG_DT` datetime DEFAULT NULL COMMENT '작성일',
  `MOD_DT` datetime DEFAULT NULL COMMENT '수정일',
  `PUSH_YN1` char(1) DEFAULT NULL COMMENT '게설시PUSH알림',
  `PUSH_YN2` char(1) DEFAULT NULL COMMENT '회의10분전PUSH알림',
  `USE_AT` char(1) DEFAULT NULL COMMENT '삭제여부',
  `MT_TOTM` varchar(2) DEFAULT NULL COMMENT '회의종료시간',
  `MT_RESULT_WR` int(11) DEFAULT NULL COMMENT '회의결과작성자',
  `MT_RESULT_DT` datetime DEFAULT NULL COMMENT '회의결과작성일시',
  `MT_PLACE_TYP` char(1) DEFAULT NULL COMMENT '회의장소 구분- 0:내부, 1:외부',
  PRIMARY KEY (`MT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_meeting_room_comment` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `MT_ID` char(20) NOT NULL,
  `MT_COMMENT_CN` text DEFAULT NULL,
  `ATTACH_FILE_ID` char(20) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `UDT_DT` datetime DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`),
  KEY `MT_ID` (`MT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7978 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_meeting_room_recieve` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `MT_ID` char(20) NOT NULL,
  `RECIEVE_TYP` char(2) DEFAULT NULL,
  `READTIME` datetime DEFAULT NULL,
  `INTEREST_YN` char(1) DEFAULT NULL,
  `TASK` char(1) DEFAULT '0' COMMENT '수기작업 플래그 0 - 손안댐 1 - 손 댄 레코드',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`),
  KEY `MT_ID` (`MT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=71198 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_mission` (
  `MISSION_ID` varchar(25) NOT NULL COMMENT '미션 아이디 PK',
  `PRJ_ID` varchar(20) DEFAULT NULL COMMENT '프로젝트 아이디',
  `MISSION_NM` varchar(100) DEFAULT NULL COMMENT '미션 이름',
  `MISSION_CN` text DEFAULT NULL COMMENT '미션코드 : 이름과 같은 문자열값',
  `PRNT_MISSION_ID` varchar(25) DEFAULT NULL COMMENT '상위미션 아이디',
  `MISSION_LV` int(5) DEFAULT NULL COMMENT '미션 단계',
  `MISSION_TREE` varchar(2000) DEFAULT NULL COMMENT '미션 트리',
  `LEADER_NO` int(10) DEFAULT NULL COMMENT '담당자 번호',
  `REG_DT` datetime DEFAULT NULL COMMENT '작성일',
  `MOD_DT` datetime DEFAULT NULL COMMENT '수정일',
  `DUE_DT` datetime DEFAULT NULL COMMENT '완료 예정일',
  `END_DT` datetime DEFAULT NULL COMMENT '완료 일',
  `ATTACH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일 아이디',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '작성자 번호',
  `USE_AT` char(1) DEFAULT 'Y' COMMENT '사용여부 YN',
  PRIMARY KEY (`MISSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_mission_history` (
  `HISTORY_NO` int(20) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `MISSION_ID` varchar(25) NOT NULL COMMENT '미션 아이디 PK',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '등록자',
  `REG_DT` datetime DEFAULT NULL COMMENT '일시',
  `HISTORY_STAT` varchar(20) DEFAULT NULL COMMENT '진행내역 담당자 변경 - CL 예정일 변경 - CD  미완료 - P  완료처리 - E 등록 - W  수정 - U 삭제 - D',
  `HISTORY_CN` text DEFAULT NULL COMMENT '변경 내용',
  `test_column` text DEFAULT NULL COMMENT '테스트용',
  PRIMARY KEY (`HISTORY_NO`),
  KEY `MISSION_ID` (`MISSION_ID`),
  CONSTRAINT `FK_tbl_mission_history_tbl_mission` FOREIGN KEY (`MISSION_ID`) REFERENCES `tbl_mission` (`MISSION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=569 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_mobile_login_log` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) DEFAULT NULL,
  `CONNECT_TIME` datetime DEFAULT NULL,
  `CONNECT_IP` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=1396 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_mymenu` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `MENU_SJ` varchar(100) DEFAULT NULL,
  `LINK_URL` varchar(500) DEFAULT NULL,
  `MENU_ORD` int(11) DEFAULT NULL,
  `ORGNZT_ID` varchar(20) DEFAULT NULL,
  `TYPE` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1: 개인, 2: 팀',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=1255 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_noterecieve` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `NOTE_ID` char(20) NOT NULL,
  `RECIEVE_NO` int(11) NOT NULL COMMENT 'RECEIVE 가 맞는 철자인데 온 시스템에 죄다 이렇게 써둬서 수정불갘ㅋㅋ나참ㅋㅋㅋㅋ',
  `READ_DT` datetime DEFAULT NULL,
  `DELETE_YN` char(1) DEFAULT 'N',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`NOTE_ID`),
  KEY `DELETE_YN` (`DELETE_YN`,`READ_DT`),
  KEY `RECIEVE_NO` (`RECIEVE_NO`,`DELETE_YN`,`READ_DT`)
) ENGINE=InnoDB AUTO_INCREMENT=428591 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_notesend` (
  `NOTE_ID` char(20) NOT NULL COMMENT '이것만 지우면 RECEIVE 테이블에 쓰레기값 남아서 쪽지함 조회 안됨',
  `SENDER_NO` int(11) NOT NULL,
  `NOTE_CN` text DEFAULT NULL,
  `SEND_DT` datetime DEFAULT NULL,
  `DELETE_YN` char(1) DEFAULT 'N',
  PRIMARY KEY (`NOTE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_orgnzt` (
  `ORGNZT_ID` char(20) NOT NULL,
  `ORGNZT_NM` varchar(50) NOT NULL,
  `ORGNZT_SNM` varchar(10) DEFAULT NULL,
  `orgnzt_dc` text DEFAULT NULL,
  `ORG_UP` char(20) DEFAULT NULL,
  `USE_YN` char(1) DEFAULT NULL,
  `FRST_REGISTER_PNTTM` date DEFAULT NULL,
  `LAST_UPDUSR_PNTTM` date DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `POSTCP_NM` varchar(200) DEFAULT NULL,
  `POSTCP_RNM` varchar(200) DEFAULT NULL,
  `CUR_MAX_PRJ_CD` int(10) DEFAULT 0,
  `DEFAULT_PRJ_ID` char(20) DEFAULT NULL,
  `ORG_TREE` varchar(2000) DEFAULT NULL COMMENT '조직트리',
  `ORD` int(3) DEFAULT 100 COMMENT '정렬 ',
  `ORG_TREE_ORD` varchar(2000) DEFAULT NULL COMMENT '정렬조건 추가 조직트리',
  `HAVING_LEAF` tinyint(1) DEFAULT 0 COMMENT '하위 조직 및 프로젝트 유무',
  PRIMARY KEY (`ORGNZT_ID`),
  KEY `NewIndex1` (`ORG_UP`),
  KEY `NewIndex2` (`ORG_TREE`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `tbl_orgnzt` (`ORGNZT_ID`, `ORGNZT_NM`, `ORGNZT_SNM`, `orgnzt_dc`, `ORG_UP`, `USE_YN`, `FRST_REGISTER_PNTTM`, `LAST_UPDUSR_PNTTM`, `FRST_REGISTER_ID`, `LAST_UPDUSR_ID`, `POSTCP_NM`, `POSTCP_RNM`, `CUR_MAX_PRJ_CD`, `DEFAULT_PRJ_ID`, `ORG_TREE`, `ORD`, `ORG_TREE_ORD`, `HAVING_LEAF`) VALUES
	('ORGAN_RET_ORGAN_CODE', '퇴직자그룹', '퇴직자그룹', '(시스템 기본 조직)', 'ORGAN_TOP_ORGAN_CODE', 'Y', '2011-12-01', '2013-01-04', 'admin', NULL, '', '', 0, NULL, 'ORGAN_TOP_ORGAN_CODE/ORGAN_RET_ORGAN_CODE', 970, '001ORGAN_TOP_ORGAN_CODE/R970ORGAN_RET_ORGAN_CODE', 0),
	('ORGAN_STD_ORGAN_CODE', '발령대기', '발령대기', '(시스템 기본 조직)', 'ORGAN_TOP_ORGAN_CODE', 'Y', '2011-12-01', '2013-01-04', 'admin', NULL, '', '', 0, NULL, 'ORGAN_TOP_ORGAN_CODE/ORGAN_STD_ORGAN_CODE', 960, '001ORGAN_TOP_ORGAN_CODE/R960ORGAN_STD_ORGAN_CODE', 0),
	('ORGAN_TOP_ORGAN_CODE', '회사', 'CO', '(시스템 기본 조직)', 'ORGAN_TOP_ORGAN_CODE', 'Y', '2011-12-01', '2013-01-04', 'admin', NULL, '대표이사', '대표이사(대)', 2, NULL, 'ORGAN_TOP_ORGAN_CODE', 1, '001ORGAN_TOP_ORGAN_CODE', 1);

CREATE TABLE IF NOT EXISTS `tbl_orgnzt_copy` (
  `ORGNZT_ID` char(20) NOT NULL,
  `ORGNZT_NM` varchar(50) NOT NULL,
  `ORGNZT_SNM` varchar(10) DEFAULT NULL,
  `orgnzt_dc` text DEFAULT NULL,
  `ORG_UP` char(20) DEFAULT NULL,
  `USE_YN` char(1) DEFAULT NULL,
  `FRST_REGISTER_PNTTM` date DEFAULT NULL,
  `LAST_UPDUSR_PNTTM` date DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) DEFAULT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  `POSTCP_NM` varchar(200) DEFAULT NULL,
  `POSTCP_RNM` varchar(200) DEFAULT NULL,
  `CUR_MAX_PRJ_CD` int(10) DEFAULT 0,
  `DEFAULT_PRJ_ID` char(20) DEFAULT NULL,
  `ORG_TREE` varchar(2000) DEFAULT NULL COMMENT '조직트리',
  `ORD` int(3) DEFAULT 100 COMMENT '정렬 ',
  `ORG_TREE_ORD` varchar(2000) DEFAULT NULL COMMENT '정렬조건 추가 조직트리',
  `HAVING_LEAF` tinyint(1) DEFAULT 0 COMMENT '하위 조직 및 프로젝트 유무',
  PRIMARY KEY (`ORGNZT_ID`),
  KEY `NewIndex1` (`ORG_UP`),
  KEY `NewIndex2` (`ORG_TREE`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_org_his` (
  `ORG_HIS_ID` int(10) NOT NULL AUTO_INCREMENT,
  `HGR_STAT` char(18) DEFAULT NULL,
  `HRG_NM` char(18) DEFAULT NULL,
  `USE_YN` char(1) DEFAULT NULL,
  `ORGNZT_ID` varchar(20) NOT NULL,
  `FRST_REGISTER_PNTTM` date NOT NULL,
  `LAST_UPDUSR_PNTTM` date DEFAULT NULL,
  `FRST_REGISTER_ID` varchar(20) NOT NULL,
  `LAST_UPDUSR_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ORG_HIS_ID`,`ORGNZT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=612 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_plan_exp` (
  `DOC_ID` varchar(20) DEFAULT NULL,
  `TYP` varchar(1) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `EXP_DT` int(8) DEFAULT NULL,
  `COST` int(20) DEFAULT NULL,
  `EXP_CT` text DEFAULT NULL,
  `IDENTIFY_NO` int(11) DEFAULT NULL COMMENT '0은 영업경비인듯',
  `DECIDE_YN` char(1) DEFAULT 'Y' COMMENT '예상 - N , 확정 - Y',
  `BUDGET_PRJ` varchar(20) DEFAULT NULL COMMENT '예산관리 프로젝트 : BUDGET_EXCEED_RULE 기준 FN_GET_BUDGET_PRJ. INSERT UPDATE TRIGGER로 관리',
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`PRJ_ID`),
  KEY `NewIndex3` (`EXP_DT`),
  KEY `NewIndex4` (`DECIDE_YN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_plan_labor` (
  `DOC_ID` varchar(20) DEFAULT NULL,
  `TYP` varchar(1) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `USER_NO` int(11) DEFAULT NULL,
  `LABOR_DT` int(8) DEFAULT NULL,
  `RATIO` double(5,4) DEFAULT NULL,
  `LABOR_CT` text DEFAULT NULL,
  `IDENTIFY_NO` int(11) DEFAULT NULL,
  `DECIDE_YN` char(1) DEFAULT 'Y' COMMENT '예상 - N , 확정 - Y',
  `SALARY` bigint(20) DEFAULT NULL,
  `COST` bigint(20) DEFAULT NULL,
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`PRJ_ID`),
  KEY `NewIndex3` (`USER_NO`),
  KEY `NewIndex4` (`LABOR_DT`),
  KEY `NewIndex5` (`DECIDE_YN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_position_history` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `CHNG_CODE` char(2) DEFAULT NULL COMMENT 'CH:변경 EN:입사 RT:퇴직 RE:재입사 LV:휴직 BK:복귀',
  `BFR_RANK_ID` varchar(50) DEFAULT NULL COMMENT '직급',
  `BFR_COMP_ID` varchar(50) DEFAULT NULL COMMENT '소속회사',
  `BFR_ORGNZT_ID` varchar(50) DEFAULT NULL COMMENT '팀',
  `BFR_POSITION` varchar(50) DEFAULT NULL COMMENT '보직 // H:부서장 S:부서장대행 N:일반',
  `AFT_RANK_ID` varchar(50) DEFAULT NULL,
  `AFT_COMP_ID` varchar(50) DEFAULT NULL,
  `AFT_ORGNZT_ID` varchar(50) DEFAULT NULL,
  `AFT_ORGNZT_NM` varchar(500) DEFAULT NULL,
  `AFT_POSITION` varchar(50) DEFAULT NULL,
  `AFT_POSITION_NM` varchar(500) DEFAULT NULL,
  `CHNG_DT` char(8) DEFAULT NULL,
  `NOTE` text DEFAULT NULL,
  `ADMIN_NO` int(11) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`),
  KEY `NewIndex2` (`CHNG_CODE`),
  KEY `NewIndex3` (`CHNG_DT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_pos_hol_salary` (
  `POSITION_CODE` char(1) DEFAULT NULL COMMENT 'H - 부서장 S -부서장대행 N -일반',
  `YEAR` int(4) DEFAULT NULL,
  `MONTH` int(2) DEFAULT NULL,
  `SALARY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_prj` (
  `PRJ_ID` varchar(20) NOT NULL COMMENT '프로젝트 아이디 PK',
  `PRJ_NM` varchar(100) DEFAULT NULL COMMENT '프로젝트이름',
  `PRJ_CD` varchar(100) DEFAULT NULL COMMENT '프로젝트코드 : 이름같은 문자열값',
  `PRJ_CN` text DEFAULT NULL COMMENT '프로젝트 설명',
  `PRNT_PRJ_ID` varchar(20) DEFAULT NULL COMMENT '상위프로젝트 아이디',
  `PRJ_LV` int(5) DEFAULT NULL COMMENT '프로젝트 단계',
  `ORGNZT_ID` varchar(20) DEFAULT NULL COMMENT '주관부서',
  `LEADER_NO` int(10) DEFAULT NULL COMMENT 'PL ',
  `STAT` char(1) DEFAULT NULL COMMENT 'KMS010 P - 진행/ S - 중지 / E -종료',
  `DAY_REPORT_RULE` char(3) DEFAULT NULL COMMENT '업무실적등록 Y - 투입입력만 ALL - 모두가능 N - 불가능',
  `MANAGE_COST_RULE` char(3) DEFAULT NULL COMMENT '비용지출 Y - 투입입력만 ALL - 모두가능 N - 불가능',
  `BUDGET_EXCEED_RULE` char(3) DEFAULT NULL COMMENT '예산초과관리 기본 Y - 자기프로젝트 N - 상위(Y 프로젝트까지 재귀탐색)',
  `PURCHASE_PRJ_ID` varchar(20) DEFAULT NULL COMMENT '사용하지 않음',
  `REG_DT` datetime DEFAULT NULL COMMENT '작성일',
  `ST_DT` varchar(8) DEFAULT NULL COMMENT '시작일',
  `COMP_DUE_DT` varchar(8) DEFAULT NULL COMMENT '종료일 (완료예정일이지만 한마음 시스템에서 종료일로 사용)',
  `COMP_DT` datetime DEFAULT NULL COMMENT '사용안함 : 종료/중단일 - 모든 프로젝트가 REG_DT = COMP_DT 같음',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '작성자 번호',
  `CUR_MAX_PRJ_CD` int(10) DEFAULT 0 COMMENT '하위프로젝트 코드순서',
  `PRJ_TREE` varchar(2000) DEFAULT NULL COMMENT '프로젝트 트리',
  `ORG_PRJ_TREE` varchar(2000) DEFAULT NULL COMMENT '조직프로젝트 트리',
  `PRJ_TYPE` char(1) DEFAULT NULL COMMENT '수행(P), 영업(S), 사업(B), 경영(M), 기타(E)',
  `ORG_PRJ_TREE_ORD` varchar(2000) DEFAULT NULL COMMENT '정렬 추가 조직프로젝트 트리',
  `ORD` int(3) DEFAULT 100 COMMENT '정렬조건 3자리 수',
  `BOND_YN` char(1) DEFAULT 'Y' COMMENT '채권관리 속성',
  `BUDGET_PRJ` varchar(20) DEFAULT NULL COMMENT '예산관리 프로젝트 : BUDGET_EXCEED_RULE 기준 FN_GET_BUDGET_PRJ. INSERT UPDATE TRIGGER로 관리',
  `PROPOSAL` char(1) DEFAULT 'N' COMMENT '제안서 속성',
  `UPD_DT` datetime DEFAULT NULL COMMENT '수정일',
  `UPDATER_NO` int(10) DEFAULT NULL COMMENT '수정자 번호',
  `CUST_ID` char(20) DEFAULT NULL COMMENT '고객사 ID',
  `PLAN_SALES` varchar(50) DEFAULT NULL COMMENT '예상 매출',
  `PLAN_PROFIT` varchar(50) DEFAULT NULL COMMENT '예상 이익',
  `PLAN_DATE` varchar(50) DEFAULT NULL COMMENT '예상 영업시기',
  `LAST_REPORT_NO` int(11) DEFAULT NULL COMMENT '마지막 작업실적 번호(영업관리)',
  `HAVING_LEAF` tinyint(1) DEFAULT 0 COMMENT '하위노드 유무',
  PRIMARY KEY (`PRJ_ID`),
  KEY `NewIndex1` (`PRNT_PRJ_ID`),
  KEY `NewIndex2` (`ORGNZT_ID`),
  KEY `NewIndex3` (`PRJ_TREE`(255)),
  KEY `NewIndex4` (`ORG_PRJ_TREE`(255)),
  KEY `NewIndex5` (`PRJ_TYPE`),
  KEY `NewIndex6` (`STAT`),
  KEY `BUDGET_PRJ` (`BUDGET_PRJ`),
  KEY `IDX_LEADER_NO` (`LEADER_NO`),
  KEY `IDX_PRJ_CUST_ID` (`CUST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_prj_copy` (
  `PRJ_ID` varchar(20) NOT NULL COMMENT '프로젝트 아이디 PK',
  `PRJ_NM` varchar(100) DEFAULT NULL COMMENT '프로젝트이름',
  `PRJ_CD` varchar(100) DEFAULT NULL COMMENT '프로젝트코드 : 이름같은 문자열값',
  `PRJ_CN` text DEFAULT NULL COMMENT '프로젝트 설명',
  `PRNT_PRJ_ID` varchar(20) DEFAULT NULL COMMENT '상위프로젝트 아이디',
  `PRJ_LV` int(5) DEFAULT NULL COMMENT '프로젝트 단계',
  `ORGNZT_ID` varchar(20) DEFAULT NULL COMMENT '주관부서',
  `LEADER_NO` int(10) DEFAULT NULL COMMENT 'PL ',
  `STAT` char(1) DEFAULT NULL COMMENT 'KMS010 P - 진행/ S - 중지 / E -종료',
  `DAY_REPORT_RULE` char(3) DEFAULT NULL COMMENT '업무실적등록 Y - 투입입력만 ALL - 모두가능 N - 불가능',
  `MANAGE_COST_RULE` char(3) DEFAULT NULL COMMENT '비용지출 Y - 투입입력만 ALL - 모두가능 N - 불가능',
  `BUDGET_EXCEED_RULE` char(3) DEFAULT NULL COMMENT '예산초과관리 기본 Y - 자기프로젝트 N - 상위(Y 프로젝트까지 재귀탐색)',
  `PURCHASE_PRJ_ID` varchar(20) DEFAULT NULL COMMENT '사용하지 않음',
  `REG_DT` datetime DEFAULT NULL COMMENT '작성일',
  `ST_DT` varchar(8) DEFAULT NULL COMMENT '시작일',
  `COMP_DUE_DT` varchar(8) DEFAULT NULL COMMENT '종료일 (완료예정일이지만 한마음 시스템에서 종료일로 사용)',
  `COMP_DT` datetime DEFAULT NULL COMMENT '사용안함 : 종료/중단일 - 모든 프로젝트가 REG_DT = COMP_DT 같음',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '작성자 번호',
  `CUR_MAX_PRJ_CD` int(10) DEFAULT 0 COMMENT '하위프로젝트 코드순서',
  `PRJ_TREE` varchar(2000) DEFAULT NULL COMMENT '프로젝트 트리',
  `ORG_PRJ_TREE` varchar(2000) DEFAULT NULL COMMENT '조직프로젝트 트리',
  `PRJ_TYPE` char(1) DEFAULT NULL COMMENT '수행(P), 영업(S), 사업(B), 경영(M), 기타(E)',
  `ORG_PRJ_TREE_ORD` varchar(2000) DEFAULT NULL COMMENT '정렬 추가 조직프로젝트 트리',
  `ORD` int(3) DEFAULT 100 COMMENT '정렬조건 3자리 수',
  `BOND_YN` char(1) DEFAULT 'Y' COMMENT '채권관리 속성',
  `BUDGET_PRJ` varchar(20) DEFAULT NULL COMMENT '예산관리 프로젝트 : BUDGET_EXCEED_RULE 기준 FN_GET_BUDGET_PRJ. INSERT UPDATE TRIGGER로 관리',
  `PROPOSAL` char(1) DEFAULT 'N' COMMENT '제안서 속성',
  `UPD_DT` datetime DEFAULT NULL COMMENT '수정일',
  `UPDATER_NO` int(10) DEFAULT NULL COMMENT '수정자 번호',
  `CUST_ID` char(20) DEFAULT NULL COMMENT '고객사 ID',
  `PLAN_SALES` varchar(50) DEFAULT NULL COMMENT '예상 매출',
  `PLAN_PROFIT` varchar(50) DEFAULT NULL COMMENT '예상 이익',
  `PLAN_DATE` varchar(50) DEFAULT NULL COMMENT '예상 영업시기',
  `LAST_REPORT_NO` int(11) DEFAULT NULL COMMENT '마지막 작업실적 번호(영업관리)',
  `HAVING_LEAF` tinyint(1) DEFAULT 0 COMMENT '하위노드 유무',
  PRIMARY KEY (`PRJ_ID`),
  KEY `NewIndex1` (`PRNT_PRJ_ID`),
  KEY `NewIndex2` (`ORGNZT_ID`),
  KEY `NewIndex3` (`PRJ_TREE`(255)),
  KEY `NewIndex4` (`ORG_PRJ_TREE`(255)),
  KEY `NewIndex5` (`PRJ_TYPE`),
  KEY `NewIndex6` (`STAT`),
  KEY `BUDGET_PRJ` (`BUDGET_PRJ`),
  KEY `IDX_LEADER_NO` (`LEADER_NO`),
  KEY `IDX_PRJ_CUST_ID` (`CUST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_prj_input` (
  `PRJ_INPUT_NO` int(11) NOT NULL AUTO_INCREMENT,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `USER_NO` int(10) DEFAULT NULL,
  `YEAR` varchar(4) DEFAULT NULL,
  `MONTH` varchar(2) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `WRITER_NO` int(11) DEFAULT NULL,
  PRIMARY KEY (`PRJ_INPUT_NO`),
  KEY `NewIndex1` (`PRJ_ID`),
  KEY `NewIndex2` (`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=1213865 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_prj_input_plan` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `PRJ_ID` char(20) NOT NULL,
  `INPUT_PERCENT` int(11) DEFAULT NULL,
  `INPUT_SDT` char(8) DEFAULT NULL,
  `INPUT_EDT` char(8) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `REG_USER_NO` int(11) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `MOD_USER_NO` int(11) DEFAULT NULL,
  `MOD_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`PRJ_ID`),
  KEY `NewIndex2` (`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_prj_interest` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `USER_NO` int(20) DEFAULT NULL,
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_prj_result` (
  `ID` char(28) NOT NULL,
  `YEAR` char(4) NOT NULL,
  `MONTH` char(2) NOT NULL,
  `PRJ_ID` char(20) NOT NULL,
  `SALES_OUT` bigint(20) DEFAULT 0,
  `SALES_IN` bigint(20) DEFAULT 0,
  `PURCHASE_OUT` bigint(20) DEFAULT 0,
  `PURCHASE_IN_NORMAL` bigint(20) DEFAULT 0,
  `PURCHASE_IN_COMMON` bigint(20) DEFAULT 0,
  `PLAN_LABOR` bigint(20) DEFAULT 0,
  `LABOR` bigint(20) DEFAULT 0,
  `PLAN_EXP` bigint(20) DEFAULT 0,
  `EXP` bigint(20) DEFAULT 0,
  `MOD_DT` datetime DEFAULT NULL,
  `ST_DT` varchar(8) DEFAULT NULL COMMENT '시작일',
  `COMP_DT` varchar(8) DEFAULT NULL COMMENT '사용안함(훼이크 종료일 ST_DT와 동일)',
  `COMP_DUE_DT` varchar(8) DEFAULT NULL COMMENT '종료일 (종료예정일인데 한마음 시스템에서 종료일로 사용)',
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`YEAR`),
  KEY `NewIndex2` (`MONTH`),
  KEY `NewIndex3` (`PRJ_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_prj_result_total` (
  `ID` char(28) NOT NULL,
  `YEAR` char(4) NOT NULL,
  `MONTH` char(2) NOT NULL,
  `PRJ_ID` char(20) NOT NULL,
  `SALES_OUT` bigint(20) DEFAULT NULL,
  `SALES_OUT_EST` bigint(20) DEFAULT NULL,
  `SALES_IN` bigint(20) DEFAULT NULL,
  `SALES_IN_EST` bigint(20) DEFAULT NULL,
  `PURCHASE_OUT` bigint(20) DEFAULT NULL,
  `PURCHASE_OUT_EST` bigint(20) DEFAULT NULL,
  `PURCHASE_IN_NORMAL` bigint(20) DEFAULT NULL,
  `PURCHASE_IN_NORMAL_EST` bigint(20) DEFAULT NULL,
  `PURCHASE_IN_COMMON` bigint(20) DEFAULT NULL,
  `PLAN_LABOR` bigint(20) DEFAULT NULL,
  `PLAN_LABOR_EST` bigint(20) DEFAULT NULL,
  `LABOR` bigint(20) DEFAULT NULL,
  `PLAN_EXP` bigint(20) DEFAULT NULL,
  `PLAN_EXP_EST` bigint(20) DEFAULT NULL,
  `EXP` bigint(20) DEFAULT NULL,
  `EXP_EST` bigint(20) DEFAULT NULL,
  `MOD_DT` datetime DEFAULT NULL,
  `ST_DT` varchar(8) DEFAULT NULL COMMENT '시작일',
  `COMP_DT` varchar(8) DEFAULT NULL COMMENT '사용안함(훼이크 종료일 ST_DT와 동일)',
  `COMP_DUE_DT` varchar(8) DEFAULT NULL COMMENT '종료일 (종료예정일인데 한마음 시스템에서 종료일로 사용)',
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`YEAR`),
  KEY `NewIndex2` (`MONTH`),
  KEY `NewIndex3` (`PRJ_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_product_info` (
  `PRODUCT_ID` varchar(30) NOT NULL COMMENT 'PRODUCT_ID PK',
  `PRODUCT_NM` varchar(255) DEFAULT NULL COMMENT '제품 이름',
  `PRODUCT_CN` text DEFAULT NULL COMMENT '제품 설명',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '등록자 NO',
  `ADMIN_NO` int(20) DEFAULT NULL COMMENT '관리자',
  `USE_AT` varchar(2) DEFAULT NULL COMMENT '사용여부 YN',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬 순서',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `MOD_DT` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_product_output` (
  `PRODUCT_ID` varchar(30) NOT NULL COMMENT 'PRODUCT_ID PK',
  `PART_ID` varchar(30) NOT NULL COMMENT 'PART_ID : PK',
  `OUTPUT_ID` varchar(30) NOT NULL COMMENT 'OUTPUT_ID : PK',
  `OUTPUT_NM` varchar(255) DEFAULT NULL COMMENT '산출물 이름',
  `OUTPUT_CN` text DEFAULT NULL COMMENT '산출물 설명',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '등록자 NO',
  `USE_AT` varchar(2) DEFAULT NULL COMMENT '사용여부 YN',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬 순서',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `MOD_DT` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`OUTPUT_ID`),
  KEY `PART_ID` (`PART_ID`),
  KEY `PRODUCT_ID` (`PRODUCT_ID`),
  CONSTRAINT `FK_tbl_product_output_tbl_product_info` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `tbl_product_info` (`PRODUCT_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_tbl_product_output_tbl_product_part` FOREIGN KEY (`PART_ID`) REFERENCES `tbl_product_part` (`PART_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_product_output_info` (
  `PRODUCT_ID` varchar(30) NOT NULL COMMENT 'PRODUCT_ID PK',
  `PART_ID` varchar(30) NOT NULL COMMENT 'PART_ID : PK',
  `OUTPUT_ID` varchar(30) NOT NULL COMMENT 'OUTPUT_ID : PK',
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'INFO_NO PK',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '등록자 NO',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `MOD_DT` datetime DEFAULT NULL,
  `INFO_CN` text DEFAULT NULL COMMENT '산출물 설명',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일 ID',
  `USE_AT` varchar(2) DEFAULT NULL COMMENT '사용요부 YN',
  PRIMARY KEY (`NO`),
  KEY `OUTPUT_ID` (`OUTPUT_ID`),
  KEY `PART_ID` (`PART_ID`),
  KEY `PRODUCT_ID` (`PRODUCT_ID`),
  CONSTRAINT `FK_tbl_product_output_info_tbl_product_info` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `tbl_product_info` (`PRODUCT_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_tbl_product_output_info_tbl_product_output` FOREIGN KEY (`OUTPUT_ID`) REFERENCES `tbl_product_output` (`OUTPUT_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_tbl_product_output_info_tbl_product_part` FOREIGN KEY (`PART_ID`) REFERENCES `tbl_product_part` (`PART_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_product_part` (
  `PRODUCT_ID` varchar(30) NOT NULL COMMENT 'PRODUCT_ID PK',
  `PART_ID` varchar(30) NOT NULL COMMENT 'PART_ID : PK',
  `PART_NM` varchar(255) DEFAULT NULL COMMENT '수성품 이름',
  `PART_CN` text DEFAULT NULL COMMENT '구성품 설명',
  `USE_AT` varchar(2) DEFAULT NULL COMMENT '사용여부 YN',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬 순서',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `MOD_DT` datetime DEFAULT NULL COMMENT '수정일',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '작성자',
  PRIMARY KEY (`PART_ID`),
  KEY `PRODUCT_ID` (`PRODUCT_ID`),
  CONSTRAINT `FK_tbl_product_part_tbl_product_info` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `tbl_product_info` (`PRODUCT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_product_request` (
  `PRODUCT_ID` varchar(30) NOT NULL COMMENT 'PRODUCT_ID PK',
  `REQUEST_ID` varchar(30) NOT NULL COMMENT 'REQUEST_ID PK',
  `PART_ID` varchar(30) NOT NULL COMMENT 'PART_ID : PK',
  `REQUEST_NM` varchar(255) DEFAULT NULL COMMENT '요구사항명',
  `REQUEST_TYPE` varchar(1) DEFAULT NULL COMMENT '요구 유형\n기능개선 I\n기능추가 A\n기능오류 E',
  `request_cn` mediumtext DEFAULT NULL,
  `REQUEST_STATE` varchar(1) DEFAULT NULL COMMENT '미처리     A\n처리완료  B\n검토완료  C\n미검토     D\n기각        E',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '등록자 NO',
  `ADMIN_NO` int(10) DEFAULT NULL COMMENT '담당자 NO',
  `HOPE_DT` varchar(10) DEFAULT NULL COMMENT '적용희망일',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `MOD_DT` datetime DEFAULT NULL COMMENT '변경일',
  `END_DT` datetime DEFAULT NULL COMMENT '처리일',
  `USE_AT` varchar(1) DEFAULT NULL COMMENT '사용여부 YN',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT '부첨부파일 ID',
  `DUE_DT` varchar(10) DEFAULT NULL COMMENT '처리예정일',
  `ACCEPT_AT` varchar(1) DEFAULT NULL COMMENT '수용여부 YN',
  `CHECK_WRITER_NO` int(10) DEFAULT NULL COMMENT '검토자',
  `check_cn` mediumtext DEFAULT NULL,
  `CHECK_ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT 'CHECK_ATCH_FILE_ID',
  `CHECK_REG_DT` datetime DEFAULT NULL COMMENT '검토 일',
  `CHECK_MOD_DT` datetime DEFAULT NULL COMMENT '검토 수정 일',
  `VERSION_NM` varchar(50) DEFAULT NULL COMMENT '버전',
  `MODIFIER_NO` int(10) DEFAULT NULL COMMENT '수정자 NO',
  `PRJ_ID` varchar(20) DEFAULT NULL COMMENT '프로젝트 아이디',
  PRIMARY KEY (`REQUEST_ID`),
  KEY `PART_ID` (`PART_ID`),
  KEY `PRODUCT_ID` (`PRODUCT_ID`),
  CONSTRAINT `FK_tbl_product_request_tbl_product_info` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `tbl_product_info` (`PRODUCT_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_tbl_product_request_tbl_product_part` FOREIGN KEY (`PART_ID`) REFERENCES `tbl_product_part` (`PART_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_product_request_check` (
  `REQUEST_ID` varchar(30) NOT NULL COMMENT 'REQUEST_ID PK',
  `CHECK_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'CHECK_ID : PK',
  `CHECK_CN` text DEFAULT NULL COMMENT '검토 결과 내용',
  `ACCEPT_AT` varchar(2) DEFAULT NULL COMMENT '수용여부 YN',
  `DUE_DT` datetime DEFAULT NULL COMMENT '처리예정일',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `MOD_DT` datetime DEFAULT NULL COMMENT '수정일',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일 ID',
  PRIMARY KEY (`CHECK_ID`),
  KEY `REQUEST_ID` (`REQUEST_ID`),
  CONSTRAINT `FK_tbl_product_request_tbl_product_request_check` FOREIGN KEY (`REQUEST_ID`) REFERENCES `tbl_product_request` (`REQUEST_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_product_request_check_part` (
  `REQUEST_ID` varchar(30) NOT NULL COMMENT 'REQUEST_ID PK',
  `PART_ID` varchar(30) NOT NULL COMMENT 'PART_ID : PK',
  KEY `PART_ID` (`PART_ID`),
  KEY `REQUEST_ID` (`REQUEST_ID`),
  CONSTRAINT `FK_tbl_product_request_check_part_tbl_product_part` FOREIGN KEY (`PART_ID`) REFERENCES `tbl_product_part` (`PART_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_tbl_product_request_check_part_tbl_product_request_check` FOREIGN KEY (`REQUEST_ID`) REFERENCES `tbl_product_request` (`REQUEST_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_product_request_comment` (
  `REQUEST_ID` varchar(30) NOT NULL COMMENT 'REQUEST_ID PK',
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'NO PK',
  `COMMENT_CN` text DEFAULT NULL COMMENT '코멘트 내용',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '등록자 NO',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `MOD_DT` datetime DEFAULT NULL COMMENT '변경일',
  `USE_AT` varchar(1) DEFAULT NULL COMMENT '사용여부 YN',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `REQUEST_ID` (`REQUEST_ID`),
  CONSTRAINT `FK_tbl_product_request_comment_tbl_product_request` FOREIGN KEY (`REQUEST_ID`) REFERENCES `tbl_product_request` (`REQUEST_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2746 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_product_request_history` (
  `REQUEST_ID` varchar(30) NOT NULL COMMENT 'REQUEST_ID PK',
  `NO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'NO :  PK',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `WRITER_NO` int(20) DEFAULT NULL COMMENT '등록자 NO',
  `HISTORY_STATE` varchar(2) DEFAULT NULL COMMENT '진행내역\n처리미완료A \n처리완료B\n검토C\n재검토D\n수정E\n등록F',
  `HISTORY_CN` text DEFAULT NULL COMMENT '진행 내용',
  PRIMARY KEY (`NO`),
  KEY `REQUEST_ID` (`REQUEST_ID`),
  CONSTRAINT `FK_tbl_product_request_history_tbl_product_request` FOREIGN KEY (`REQUEST_ID`) REFERENCES `tbl_product_request` (`REQUEST_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3324 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_purchase_in` (
  `PURCHASE_IN_NO` int(11) NOT NULL AUTO_INCREMENT,
  `DOC_ID` varchar(20) DEFAULT NULL,
  `PURCHASE_PRJ_ID` varchar(20) DEFAULT NULL,
  `SALES_PRJ_ID` varchar(20) DEFAULT NULL,
  `TYP` varchar(10) DEFAULT NULL COMMENT 'C -공통비 , G - 보통, P -pre, A - after PE - plan_exp에서 나온 값. PO-사외매입',
  `PURCHASE_IN_DT` int(8) DEFAULT NULL,
  `COST` bigint(20) DEFAULT NULL COMMENT '판관비',
  `PURCHASE_IN_CT` text DEFAULT NULL,
  `DECIDE_YN` char(1) DEFAULT 'Y' COMMENT '예상 - N , 확정 - Y',
  `IDENTIFY_NO` int(11) DEFAULT NULL,
  PRIMARY KEY (`PURCHASE_IN_NO`),
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`SALES_PRJ_ID`),
  KEY `NewIndex3` (`PURCHASE_PRJ_ID`),
  KEY `NewIndex4` (`TYP`),
  KEY `NewIndex5` (`PURCHASE_IN_DT`),
  KEY `NewIndex6` (`DECIDE_YN`)
) ENGINE=InnoDB AUTO_INCREMENT=154869 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_purchase_in_labor` (
  `PURCHASE_IN_NO` int(11) NOT NULL AUTO_INCREMENT,
  `DOC_ID` varchar(20) DEFAULT NULL,
  `PURCHASE_PRJ_ID` varchar(20) DEFAULT NULL,
  `SALES_PRJ_ID` varchar(20) DEFAULT NULL,
  `PURCHASE_IN_DT` int(8) DEFAULT NULL,
  `RATIO` double(10,4) DEFAULT NULL,
  `USER_NO` int(11) DEFAULT NULL,
  `PURCHASE_IN_CT` text DEFAULT NULL,
  `DECIDE_YN` char(1) DEFAULT 'Y' COMMENT '예상 - N , 확정 - Y',
  `IDENTIFY_NO` int(11) DEFAULT NULL,
  `SALARY` bigint(20) DEFAULT NULL,
  `COST` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`PURCHASE_IN_NO`),
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`PURCHASE_PRJ_ID`),
  KEY `NewIndex3` (`SALES_PRJ_ID`),
  KEY `NewIndex4` (`USER_NO`),
  KEY `NewIndex5` (`PURCHASE_IN_DT`),
  KEY `NewIndex6` (`DECIDE_YN`)
) ENGINE=InnoDB AUTO_INCREMENT=509608 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_purchase_out` (
  `PURCHASE_OUT_NO` int(11) NOT NULL AUTO_INCREMENT,
  `DOC_ID` varchar(20) DEFAULT NULL,
  `IDENTIFY_NO` int(11) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `COST` bigint(20) DEFAULT NULL,
  `PURCHASE_OUT_DT` int(8) DEFAULT NULL,
  `PURCHASE_OUT_CT` mediumtext DEFAULT NULL,
  `DECIDE_YN` char(1) DEFAULT 'Y' COMMENT '예상 - N , 확정 - Y',
  PRIMARY KEY (`PURCHASE_OUT_NO`),
  KEY `NewIndex1` (`DOC_ID`),
  KEY `NewIndex2` (`PRJ_ID`),
  KEY `NewIndex3` (`PURCHASE_OUT_DT`),
  KEY `NewIndex4` (`DECIDE_YN`)
) ENGINE=InnoDB AUTO_INCREMENT=47189 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_push_log` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `from_user_id` varchar(20) DEFAULT NULL,
  `to_user_id` varchar(20) DEFAULT NULL,
  `note_no` char(20) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `tm` datetime DEFAULT NULL,
  `push_key` varchar(53) DEFAULT NULL,
  `success` char(1) DEFAULT 'Y',
  `test` varchar(200) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL COMMENT '\r\n업무연락         : work\r\n한마음회의실   : conf\r\n쪽지               : note\r\n사내메일         : mail',
  `to_user_phone_no` varchar(20) DEFAULT NULL COMMENT '수신자 전화번호',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=376276 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_rank_hol_salary` (
  `RANK_CODE` char(2) DEFAULT NULL,
  `YEAR` int(4) DEFAULT NULL,
  `MONTH` int(2) DEFAULT NULL,
  `SALARY` int(11) DEFAULT NULL,
  UNIQUE KEY `NewIndex1` (`RANK_CODE`,`YEAR`,`MONTH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_rank_salary` (
  `RANK_CODE` varchar(20) NOT NULL,
  `YEAR` int(4) NOT NULL,
  `MONTH` int(11) NOT NULL DEFAULT 0,
  `SALARY` bigint(11) NOT NULL DEFAULT 0 COMMENT '연봉아님 인건비임 NOT SALARY, THIS IS LABOR COST',
  PRIMARY KEY (`RANK_CODE`,`YEAR`,`MONTH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_rank_salary_real` (
  `RANK_CODE` varchar(20) NOT NULL,
  `YEAR` int(4) NOT NULL,
  `RAISE_RATE` int(11) NOT NULL DEFAULT 0 COMMENT '인상률에서 용도변경',
  `SALARY` bigint(11) NOT NULL DEFAULT 0 COMMENT '실제 연봉 A등급 기준',
  `YEAR_DIFF` bigint(11) DEFAULT 0 COMMENT '년차별 연봉공차',
  `GRADE_DIFF` bigint(11) DEFAULT 0 COMMENT '등급별 연봉공차',
  PRIMARY KEY (`RANK_CODE`,`YEAR`,`RAISE_RATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_rule_content` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE_NO` int(11) DEFAULT NULL,
  `SJ` varchar(20) DEFAULT NULL,
  `CN` mediumtext DEFAULT NULL,
  `USE_AT` char(1) DEFAULT 'Y',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_rule_history` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `TYP` char(3) DEFAULT NULL,
  `TITLE_NO` int(11) DEFAULT NULL,
  `CONTENT_NO` int(11) DEFAULT NULL,
  `TM` datetime DEFAULT NULL,
  `INFO` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_rule_title` (
  `NO` int(11) NOT NULL,
  `ORD` int(11) NOT NULL AUTO_INCREMENT,
  `SJ` varchar(200) DEFAULT NULL,
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL,
  `USE_AT` char(1) DEFAULT 'Y',
  PRIMARY KEY (`NO`),
  KEY `ORD` (`ORD`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_sales` (
  `SALES_NO` int(11) NOT NULL AUTO_INCREMENT,
  `DOC_ID` varchar(20) DEFAULT NULL,
  `PRJ_ID` varchar(20) DEFAULT NULL,
  `COST` bigint(20) DEFAULT NULL,
  `SALES_DT` int(8) DEFAULT NULL,
  `SALES_CT` text DEFAULT NULL,
  `DECIDE_YN` char(1) DEFAULT 'Y' COMMENT '예상 - N , 확정 - Y',
  `BOND_MANAGE_YN` char(1) DEFAULT 'Y',
  PRIMARY KEY (`SALES_NO`),
  KEY `NewIndex1` (`PRJ_ID`),
  KEY `NewIndex2` (`DOC_ID`),
  KEY `NewIndex3` (`SALES_DT`),
  KEY `NewIndex4` (`DECIDE_YN`)
) ENGINE=InnoDB AUTO_INCREMENT=66083 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_sales_bond` (
  `DOC_ID` varchar(20) NOT NULL COMMENT '문서번호',
  `BOND_PRJ_NO` int(11) NOT NULL COMMENT '프로젝트별세금계산서번호',
  `REG_USER_NO` int(20) NOT NULL COMMENT '등록자',
  `REG_DT` datetime NOT NULL COMMENT '등록일시',
  PRIMARY KEY (`DOC_ID`,`BOND_PRJ_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_sales_trans` (
  `DOC_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '문서ID',
  `PRJ_ID` varchar(20) DEFAULT NULL COMMENT '프로젝트ID',
  `SAVE_DT` varchar(8) NOT NULL DEFAULT '' COMMENT '날짜',
  `COST_LABOR` int(20) DEFAULT NULL COMMENT '노동비기존매출',
  `COST_EXP` int(20) DEFAULT NULL COMMENT '수행경비기존매출',
  PRIMARY KEY (`DOC_ID`,`SAVE_DT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_schedule` (
  `SCHE_ID` char(20) NOT NULL,
  `USER_NO` int(11) NOT NULL,
  `SCHE_TYP` char(1) DEFAULT NULL COMMENT 'C회사일정 T팀일정 P개인일정 H법정공휴일 I임시공휴일 J회사공휴일',
  `SCHE_ORGNZT_ID` char(20) DEFAULT NULL,
  `SCHE_YEAR` char(4) DEFAULT NULL,
  `SCHE_MONTH` char(2) DEFAULT NULL,
  `SCHE_DATE` char(2) DEFAULT NULL,
  `SCHE_TM_TYP` char(1) DEFAULT NULL,
  `SCHE_TM_FROM` varchar(5) DEFAULT NULL,
  `SCHE_TM_TO` varchar(5) DEFAULT NULL,
  `SCHE_SJ` varchar(200) DEFAULT NULL,
  `SCHE_CN` mediumtext DEFAULT NULL,
  `DELETE_YN` char(1) DEFAULT 'N',
  `SCHE_DATE_ALL` char(8) DEFAULT NULL COMMENT '2013-03-04 추가 속성 YYYYmmdd',
  `SCHE_SHARED_ORGNZT_ID` varchar(500) DEFAULT NULL,
  `SCHE_SHARED_ORGNZT_NM` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`SCHE_ID`),
  KEY `NewIndex1` (`USER_NO`),
  KEY `NewIndex2` (`SCHE_ORGNZT_ID`),
  KEY `NewIndex3` (`SCHE_TYP`),
  KEY `NewIndex4` (`DELETE_YN`),
  KEY `NewIndex5` (`SCHE_YEAR`),
  KEY `NewIndex6` (`SCHE_MONTH`),
  KEY `NewIndex7` (`SCHE_DATE`),
  KEY `SCHE_DATE_ALL` (`SCHE_DATE_ALL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_schedule_copy` (
  `SCHE_ID` char(20) NOT NULL,
  `USER_NO` int(11) NOT NULL,
  `SCHE_TYP` char(1) DEFAULT NULL COMMENT 'C회사일정 T팀일정 P개인일정 H법정공휴일 I임시공휴일 J회사공휴일',
  `SCHE_ORGNZT_ID` char(20) DEFAULT NULL,
  `SCHE_YEAR` char(4) DEFAULT NULL,
  `SCHE_MONTH` char(2) DEFAULT NULL,
  `SCHE_DATE` char(2) DEFAULT NULL,
  `SCHE_TM_TYP` char(1) DEFAULT NULL,
  `SCHE_TM_FROM` varchar(5) DEFAULT NULL,
  `SCHE_TM_TO` varchar(5) DEFAULT NULL,
  `SCHE_SJ` varchar(200) DEFAULT NULL,
  `SCHE_CN` mediumtext DEFAULT NULL,
  `DELETE_YN` char(1) DEFAULT 'N',
  PRIMARY KEY (`SCHE_ID`),
  KEY `NewIndex1` (`USER_NO`),
  KEY `NewIndex2` (`SCHE_ORGNZT_ID`),
  KEY `NewIndex3` (`SCHE_TYP`),
  KEY `NewIndex4` (`DELETE_YN`),
  KEY `NewIndex5` (`SCHE_YEAR`),
  KEY `NewIndex6` (`SCHE_MONTH`),
  KEY `NewIndex7` (`SCHE_DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_score` (
  `SCORE_ID` varchar(20) NOT NULL,
  `CATEGORY` varchar(3) DEFAULT NULL,
  `CODE` varchar(20) DEFAULT NULL,
  `ACT` varchar(20) DEFAULT NULL,
  `NM` varchar(100) DEFAULT NULL,
  `POINT` int(11) DEFAULT NULL,
  PRIMARY KEY (`SCORE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_score_detail` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `SCORE_ID` varchar(20) DEFAULT NULL,
  `USER_NO` varchar(20) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `POINT` int(11) DEFAULT NULL,
  `KEY1` varchar(20) DEFAULT NULL,
  `KEY2` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`SCORE_ID`),
  KEY `NewIndex2` (`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=27324 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_scrap` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `TYP` char(10) NOT NULL,
  `ARTICLE_ID` varchar(20) NOT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=331 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_selfdev` (
  `SELFDEV_NO` int(10) NOT NULL AUTO_INCREMENT,
  `MONTH` int(1) DEFAULT NULL,
  `FULL` int(11) DEFAULT NULL,
  `HALF` int(11) DEFAULT NULL,
  `YEAR` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`SELFDEV_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_selfdev_usr` (
  `SELFDEV_USR_NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) DEFAULT NULL,
  `YEAR` varchar(4) DEFAULT NULL,
  `PERCENT` double(5,2) DEFAULT NULL,
  `DESCRIPTION` varchar(200) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `EXTRA_CHARGE` int(11) DEFAULT NULL COMMENT '할증금액',
  PRIMARY KEY (`SELFDEV_USR_NO`),
  UNIQUE KEY `NewIndex1` (`USER_NO`,`YEAR`)
) ENGINE=InnoDB AUTO_INCREMENT=1571 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_solution_equipment` (
  `SOLUTION_NO` int(10) NOT NULL,
  `SOLUTION_NAME` varchar(100) NOT NULL,
  PRIMARY KEY (`SOLUTION_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_statistic_sector` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `SECTOR_TYP` int(2) DEFAULT NULL,
  `STATISTIC_SECTOR_NM` varchar(50) NOT NULL,
  `STATISTIC_SECTOR_VAL` varchar(1000) DEFAULT NULL,
  `STATISTIC_SECTOR_ORD` int(11) DEFAULT NULL,
  `COLOR_TYP` char(1) DEFAULT NULL,
  `YEAR` char(4) DEFAULT NULL COMMENT '년도조건 추가하려다 복잡해서 중단',
  PRIMARY KEY (`NO`),
  KEY `STATISTIC_SECTOR_VAL` (`STATISTIC_SECTOR_VAL`(255))
) ENGINE=InnoDB AUTO_INCREMENT=585 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_statistic_sector_2012` (
  `NO` int(11) NOT NULL,
  `SECTOR_TYP` int(2) DEFAULT NULL,
  `STATISTIC_SECTOR_NM` varchar(50) NOT NULL,
  `STATISTIC_SECTOR_VAL` varchar(500) DEFAULT NULL,
  `STATISTIC_SECTOR_ORD` int(11) DEFAULT NULL,
  `COLOR_TYP` char(1) DEFAULT NULL,
  `YEAR` char(4) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `STATISTIC_SECTOR_VAL` (`STATISTIC_SECTOR_VAL`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_stock` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `input_user_no` int(11) DEFAULT NULL COMMENT '입고자 user_no',
  `serial_no` varchar(50) DEFAULT NULL COMMENT '시리얼 번호(시리얼코드 + 품목코드 + 날짜8자리 + 숫자3자리)',
  `item_no` int(11) DEFAULT NULL COMMENT '품목 테이블(TBL_STOCK_ITEM) PK',
  `input_date` char(8) DEFAULT NULL COMMENT '입고일',
  `expense` int(11) DEFAULT NULL COMMENT '개별단가',
  `note` varchar(2000) DEFAULT NULL COMMENT '비고',
  `input_place` varchar(100) DEFAULT NULL COMMENT '입고처',
  `exp_id` varchar(20) DEFAULT NULL COMMENT '지출결의서테이블(TBL_EAPP_EXP) PK',
  `temp_saver_no` int(11) DEFAULT -1 COMMENT '임시저장중이 아닐 때엔 -1, 임시저장한 사용자의 user_no',
  `prj_id` varchar(20) DEFAULT NULL COMMENT '프로젝트 테이블 PK (TBL_PRJ)',
  `is_serial_changed` int(11) DEFAULT NULL,
  `status` char(2) DEFAULT '0',
  `reg_date` datetime DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_stock_category` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `category_code` varchar(10) DEFAULT NULL COMMENT '카테고리 코드',
  `category_name` varchar(100) DEFAULT NULL COMMENT '구분 이름',
  `division` char(1) DEFAULT NULL COMMENT 'S/W, H/W 구분(S/W:S, H/W:H)',
  `use_at` char(1) DEFAULT 'Y' COMMENT '해당 레코드 사용여부(Y:사용, N:삭제)',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_stock_history` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `stock_no` int(11) DEFAULT NULL COMMENT '재고 테이블 PK (TBL_STOCK)',
  `user_no` int(11) DEFAULT NULL COMMENT '입/출고 담당자의 user_no',
  `s_date` char(10) DEFAULT NULL COMMENT '시작일',
  `e_date` char(10) DEFAULT NULL COMMENT '종료일',
  `status` char(2) DEFAULT NULL COMMENT '목적 (재고:0,판매:,데모:,재입고:5)',
  `reseller` varchar(100) DEFAULT NULL COMMENT '판매사',
  `enduser` varchar(100) DEFAULT NULL COMMENT '고객사',
  `install_place` varchar(100) DEFAULT NULL COMMENT '설치장소',
  `prj_id` varchar(20) DEFAULT NULL COMMENT '프로젝트 테이블 PK (TBL_PRJ)',
  `note` varchar(2000) DEFAULT NULL COMMENT '비고',
  `category_no` int(11) DEFAULT NULL COMMENT '구분',
  `serial_no` varchar(50) DEFAULT NULL COMMENT '시리얼번호',
  `item_code` int(11) DEFAULT NULL COMMENT '품목번호',
  `expense` int(11) DEFAULT NULL COMMENT '개별단가',
  `reg_date` datetime DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_stock_install` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `hw_no` int(11) DEFAULT NULL COMMENT '설치될 하드웨어',
  `sw_no` int(11) DEFAULT NULL COMMENT '설치할 소프트웨어',
  `typ` char(1) DEFAULT NULL COMMENT '설치유형 (detailcode : KMS031 참고 / 1:codec 2:camera 3:phone 4.mic)',
  `use_at` char(1) DEFAULT 'Y' COMMENT '사용여부 (Y사용 N삭제)',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_stock_item` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `item_code` varchar(10) DEFAULT NULL COMMENT '품목코드 (예:001)',
  `item_name` varchar(100) DEFAULT NULL COMMENT '품목명',
  `category_no` int(11) DEFAULT NULL COMMENT '구분 테이블 PK',
  `price` int(11) DEFAULT NULL COMMENT '단가',
  `avg_price` int(11) DEFAULT NULL COMMENT '평균가',
  `input_cnt` int(11) DEFAULT 0 COMMENT '입고수량',
  `note` varchar(2000) DEFAULT NULL COMMENT '설명',
  `serial_code` char(4) DEFAULT NULL COMMENT '시리얼코드 (시리얼번호의 앞 4자리)',
  `use_at` char(1) DEFAULT 'Y' COMMENT '해당 레코드 사용여부(Y:사용, N:삭제)',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=9007 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_suggest_history` (
  `NTT_ID` int(11) NOT NULL,
  `BBS_ID` char(20) NOT NULL,
  `USER_NO` int(11) NOT NULL,
  `SGST_ST` char(1) DEFAULT NULL COMMENT 'E 작업예정 H 작업중 C 향후작업 R 기각 F 처리완료',
  `REG_DT` datetime DEFAULT NULL,
  `NOTE` text DEFAULT NULL,
  KEY `NewIndex1` (`NTT_ID`,`BBS_ID`),
  KEY `NewIndex2` (`USER_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_task` (
  `TASK_ID` char(20) NOT NULL COMMENT '작업 ID',
  `USER_NO` int(11) NOT NULL COMMENT '담당자',
  `PRJ_ID` char(20) DEFAULT NULL COMMENT '프로젝트 ID',
  `TASK_SJ` varchar(200) DEFAULT NULL COMMENT '작업 명',
  `TASK_CN` text DEFAULT NULL COMMENT '작업 내용',
  `TASK_REGDATE` char(8) DEFAULT NULL COMMENT '작업 등록일',
  `TASK_STARTDATE` char(8) DEFAULT NULL COMMENT '작업 시작일',
  `TASK_DUEDATE` char(8) DEFAULT NULL COMMENT '작업 완료예정일',
  `TASK_DUETIME` char(2) DEFAULT NULL COMMENT '작업 완료예정시간',
  `TASK_ENDDATE` char(8) DEFAULT NULL COMMENT '작완 완료일',
  `WRITER_NO` int(11) NOT NULL COMMENT '작성자',
  `TASK_STATE` char(1) DEFAULT NULL COMMENT 'P작업중 C작업완료',
  `ALWAYS_VIEW_YN` char(1) DEFAULT NULL COMMENT '계속보기 Y/N',
  `TASK_STARTTIME` char(8) DEFAULT NULL COMMENT '작업 시작시간',
  PRIMARY KEY (`TASK_ID`),
  KEY `NewIndex1` (`PRJ_ID`),
  KEY `NewIndex2` (`USER_NO`),
  KEY `NewIndex3` (`WRITER_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_task_content` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `TASK_ID` char(20) NOT NULL COMMENT 'TASK ID',
  `USER_NO` int(11) NOT NULL COMMENT 'USER NO',
  `TASK_CNT_TYP` char(2) DEFAULT NULL COMMENT 'CO업무연락 AP전자결재 SB자료공유 TA관련작업',
  `TASK_CNT_SJ` varchar(500) DEFAULT NULL,
  `LINK_URL` varchar(1000) DEFAULT NULL,
  `TASK_CNT_REG_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`TASK_ID`),
  KEY `NewIndex2` (`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=450 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_task_history` (
  `HISTORY_NO` int(20) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `TASK_ID` char(20) DEFAULT NULL COMMENT 'TASK ID',
  `WRITER_NO` int(10) DEFAULT NULL COMMENT '등록자',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록일',
  `HISTORY_STAT` varchar(20) DEFAULT NULL COMMENT '진행내역',
  `HISTORY_CN` text DEFAULT NULL COMMENT '변경 내용',
  PRIMARY KEY (`HISTORY_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=79377 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_userinfo` (
  `NO` int(20) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `USER_ID` varchar(20) NOT NULL COMMENT 'ID',
  `USER_NM` varchar(60) NOT NULL COMMENT 'Name',
  `USER_ENM` varchar(60) DEFAULT NULL COMMENT 'English Name',
  `PASSWORD` varchar(100) NOT NULL COMMENT 'PW',
  `SABUN` char(4) DEFAULT NULL COMMENT '사번',
  `IHIDNUM` char(13) DEFAULT NULL COMMENT '주민번호',
  `SEXDSTN_CODE` char(1) DEFAULT NULL COMMENT '성별 - 미사용',
  `BRTH` char(8) DEFAULT NULL COMMENT '생일',
  `GRE_LUN` char(1) DEFAULT 'G' COMMENT 'G 양력(그레고리안) L 음력(루나)',
  `HOME_ADRES` varchar(100) DEFAULT NULL COMMENT '주소',
  `MOBLPHON_NO` varchar(30) DEFAULT NULL COMMENT '이동전화',
  `HOME_TELNO` varchar(30) DEFAULT NULL COMMENT '집전화',
  `OFFM_ID` varchar(20) DEFAULT NULL COMMENT '사무실번호 - 미사용',
  `OFFM_TELNO` varchar(15) DEFAULT NULL COMMENT '사무실전화번호',
  `OFFM_TELNO_INNER` varchar(15) DEFAULT NULL COMMENT '내선번호',
  `EMAIL_ADRES` varchar(50) DEFAULT NULL COMMENT '회사메일',
  `EMAIL_ADRES2` varchar(50) DEFAULT NULL COMMENT '외부메일',
  `EXP_COMP_ID` varchar(20) DEFAULT NULL COMMENT '지출결의회사',
  `COMPNY_ID` varchar(20) DEFAULT NULL COMMENT '소속회사',
  `ORGNZT_ID` char(20) DEFAULT NULL COMMENT '소속조직',
  `RANK_ID` char(20) DEFAULT NULL COMMENT '직급',
  `POSITION` char(1) DEFAULT 'N' COMMENT '보직 // H:부서장 S:부서장대행 N:일반',
  `COMPIN_DT` varchar(8) DEFAULT NULL COMMENT '입사일',
  `COMPOT_DT` varchar(8) DEFAULT NULL COMMENT '퇴사일',
  `WORK_ST` char(1) DEFAULT 'W' COMMENT 'W:근무 L:휴직 R:퇴직',
  `CAR_ID` varchar(20) DEFAULT NULL COMMENT '소유차량 등록번호',
  `CAR_LIC_TYP` varchar(10) DEFAULT NULL COMMENT 'A:1종대형 B:1종보통 C:2종자동',
  `ABUTME` text DEFAULT NULL COMMENT '자기소개',
  `PIC_FILE_ID` char(20) DEFAULT NULL COMMENT '소개사진',
  `PIC_FILE_ID2` char(20) DEFAULT NULL COMMENT '증명사진',
  `ADMIN_NOTE` text DEFAULT NULL COMMENT '비고란',
  `GHOST` tinyint(1) NOT NULL DEFAULT 0 COMMENT '고스트 속성',
  `SHOW_RIGHT` tinyint(1) DEFAULT 1 COMMENT '우측메뉴 보임/숨김',
  `DAY_REPORT_TYP` char(1) DEFAULT NULL COMMENT 'B(rief), D(etail)',
  `MOBILE_PUSH_CHK` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL COMMENT '모바일에서 전송하는 PUSH 전송 여부 FLAG',
  `MAC_ADDR` varchar(100) DEFAULT NULL COMMENT '맥어드레스',
  `DEVICE_TYPE` varchar(100) DEFAULT NULL COMMENT '모바일 기기 타입',
  `TOKEN_INFO` varchar(1000) DEFAULT NULL COMMENT '토큰정보',
  `APP_VERSION` varchar(10) DEFAULT NULL COMMENT '앱버전정보',
  `INITIAL` varchar(10) DEFAULT NULL COMMENT '초성검색',
  `CAR_OWN` char(1) DEFAULT 'N' COMMENT 'Y-소유 N-비소유',
  `RECOMMENDER` varchar(60) DEFAULT NULL COMMENT '입사추천 사원이름',
  `DEGREE` char(2) DEFAULT '06' COMMENT '학위코드 - SELECT * FROM COMTCCMMNDETAILCODE WHERE CODE_ID = ''KMS033'';',
  `PROMOTION_YEAR` int(4) DEFAULT 0 COMMENT '진급년도',
  `CAREER_MONTH` int(4) DEFAULT 0 COMMENT '입사시 인정경력 개월수로 입력',
  `DAY_REPORT_SMS` char(1) DEFAULT 'Y' COMMENT '일일업무보고 0시간 SMS 발송',
  `EMAIL_LINK` varchar(50) DEFAULT NULL COMMENT '상단 이메일 링크 도메인',
  `ACCEPT_COMPIN_DT` varchar(8) DEFAULT NULL COMMENT '인정입사일',
  `ORGNZT_ID_SEC` char(20) DEFAULT NULL COMMENT '겸직조직',
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`RANK_ID`),
  KEY `NewIndex2` (`ORGNZT_ID`),
  KEY `NewIndex3` (`OFFM_ID`),
  KEY `NewIndex4` (`PIC_FILE_ID`),
  KEY `NewIndex5` (`PIC_FILE_ID2`)
) ENGINE=InnoDB AUTO_INCREMENT=595 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `tbl_userinfo` (`NO`, `USER_ID`, `USER_NM`, `USER_ENM`, `PASSWORD`, `SABUN`, `IHIDNUM`, `SEXDSTN_CODE`, `BRTH`, `GRE_LUN`, `HOME_ADRES`, `MOBLPHON_NO`, `HOME_TELNO`, `OFFM_ID`, `OFFM_TELNO`, `OFFM_TELNO_INNER`, `EMAIL_ADRES`, `EMAIL_ADRES2`, `EXP_COMP_ID`, `COMPNY_ID`, `ORGNZT_ID`, `RANK_ID`, `POSITION`, `COMPIN_DT`, `COMPOT_DT`, `WORK_ST`, `CAR_ID`, `CAR_LIC_TYP`, `ABUTME`, `PIC_FILE_ID`, `PIC_FILE_ID2`, `ADMIN_NOTE`, `GHOST`, `SHOW_RIGHT`, `DAY_REPORT_TYP`, `MOBILE_PUSH_CHK`, `MAC_ADDR`, `DEVICE_TYPE`, `TOKEN_INFO`, `APP_VERSION`, `INITIAL`, `CAR_OWN`, `RECOMMENDER`, `DEGREE`, `PROMOTION_YEAR`, `CAREER_MONTH`, `DAY_REPORT_SMS`, `EMAIL_LINK`, `ACCEPT_COMPIN_DT`, `ORGNZT_ID_SEC`) VALUES
	(1, 'admin', '운영자', 'admin', '1', NULL, NULL, NULL, '', 'G', '', '', '', '', '', '', '', '', NULL, NULL, 'ORGAN_TOP_ORGAN_CODE', NULL, 'N', NULL, NULL, 'W', '', '', '', NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', NULL, '06', 0, 0, 'Y', '', NULL, NULL);

CREATE TABLE IF NOT EXISTS `tbl_userinfo_insa` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `FILE_TYP` varchar(50) DEFAULT NULL,
  `ATCH_FILE_ID` char(20) DEFAULT NULL,
  `NOTE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`),
  KEY `NewIndex2` (`ATCH_FILE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_userinfo_military` (
  `NO` int(20) NOT NULL AUTO_INCREMENT,
  `USER_NM` varchar(60) NOT NULL,
  `DUTYIN_DT` varchar(8) DEFAULT NULL COMMENT '편입일자',
  `DUTYOT_DT` varchar(8) DEFAULT NULL COMMENT '소집해제일자',
  `BODY_GRADE` char(1) DEFAULT '1' COMMENT '신체등위 1-4급',
  `DUTY_TYPE` char(1) DEFAULT '1' COMMENT '역종 : 1 - 현역 2- 보충역',
  `HIRED` char(1) DEFAULT '1' COMMENT '채용 : 1 - 신규편입 2 - 전직',
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=802 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_userinfo_msn` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NO` int(11) NOT NULL,
  `MSN_TYP` varchar(20) DEFAULT NULL,
  `MSN_ADRES` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`NO`),
  KEY `NewIndex1` (`USER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_user_auth` (
  `USER_NO` int(11) NOT NULL,
  `AUTH_CODE` varchar(20) NOT NULL,
  `REG_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`USER_NO`,`AUTH_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `tbl_user_auth` (`USER_NO`, `AUTH_CODE`, `REG_DT`) VALUES
	(1, 'admin', '2023-11-21 15:06:46');

CREATE TABLE IF NOT EXISTS `tbl_user_eva` (
  `USER_NO` int(20) NOT NULL,
  `YEAR` char(4) NOT NULL,
  `GRADE` varchar(5) DEFAULT NULL COMMENT '총등급',
  `EVA1` int(20) DEFAULT NULL COMMENT '1차 평가자 번호',
  `SCORE1` varchar(5) DEFAULT NULL COMMENT '1차 평가점수',
  `EVA2` int(20) DEFAULT NULL COMMENT '2차 평가자 번호',
  `SCORE2` varchar(5) DEFAULT NULL COMMENT '2차 평가점수',
  `EVA3` int(20) DEFAULT NULL COMMENT '3차 평가자 번호',
  `SCORE3` varchar(5) DEFAULT '10' COMMENT '3차 평가점수',
  `EXP_COMP_ID` varchar(20) DEFAULT NULL COMMENT '지출결의회사',
  `COMPNY_ID` varchar(20) DEFAULT NULL COMMENT '평가당시 소속회사',
  `ORGNZT_ID` char(20) DEFAULT NULL COMMENT '평가당시 부서',
  `RANK_ID` char(20) DEFAULT NULL COMMENT '평가당시 직급',
  `POSITION` char(1) DEFAULT 'N' COMMENT '평가당시 보직 // H:부서장 S:부서장대행 N:일반',
  `WORK_ST` char(1) DEFAULT 'W' COMMENT '평가당시 근태 W:근무 L:휴직 R:퇴직',
  `DEGREE` char(2) DEFAULT '06' COMMENT '평가당시 학위코드 - SELECT * FROM COMTCCMMNDETAILCODE WHERE CODE_ID = ''KMS033'';',
  `PROMOTION_YEAR` varchar(4) DEFAULT NULL COMMENT '평가당시 직급 진급년도',
  `CAREER_LENGTH` varchar(4) DEFAULT NULL COMMENT '평가당시 경력',
  `SCORE_SELF` varchar(4) DEFAULT NULL COMMENT '임시자기평가 항목',
  PRIMARY KEY (`USER_NO`,`YEAR`),
  KEY `NewIndex1` (`RANK_ID`),
  KEY `NewIndex2` (`ORGNZT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_user_hol_salary` (
  `USER_NO` int(11) DEFAULT NULL,
  `YEAR` int(4) DEFAULT NULL,
  `MONTH` int(2) DEFAULT NULL,
  `SALARY` int(11) DEFAULT NULL,
  KEY `NewIndex1` (`USER_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_user_salary` (
  `USER_NO` varchar(20) NOT NULL COMMENT '이 테이블은 연봉 아니고 인건비이다. Not salary, labor cost',
  `YEAR` int(11) NOT NULL,
  `MONTH` int(11) NOT NULL,
  `SALARY1` bigint(11) DEFAULT 0 COMMENT '기본 인건비. 2번 인건비 숫자가 NULL이나 0인 경우 1번 숫자로 집계. 2번 숫자가 있어도 종합매출보고서 등 jQuery ajax 계산에서는 1번만 사용',
  `SALARY2` bigint(11) DEFAULT 0 COMMENT '입사 퇴사 휴직 복직 등의 이슈로 인건비 조정이 필요한 경우에 사용. 0이나 NULL 이 아닌경우 집계에서 2번 숫자를 사용함',
  `SALARY3` bigint(11) DEFAULT 0,
  `YM` char(6) NOT NULL,
  PRIMARY KEY (`USER_NO`,`YEAR`,`MONTH`),
  KEY `MONTH` (`MONTH`),
  KEY `YEAR` (`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_user_salary_real` (
  `USER_NO` varchar(20) NOT NULL,
  `YEAR` int(11) NOT NULL,
  `SALARY_REAL` bigint(11) DEFAULT NULL COMMENT '실제연봉',
  `SALARY_HOPE` bigint(11) DEFAULT NULL COMMENT '희망연봉',
  `SALARY_SUGGEST` bigint(11) DEFAULT NULL COMMENT '제안연봉',
  `ACCEPT` char(1) DEFAULT 'U' COMMENT '동의상태 Y - 동의 N - 거절 S - 조회 U - 비조회',
  `CEO_CONFIRM` char(1) DEFAULT 'N' COMMENT '제안연봉 대표이사 확인여부',
  `CAR_COST` int(11) DEFAULT 200000 COMMENT '차량유지비',
  `MEAL_COST` int(11) DEFAULT 100000 COMMENT '식대',
  `BABY_COST` int(11) DEFAULT 0 COMMENT '보육수당',
  `COMMUNICATION_COST` int(11) DEFAULT 0 COMMENT '통신비',
  `STATUS` varchar(4) DEFAULT '1' COMMENT '상태코드 1 - 제시 2 - 동의 3 - 면담',
  `NOTE` text DEFAULT NULL COMMENT '특약사항(2013년부터 사장님 메모)',
  `HOPE_NOTE` text DEFAULT NULL COMMENT '사장님께 하고싶은 말',
  `ADMIN_NOTE` text DEFAULT NULL COMMENT '관리자(연봉담당자) 메모',
  PRIMARY KEY (`USER_NO`,`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `tbl_work_state` (
  `WS_ID` char(20) NOT NULL,
  `USER_NO` int(11) NOT NULL,
  `WRITER_NO` int(11) NOT NULL,
  `WS_TYP` char(1) DEFAULT NULL COMMENT '외근:O(work Outside) 출장:T(business Trip) 파견:S(Send) 연장근무:N(Night) 휴가:V(Vacation) 기타(주로 면제로 쓰임):E(Etc)',
  `WS_BGN_DE` char(8) DEFAULT NULL,
  `WS_END_DE` char(8) DEFAULT NULL,
  `WS_BGN_TM` char(2) DEFAULT NULL,
  `WS_END_TM` char(2) DEFAULT NULL,
  `WS_HR_CNT` int(11) DEFAULT NULL,
  `USER_TELNO` varchar(30) DEFAULT NULL,
  `USER_MOBLPHON_NO` varchar(30) DEFAULT NULL,
  `WS_PLACE` varchar(100) DEFAULT NULL,
  `WS_PURPOSE` text DEFAULT NULL,
  `USE_AT` char(1) DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `UPDT_DT` datetime DEFAULT NULL,
  `USER_IP` char(15) DEFAULT NULL,
  `IS_INNER_NETWORK` char(1) DEFAULT NULL,
  `DOC_ID` varchar(20) DEFAULT 'N' COMMENT '휴가 문서번호 기본값 N = 해당없음 // 삭제시 PK로 사용하기 때문에 NULL 값은 전체 삭제 리스크가 있음',
  PRIMARY KEY (`WS_ID`),
  KEY `NewIndex1` (`USER_NO`),
  KEY `NewIndex2` (`WRITER_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


CREATE TABLE IF NOT EXISTS `test1` (
  `NO` int(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DELIMITER //
CREATE PROCEDURE `testApprDoc2`()
BEGIN
	DECLARE    tmp_no                        VARCHAR(30);  
	DECLARE m_Done INT DEFAULT 0;
	/* 여기에 커서를 정의 합니다. */
	DECLARE m_Cursor CURSOR FOR
	select no from tbl_userinfo where user_nm in('고양곤', 
'김규동', 
'김민균',  
'김상규', 
'김종완', 
'김현석', 
'나성재', 
'박태준', 
'서장열', 
'성재규', 
'오인탁', 
'이동호', 
'이유수', 
'이장영', 
'조남희', 
'최성화', 
'호철종', 
'황용하');
	  
	/* 데이터가 없으면 m_Done에 1 */
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET m_Done=1;
	OPEN m_Cursor;
	/* 반복합니다. */ 
	REPEAT
		 /* 반환된 filed_value을 변수에 담습니다. */
		FETCH NEXT FROM m_Cursor INTO 
			tmp_no;    
		IF NOT m_Done THEN
		   /* 수행할 쿼리리 여기에 작성합니다. */  
			INSERT INTO TBL_EAPP_DOC( 
			 `DOC_ID` 
			 , `PARNT_ID` 
			 , `WRITER_NO` 
			 , `SUBJECT` 
			 , `CONTENT` 
			 , `DOC_DT` 
			 , `PRE_APP_DT` 
			 , `DOC_STAT` 
			 , `NEW_AT`
			 , `CNT` 
			 , `RE_USE_CNT` 
			 , `HANDLE_STAT` 
			 , `ATCH_FILE_ID` 
			 , `TEMPLT_ID` 
			 , `RE_WRITE_TYP` 
			 , `PRJ_ID_DOC`
		
			)
			VALUES	(
			concat('APP_00000000000' ,(replace((select max(a.doc_id) from tbl_eapp_doc a),'APP_','')+1))
			,	concat('APP_00000000000' ,(replace((select max(b.doc_id) from tbl_eapp_doc b),'APP_','')+1))
			,tmp_no 
			,'2019년 5/23(목)~5/24(금) 일괄휴가처리 문서-해외워크샵'
			,'2019년 5/23(목)~5/24(금) 일괄휴가처리 문서-해외워크샵'
			,SYSDATE()
			,SYSDATE()
			,'APP004'
			,1
			,0
			,0
			,0
			,''
			,2
			,0
			,null
			
			);
			
			INSERT INTO TBL_EAPP_VAC 
			( DOC_ID
			  , VAC_TYP
			  , ST_DT
			  , ED_DT
			  , ST_AMPM
			  , ED_AMPM
			  , SUM_DATE
			  , SYSTEM
			  , WS_PLACE
			  , EAPP_WRITER_NO )
		VALUES ( 
			(select max(c.doc_id) from tbl_eapp_doc c)
			  , 1
			  , '20190523'
			  , '20190524'
			  , 1
			  , 2
			  , 2
			  , 1
			  , null
			  , tmp_no );
			  
		INSERT INTO TBL_WORK_STATE
			(
				WS_ID, USER_NO, WRITER_NO, WS_TYP, WS_BGN_DE, WS_END_DE, WS_BGN_TM, WS_END_TM,
				USER_TELNO, USER_MOBLPHON_NO, WS_PLACE, WS_PURPOSE, USE_AT, WS_HR_CNT, REG_DT
				, USER_IP, IS_INNER_NETWORK, DOC_ID
			) VALUES (
			concat('WS_000000000000' ,(replace((select max(a.ws_id) from tbl_WORK_STATE a),'WS_','')+1)), tmp_no, tmp_no, 'V', '20190523', '20190524', null, null,
				(select ifnull(HOME_TELNO,'') from tbl_userinfo where no = tmp_no ), (select MOBLPHON_NO from tbl_userinfo where no = tmp_no ), null, '2019년 5/23(목)~5/24(금) 일괄휴가처리 문서-해외워크샵', 'Y', null, SYSDATE()
				, null, null, (select max(d.doc_id) from tbl_eapp_doc d)
			);				  
		    
		   
		END IF;
	/* m_Done이 1이 될때까지 반복 합니다. */
	UNTIL m_Done END REPEAT;
	CLOSE m_Cursor;
    END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `testproc`()
BEGIN
	DECLARE I_ATTEND_NO INT;
    DECLARE I_USER_NO INT;
	DECLARE I_ATTEND_DT VARCHAR(8);
    DECLARE I_ATTEND_TM VARCHAR(10);
    DECLARE I_ATTEND_IP VARCHAR(20); 
    
    SELECT 	NO, 
           	USER_NO,
           	ATTEND_DT 
    INTO 	I_ATTEND_NO, 
           	I_USER_NO, 
           	I_ATTEND_DT 
	FROM 	TBL_ATTEND_CHECK 
    WHERE 	ATTEND_DT > '20120715' 
    AND 	!(	ATTEND_IP LIKE '172.16.30%' 
             OR ATTEND_IP LIKE '172.16.31%' 
             OR ATTEND_IP LIKE '172.16.32%' 
             OR ATTEND_IP LIKE '172.16.33%' 
             OR ATTEND_IP LIKE '172.16.34%' 
             OR ATTEND_IP LIKE '175.198.119%' 
             OR ATTEND_IP LIKE '222.112.151%' 
             OR ATTEND_IP LIKE '222.112.235%') 
  	ORDER BY NO
    LIMIT 	0, 1;
                 
    SELECT 	CASE WHEN COUNT(USER_NO) = 0 THEN NULL ELSE DATE_FORMAT(TM, '%H:%i:%s') END,
    		CASE WHEN COUNT(USER_NO) = 0 THEN NULL ELSE IP END
    INTO	I_ATTEND_TM,
    		I_ATTEND_IP
    FROM 	(SELECT * FROM TBL_LOGIN_LOG ORDER BY NO) A 
    WHERE 	USER_NO = I_USER_NO
    AND 	DATE_FORMAT(TM, '%Y%m%d') = I_ATTEND_DT
    AND 	(	IP LIKE '172.16.30%' 
             OR IP LIKE '172.16.31%' 
             OR IP LIKE '172.16.32%' 
             OR IP LIKE '172.16.33%' 
             OR IP LIKE '172.16.34%' 
             OR IP LIKE '175.198.119%' 
             OR IP LIKE '222.112.151%' 
             OR IP LIKE '222.112.235%');
             
    UPDATE	TBL_ATTEND_CHECK
    SET		ATTEND_TM = I_ATTEND_TM,
            ATTEND_IP = I_ATTEND_IP,
            ATTEND_CD = ''
    WHERE	NO = I_ATTEND_NO;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `TEST_PRC`(_TEMPLT_ID INT)
BEGIN
	SET @CCC = _TEMPLT_ID;
	SET @AAA = 'Y';
	SET @BBB = 'TEMP01';
   SET @sql = CONCAT('SELECT CODE_NM FROM COMTCCMMNDETAILCODE WHERE USE_AT = ? AND CODE_ID = ? AND CODE = ?');
   PREPARE s1 FROM @sql;
   EXECUTE s1 USING @AAA,@BBB, @CCC;
   
   SET @ttt = s1.CODE_NM;
   SET @SQL2 = 'SELECT * FROM ?';
   PREPARE s2 FROM @SQL2;
   EXECUTE s2 USING @ttt;
   DEALLOCATE PREPARE s2;
END//
DELIMITER ;

CREATE TABLE `v_eapp_exp` (
	`EXP_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`DOC_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`PRESET_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`EXP_SPEND_TYP` VARCHAR(2) NULL COLLATE 'utf8mb3_general_ci',
	`PAYING_DUE_DATE` VARCHAR(8) NULL COLLATE 'utf8mb3_general_ci',
	`ACC_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`EXP_DT` VARCHAR(8) NULL COLLATE 'utf8mb3_general_ci',
	`EXP_SPEND` BIGINT(20) NULL,
	`PRJ_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`COMPANY_CD` VARCHAR(10) NULL COLLATE 'utf8mb3_general_ci',
	`EXP_CT` MEDIUMTEXT NULL COLLATE 'utf8mb3_general_ci',
	`CARD_SPEND_NO` INT(11) NULL,
	`COLUMN1` VARCHAR(500) NULL COLLATE 'utf8mb3_general_ci',
	`COLUMN2` VARCHAR(500) NULL COLLATE 'utf8mb3_general_ci',
	`BUDGET_PRJ` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci'
) ENGINE=MyISAM;

CREATE TABLE `v_eapp_exp_card` (
	`CARD_SPEND_NO` INT(11) NULL,
	`DOC_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`DOC_STAT` VARCHAR(10) NULL COMMENT 'APP000 기안대기(저장문서) APP001 검토중 APP002 협조중 APP003 전결중 APP004 참조중 APP005 완료 else(APP099) 결재실패' COLLATE 'utf8mb3_general_ci',
	`NEW_AT` CHAR(1) NULL COMMENT '유효성 : 0 - 무효 1 - 유효' COLLATE 'utf8mb3_general_ci'
) ENGINE=MyISAM;

CREATE TABLE `v_org_head_bak` (
	`ORGNZT_ID` CHAR(20) NOT NULL COLLATE 'utf8mb3_general_ci',
	`ORGNZT_NM` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
	`USER_NO` INT(20) NULL COMMENT 'PK',
	`USER_NM` VARCHAR(60) NULL COMMENT 'Name' COLLATE 'utf8mb3_general_ci',
	`USER_ID` VARCHAR(20) NULL COMMENT 'ID' COLLATE 'utf8mb3_general_ci',
	`POSITION` CHAR(1) NULL COMMENT '보직 // H:부서장 S:부서장대행 N:일반' COLLATE 'utf8mb3_general_ci'
) ENGINE=MyISAM;

CREATE TABLE `v_prj_tree` (
	`ID` VARCHAR(20) NOT NULL COLLATE 'utf8mb3_general_ci',
	`NM` VARCHAR(100) NULL COLLATE 'utf8mb3_general_ci',
	`PRNT` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`SN` VARCHAR(2000) NULL COLLATE 'utf8mb3_general_ci',
	`SN_ORD` VARCHAR(2000) NULL COLLATE 'utf8mb3_general_ci',
	`LV` BIGINT(11) NULL,
	`TYP` VARCHAR(3) NOT NULL COLLATE 'utf8mb4_general_ci',
	`ST_DT` VARCHAR(8) NULL COLLATE 'utf8mb3_general_ci',
	`COMP_DT` VARCHAR(8) NULL COLLATE 'utf8mb4_general_ci',
	`COMP_DUE_DT` VARCHAR(8) NULL COLLATE 'utf8mb3_general_ci',
	`STAT` CHAR(1) NULL COLLATE 'utf8mb3_general_ci',
	`PRJ_TYPE` VARCHAR(1) NULL COLLATE 'utf8mb3_general_ci',
	`HAVING_LEAF` TINYINT(4) NULL
) ENGINE=MyISAM;

CREATE TABLE `v_prj_tree2` (
	`ID` VARCHAR(20) NOT NULL COLLATE 'utf8mb3_general_ci',
	`NM` VARCHAR(100) NULL COLLATE 'utf8mb3_general_ci',
	`PRNT` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`SN` VARCHAR(2000) NULL COLLATE 'utf8mb3_general_ci',
	`SN_ORD` VARCHAR(2000) NULL COLLATE 'utf8mb3_general_ci',
	`LV` BIGINT(11) NULL,
	`TYP` VARCHAR(3) NOT NULL COLLATE 'utf8mb4_general_ci',
	`ST_DT` VARCHAR(8) NULL COLLATE 'utf8mb3_general_ci',
	`COMP_DT` VARCHAR(8) NULL COLLATE 'utf8mb4_general_ci',
	`COMP_DUE_DT` VARCHAR(8) NULL COLLATE 'utf8mb3_general_ci',
	`PRNTCNT` BIGINT(21) NULL
) ENGINE=MyISAM;

CREATE TABLE `v_purchase_in` (
	`PURCHASE_IN_NO` INT(11) NOT NULL,
	`DOC_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`PURCHASE_PRJ_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`SALES_PRJ_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`TYP` VARCHAR(10) NULL COLLATE 'utf8mb3_general_ci',
	`PURCHASE_IN_DT` INT(11) NULL,
	`COST` BIGINT(20) NULL,
	`PURCHASE_IN_CT` MEDIUMTEXT NULL COLLATE 'utf8mb3_general_ci',
	`DECIDE_YN` CHAR(1) NULL COLLATE 'utf8mb3_general_ci',
	`IDENTIFY_NO` INT(11) NULL
) ENGINE=MyISAM;

CREATE TABLE `v_purchase_in_bak` (
	`PURCHASE_IN_NO` INT(11) NOT NULL,
	`DOC_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`PURCHASE_PRJ_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`SALES_PRJ_ID` VARCHAR(20) NULL COLLATE 'utf8mb3_general_ci',
	`TYP` VARCHAR(10) NULL COLLATE 'utf8mb3_general_ci',
	`PURCHASE_IN_DT` INT(11) NULL,
	`COST` DOUBLE(24,4) NULL,
	`PURCHASE_IN_CT` MEDIUMTEXT NULL COLLATE 'utf8mb3_general_ci',
	`DECIDE_YN` CHAR(1) NULL COLLATE 'utf8mb3_general_ci',
	`IDENTIFY_NO` INT(11) NULL
) ENGINE=MyISAM;

CREATE TABLE `v_userinfo_bak` (
	`NO` INT(20) NOT NULL COMMENT 'PK',
	`USER_ID` VARCHAR(20) NOT NULL COMMENT 'ID' COLLATE 'utf8mb3_general_ci',
	`USER_NM` VARCHAR(60) NOT NULL COMMENT 'Name' COLLATE 'utf8mb3_general_ci',
	`USER_ENM` VARCHAR(60) NULL COMMENT 'English Name' COLLATE 'utf8mb3_general_ci',
	`PASSWORD` VARCHAR(100) NOT NULL COMMENT 'PW' COLLATE 'utf8mb3_general_ci',
	`SABUN` CHAR(4) NULL COMMENT '사번' COLLATE 'utf8mb3_general_ci',
	`IHIDNUM` CHAR(13) NULL COMMENT '주민번호' COLLATE 'utf8mb3_general_ci',
	`SEXDSTN_CODE` CHAR(1) NULL COMMENT '성별 - 미사용' COLLATE 'utf8mb3_general_ci',
	`BRTH` CHAR(8) NULL COMMENT '생일' COLLATE 'utf8mb3_general_ci',
	`GRE_LUN` CHAR(1) NULL COMMENT 'G 양력(그레고리안) L 음력(루나)' COLLATE 'utf8mb3_general_ci',
	`HOME_ADRES` VARCHAR(100) NULL COMMENT '주소' COLLATE 'utf8mb3_general_ci',
	`MOBLPHON_NO` VARCHAR(30) NULL COMMENT '이동전화' COLLATE 'utf8mb3_general_ci',
	`HOME_TELNO` VARCHAR(30) NULL COMMENT '집전화' COLLATE 'utf8mb3_general_ci',
	`OFFM_ID` VARCHAR(20) NULL COMMENT '사무실번호 - 미사용' COLLATE 'utf8mb3_general_ci',
	`OFFM_TELNO` VARCHAR(15) NULL COMMENT '사무실전화번호' COLLATE 'utf8mb3_general_ci',
	`OFFM_TELNO_INNER` VARCHAR(15) NULL COMMENT '내선번호' COLLATE 'utf8mb3_general_ci',
	`EMAIL_ADRES` VARCHAR(50) NULL COMMENT '회사메일' COLLATE 'utf8mb3_general_ci',
	`EMAIL_ADRES2` VARCHAR(50) NULL COMMENT '외부메일' COLLATE 'utf8mb3_general_ci',
	`EXP_COMP_ID` VARCHAR(20) NULL COMMENT '지출결의회사' COLLATE 'utf8mb3_general_ci',
	`COMPNY_ID` VARCHAR(20) NULL COMMENT '소속회사' COLLATE 'utf8mb3_general_ci',
	`ORGNZT_ID` CHAR(20) NULL COMMENT '소속조직' COLLATE 'utf8mb3_general_ci',
	`RANK_ID` CHAR(20) NULL COMMENT '직급' COLLATE 'utf8mb3_general_ci',
	`POSITION` CHAR(1) NULL COMMENT '보직 // H:부서장 S:부서장대행 N:일반' COLLATE 'utf8mb3_general_ci',
	`COMPIN_DT` VARCHAR(8) NULL COMMENT '입사일' COLLATE 'utf8mb3_general_ci',
	`COMPOT_DT` VARCHAR(8) NULL COMMENT '퇴사일' COLLATE 'utf8mb3_general_ci',
	`WORK_ST` CHAR(1) NULL COMMENT 'W:근무 L:휴직 R:퇴직' COLLATE 'utf8mb3_general_ci',
	`CAR_ID` VARCHAR(20) NULL COMMENT '소유차량 등록번호' COLLATE 'utf8mb3_general_ci',
	`CAR_LIC_TYP` VARCHAR(10) NULL COMMENT 'A:1종대형 B:1종보통 C:2종자동' COLLATE 'utf8mb3_general_ci',
	`ABUTME` TEXT NULL COMMENT '자기소개' COLLATE 'utf8mb3_general_ci',
	`PIC_FILE_ID` CHAR(20) NULL COMMENT '소개사진' COLLATE 'utf8mb3_general_ci',
	`PIC_FILE_ID2` CHAR(20) NULL COMMENT '증명사진' COLLATE 'utf8mb3_general_ci',
	`ADMIN_NOTE` TEXT NULL COMMENT '비고란' COLLATE 'utf8mb3_general_ci',
	`GHOST` TINYINT(1) NOT NULL COMMENT '고스트 속성',
	`SHOW_RIGHT` TINYINT(1) NULL COMMENT '우측메뉴 보임/숨김',
	`DAY_REPORT_TYP` CHAR(1) NULL COMMENT 'B(rief), D(etail)' COLLATE 'utf8mb3_general_ci'
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `v_eapp_exp`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_eapp_exp` AS select `tbl_eapp_exp`.`EXP_ID` AS `EXP_ID`,`tbl_eapp_exp`.`DOC_ID` AS `DOC_ID`,`tbl_eapp_exp`.`PRESET_ID` AS `PRESET_ID`,`tbl_eapp_exp`.`EXP_SPEND_TYP` AS `EXP_SPEND_TYP`,`tbl_eapp_exp`.`PAYING_DUE_DATE` AS `PAYING_DUE_DATE`,`tbl_eapp_exp`.`ACC_ID` AS `ACC_ID`,`tbl_eapp_exp`.`EXP_DT` AS `EXP_DT`,`tbl_eapp_exp`.`exp_spend` AS `EXP_SPEND`,`tbl_eapp_exp`.`PRJ_ID` AS `PRJ_ID`,`tbl_eapp_exp`.`COMPANY_CD` AS `COMPANY_CD`,`tbl_eapp_exp`.`EXP_CT` AS `EXP_CT`,`tbl_eapp_exp`.`CARD_SPEND_NO` AS `CARD_SPEND_NO`,`tbl_eapp_exp`.`COLUMN1` AS `COLUMN1`,`tbl_eapp_exp`.`COLUMN2` AS `COLUMN2`,`tbl_eapp_exp`.`BUDGET_PRJ` AS `BUDGET_PRJ` from `tbl_eapp_exp` union all select lpad(`a`.`HOL_NO`,20,'0') AS `EXP_ID`,`a`.`DOC_ID` AS `DOC_ID`,NULL AS `PRESET_ID`,'HW' AS `EXP_SPEND_TYP`,NULL AS `PAYING_DUE_DATE`,'HOLIDAY_WORK_ACCOUNT' AS `ACC_ID`,`a`.`ST_DT` AS `EXP_DT`,`a`.`COST` AS `EXP_SPEND`,`a`.`PRJ_ID` AS `PRJ_ID`,'' AS `COMPANY_CD`,`b`.`CONTENT` AS `EXP_CT`,NULL AS `CARD_SPEND_NO`,NULL AS `COLUMN1`,NULL AS `COLUMN2`,NULL AS `BUDGET_PRJ` from (`tbl_eapp_hol` `a` join `tbl_eapp_doc` `b` on((`a`.`DOC_ID` = `b`.`DOC_ID`))) ;

DROP TABLE IF EXISTS `v_eapp_exp_card`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_eapp_exp_card` AS select `h`.`CARD_SPEND_NO` AS `CARD_SPEND_NO`,`h`.`DOC_ID` AS `DOC_ID`,`i`.`DOC_STAT` AS `DOC_STAT`,`i`.`NEW_AT` AS `NEW_AT` from (`tbl_eapp_exp` `h` join `tbl_eapp_doc` `i` on(((`h`.`DOC_ID` = `i`.`DOC_ID`) and (`i`.`DOC_STAT` not in ('APP000','APP099'))))) where (`h`.`CARD_SPEND_NO` is not null) ;

DROP TABLE IF EXISTS `v_org_head_bak`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_org_head_bak` AS select `org`.`ORGNZT_ID` AS `ORGNZT_ID`,`org`.`ORGNZT_NM` AS `ORGNZT_NM`,`usr`.`NO` AS `USER_NO`,`usr`.`USER_NM` AS `USER_NM`,`usr`.`USER_ID` AS `USER_ID`,`usr`.`POSITION` AS `POSITION` from (`tbl_orgnzt` `org` left join `tbl_userinfo` `usr` on(((`org`.`ORGNZT_ID` = `usr`.`ORGNZT_ID`) and (`usr`.`POSITION` in ('H','S'))))) ;

DROP TABLE IF EXISTS `v_prj_tree`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_prj_tree` AS select `tbl_prj`.`PRJ_ID` AS `ID`,`tbl_prj`.`PRJ_NM` AS `NM`,if((`tbl_prj`.`PRNT_PRJ_ID` = `tbl_prj`.`PRJ_ID`),`tbl_prj`.`ORGNZT_ID`,`tbl_prj`.`PRNT_PRJ_ID`) AS `PRNT`,`tbl_prj`.`ORG_PRJ_TREE` AS `SN`,`tbl_prj`.`ORG_PRJ_TREE_ORD` AS `SN_ORD`,(char_length(`tbl_prj`.`ORG_PRJ_TREE`) - char_length(replace(`tbl_prj`.`ORG_PRJ_TREE`,'/',''))) AS `LV`,'PRJ' AS `TYP`,`tbl_prj`.`ST_DT` AS `ST_DT`,date_format(`tbl_prj`.`COMP_DT`,'%Y%m%d') AS `COMP_DT`,`tbl_prj`.`COMP_DUE_DT` AS `COMP_DUE_DT`,`tbl_prj`.`STAT` AS `STAT`,`tbl_prj`.`PRJ_TYPE` AS `PRJ_TYPE`,`tbl_prj`.`HAVING_LEAF` AS `HAVING_LEAF` from `tbl_prj` union all select `tbl_orgnzt`.`ORGNZT_ID` AS `ID`,`tbl_orgnzt`.`ORGNZT_NM` AS `NM`,if((`tbl_orgnzt`.`ORG_UP` = `tbl_orgnzt`.`ORGNZT_ID`),'',`tbl_orgnzt`.`ORG_UP`) AS `PRNT`,`tbl_orgnzt`.`ORG_TREE` AS `SN`,`tbl_orgnzt`.`ORG_TREE_ORD` AS `SN_ORD`,(char_length(`tbl_orgnzt`.`ORG_TREE`) - char_length(replace(`tbl_orgnzt`.`ORG_TREE`,'/',''))) AS `LV`,'ORG' AS `TYP`,'19990101' AS `ST_DT`,'29991231' AS `COMP_DT`,'39991231' AS `COMP_DUE_DT`,`tbl_orgnzt`.`USE_YN` AS `STAT`,'O' AS `PRJ_TYPE`,`tbl_orgnzt`.`HAVING_LEAF` AS `HAVING_LEAF` from `tbl_orgnzt` where (`tbl_orgnzt`.`USE_YN` = 'Y') order by `SN` ;

DROP TABLE IF EXISTS `v_prj_tree2`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_prj_tree2` AS select `t`.`PRJ_ID` AS `ID`,`t`.`PRJ_NM` AS `NM`,if((`t`.`PRNT_PRJ_ID` = `t`.`PRJ_ID`),`t`.`ORGNZT_ID`,`t`.`PRNT_PRJ_ID`) AS `PRNT`,`t`.`ORG_PRJ_TREE` AS `SN`,`t`.`ORG_PRJ_TREE_ORD` AS `SN_ORD`,(char_length(`t`.`ORG_PRJ_TREE`) - char_length(replace(`t`.`ORG_PRJ_TREE`,'/',''))) AS `LV`,'PRJ' AS `TYP`,`t`.`ST_DT` AS `ST_DT`,date_format(`t`.`COMP_DT`,'%Y%m%d') AS `COMP_DT`,`t`.`COMP_DUE_DT` AS `COMP_DUE_DT`,(select count(`tbl_prj`.`PRJ_ID`) from `tbl_prj` where ((`tbl_prj`.`PRNT_PRJ_ID` = `t`.`PRJ_ID`) and (`tbl_prj`.`PRJ_ID` <> `tbl_prj`.`PRNT_PRJ_ID`))) AS `PRNTCNT` from `tbl_prj` `t` union all select `o`.`ORGNZT_ID` AS `ID`,`o`.`ORGNZT_NM` AS `NM`,if((`o`.`ORG_UP` = `o`.`ORGNZT_ID`),'',`o`.`ORG_UP`) AS `PRNT`,`o`.`ORG_TREE` AS `SN`,`o`.`ORG_TREE_ORD` AS `SN_ORD`,(char_length(`o`.`ORG_TREE`) - char_length(replace(`o`.`ORG_TREE`,'/',''))) AS `LV`,'ORG' AS `TYP`,'19990101' AS `ST_DT`,'29991231' AS `COMP_DT`,'39991231' AS `COMP_DUE_DT`,(select count(`tbl_orgnzt`.`ORGNZT_ID`) from `tbl_orgnzt` where ((`tbl_orgnzt`.`ORG_UP` = `o`.`ORGNZT_ID`) and (`tbl_orgnzt`.`ORGNZT_ID` <> `tbl_orgnzt`.`ORG_UP`))) AS `PRNTCNT` from `tbl_orgnzt` `o` where (`o`.`USE_YN` = 'Y') order by `SN` ;

DROP TABLE IF EXISTS `v_purchase_in`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_purchase_in` AS select `tbl_purchase_in`.`PURCHASE_IN_NO` AS `PURCHASE_IN_NO`,`tbl_purchase_in`.`DOC_ID` AS `DOC_ID`,`tbl_purchase_in`.`PURCHASE_PRJ_ID` AS `PURCHASE_PRJ_ID`,`tbl_purchase_in`.`SALES_PRJ_ID` AS `SALES_PRJ_ID`,`tbl_purchase_in`.`TYP` AS `TYP`,`tbl_purchase_in`.`PURCHASE_IN_DT` AS `PURCHASE_IN_DT`,`tbl_purchase_in`.`COST` AS `COST`,`tbl_purchase_in`.`PURCHASE_IN_CT` AS `PURCHASE_IN_CT`,`tbl_purchase_in`.`DECIDE_YN` AS `DECIDE_YN`,`tbl_purchase_in`.`IDENTIFY_NO` AS `IDENTIFY_NO` from `tbl_purchase_in` union all select `tbl_purchase_in_labor`.`PURCHASE_IN_NO` AS `PURCHASE_IN_NO`,`tbl_purchase_in_labor`.`DOC_ID` AS `DOC_ID`,`tbl_purchase_in_labor`.`PURCHASE_PRJ_ID` AS `PURCHASE_PRJ_ID`,`tbl_purchase_in_labor`.`SALES_PRJ_ID` AS `SALES_PRJ_ID`,'PL' AS `PL`,`tbl_purchase_in_labor`.`PURCHASE_IN_DT` AS `PURCHASE_IN_DT`,`tbl_purchase_in_labor`.`COST` AS `COST`,`tbl_purchase_in_labor`.`PURCHASE_IN_CT` AS `PURCHASE_IN_CT`,`tbl_purchase_in_labor`.`DECIDE_YN` AS `DECIDE_YN`,`tbl_purchase_in_labor`.`IDENTIFY_NO` AS `IDENTIFY_NO` from `tbl_purchase_in_labor` ;

DROP TABLE IF EXISTS `v_purchase_in_bak`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_purchase_in_bak` AS select `tbl_purchase_in`.`PURCHASE_IN_NO` AS `PURCHASE_IN_NO`,`tbl_purchase_in`.`DOC_ID` AS `DOC_ID`,`tbl_purchase_in`.`PURCHASE_PRJ_ID` AS `PURCHASE_PRJ_ID`,`tbl_purchase_in`.`SALES_PRJ_ID` AS `SALES_PRJ_ID`,`tbl_purchase_in`.`TYP` AS `TYP`,`tbl_purchase_in`.`PURCHASE_IN_DT` AS `PURCHASE_IN_DT`,`tbl_purchase_in`.`COST` AS `COST`,`tbl_purchase_in`.`PURCHASE_IN_CT` AS `PURCHASE_IN_CT`,`tbl_purchase_in`.`DECIDE_YN` AS `DECIDE_YN`,`tbl_purchase_in`.`IDENTIFY_NO` AS `IDENTIFY_NO` from `tbl_purchase_in` union all select `tbl_purchase_in_labor`.`PURCHASE_IN_NO` AS `PURCHASE_IN_NO`,`tbl_purchase_in_labor`.`DOC_ID` AS `DOC_ID`,`tbl_purchase_in_labor`.`PURCHASE_PRJ_ID` AS `PURCHASE_PRJ_ID`,`tbl_purchase_in_labor`.`SALES_PRJ_ID` AS `SALES_PRJ_ID`,'PL' AS `PL`,`tbl_purchase_in_labor`.`PURCHASE_IN_DT` AS `PURCHASE_IN_DT`,(`FN_GET_SALARY`(`tbl_purchase_in_labor`.`USER_NO`,year(`tbl_purchase_in_labor`.`PURCHASE_IN_DT`),month(`tbl_purchase_in_labor`.`PURCHASE_IN_DT`)) * `tbl_purchase_in_labor`.`RATIO`) AS `COST`,`tbl_purchase_in_labor`.`PURCHASE_IN_CT` AS `PURCHASE_IN_CT`,`tbl_purchase_in_labor`.`DECIDE_YN` AS `DECIDE_YN`,`tbl_purchase_in_labor`.`IDENTIFY_NO` AS `IDENTIFY_NO` from `tbl_purchase_in_labor` ;

DROP TABLE IF EXISTS `v_userinfo_bak`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_userinfo_bak` AS (select `tbl_userinfo`.`NO` AS `NO`,`tbl_userinfo`.`USER_ID` AS `USER_ID`,`tbl_userinfo`.`USER_NM` AS `USER_NM`,`tbl_userinfo`.`USER_ENM` AS `USER_ENM`,`tbl_userinfo`.`PASSWORD` AS `PASSWORD`,`tbl_userinfo`.`SABUN` AS `SABUN`,`tbl_userinfo`.`IHIDNUM` AS `IHIDNUM`,`tbl_userinfo`.`SEXDSTN_CODE` AS `SEXDSTN_CODE`,`tbl_userinfo`.`BRTH` AS `BRTH`,`tbl_userinfo`.`GRE_LUN` AS `GRE_LUN`,`tbl_userinfo`.`HOME_ADRES` AS `HOME_ADRES`,`tbl_userinfo`.`MOBLPHON_NO` AS `MOBLPHON_NO`,`tbl_userinfo`.`HOME_TELNO` AS `HOME_TELNO`,`tbl_userinfo`.`OFFM_ID` AS `OFFM_ID`,`tbl_userinfo`.`OFFM_TELNO` AS `OFFM_TELNO`,`tbl_userinfo`.`OFFM_TELNO_INNER` AS `OFFM_TELNO_INNER`,`tbl_userinfo`.`EMAIL_ADRES` AS `EMAIL_ADRES`,`tbl_userinfo`.`EMAIL_ADRES2` AS `EMAIL_ADRES2`,`tbl_userinfo`.`EXP_COMP_ID` AS `EXP_COMP_ID`,`tbl_userinfo`.`COMPNY_ID` AS `COMPNY_ID`,`tbl_userinfo`.`ORGNZT_ID` AS `ORGNZT_ID`,`tbl_userinfo`.`RANK_ID` AS `RANK_ID`,`tbl_userinfo`.`POSITION` AS `POSITION`,`tbl_userinfo`.`COMPIN_DT` AS `COMPIN_DT`,`tbl_userinfo`.`COMPOT_DT` AS `COMPOT_DT`,`tbl_userinfo`.`WORK_ST` AS `WORK_ST`,`tbl_userinfo`.`CAR_ID` AS `CAR_ID`,`tbl_userinfo`.`CAR_LIC_TYP` AS `CAR_LIC_TYP`,`tbl_userinfo`.`ABUTME` AS `ABUTME`,`tbl_userinfo`.`PIC_FILE_ID` AS `PIC_FILE_ID`,`tbl_userinfo`.`PIC_FILE_ID2` AS `PIC_FILE_ID2`,`tbl_userinfo`.`ADMIN_NOTE` AS `ADMIN_NOTE`,`tbl_userinfo`.`GHOST` AS `GHOST`,`tbl_userinfo`.`SHOW_RIGHT` AS `SHOW_RIGHT`,`tbl_userinfo`.`DAY_REPORT_TYP` AS `DAY_REPORT_TYP` from `tbl_userinfo` where (`tbl_userinfo`.`GHOST` = 0)) ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
