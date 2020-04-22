package com.devcases.springboot.crud.library.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.devcases.springboot.crud.library.model.Book;
import com.devcases.springboot.crud.library.service.BookService;

@Controller
public class BookController {
	
	private BookService service;

    @Autowired
    public BookController(BookService service) {
        this.service = service;
    }
    
    //@GetMapping("/")
    @GetMapping
    public String showAllBooks(Model model) {
        model.addAttribute("books", service.findAll());
        return "books";
    }
    
    @GetMapping("/new-book")
    public String showBookCreationForm(Model model) {
        model.addAttribute("book", new Book());
        return "new-book";
    }

    @PostMapping(value = "/add", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String addNewBook(@Valid @ModelAttribute Book book, BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "new-book";
        }
        service.save(book);
        //model.addAttribute("books", service.findAll());
        //return "books";
        
        return "redirect:/";

    }

    @GetMapping("/{id}")
    public String showBookdById(@PathVariable Long id, Model model) {
        Book book = service.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));
        model.addAttribute("book", book);
        return "edit-book";
    }

    @PostMapping("/{id}/update")
    public String updateBook(@PathVariable Long id, @Valid @ModelAttribute Book book, BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "edit-book";
        }
        service.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));
        service.save(book);
        return "redirect:/";

    }

    @PostMapping("/{id}/delete")
    public String deleteBook(@PathVariable Long id, Model model) {
        service.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid book Id:" + id));
        service.deleteById(id);
        return "redirect:/";
    }
    
    @GetMapping("/nextpage")
    public String showNext(Model model) {
        return "next";
    }

}
