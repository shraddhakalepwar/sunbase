<%@ page language="java" contentType="text/html; charset=UTF-8"
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