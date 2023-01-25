<%-- 
    Document   : quiz
    Created on : Jan 22, 2021, 8:22:19 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="CSS/user.css" rel="stylesheet" type="text/css"/>
        <title>User Page</title>
    </head>
    <body>

        <a href="LogoutController" class="logout">Logout</a>
        <a href="ShowHistoryPageControlller"class="history">History</a>
        <h1>Welcome ${sessionScope.LOGIN_USER.fullName}</h1>  
        <form action="TakeQuizController" method="POST">
            <h3>Select subject to do quiz : <select name="cmbSubject" class="subject">
                    <c:forEach var="subjectDTO" varStatus="counter" items="${sessionScope.LIST_ALL_SUBJECT}">
                        <option value="${subjectDTO.subjectID}">${subjectDTO.subjectName}</option>
                    </c:forEach>
                </select>
            </h3>
            <input type="submit" name="btnAction" value="Take Quiz" class="quiz"/>
        </form>


    </body>
</html>
