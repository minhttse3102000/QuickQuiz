<%-- 
    Document   : quiz
    Created on : Jan 26, 2021, 8:18:26 PM
    Author     : minhv
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <link href="CSS/quiz.css" rel="stylesheet" type="text/css"/>
        <title>Quiz Page</title>
    </head>
    <body>


        <c:if test="${sessionScope.QUIZ !=null && sessionScope.SUBJECT !=null && sessionScope.CURRENT_QUESTION !=null && sessionScope.LIST_CURRENT_ANSWER !=null}">
            <c:set var="index" value="-1"/>
            <c:forEach var="questionDTO" varStatus="counter" items="${sessionScope.QUIZ.listQuestion}">
                <c:if test="${questionDTO.questionID == sessionScope.CURRENT_QUESTION.questionID}">
                    <c:set var="index" value="${counter.count-1}"/>
                </c:if>
            </c:forEach>


            <h2>Subject :${sessionScope.SUBJECT.subjectName}</h2>  
            <h2>Student Name :${sessionScope.LOGIN_USER.fullName}</h2>  
            
            <form action="TakeQuizController" method="POST" class="main-layout">
                <input name="btnAction" type="submit" id="finish" value="FinishQuiz" onclick="return confirm('Do you want to finish ?')">
                <div class="container">
                    <h3>Time :</h3>
                    <p id="timeQuiz"></p>
                </div>
                <div>                      
                    <h4>Question ${index+1} :<br>${sessionScope.CURRENT_QUESTION.question_content}</h4> 
                    <c:forEach var="answerDTO" varStatus="counter" items="${sessionScope.LIST_CURRENT_ANSWER}">
                        <c:if test="${sessionScope.QUIZ.listAnswerSelected[index] == answerDTO.answerID}">
                            <input name="radioAnswerSelected" type="radio" checked="true" value="${answerDTO.answerID}"/>${answerDTO.answer_content}<br>
                        </c:if>
                        <c:if test="${sessionScope.QUIZ.listAnswerSelected[index] != answerDTO.answerID}">
                            <input name="radioAnswerSelected" type="radio" value="${answerDTO.answerID}"/>${answerDTO.answer_content}<br>
                        </c:if>
                    </c:forEach>

                    <input name="needToSaveQuestion" type="hidden" value="${sessionScope.CURRENT_QUESTION.questionID}"/>
                    <br> 
                </div> 

                <nav>
                    <ul class="pagination justify-content-center">
                        <c:forEach var="count" begin="1" end="${sessionScope.SUBJECT.numberQuestion}">
                            <li class="page-item">
                                <input class="page-link" name="txtCurrentQuestion" type="submit" value="${count}">
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </form>        
        </c:if>

        <c:if test="${requestScope.RESULT_MESSAGE !=null}">
            <h3>${requestScope.RESULT_MESSAGE}</h3>
            <a href="ShowQuizPageController" class="backQuiz">Back to Quiz page !</a>
        </c:if>


       
        <script>
            // Thiết lập thời gian đích mà ta sẽ đếm
            var ngaystring= "${sessionScope.QUIZ.finishedQuizTime}";
            var countDownDate = new Date(ngaystring).getTime();  
            // cập nhập thời gian sau mỗi 1 giây
            var x = setInterval(function() {

              // Lấy thời gian hiện tại
              var now = new Date().getTime();

              // Lấy số thời gian chênh lệch
              var distance = countDownDate - now;

              // Tính toán số ngày, giờ, phút, giây từ thời gian chênh lệch
              var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
              var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
              var seconds = Math.floor((distance % (1000 * 60)) / 1000);

              // HIển thị chuỗi thời gian trong thẻ p
              // Nếu thời gian kết thúc, hiển thị chuỗi thông báo
              if (distance > 0) {
                document.getElementById("timeQuiz").innerHTML =  hours + " hours "
              + minutes + " minutes " + seconds + " seconds " ;
              }
              if (distance < 0) {
                clearInterval(x);
                document.getElementById("timeQuiz").innerHTML = "Time out !" ;
                document.getElementById("finish").setAttribute('onclick','true');
                document.getElementById("finish").click();
              }
            }, 1000);
        </script>
    </body>
</html>
