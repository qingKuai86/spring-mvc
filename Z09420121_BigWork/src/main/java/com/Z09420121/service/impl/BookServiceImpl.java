package com.Z09420121.service.impl;

import com.Z09420121.dao.BookDao;
import com.Z09420121.domain.Book;
import com.Z09420121.domain.Booking;
import com.Z09420121.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {
    @Autowired
    private BookDao bookDao;

    public boolean save(Book book) {
        return bookDao.save(book) > 0;
    }

    public boolean update(Book book) {
        return bookDao.update(book) > 0;
    }

    public boolean delete(Integer id) {
        return bookDao.delete(id) > 0;
    }
    public boolean deleteBooking(Booking booking) {
        return bookDao.deleteBooking(booking) > 0;
    }

    public Book getById(Integer id) {
        return bookDao.getById(id);
    }

    public List<Book> getAll(String value) {
        return bookDao.getAll(value);
    }

    @Override
    public List<Book> getMyAll(String value) {
        return bookDao.getMyAll(value);
    }

    @Override
    public boolean booking(Booking booking) {
        return bookDao.booking(booking) > 0;
    }

    @Override
    public Booking getBooking(Booking booking) {
        return bookDao.getBooking(booking);
    }
}
