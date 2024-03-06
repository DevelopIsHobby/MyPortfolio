package com.myportfolio.web.service;

import com.myportfolio.web.dao.BoardDao;
import com.myportfolio.web.dao.CommentDao;
import com.myportfolio.web.domain.CommentDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    CommentDao commentDao;
    BoardDao boardDao;

    @Autowired
    public CommentServiceImpl(CommentDao commentDao, BoardDao boardDao) {
        this.commentDao = commentDao;
        this.boardDao = boardDao;
    }

    @Override
    public int getCount(Integer bno) throws Exception {
        return commentDao.count(bno);
    }
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int remove(Integer cno, Integer bno, String commenter) throws Exception {
        int rowCnt = commentDao.delete(cno, commenter);
        rowCnt = boardDao.updateCommentCnt(bno, -1);
        return rowCnt;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int write(CommentDto commentDto) throws Exception {
        int rowCnt = boardDao.updateCommentCnt(commentDto.getBno(), 1);
        rowCnt = commentDao.insert(commentDto);
        return rowCnt;
    }

    @Override
    public List<CommentDto> getList(Integer bno) throws Exception {
        return commentDao.selectAll(bno);
    }

    @Override
    public CommentDto read(Integer cno) throws Exception {
        return commentDao.select(cno);
    }

    @Override
    public int modify(CommentDto commentDto) throws Exception {
        return commentDao.update(commentDto);
    }
}
