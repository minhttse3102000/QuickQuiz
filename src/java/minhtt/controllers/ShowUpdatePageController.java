/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package minhtt.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import minhtt.daos.AnswerDAO;
import minhtt.daos.QuestionDAO;
import minhtt.daos.SubjectDAO;
import minhtt.dtos.AnswerDTO;
import minhtt.dtos.QuestionDTO;
import minhtt.dtos.SubjectDTO;
import minhtt.dtos.UserDTO;

/**
 *
 * @author minhv
 */
public class ShowUpdatePageController extends HttpServlet {
    private final static String SUCCESS = "update.jsp";
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
                QuestionDAO questionDao=new QuestionDAO();
                SubjectDAO subjectDao = new SubjectDAO();              
                AnswerDAO answerDao=new AnswerDAO();
                
                QuestionDTO questiondto=questionDao.getQuestion(questionID);
                session.setAttribute("QUESTION_UPDATE", questiondto);
                
                List<AnswerDTO> listAnswer = answerDao.getAnswersFromQuestionID(questionID);
                session.setAttribute("LIST_ANSWER_UPDATE", listAnswer);
                
                List<SubjectDTO> listSubject = subjectDao.getAllSubject();
                if (listSubject != null) {
                    url = SUCCESS;
                    session.setAttribute("LIST_SUBJECT", listSubject);
                }
            }
        } catch (Exception e) {
            log("Error at ShowUpdatePageServlet " + e.toString());
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
