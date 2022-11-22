package com.kh.forworks;

public class Pagination {
    
    // PageVo 리턴
    public static PageVo getPageVo(int listCount, int currentPage, int pageLimit, int boardLimit) {
     
        int maxPage = (int)Math.ceil((double)listCount / boardLimit);
        int startPge = (currentPage-1)/pageLimit * pageLimit + 1;
        int endPage = startPge + pageLimit - 1;
        
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        
        PageVo vo = new PageVo();
        vo.setListCount(listCount);
        vo.setCurrentPage(currentPage);
        vo.setPageLimit(pageLimit);
        vo.setBoardLimit(boardLimit);
        
        vo.setMaxPage(maxPage);
        vo.setStartPage(startPge);
        vo.setEndPage(endPage);
        
        return vo;
    }
}
