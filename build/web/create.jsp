<%-- 
    Document   : create
    Created on : Jan 26, 2021, 2:00:17 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Page</title>
        <link href="CSS/createQuestion.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <c:if test="${requestScope.QUESTION_ERROR ==null}">
            <c:set var="requestScope.QUESTION_ERROR.questionErrorID" value=""/>
            <c:set var="requestScope.QUESTION_ERROR.question_contentError" value=""/>
            <c:set var="requestScope.QUESTION_ERROR.answer_contentError" value=""/>
        </c:if>
        
        <a href="LogoutController" class="logout">Logout</a><br>
        <h2>Admin: ${sessionScope.LOGIN_USER.fullName}</h2>
        <div>     
            <h1>Create Question </h1>
            <c:if test="${sessionScope.LIST_ALL_SUBJECT !=null}">

                <form action="CreateQuestionController" method="POST" class="main-layout">
                    Question ID<input type="text" name="txtQuestionID" class="id" value="${param.txtQuestionID==null ?"":param.txtQuestionID}">                
                    ${requestScope.QUESTION_ERROR.questionErrorID}</br>
     
                    Question Content<input type="text" name="txtQuestionContent1" class="content" value="${param.txtQuestionContent1==null ?"":param.txtQuestionContent1}">                   
                    ${requestScope.QUESTION_ERROR.question_contentError}</br>
                    
                    Answer 1: <input type="text" name="txtAnswer1" class="answer" value="${param.txtAnswer1==null ?"":param.txtAnswer1}"></br>
                    Answer 2: <input type="text" name="txtAnswer2" class="answer" value="${param.txtAnswer2==null ?"":param.txtAnswer2}"></br>
                    Answer 3: <input type="text" name="txtAnswer3" class="answer" value="${param.txtAnswer3==null ?"":param.txtAnswer3}"></br>
                    Answer 4: <input type="text" name="txtAnswer4" class="answer" value="${param.txtAnswer4==null ?"":param.txtAnswer4}"></br>                    
                    ${requestScope.QUESTION_ERROR.answer_contentError}</br>
                    
                    Answer Correct <select name="cmbAnswerCorrect" class="answer">
                    <c:forEach var="count" begin="1" end="4">
                        <option value="${count}">Answer ${count}</option>
                    </c:forEach>   
                </select></br>

                Subject <select name="cmbSubject" class="subject">
                    <c:forEach var="subjectDTO" varStatus="counter" items="${sessionScope.LIST_ALL_SUBJECT}">
                        <option value="${subjectDTO.subjectID}">${subjectDTO.subjectName}</option>
                    </c:forEach>
                </select></br>                                

                <input type="submit" name="btnAction" value="Create Question" class="create">
                <input type="reset"  value="Reset" class="reset">
            </form>
        </c:if>
    </div>
</body>
</html>
