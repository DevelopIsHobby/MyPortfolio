package com.myportfolio.web.domain;

import org.junit.Test;

import static org.junit.Assert.*;

public class PageHandlerTest {
    @Test
    public void test() {
        PageHandler ph = new PageHandler(255,23);
        ph.print();
        assertTrue(ph.beginPage==21);
        assertTrue(ph.endPage==26);
    }

}