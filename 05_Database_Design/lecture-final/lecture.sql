-- this is how you would create a database (in this case you do this from another tool or 
-- database because this database would be the one you are creating, so it does not exist to run this
CREATE DATABASE art_gallery;

-- create table artist
CREATE TABLE artist (
        artist_id serial NOT NULL, -- serial indicates an auto-vreated sequence which will to auto-generate ids
        first_name varchar(100),
        last_name varchar(100)
);

-- Modify the artist table to add a PRIMARY KEY constraint on the artisit_id field
ALTER TABLE artist ADD CONSTRAINT
pk_artist_artist_id PRIMARY KEY(artist_id);

-- if you want to drop a table....
DROP TABLE artist;

-- creating again but including PRIMARY KEY in table definition
CREATE TABLE artist (
        artist_id serial NOT NULL,
        first_name varchar(100),
        last_name varchar(100),
        CONSTRAINT pk_artist_artist_id PRIMARY KEY(artist_id)
        
);

--- creates a sequence named test_counter_seq
CREATE SEQUENCE test_counter_seq;

-- gets the next value from the sequence
SELECT nextval('test_counter_seq');

-- just some inserts for demonstration purposes
INSERT INTO artist (first_name, last_name) VALUES ('Lady', 'Gaga');
INSERT INTO artist (first_name, last_name) VALUES ('Bob', 'Dylan');

-- when you rollback a transaction, any inserts will be rolled back
-- butthe value of the sequence WILL NOT so if you insert again, the id will be different 
START TRANSACTION;
INSERT INTO artist (first_name, last_name) VALUES ('Bruce', 'Springsteen');
ROLLBACK;
SELECT * FROM artist;

-- dropping a sequence

DROP SEQUENCE test_counter_seq;



SELECT * FROM artist;

CREATE TABLE artwork(
        artwork_id SERIAL NOT NULL,
        title VARCHAR(500),
        artist_id INTEGER,
        CONSTRAINT pk_artwork_artwork_id PRIMARY KEY(artwork_id)
);

ALTER TABLE artwork ADD FOREIGN KEY (artist_id) REFERENCES artist (artist_id);


CREATE TABLE address(
        address_id SERIAL NOT NULL,
        address_1 VARCHAR(500),
        address_2 VARCHAR(500),
        city VARCHAR(100),
        district VARCHAR(100),
        CONSTRAINT pk_address_address_id PRIMARY KEY (address_id)
);

SELECT LENGTH(first_name) FROM artist;

ALTER TABLE artist ADD CONSTRAINT 
chk_first_name_length CHECK(LENGTH(first_name) > 2 AND LENGTH(first_name) < 10);

INSERT INTO artist (first_name, last_name) VALUES ('Lady2', 'Gaga');

-- CHECK THIS
ALTER TABLE artist  COLUMN
first_name VARCHAR(100) NOT NULL;

CREATE TABLE customer (
        customer_id SERIAL NOT NULL,
        first_name VARCHAR(100),
        last_name VARCHAR(100),
        artist_id INTEGER,
        phone VARCHAR(20),
        CONSTRAINT pk_customer_custome_id PRIMARY KEY(customer_id),
        CONSTRAINT fk_customer_artist_id FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);
-- this is a comment
// this is a comment
