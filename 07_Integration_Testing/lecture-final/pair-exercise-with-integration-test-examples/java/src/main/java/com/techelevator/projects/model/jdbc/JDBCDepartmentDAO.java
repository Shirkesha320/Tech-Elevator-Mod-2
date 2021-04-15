package com.techelevator.projects.model.jdbc;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.techelevator.projects.model.Department;
import com.techelevator.projects.model.DepartmentDAO;

public class JDBCDepartmentDAO implements DepartmentDAO {
	
	private JdbcTemplate jdbcTemplate;

	public JDBCDepartmentDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public List<Department> getAllDepartments() {
		List<Department> deptList = new ArrayList<>();
		
		// the query
		String sql = "SELECT department_id, name FROM department";
		
		// ask the database for data, SqlEowSet is returned
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
		
		// go through all rows
		while(results.next()) {
			// create Department object from current row
			Department newDept = getDepartmentFromRow(results);
			// add Department to List
			deptList.add(newDept);
		}
		
		// return List
		return deptList;
	}
	
	private Department getDepartmentFromRow(SqlRowSet row) {
		Department dept = new Department();
		dept.setId(row.getLong("department_id"));
		dept.setName(row.getString("name"));
		
		return dept;
	}

	@Override
	public List<Department> searchDepartmentsByName(String nameSearch) {
		return new ArrayList<>();
	}

	@Override
	public void saveDepartment(Department updatedDepartment) {
		if (updatedDepartment != null && updatedDepartment.getName() != null
				&& updatedDepartment.getId() != null) {
			// Create update statement using updatedDepartment id as well as whatever is in its name
			String sql = "UPDATE department SET  name = ? WHERE department_id=?";
		
			// Run the query get back how many rows were changed
			int rowsAffected = jdbcTemplate.update(sql, updatedDepartment.getName(), updatedDepartment.getId());
		}
		
	}

	@Override
	/*
	public Department createDepartment(Department newDepartment) {
		String sql = "INSERT INTO department (name) VALUES (?)";
		jdbcTemplate.update(sql, newDepartment.getName());
		
		return newDepartment;
	}
	*/
	
	// Method 1: Brute force!
		/*
		@Override
		public Department createDepartment(Department newDepartment) {
			String query = "INSERT INTO department (name) VALUES (?)";
			
			// Insert the department
			jdbcTemplate.update(query, newDepartment.getName());
			
			// query the db for inserted record id
			// and update the department id
			newDepartment.setId(getDepartmentId(newDepartment.getName()));
			
			// return the updated department
			return newDepartment;
		}
		*/
		
		// Method 2: Retrieve the id ourselves
		/*
		@Override
		public Department createDepartment(Department newDepartment) {
			String query = "INSERT INTO department VALUES (?, ?)";
			
			// query next id from sequence
			Long newDeptId = getNextDeptId();
			
			// use it in insert statement (the serial method of a table is only involed
			// when no value for the column is provided)
			jdbcTemplate.update(query, newDeptId, newDepartment.getName());
			
			// after update set the id of the department object
			newDepartment.setId(newDeptId);
			
			// return the updated department
			return newDepartment;
		}
		*/
	
	public Department createDepartment(Department newDepartment) {
		String sql = "INSERT INTO department (name) VALUES (?) RETURNING department_id";
		
		Long newId = jdbcTemplate.queryForObject(sql, Long.class, newDepartment.getName());
		
		newDepartment.setId(newId);
		
		return newDepartment;
	}
	
	private Long getDepartmentId(String name) {
		// query the department id by name
		String query = "SELECT department_id FROM department WHERE name=?";
		
		// id should be unique so we can use queryForObject
		Long resultId = jdbcTemplate.queryForObject(query, Long.class, name);
		
		// return id
		return resultId;
	}
	
	private Long getNextDeptId() {
		String query = "SELECT nextval('seq_department_id')";
		Long result = jdbcTemplate.queryForObject(query, Long.class);
		return result;
	}

	@Override
	public Department getDepartmentById(Long id) {
		return null;
	}
	
	public void printHello() {
		
	}

}
