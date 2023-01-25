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
import minhtt.daos.AnswerDAO;
import minhtt.daos.QuestionDAO;
import minhtt.dtos.AnswerDTO;
import minhtt.dtos.QuestionDTO;
import minhtt.dtos.QuestionErrorDTO;

/**
 *
 * @author minhv
 */
public class CreateQuestionController extends HttpServlet {
    private final static String ERROR = "create.jsp";
    private final static String SUCCESS = "ShowAdminPageController";

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
            String questionID = request.getParameter("txtQuestionID");
            String questionContent = request.getParameter("txtQuestionContent1");
            String answerContent1 = request.getParameter("txtAnswer1");
            String answerContent2 = request.getParameter("txtAnswer2");
            String answerContent3 = request.getParameter("txtAnswer3");
            String answerContent4 = request.getParameter("txtAnswer4");    
            String answerCorrect = request.getParameter("cmbAnswerCorrect");         
            String cmbSubject = request.getParameter("cmbSubject");
            
            QuestionErrorDTO errorObject = new QuestionErrorDTO("", "", "", "", "", "");
            QuestionDAO questionDAO = new QuestionDAO();
            AnswerDAO answerDAO = new AnswerDAO();
            boolean check = true;
            if (questionID.trim().isEmpty()) {
                check = false;
                errorObject.setQuestionErrorID("QuestionID is not empty !");
            }
            if (questionContent.trim().isEmpty()) {
                check = false;
                errorObject.setQuestion_contentError("Question Content is not empty !");
            }
            if (answerContent1.trim().isEmpty() || answerContent2.trim().isEmpty() || answerContent3.trim().isEmpty() || answerContent4.trim().isEmpty()) {
                check = false;
                errorObject.setAnswer_contentError("Answer Content is invalid !");
            }
            if (answerContent1.trim().equals(answerContent2.trim()) || answerContent1.trim().equals(answerContent3.trim()) || answerContent1.trim().equals(answerContent4.trim()) || 
                    answerContent2.trim().equals(answerContent3.trim()) || answerContent2.trim().equals(answerContent4.trim()) || answerContent3.trim().equals(answerContent4.trim())) {
                check = false;
                errorObject.setAnswer_contentError("Answer Content is invalid !");
            }
            if (questionDAO.checkID(questionID)==true) {
                check = false;
                errorObject.setQuestionErrorID("QuestioonID is duplicate !");
            }
            if (check == true) {
                SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
                Date date = new Date();
                String strCurrentDate = formatter.format(date);
                QuestionDTO questionDTO = new QuestionDTO(questionID, questionContent, strCurrentDate, cmbSubject, true);
                questionDAO.create(questionDTO);
                for (int i = 1; i <= 4; i++) {
                    if (Integer.parseInt(answerCorrect)==i) {
                        String answerContent = request.getParameter("txtAnswer" + i);
                        AnswerDTO answerDTO = new AnswerDTO("", answerContent, true, questionID, true);
                        answerDAO.create(answerDTO);
                    }else{
                        String answerContent = request.getParameter("txtAnswer" + i);
                        AnswerDTO answerDTO = new AnswerDTO("", answerContent, false, questionID, true);
                        answerDAO.create(answerDTO);
                    }
                }
                url = SUCCESS;
            } else {
                request.setAttribute("QUESTION_ERROR", errorObject);
            }
        } catch (Exception e) {
            log("Error at CreateQuestionServlet: " + e.toString());
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
