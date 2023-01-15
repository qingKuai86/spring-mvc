package com.Z09420121.service;

import com.Z09420121.domain.Book;
import com.Z09420121.domain.Booking;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
public interface BookService {

    /**
     * 保存
     * @param book
     * @return
     */
    public boolean save(Book book);

    /**
     * 修改
     * @param book
     * @return
     */
    public boolean update(Book book);

    /**
     * 按id删除
     * @param id
     * @return
     */
    public boolean delete(Integer id);

    public boolean deleteBooking(Booking booking);

    /**
     * 按id查询
     * @param id
     * @return
     */
    public Book getById(Integer id);

    /**
     * 查询全部
     * @return
     */
    public List<Book> getAll(String value);

    public List<Book> getMyAll(String value);

    /**
     * 预订书
     * @return
     */
    public boolean booking(Booking booking);
    /**
     * 查看有没有预订过
     * @return
     */
    public Booking getBooking(Booking booking);
}
