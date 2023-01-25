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
import minhtt.daos.QuizDetailDAO;
import minhtt.dtos.AnswerDTO;
import minhtt.dtos.QuestionDTO;
import minhtt.dtos.UserDTO;

/**
 *
 * @author minhv
 */
public class ShowDetailController extends HttpServlet {
    private final static String DETAIL = "detail.jsp";
    private final static String ERROR = "detail.jsp";

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
            String quizID = request.getParameter("quizID");
            String subjectID = request.getParameter("subjectID");
            String totalMark = request.getParameter("totalMark");

            QuestionDAO questionDAO=new QuestionDAO();
            AnswerDAO answerDAO=new AnswerDAO();
            QuizDetailDAO detailDAO =new QuizDetailDAO();
            if (loginUser != null && loginUser.getRoleID().equals("US")) {
                if (quizID != null) {
                    List<QuestionDTO> listQuestion = questionDAO.getQuestionHistory(quizID);
                    if (listQuestion != null && listQuestion.size()>0) {
                        List<AnswerDTO> listAnswer = answerDAO.getAnswerHistory(quizID);
                        List<String> listSelectedAnswer= detailDAO.getListAnswerSelectedAndQuestionID(quizID);                       
                        url = DETAIL;
                        session.setAttribute("LIST_QUESTION_HISTORY", listQuestion);
                        session.setAttribute("LIST_ANSWER_HISTORY", listAnswer);
                        session.setAttribute("LIST_SELECTED_ANSWER_HISTORY", listSelectedAnswer);
                        session.setAttribute("TOTALMARK_HISTORY", totalMark);
                        session.setAttribute("SUBJECTID_HISTORY", subjectID);
                    } 
                }
            }
        } catch (Exception e) {
            log("Error at ShowDetailServlet " + e.toString());
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
