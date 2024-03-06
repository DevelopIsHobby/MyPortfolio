package com.myportfolio.web.domain;

import org.springframework.web.util.UriComponentsBuilder;

public class PageHandler {

//    private int page; // 현재 페이지
//    private int pageSize; // 한 페이지의 크기
//    private String option;
//    private String keyword;
    private SearchCondition sc;


    private int totalCnt; // 총 게시물의 갯수
    private int naviSize=10; // 페이지 네비게이션의 크기
    private int totalPage; // 전체 페이지의 갯수
    private int beginPage; // 네이게이션의 시작페이지
    private int endPage; // 네비게이션의 마지막 페이지
    private boolean showPrev; // 이전페이지로 이동하는 링크를 보여줄 것인지의 여부
    private boolean showNext; // 다음페이지로 이동하는 링크를 보여줄 것인지의 여부



    public PageHandler(int totalCnt, Integer page) {
        this(totalCnt, new SearchCondition(page, 10));
    }
    public PageHandler(int totalCnt, Integer page, Integer pageSize) {
        this(totalCnt, new SearchCondition(page, pageSize));
    }
    public PageHandler(int totalCnt, SearchCondition sc) {
        this.totalCnt = totalCnt;
        this.sc = sc;

        doPaging(totalCnt, sc);
    }

    private void doPaging(int totalCnt, SearchCondition sc) {
        // 검색조건으로 계산한 전체 게시물의 개수가 pageSize로 나누었을 때 0이 아니면 1을 더함
        this.totalPage = totalCnt / sc.getPageSize() + (totalCnt % sc.getPageSize() == 0? 0:1);
        this.sc.setPage(Math.min(sc.getPage(), totalPage)); // page가 totalPage보다 작게함
        this.beginPage = (this.sc.getPage()-1) / naviSize * naviSize +1;
        this.endPage = Math.min(beginPage + naviSize -1, totalPage);
        showPrev = beginPage!=1;
        showNext = endPage != totalPage;
    }

    public String getQueryString() {
        return getQueryString(this.sc.getPage());
    }
    public String getQueryString(Integer page) {
        return UriComponentsBuilder.newInstance()
                .queryParam("page",     page)
                .queryParam("pageSize", sc.getPageSize())
                .queryParam("option",   sc.getOption())
                .queryParam("keyword",  sc.getKeyword())
                .build().toString();
    }

    void print() {
        System.out.println("page = " + sc.getPage());
        System.out.print(showPrev? "[PREV] ":"");
        for(int i=beginPage; i<=endPage; i++) {
            System.out.print(i+" ");
        }
        System.out.println(showNext? "[NEXT]":"");
    }

    @Override
    public String toString() {
        return "PageHandler{" +
                "sc=" + sc +
                ", totalCnt=" + totalCnt +
                ", naviSize=" + naviSize +
                ", totalPage=" + totalPage +
                ", beginPage=" + beginPage +
                ", endPage=" + endPage +
                ", showPrev=" + showPrev +
                ", showNext=" + showNext +
                '}';
    }

    public SearchCondition getSc() {
        return sc;
    }

    public void setSc(SearchCondition sc) {
        this.sc = sc;
    }

    public int getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }


    public int getNaviSize() {
        return naviSize;
    }

    public void setNaviSize(int naviSize) {
        this.naviSize = naviSize;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(int beginPage) {
        this.beginPage = beginPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public boolean isShowPrev() {
        return showPrev;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

    public boolean isShowNext() {
        return showNext;
    }

    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }
}
