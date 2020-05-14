package com.devcases.springboot.crud.library.repository;

import com.devcases.springboot.crud.library.model.Book;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends CrudRepository<Book, Long> {

	@Query(value = "select * from book where name = ?1", nativeQuery = true)
	Book findByName(String bname);
	
}