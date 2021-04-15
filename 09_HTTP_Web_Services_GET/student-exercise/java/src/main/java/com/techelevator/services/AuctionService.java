package com.techelevator.services;

import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestClientResponseException;
import org.springframework.web.client.RestTemplate;

import com.techelevator.models.Auction;


public class AuctionService {

    public static final String BASE_URL = "http://localhost:3000/auctions";
    public RestTemplate restTemplate = new RestTemplate();
    private final ConsoleService console = new ConsoleService();


    public Auction[] listAllAuctions() {
    	
    	Auction[] result = restTemplate.getForObject(BASE_URL, Auction[].class); 
    	return result;
    	             
    }

    public Auction listDetailsForAuction(int id) {
    	
    	String url = BASE_URL + "/" + id;
    	
    	Auction result = restTemplate.getForObject(url,Auction.class);
    	 return result;
      
         }

    public Auction[] findAuctionsSearchTitle(String title) {
       
    	String url = BASE_URL + "?title_like=" + title;
    	Auction[] results = restTemplate.getForObject(url, Auction[].class);
    	 
    		  return results;
    	  
    }

    public Auction[] findAuctionsSearchPrice(double price) {
     
    	String url = BASE_URL + "?currentBid_lte=" + price;
    	
    	Auction[] results = restTemplate.getForObject(url, Auction[].class);
        return results;
    }

}
