package kms.com.common.exception;


@SuppressWarnings("serial")
public class IdMixInputException extends Exception{
    public String msg="이름 입력형식이 잘못되었습니다.";
    public IdMixInputException(String msg){
        this.msg = msg;
    }
    public IdMixInputException(){
        
    }
}
