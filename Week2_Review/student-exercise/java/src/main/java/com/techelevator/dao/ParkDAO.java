package com.techelevator.dao;

import com.techelevator.model.Park;

import java.util.List;

public interface ParkDAO {

   public List<Park> getAllParks();
    
   public List<Park> getParkById(long id);
}
