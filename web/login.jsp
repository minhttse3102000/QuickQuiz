<%-- 
    Document   : login
    Created on : Oct 17, 2020, 3:55:38 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="CSS/login.css">   
        <link href="CSS/login.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>       
        <div class="main-div">
            <h1>Login </h1>
            <form action="LoginController" method="POST" class="main-layout">
                Email:  <input type="email" name="txtEmail" class="ID"/></br>
                Password: <input type="password" name="txtPassword" class="password"/></br>
                <input type="submit" name="btnAction" value="Login" class="login"/>
                <input type="reset" value="Reset" class="reset"/>
            </form>
            <c:if test="${sessionScope.LOGIN_INVALID !=null}">
                <h5>${sessionScope.LOGIN_INVALID}</h5>
            </c:if>
            <a href="ShowCreateUserPageController" class="create">Register</a>
        </div>
            
        
         
      
    </body>
</html>
