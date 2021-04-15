package com.techelevator.projects.model.jdbc;

import java.sql.SQLException;
import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;

import com.techelevator.projects.model.Department;

public class JDBCDepartmentDAOTests {
	
	private static SingleConnectionDataSource dataSource;
	
	private JDBCDepartmentDAO dao;
	
	@BeforeClass
	public static void setUpDataSource() {
		dataSource = new SingleConnectionDataSource();
		dataSource.setUrl("jdbc:postgresql://localhost:5432/projects");
		dataSource.setUsername("postgres");
		dataSource.setPassword("postgres1");
		dataSource.setAutoCommit(false);
	}
	
	@Before // Before EACH test
	public void setUp() {
		// create a dao we can use
		dao = new JDBCDepartmentDAO(dataSource);
	}
	
	@After // After EACH test
	public void rollback() throws SQLException {
		// rollback data from test so it doesn't affect our real data
		dataSource.getConnection().rollback();
	}
	
	@Test
	public void getAllDepartments_withDataInDatabase_shouldReturnMultipleResults() {
		// Arrange
		
		// create a jdbcTemplate so we can insert some data
		// without the DAO
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		
		// Test Data
		String dept1 = "Test Department 1";
		String dept2 = "Test Department 2";
		
		// Insert test data
		String query = "INSERT INTO department (name) VALUES (?)";	
		
		jdbcTemplate.update(query, dept1);
		jdbcTemplate.update(query, dept2);
		
		// Act
		// call out method
		List<Department> result = dao.getAllDepartments();
		
		// Assert
		// check the List we got back was not null AND has at least 2 elements
		// (since we inserted 2)
		Assert.assertNotNull(result);
		Assert.assertTrue("getAllDepartments expected at least 2 rows, got " + result.size(),
				result.size() >= 2);
		
		// once done our database changes will be rolled back to the are not
		// permanent
	}
	
	@Test
	public void createDepartment_withValidData_shouldInsertAndReturnId() {
		// Arrange		
		Department dept = new Department();
		dept.setName("CREATE DEPT TEST");
		
		// Act
		Department result = dao.createDepartment(dept);
		
		// Assert
		// 1) Not null
		// 2) Got an id back
		Assert.assertNotNull(result);
		Assert.assertNotNull(result.getId());
		
		// Use id to retrieve record
		String sql = "SELECT name FROM department WHERE department_id = ?";
		
		// Create jdbcTemplate
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		
		// Since we expect only one record we can use queryForObject
		String resultString  = jdbcTemplate.queryForObject(sql, String.class, result.getId());
		
		// Check if not null
		Assert.assertNotNull(resultString);
		
		// Check name is correct
		Assert.assertEquals("createdDepartment expected " + dept.getName() + " got " + 
				result.getName(), dept.getName(), resultString);
	}
	
	@Test
	public void saveDepartmentTest_withValidData_shouldUpdateRecord() {
		// Arrange
		Department dept = new Department();
		dept.setName("SAVE TEST");
		
		// Create jdbcTemplate
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		
		// insert the department so we can test updating it. we will need id for update
		// so we are using RETURNING department_id
		String sql = "INSERT INTO department (name) VALUES (?) RETURNING department_id";
		
		// get saved id and update object to use the id
		Long newId = jdbcTemplate.queryForObject(sql, Long.class, dept.getName());
		dept.setId(newId);
		
		// at this point our starting scenario is setup
		
		// update the object being passed to method...
		dept.setName("CHANGED NAME TEST");
		
		// ACT
		
		// save to database
		dao.saveDepartment(dept);
		
		// Retrieve the same record from the db using original id we got from save
		String query = "SELECT name FROM department WHERE department_id = ?";
		String savedDeptName = jdbcTemplate.queryForObject(query, String.class, dept.getId());
		
		// Make sure the update worked correctly
		Assert.assertEquals("CHANGED NAME TEST", savedDeptName);	
	}
	
	@Test
	public void saveDepartmentTest_withNullId_shouldNotUpdateRecord() {
		// Arrange
		Department dept = new Department();
		dept.setName("SAVE TEST");
		
		// Create jdbcTemplate
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		
		// insert the department so we can test updating it. we will need id for update
		// so we are using RETURNING department_id
		String sql = "INSERT INTO department (name) VALUES (?) RETURNING department_id";
		
		// get saved id and update object to use the id
		Long newId = jdbcTemplate.queryForObject(sql, Long.class, dept.getName());
		
		// set id to null to test id=null scenario in save method
		// we will use newId above to retreive record from database
		// to confirm it hasn't changed
		dept.setId(null);
		
		// at this point our starting scenario is setup
		
		// update the object
		dept.setName("CHANGED NAME TEST");
		
		// ACT
		
		// save to database
		dao.saveDepartment(dept);
		
		// Retrieve the same record from the db using id
		String query = "SELECT name FROM department WHERE department_id = ?";
		String savedDeptName = jdbcTemplate.queryForObject(query, String.class, newId);
		
		// Make sure the update DID NOT happen since the method was passed
		// an object with a null id
		Assert.assertEquals("SAVE TEST", savedDeptName);
		
	}
	
	@AfterClass
	public static void cleanUp() {
		dataSource.destroy();
	}

}
