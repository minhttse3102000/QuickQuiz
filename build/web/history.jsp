<%-- 
    Document   : history
    Created on : Jan 30, 2021, 3:43:17 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="CSS/history.css" rel="stylesheet" type="text/css"/>
        <title>History Page</title>
    </head>
    <body>

        <a href="ShowQuizPageController" class="quiz">Back to Quiz Page</a> 
        <a href="LogoutController" class="logout">Logout</a>
        <h1>Student name : ${sessionScope.LOGIN_USER.fullName}</h1>
        <br><br><h1>History : </h1><br><br>

        <form action="SearchHitoryController" class="main-layout" method="POST">
            Search history: <br>
            Subject:  
            <select name="cmbSubject" class="subject">
                <c:set var="all" value=""/>
                <c:if test="${param.cmbSubject==null}">
                    <c:forEach var="subject" varStatus="counter" items="${sessionScope.LIST_ALL_SUBJECT}">
                        <option value="${subject.subjectID}">${subject.subjectName}</option>                                   
                    </c:forEach>                     
                        <option value="">All</option>
                </c:if>
                <c:if test="${param.cmbSubject==all}">     
                    <c:forEach var="subject" varStatus="counter" items="${sessionScope.LIST_ALL_SUBJECT}">
                        <option value="${subject.subjectID}">${subject.subjectName}</option>                                   
                    </c:forEach>                     
                        <option value="" selected="true">All</option>
                </c:if>    
                <c:if test="${param.cmbSubject!=null && param.cmbSubject!=all}">
                    <c:forEach var="subject" varStatus="counter" items="${sessionScope.LIST_ALL_SUBJECT}">
                        <c:if test="${param.cmbSubject==subject.subjectID}">
                            <option value="${subject.subjectID}" selected="true">${subject.subjectName}</option>   
                        </c:if>                                   
                        <c:if test="${param.cmbSubject!=subject.subjectID}">
                            <option value="${subject.subjectID}">${subject.subjectName}</option>   
                        </c:if> 
                    </c:forEach>
                    <option value="">All</option>
                </c:if> 
            </select>
            <input type="submit" name="btnAction" value="Search History" class="search"/>
        </form>



        <c:if test="${requestScope.MESSAGE !=null}">
            <h3>${requestScope.MESSAGE}</h3>
        </c:if>

        <c:if test="${requestScope.LIST_HISTORY !=null}">
            <c:if test="${not empty requestScope.LIST_HISTORY}">

                <table border="1">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>SubjectID</th>
                            <th>Total Mark</th>
                            <th>Number answer correct</th>
                            <th>Finished Quiz Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="string" varStatus="counter" items="${requestScope.LIST_HISTORY}">
                            <c:set var="arr" value="${fn:split(string, '_')}" /> 
                            <c:forEach var="subject" varStatus="counter1" items="${sessionScope.LIST_ALL_SUBJECT}">
                                <c:if test="${subject.subjectID ==arr[1]}">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>${arr[1]}</td>
                                        <td>${arr[2]}</td>
                                        <td>${(arr[2]*subject.numberQuestion)/10}/${subject.numberQuestion}</td>       
                                        <td>${arr[3]}</td>  
                                        <td><a href="ShowDetailController?quizID=${arr[0]}&subjectID=${arr[1]}&totalMark=${arr[2]}" >Detail</a></td> 
                                    </tr>
                                </c:if>
                            </c:forEach>

                        </c:forEach>
                    </tbody>
                </table>                           

            </c:if>
        </c:if>
    </body>
</html>
