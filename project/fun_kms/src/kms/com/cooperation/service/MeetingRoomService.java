package kms.com.cooperation.service;

import java.util.List;

public interface MeetingRoomService {
	List<MeetingRoomVO> selectMeetingRoomList(MeetingRoomVO meetingRoomVO) throws Exception;
	int selectMeetingRoomListTotCnt(MeetingRoomVO meetingRoomVO) throws Exception;
	
	MeetingRoomVO selectMeetingRoom(MeetingRoomVO meetingRoomVO) throws Exception;
	List<MeetingRoomRecieve> selectMeetingRoomRecieve(MeetingRoomVO meetingRoomVO) throws Exception;
	
	String insertMeetingRoom(MeetingRoom meetingRoom, MeetingRoomRecieve meetingRoomRecieve) throws Exception;
	void updateMeetingRoom(MeetingRoom meetingRoom) throws Exception;
	void updateMeetingRoom(MeetingRoom meetingRoom, MeetingRoomRecieve meetingRoomRecieve) throws Exception;

	void insertMeetingRoomRecieve(MeetingRoomRecieve meetingRoomRecieve) throws Exception;
	void updateMeetingRoomRecieve(MeetingRoomRecieve meetingRoomRecieve) throws Exception;
	void deleteMeetingRoomRecieve(MeetingRoomRecieve meetingRoomRecieve) throws Exception;
	void changeMeetingRoomRecieve(MeetingRoomRecieve meetingRoomRecieve) throws Exception;
	void changeMeetingRoomWriter(MeetingRoomRecieve meetingRoomRecieve) throws Exception;	
	
	List<MeetingRoomComment> selectMeetingRoomCommentList(MeetingRoomComment meetingRoomComment) throws Exception;
	MeetingRoomComment selectMeetingRoomComment(MeetingRoomComment meetingRoomComment) throws Exception;
	void insertMeetingRoomComment(MeetingRoomComment meetingRoomComment) throws Exception;
	void updateMeetingRoomComment(MeetingRoomComment meetingRoomComment) throws Exception;
	
	List<MeetingRoomVO> selectMeetingRoomListHeadSearch(MeetingRoomVO bcVO) throws Exception;
	int selectMeetingRoomListTotCntHeadSearch(MeetingRoomVO bcVO) throws Exception;
	
	void updateMeetingResult(MeetingRoom meetingRoom) throws Exception;

}
