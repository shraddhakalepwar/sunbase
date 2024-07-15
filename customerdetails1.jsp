<%@ page language="java" contentType="text/html; charset=UTF-8"
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