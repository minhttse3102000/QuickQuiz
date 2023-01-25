/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package minhtt.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import minhtt.daos.AnswerDAO;
import minhtt.daos.QuizDAO;
import minhtt.daos.QuizDetailDAO;
import minhtt.dtos.QuestionDTO;
import minhtt.dtos.QuizDTO;
import minhtt.dtos.SubjectDTO;
import minhtt.dtos.UserDTO;

/**
 *
 * @author minhv
 */
public class FinishQuizController extends HttpServlet {
    private final static String SUCCESS = "quiz.jsp";
    private final static String ERROR = "quiz.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser != null && loginUser.getRoleID().equals("US")) {
                String answerSelectedID = request.getParameter("radioAnswerSelected");             
                QuizDTO quiz = (QuizDTO) session.getAttribute("QUIZ");
                SubjectDTO subjectCurrent = (SubjectDTO) session.getAttribute("SUBJECT");
                
                QuizDAO quizDAO = new QuizDAO();
                QuizDetailDAO detailDAO = new QuizDetailDAO();
                AnswerDAO answerDAO=new AnswerDAO();
                
                if(quiz!=null && subjectCurrent!=null) {//luu dap an da selected
                    String needSaveQuestionID = request.getParameter("needToSaveQuestion");
                    if (answerSelectedID != null) {
                        if (answerDAO.checkAnswerCorrect(Integer.parseInt(answerSelectedID)) == true) {  // cap nhat dap an da chon 
                            detailDAO.updateQuizDetail(quiz.getQuizID(), needSaveQuestionID, Integer.parseInt(answerSelectedID), true);
                        } else {
                            detailDAO.updateQuizDetail(quiz.getQuizID(), needSaveQuestionID, Integer.parseInt(answerSelectedID), false);
                        }
                        int index = -1;
                        for (QuestionDTO questionDTO : quiz.getListQuestion()) {
                            if (needSaveQuestionID.equals(questionDTO.getQuestionID())) {
                                index = quiz.getListQuestion().indexOf(questionDTO);
                            }
                        }
                        quiz.getListAnswerSelected()[index] = Integer.parseInt(answerSelectedID);
                    }
                    
                    float totalMarkUpdate=detailDAO.getTotalMark(quiz.getQuizID());//cap nhat diem
                    quiz.setTotalMark(totalMarkUpdate);
                    quizDAO.updateTotalMark(quiz.getQuizID(), totalMarkUpdate);
                    
                    SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");//cap nhat thoi gian finish
                    Date date = new Date();
                    String strCurrentDate = formatter.format(date);
                    quizDAO.updateFinishTime(quiz.getQuizID(), strCurrentDate);
                    
                    request.setAttribute("RESULT_MESSAGE", "You finished quiz successful, you score: "+quiz.getTotalMark()+"/10, question correct: "+quiz.getTotalMark()*subjectCurrent.getNumberQuestion()/10+"/"+subjectCurrent.getNumberQuestion());
                    session.setAttribute("CURRENT_QUESTION", null);
                    session.setAttribute("LIST_CURRENT_ANSWER", null);
                    session.setAttribute("SUBJECT", null);
                    session.setAttribute("QUIZ", null);
 
                    url = SUCCESS;
                }
            }
        } catch (Exception e) {
            log("Error at FinishQuizServlet " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
