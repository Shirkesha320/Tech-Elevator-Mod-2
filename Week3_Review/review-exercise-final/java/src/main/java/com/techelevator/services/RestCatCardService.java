package com.techelevator.services;

import org.springframework.stereotype.Component;

import com.techelevator.model.CatCard;
import com.techelevator.model.CatFact;

@Component
public class RestCatCardService implements CatCardService {
	
	private CatFactService catFactService;
	
	public RestCatCardService(CatFactService catFactService) {
		this.catFactService = catFactService;
	}

	@Override
	public CatCard getRandomCatCard() {
		CatCard card =  new CatCard();
		CatFact catFact = catFactService.getFact();
		
		card.setCatFact(catFact.getText());
		card.setImgUrl("https://i.some-random-api.ml/EXtIdiwwp3.jpg");
		return card;
	}

}
