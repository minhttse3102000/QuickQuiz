/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package minhtt.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import minhtt.daos.AnswerDAO;
import minhtt.daos.QuestionDAO;
import minhtt.dtos.AnswerDTO;
import minhtt.dtos.QuestionDTO;
import minhtt.dtos.QuestionErrorDTO;
import minhtt.dtos.UserDTO;

/**
 *
 * @author minhv
 */
public class UpdateController extends HttpServlet {

    private final static String SUCCESS = "admin.jsp";
    private final static String ERROR = "update.jsp";

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
            if (loginUser != null && loginUser.getRoleID().equals("AD")) {
                String questionID = request.getParameter("txtQuestionID");
                String questionContent = request.getParameter("txtQuestionContentt");
                String subjectID = request.getParameter("cmbSubject");
                String status = request.getParameter("cmbStatus");

                String count = request.getParameter("txtAnswercount");
                String answerCorrect = request.getParameter("cmbAnswerCorrect");
                QuestionDAO questionDao = new QuestionDAO();
                AnswerDAO answerDao = new AnswerDAO();
                if (questionDao.checkQuestionInQuiz(questionID)==true) {
                    request.setAttribute("UPDATE_MESSAGE_ERROR", "Cannot be updated, this question is in quiz at the moment");               
                } else {
                    QuestionErrorDTO errorObject = new QuestionErrorDTO("", "", "", "", "", "");                   
                    boolean check = true;
                    if (questionContent.isEmpty()) {
                        check = false;
                        errorObject.setQuestion_contentError("Question content is not empty !");
                    }
                                      
                    String answerContent1 = request.getParameter("txtAnswerContent1");
                    String answerContent2 = request.getParameter("txtAnswerContent1");
                    String answerContent3 = request.getParameter("txtAnswerContent1");
                    String answerContent4 = request.getParameter("txtAnswerContent1");
                    if (answerContent1.trim().isEmpty() || answerContent2.trim().isEmpty() || answerContent3.trim().isEmpty() || answerContent4.trim().isEmpty()) {
                        check = false;
                        errorObject.setAnswer_contentError("Answer content is invalid !");
                    }
                    if (answerContent1.trim().equals(answerContent2.trim()) || answerContent1.trim().equals(answerContent3.trim()) || answerContent1.trim().equals(answerContent4.trim())
                            || answerContent2.trim().equals(answerContent3.trim()) || answerContent2.trim().equals(answerContent4.trim()) || answerContent3.trim().equals(answerContent4.trim())) {
                        check = false;
                        errorObject.setAnswer_contentError("Answer content is invalid !");
                    }

                    if (check == true) {
                        QuestionDTO questionDTO = new QuestionDTO(questionID, questionContent, "", subjectID, Boolean.parseBoolean(status));
                        questionDao.update(questionDTO);
                        for (int i = 1; i <= (Integer.parseInt(count) - 1); i++) {
                            String answerID = request.getParameter("txtAnswerID" + i);
                            String answerContent = request.getParameter("txtAnswerContent" + i);
                            if (answerCorrect.equals(answerID)) {
                                AnswerDTO answerDTO = new AnswerDTO(answerID, answerContent, true, questionID, true);
                                answerDao.update(answerDTO);
                            } else {
                                AnswerDTO answerDTO = new AnswerDTO(answerID, answerContent, false, questionID, true);
                                answerDao.update(answerDTO);
                            }
                        }
                        url = SUCCESS;

                    } else {
                        request.setAttribute("QUESTION_ERROR", errorObject);
                    }
                }
            }
        } catch (Exception e) {
            log("Error at UpdateServlet " + e.toString());
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
