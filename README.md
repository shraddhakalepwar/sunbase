# sunbase
Steps:
Java:

1] created a spring starter project(sb) in eclipse
>>added dependencies(mysql driver, spring devtools, spring datajpa, springweb)

2]added properties(port, mysql, hibernate) in application.properties file
    /*
    spring.application.name=sb

    #server properties
    server.port=9080

    #database properties
    spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
    spring.datasource.url=jdbc:mysql://localhost:3306/customer
    spring.datasource.username=root
    spring.datasource.password=K27shr@ddha

    #hibernate properties
    spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
    spring.jpa.properties.hibernate.hbm2ddl.auto=update
    spring.jpa.properties.hibernate.show_sql=true
    spring.jpa.properties.hibernate.format_sql=true
    */

import javax.annotation.processing.Generated;

3]created model class Customer
>>added propertis 
>>setter and getter
>>toString
>>annotations(to map class with table)
>>@Id and @GeneratedValue for unique, auto-incremented and auto generated Id

    /*
    package com.demo.model;

    import jakarta.persistence.Entity;
    import jakarta.persistence.GeneratedValue;
    import jakarta.persistence.GenerationType;
    import jakarta.persistence.Id;

    @Entity
    public class Customer {
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private int id;
        private String firstName;
        private String lastName;
        private String street;
        private String address;
        private String city;
        private String state;
        private String email;
        private String phone;
        public int getId() {
            return id;
        }
        public void setId(int id) {
            this.id = id;
        }
        public String getFirstName() {
            return firstName;
        }
        public void setFirstName(String firstName) {
            this.firstName = firstName;
        }
        public String getLastName() {
            return lastName;
        }
        public void setLastName(String lastName) {
            this.lastName = lastName;
        }
        public String getStreet() {
            return street;
        }
        public void setStreet(String treet) {
            this.street = treet;
        }
        public String getAddress() {
            return address;
        }
        public void setAddress(String address) {
            this.address = address;
        }
        public String getCity() {
            return city;
        }
        public void setCity(String city) {
            this.city = city;
        }
        public String getState() {
            return state;
        }
        public void setState(String state) {
            this.state = state;
        }
        public String getEmail() {
            return email;
        }
        public void setEmail(String email) {
            this.email = email;
        }
        public String getPhone() {
            return phone;
        }
        public void setPhone(String phone) {
            this.phone = phone;
        }
        @Override
        public String toString() {
            return "Customer [Id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", street=" + street
                    + ", address=" + address + ", city=" + city + ", state=" + state + ", email=" + email + ", phone="
                    + phone + "]";
        }
    }
 */

4]created CustomerDao class which extends JpaRepository where actual curd operations are performed in dao package

    /*
    package com.demo.dao;

    import java.util.List;
    import java.util.Optional;

    import org.springframework.data.jpa.repository.JpaRepository;
    import org.springframework.data.jpa.repository.Query;
    import org.springframework.stereotype.Repository;

    import com.demo.model.Customer;

    @Repository
    public interface CustomerDao extends JpaRepository<Customer, Integer>{
        Customer save(Customer c);//save and update
        
        List<Customer> findAll();
        
        int deleteByEmail(String email);
        
        Customer findByEmail(String email);
        
        @Query(value = "select id,first_name,last_name,street,address,city,state,email,phone from customer where first_name like %?1% or city like %?1% or email like %?1% or phone like %?1%" , nativeQuery = true)
        List<Customer> findByAny(String b1);
    }
    */

5]created supporting classes and packages for powerfull abstraction
>>CustomerServiceImpl class which implements CustomerService interface

/*
package com.demo.service;

import java.util.List;

import com.demo.model.Customer;

public interface CustomerService{
Customer save(Customer c);//save and update
	
	List<Customer> findAll();
	
	int deleteByEmail(String email);
	
	Customer findByEmail(String email);
	
	List<Customer> findByAny(String b1);
	
}
 */

/*
 * package com.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.CustomerDao;
import com.demo.model.Customer;

@Service
@Transactional
public class CustomerServiceImpl implements CustomerService{
	
	@Autowired
	private CustomerDao cd;

	@Override
	public Customer save(Customer c) {
		return cd.save(c);
	}

	@Override
	public List<Customer> findAll() {
		return cd.findAll();
	}

	@Override
	public int deleteByEmail(String email) {
		return cd.deleteByEmail(email);
	}

	@Override
	public Customer findByEmail(String email) {
		// TODO Auto-generated method stub
		return cd.findByEmail(email);
	}

	@Override
	public List<Customer> findByAny(String b1) {
		// TODO Auto-generated method stub
		return cd.findByAny(b1);
	}	
}

 */

6] created class CustomerController in controller package
>>contains API's (i.e methods)

/*
 * package com.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.demo.model.Customer;
import com.demo.service.CustomerService;

@Controller
public class CustomerController {
	
	@Autowired
	private CustomerService cs;
	
	@GetMapping(value="/")
	public String login() {
		return "login.jsp";
	}
	
	@PostMapping(value = "/customerlist")
	public ModelAndView customerList(Customer c, String b1, ModelAndView m) {
		m.addObject("customers", cs.findAll());
		m.setViewName("customerlist.jsp");
		return m;
	}
	
	@GetMapping(value = "/add")
	public String add() {
		return "customerdetails.jsp";
	}
	
	@GetMapping(value = "/customerdetails")
	public String customerDetails() {
		return "customerdetails.jsp";
	}
	
	@GetMapping(value = "/submit")
	public ModelAndView add(Customer c,String b1, ModelAndView m) {
		System.out.println("we're in submit");
		if(b1.equalsIgnoreCase("submit")) {
			System.out.println("we're in add");
			c = cs.save(c);
			if(c!=null)
				m.addObject("msg", "Customer inserted Successfully");
		}
		customerList(c,b1,m);
		return m;
	}
	
	@GetMapping(value = "/delete")
	public ModelAndView delete(Customer c, String s, ModelAndView m, String email) {
		
		System.out.println("we're in delete:");
		System.out.println(cs.deleteByEmail(email));
		
		//m.addObject("msg",(check!=0)?"Customer deleted successfully":"Customer not found");
		customerList(c, s, m);
		return m;
	}
	
	
	@GetMapping(value = "/search")
	public ModelAndView search(Customer c, String b1, ModelAndView m) {
		System.out.println("we're in search");
		m.addObject("customers", cs.findByAny(b1));
		m.setViewName("customerlist.jsp");
		return m;
	}
	
	@GetMapping(value = "/display")
	public ModelAndView display(Customer c, String b1, ModelAndView m) {
		c = cs.findByEmail(b1);
		if(c!=null) {
			m.addObject("customer", c);
			m.setViewName("customerdetails1.jsp");
		}
		return m;
	}
}
 */

7] Main class to exectution

/*
 * package com.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Main {

	public static void main(String[] args) {
		SpringApplication.run(Main.class, args);
	}

}

 */

Front-End:

In webapp package
1]login page(login.jsp)

/*
 * <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sunbase</title>
</head>
<body>
	<center>
		<h2>Login Page</h2>
		<br>
		<form action="customerlist" method="post">
			<input type="text" placeholder="Login id">
			<br>
			<br>
			<input type="password" placeholder="Password">
			<br>
			<br>
			<input type="submit" value="submit">
		</form>
	</center>

</body>
</html>
 */

 2]CustomerList page

 /*
  * <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
.button {
  background-color: red;
  border: none;
  color: black;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  cursor: pointer;
  border-radius: 50%;
}
.button1{
color: white;
background-color:rgb(35, 171, 229);
border-radius:5px;
border:none;
}
.pencil{
background-color:black;
color:white;
border:none;
}
.div{
            
            position: left;
            top: 50%;
            left: 1%;
            right: 1%;
            white-space: nowrap;
            height: 10%;
            width: 20%;
}
</style>
</head>
<body style="background-color:rgb(0, 0, 0)">
    <font style="color:white">
        <h2 style="text-align:center">Customer List</h2>
        <br>
        <div class = "div">
        <form action="add"><button class = "button1" >Add Customer</button></form>
        </div>
        <div class = "div">
        <select style="background-color: rgb(144, 208, 232);">
            <option value="Search">Search by</option>
            <form action = "byname"><option value="name" name="b1">First Name</option></form>
            <form action = "bycity"><option value="city" name="b1">City</option></form>
            <form action = "byemail"><option value="email" name="b1">Email</option></form>
            <form action = "byphone"><option value="phone" name="b1">Phone</option></form>
        </select>
        </div>
        <div class = "div">
        <form action = "search">
        <input type="text" name = "b1" placeholder="Search" >
        <button type="submit"><i class="fa fa-search"></i></button>
        </form>
        </div>
        <br>
        <br>
        <table style = "border:1">
        		<th>Id</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Address</th>
                <th>City</th>
                <th>State</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Action</th>
                <c:forEach var="c" items="${customers}">
                <tr>
                	<td>${c.id}</td>
	                <td>${c.firstName}</td>
	                <td>${c.lastName}</td>
	                <td>${c.street}</td>
	                <td>${c.address}</td>
	                <td>${c.state}</td>
	                <td>${c.email}</td>
	                <td>${c.phone}</td>
	                <td><form action = "delete" method = "get"><button class = "button" type="submit" name="email" value="${c.email }">-</button></form><form action = "display"><button class = " pencil fa fa-pencil" type="submit" name="b1" value="${c.email }"></button></form></td>
            	</tr>
                </c:forEach>
            
        </table>
    </font>
    <font size="2" color="red">${msg}</font>
</body>
</html>
  */

3]CustomerDetails page(customerdetails.jsp)

/*
 * <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Details</title> 
</head>
<body>
<h2 style="text-align:center">Customer Details</h2>
    <form action="submit">
    	<center>
        <pre>
        <input type="text" name = "firstName" placeholder="First Name" value = "${c.firstName}" >   <input type="text" name = "lastName" placeholder="Last Name" value = "${c.lastName}">
        <br>
        <input type="text" name = "street" placeholder="Street" value = "${c.street}" >   <input type="text" name = "address" placeholder="Address" value = "${c.address}">
        <br>
        <input type="text" name = "city" placeholder="City" value = "${c.city}">   <input type="text" name = "state" placeholder="State" value = "${c.state}">
        <br>
        <input type="text" name = "email" placeholder="Email" value = "${c.email}">   <input type="text" name = "phone" placeholder="Phone" value = "${c.phone}">
        </pre>
        </center>
	    <p style="text-align:center">
	        <input type="submit" name="b1" value="submit">
	    </p></form>
</body>
</html>
 */

 4]CustomerDetails1 page(customerdetails1.jsp)

 /*
  * <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>customer</title>
</head>
<body>
<h2 style="text-align:center">Customer Details</h2>
<form action = "update">
<center>
    <table>
    	<tr> 
    		<td>Id:</td>
    		<td><input type = "text" name = "id" value ="${customer.id}" readonly ></td>
    	</tr>
    	<tr> 
    		<td>FirstName:</td>
    		<td><input type = "text" name = "firstName" value ="${customer.firstName}" ></td>
    	</tr>
    	<tr> 
    		<td>LastName:</td>
    		<td><input type = "text" name = "lastName" value = "${customer.lastName}" ></td>
    	</tr>
    	<tr> 
    		<td>Street:</td>
    		<td><input type = "text" name = "street" value = "${customer.street}" ></td>
    	</tr>
    	<tr> 
    		<td>Address:</td>
    		<td><input type = "text" name = "address" value = "${customer.address}" ></td>
    	</tr>
    	<tr> 
    		<td>City:</td>
    		<td><input type = "text" name = "city" value = "${customer.city}" ></td>
    	</tr>
    	<tr> 
    		<td>State:</td>
    		<td><input type = "text" name = "state" value = "${customer.state}" ></td>
    	</tr>
    	<tr> 
    		<td>Email:</td>
    		<td><input type = "text" name = "email" value = "${customer.email}" ></td>
    	</tr>
    	<tr> 
    		<td>Phone:</td>
    		<td><input type = "text" name = "phone" value = "${customer.phone}" ></td>
    	</tr>
    		
    </table></center>
    <p align = "center">
    			<input type = "submit" name = "b1" value = "update">
    			</p></form>
</body>
</html>
  */

Back-end:
In Mysql:
        >>create database customer
        >>use database customer

