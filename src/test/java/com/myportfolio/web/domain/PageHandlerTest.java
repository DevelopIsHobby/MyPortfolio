package com.myportfolio.web.domain;

import org.junit.Test;

import static org.junit.Assert.*;

public class PageHandlerTest {
//    Integer page = 1;
//    Integer pageSize = 10;
//    String keyword = "";
//    String option = "";
    @Test
    public void test() {
        SearchCondition sc = new SearchCondition(23, 10, "","");
        PageHandler ph = new PageHandler(255,sc);
        ph.print();
        assertTrue(ph.getBeginPage()==21);
        assertTrue(ph.getEndPage()==26);
    }

}