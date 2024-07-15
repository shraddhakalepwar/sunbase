<%@ page language="java" contentType="text/html; charset=UTF-8"
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