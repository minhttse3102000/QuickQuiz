<%-- 
    Document   : update
    Created on : Jan 24, 2021, 8:00:17 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Page</title>
        <link href="CSS/update.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <c:set var="requestScope.QUESTION_ERROR.question_contentError" value=""/>
        <c:set var="requestScope.QUESTION_ERROR.answer_contentError" value=""/>
        <a href="LogoutController" class="logout">Logout</a><br>
        <h2>Admin: ${sessionScope.LOGIN_USER.fullName}</h2>
        <div>     
            <h1>Update Question </h1>
            <c:if test="${sessionScope.LIST_SUBJECT !=null}">
                <c:set var="answerCount" value="1"/>
                <form action="UpdateController" method="POST" class="main-layout">

                    Question ID : ${sessionScope.QUESTION_UPDATE.questionID}<br>
                    Create date : ${sessionScope.QUESTION_UPDATE.createDate}<br>

                    <input type="hidden" name="txtQuestionID" value="${sessionScope.QUESTION_UPDATE.questionID}">
                    </br>

                    Question Content  <input type="text" name="txtQuestionContentt" value="${sessionScope.QUESTION_UPDATE.question_content}" class="content">
                    ${requestScope.QUESTION_ERROR.question_contentError}
                    </br>

                    <c:forEach var="answerDTO" varStatus="counter" items="${sessionScope.LIST_ANSWER_UPDATE}">
                        <input type="hidden" name="txtAnswerID${answerCount}" value="${answerDTO.answerID}">
                        Answer ${answerCount}: <input type="text" name="txtAnswerContent${answerCount}" value="${answerDTO.answer_content}"></br> 
                        <c:set var="answerCount" value="${answerCount+1}"/>
                    </c:forEach>                                          
                    ${requestScope.QUESTION_ERROR.answer_contentError}
                    </br>
                    Answer correct <select name="cmbAnswerCorrect" class="answerCorrect">
                        <c:forEach var="answerDTO" varStatus="counter" items="${sessionScope.LIST_ANSWER_UPDATE}">
                            <c:if test="${answerDTO.answer_correct ==true}">
                                <option value="${answerDTO.answerID}" selected="true">Answer ${counter.count}</option>
                            </c:if>
                            <c:if test="${answerDTO.answer_correct !=true}">
                                <option value="${answerDTO.answerID}" >Answer ${counter.count}</option>
                            </c:if>
                        </c:forEach>    
                    </select></br>

                    <input type="hidden" name="txtAnswercount" value="${answerCount}">

                    Subject <select name="cmbSubject" class="subject">
                        <c:forEach var="subjectDTO" varStatus="counter" items="${sessionScope.LIST_SUBJECT}">
                            <c:if test="${sessionScope.QUESTION_UPDATE.subjectID ==subjectDTO.subjectID}">
                                <option value="${subjectDTO.subjectID}" selected="true">${subjectDTO.subjectName}</option>
                            </c:if>
                            <c:if test="${sessionScope.QUESTION_UPDATE.subjectID !=subjectDTO.subjectID}">
                                <option value="${subjectDTO.subjectID}">${subjectDTO.subjectName}</option>
                            </c:if>
                        </c:forEach>                                
                    </select></br>


                    Status<select name="cmbStatus" class="status">
                        <c:if test="${sessionScope.QUESTION_UPDATE.status ==true}">
                            <option value="false">Inactive</option>
                            <option value="true" selected="true">Active</option>
                        </c:if>
                        <c:if test="${sessionScope.QUESTION_UPDATE.status !=true}">
                            <option value="false" selected="true">Inactive</option>
                            <option value="true">Active</option>
                        </c:if>


                    </select>         
                    </br>

                    <input type="submit" name="btnAction" value="Update Question" class="update">

                </form>
                <c:if test="${requestScope.UPDATE_MESSAGE_ERROR !=null}">
                    <h3>${requestScope.UPDATE_MESSAGE_ERROR}</h3>
                </c:if>    

            </c:if>
        </div>
    </body>
</html>
