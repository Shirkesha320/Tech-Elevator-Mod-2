package com.techelevator.services;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.techelevator.model.CatPic;

@Component
public class RestCatPicService implements CatPicService {
	
	private RestTemplate restTemplate = new RestTemplate();

	@Override
	public CatPic getPic() {
		// TODO Auto-generated method stub
		return null;
	}

}	
