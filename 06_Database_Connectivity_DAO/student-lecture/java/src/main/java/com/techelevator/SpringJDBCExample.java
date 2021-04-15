package com.techelevator;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

// Yoav's updated version

/* Working with JDBC entails a lot of boilerplate code which can become 
 * tedious and error prone. The Spring JBDC framework can help eliminate 
 * much of the boilerplate code, and limit the tedium and mistakes. */
public class SpringJDBCExample {

	public static void main(String[] args) {
		
		/* This datasource will be used for creating connections to the database.
		 * Below, we provide the information required to make database connections */
		BasicDataSource dvdstoreDataSource = new BasicDataSource();
		dvdstoreDataSource.setUrl("jdbc:postgresql://localhost:5432/dvdstore");
		dvdstoreDataSource.setUsername("postgres");
		dvdstoreDataSource.setPassword("postgres1");
		
		/* The JdbcTemplate is the main interface we use to interact with databases using
		 * Spring JDBC. */
		JdbcTemplate dvdstoreJdbcTemplate = new JdbcTemplate(dvdstoreDataSource);
		
		
		
		
		// queryForRowSet
		
		//
		/* The JdbcTemplate can be used to execute SQL statements */
		/*
		String sqlFilmsForComedyCategory =  "SELECT film.title, film.release_year "+
									 "FROM film JOIN film_category ON film.film_id = film_category.film_id "+
									 "JOIN category ON category.category_id = film_category.category_id "+
									 "WHERE category.name = 'Comedy'";
		
		SqlRowSet results = dvdstoreJdbcTemplate.queryForRowSet(sqlFilmsForComedyCategory);
		System.out.println("Comedy Films:");
		*/

		// read data from rows
		/*
		
		while(results.next()) {  // The "next" method advances the cursor to the next row.  If a row exists, it returns true, otherwise false
			String filmTitle = results.getString("title");  // this is the title column from teh SELECT statment above
			int releaseYear = results.getInt("release_year");
			System.out.println(filmTitle+" (" + releaseYear+ ")");
		}
		*/
		
		// with params
		
		/* The JdbcTemplate can be used to execute parameterized SQL statements */
		/*
		String sqlFilmsByCategory =  "SELECT film.title, film.release_year "+
									 "FROM film JOIN film_category ON film.film_id = film_category.film_id "+
									 "JOIN category ON category.category_id = film_category.category_id "+
									 "WHERE category.name = ?";
		
									 
		// The first parameter to the "queryForRowSet" method is a String containing a parameterized SQL statement
		// Any following parameters are used to replace query placeholders (i.e. '?') in the order in which they appear */
		/*
		String category = "Action";
		results = dvdstoreJdbcTemplate.queryForRowSet(sqlFilmsByCategory, category);
		
		System.out.println();
		System.out.println(category + " Films:");
		while(results.next()) {  // The "next" method advances the cursor to the next row.  If a row exists, it returns true, otherwise false
			String filmTitle = results.getString("title");  // this is the title column from teh SELECT statment above
			int releaseYear = results.getInt("release_year");
			System.out.println(filmTitle + " ("+releaseYear+")");
		}
		*/
		
		// select single value using queryForObject
		/*		
		String sqlFilmCount = "SELECT COUNT(*) FROM film";
		Integer filmCount = dvdstoreJdbcTemplate.queryForObject(sqlFilmCount, Integer.class);
		System.out.println();
		System.out.println("Comedy Count: " + filmCount);
		
		
		// select single value using queryForObject using query param
		String sqlFilmsByCategoryCount =  "SELECT COUNT(*) "+
				 "FROM film JOIN film_category ON film.film_id = film_category.film_id "+
				 "JOIN category ON category.category_id = film_category.category_id "+
				 "WHERE category.name = ?";
		
		category = "Action";
		Integer categoryCount = dvdstoreJdbcTemplate.queryForObject(sqlFilmsByCategoryCount, Integer.class, category);
		System.out.println();
		System.out.println(category + " count: " + categoryCount);
		
		*/
		
		
//		Check if actor 1000 was inserted already and delete if so
		/*
		String sqlGetActor1000 =  "SELECT actor_id FROM actor WHERE actor_id = 1000 ";
		SqlRowSet sqlActorDeleteResults = dvdstoreJdbcTemplate.queryForRowSet(sqlGetActor1000);
		if (!sqlActorDeleteResults.wasNull()) {
			
			// update can be used for delete SQL
			String sqlDeleteActor1000 = "DELETE FROM actor WHERE actor_id = 1000";
			dvdstoreJdbcTemplate.update(sqlDeleteActor1000);
		}
		*/
		

		/* The JdbcTemplate can be used to execute parameterized SQL statements using update too */
		
		/* use the "update" method to run INSERT, UPDATE, and DELETE statements */
		/*
		String sqlCreateActor = "INSERT INTO actor(actor_id, first_name, last_name) "+
								"VALUES (?, ?, ?)";
		
		dvdstoreJdbcTemplate.update(sqlCreateActor, 1000, "Craig", "Castelaz");
		*/
		
		/* The next example makes use of the world database, so we need a new 
		 * DataSource for creating connections to that database. */
		/*
		BasicDataSource worldDataSource = new BasicDataSource();
		worldDataSource.setUrl("jdbc:postgresql://localhost:5432/world");
		worldDataSource.setUsername("postgres");
		worldDataSource.setPassword("postgres1");
		
		
		// create the JdbcTemplate
		JdbcTemplate worldJdbcTemplate = new JdbcTemplate(worldDataSource);
		*/
		
		/*
		 * Sequences are often used to generate a unique Id value prior to inserting
		 * a new record.
		 */
		/*
		String sqlGetNextId = "SELECT nextval('seq_city_id')";
		results = worldJdbcTemplate.queryForRowSet(sqlGetNextId);
		results.next(); // advances to the first row
		int id = results.getInt(1); // returns the integer value of the first column (i.e. index 1)
		System.out.println("New city id: "+id);
		*/
		
		// We could also do this using queryForObject since we know it will be one value
		
		/*
		 * Now create a new city record using the generated id 
		 */
		/*
		String sqlCreateNewCity = "INSERT INTO city(id, name, countrycode, district, population) "+
								  "VALUES(?, ?, ?, ?, ?)";
		
		worldJdbcTemplate.update(sqlCreateNewCity, id, "Smallville", "USA", "Kansas", 45001);
		*/
	}
}
