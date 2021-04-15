package com.techelevator.controller;

import java.util.List;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.model.CatCard;
import com.techelevator.model.CatCardDAO;
import com.techelevator.model.CatFact;
import com.techelevator.model.CatPic;
import com.techelevator.services.CatCardService;

@RestController
@RequestMapping("/api")
public class CatController {

    private CatCardDAO catCardDao;
    private CatCardService catCardService;

    public CatController(CatCardDAO catCardDao, CatCardService catCardService) {
        this.catCardDao = catCardDao;
        this.catCardService = catCardService;
    }
    
    @RequestMapping(path = "/cards/random", method = RequestMethod.GET)
    public CatCard getRandomCatCard() {
    	return catCardService.getRandomCatCard();
    }
    
    @RequestMapping(path = "/cards", method =  RequestMethod.POST)
    public CatCard addCatCard(@RequestBody CatCard card) {
    	catCardDao.save(card);
    	return card;
    }
    
    @RequestMapping(path = "/cards", method = RequestMethod.GET)
    public List<CatCard> getUserCollection() {
    	return catCardDao.list();
    }


}
