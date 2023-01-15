package com.Z09420121.dao;

import com.Z09420121.domain.Book;
import com.Z09420121.domain.Booking;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BookDao {

//    @Insert("insert into tbl_book values(null,#{type},#{name},#{description})")
    @Insert("insert into tbl_book (type,name,description) values(#{type},#{name},#{description})")
    public int save(Book book);

    @Update("update tbl_book set type = #{type}, name = #{name}, description = #{description} where id = #{id}")
    public int update(Book book);

    @Delete("delete from tbl_book where id = #{id}")
    public int delete(Integer id);

    @Select("select * from tbl_book where id = #{id}")
    public Book getById(Integer id);

    @Select("select * from tbl_book WHERE name LIKE '%${value}%'")
    public List<Book> getAll(String value);

    @Select("select * from tbl_book,booking WHERE tbl_book.id = booking.id and booking.username = #{value}")
    public List<Book> getMyAll(String value);

    @Insert("insert into booking values(#{id},#{username})")
    public int booking(Booking booking);

    @Select("select * from booking where id = #{id} and username = #{username}")
    public Booking getBooking(Booking booking);


    @Delete("delete from booking where id = #{id} and username = #{username}")
    public int deleteBooking(Booking booking);
}
