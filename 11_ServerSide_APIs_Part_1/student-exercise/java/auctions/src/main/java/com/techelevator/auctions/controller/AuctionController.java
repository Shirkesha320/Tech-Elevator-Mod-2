package com.techelevator.auctions.controller;

import com.techelevator.auctions.DAO.AuctionDAO;
import com.techelevator.auctions.DAO.MemoryAuctionDAO;
import com.techelevator.auctions.model.Auction;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/auctions")
public class AuctionController {

    private AuctionDAO dao;

    public AuctionController() {
        this.dao = new MemoryAuctionDAO();
    }
    
@RequestMapping(path = "/{id}", method = RequestMethod.GET)

    public Auction getAuctionByID(@PathVariable int id) {
		return dao.get(id);
}


@RequestMapping(method = RequestMethod.POST)

	public Auction createAuction(@RequestBody Auction auction) {
	return dao.create(auction);
}


@RequestMapping(method = RequestMethod.GET)

	public List<Auction> list(@RequestParam(defaultValue = "") String title_like, 
			                  @RequestParam(defaultValue = "0")
		double currentBid_lte) {
			   
	if ((!(title_like.equals("")) ) && (currentBid_lte != 0)) {
		List<Auction> list = dao.searchByTitleAndPrice(title_like, currentBid_lte);
		return list;
		
	} else if (! (title_like.contentEquals(""))) {
		List<Auction> list = dao.searchByTitle(title_like);
	    return list;
	    
	} else if (currentBid_lte != 0 ) {
		List <Auction> list = dao.searchByPrice(currentBid_lte);
	     return list;
	}
	
	List<Auction> list = dao.list();
	return list;
	
    }
}
	
    


	
