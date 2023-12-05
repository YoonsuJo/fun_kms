package egovframework.com.cmm;

import kms.com.common.config.PathConfig;
import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class ImagePaginationRenderer extends AbstractPaginationRenderer {
	
	public ImagePaginationRenderer() {
		firstPageLabel    = "<a href=\"javascript:{0}({1}); \"><img src=\"" + PathConfig.imagePath + "/btn/btn_first.gif\" alt=\"처음페이지\" /></a>&#160;"; 
        previousPageLabel = "<a href=\"javascript:{0}({1}); \" class=\"pR10\"><img src=\"" + PathConfig.imagePath + "/btn/btn_prev.gif\" alt=\"이전페이지\"></a>&#160;";
        currentPageLabel  = "<strong>{0}</strong>&#160;"; 
        otherPageLabel    = "<a href=\"javascript:{0}({1});\">{2}</a>&#160;";
        nextPageLabel     = "<a href=\"javascript:{0}({1}); \"><img src=\"" + PathConfig.imagePath + "/btn/btn_next.gif\" alt=\"다음페이지\" /></a>&#160;";
        lastPageLabel     = "<a href=\"javascript:{0}({1}); \"><img src=\"" + PathConfig.imagePath + "/btn/btn_end.gif\" alt=\"마지막페이지\" /></a>&#160;";

	}
	
	
}
