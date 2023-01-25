<%-- 
    Document   : detail
    Created on : Mar 19, 2021, 4:32:29 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detail Page</title>
    </head>
    <body>
        <a href="ShowQuizPageController" class="quiz">Back to Quiz Page</a> 
        <a href="LogoutController" class="logout">Logout</a>
        <h1>Student name : ${sessionScope.LOGIN_USER.fullName}</h1>
        <h1>Detail : </h1>
        Subject:  ${sessionScope.SUBJECTID_HISTORY}<br>
        Total Mark: ${sessionScope.TOTALMARK_HISTORY}<br>
        
        
        <c:if test="${sessionScope.LIST_QUESTION_HISTORY !=null}">
            <c:if test="${not empty sessionScope.LIST_QUESTION_HISTORY}">
                <table border="1">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Question Content</th>
                            <th>Answer 1</th>
                            <th>Answer 2</th>
                            <th>Answer 3</th>
                            <th>Answer 4</th>
                            <th>Answer Selected</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="questionDto" varStatus="counter" items="${sessionScope.LIST_QUESTION_HISTORY}">
                            <tr>
                            <td>${counter.count}</td>
                            <td>${questionDto.question_content}</td>
                                                                          
                            <c:forEach var="answerDto" varStatus="counter1" items="${sessionScope.LIST_ANSWER_HISTORY}">
                                <c:if test="${questionDto.questionID ==answerDto.questionID}">                                    
                                    <td>${answerDto.answer_content}</td>                                                                            
                                </c:if>                           
                            </c:forEach>
                                    
                            <c:forEach var="string" varStatus="counter2" items="${sessionScope.LIST_SELECTED_ANSWER_HISTORY}">
                                <c:set var="arr" value="${fn:split(string, '_')}" /> 
                                <c:forEach var="answerDto" varStatus="counter4" items="${sessionScope.LIST_ANSWER_HISTORY}">
                                    <c:if test="${arr[0]== answerDto.answerID && arr[1] ==questionDto.questionID}">                                    
                                        <td>${answerDto.answer_content}</td>                                                                            
                                    </c:if>
                                </c:forEach>
                            </c:forEach>                                                                  
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>                           
            </c:if>
        </c:if>
    </body>
</html>
