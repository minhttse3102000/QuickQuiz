/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package minhtt.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import minhtt.dtos.AnswerDTO;
import minhtt.utils.DBUtils;

/**
 *
 * @author minhv
 */
public class AnswerDAO {
    public List<AnswerDTO> getAnswersFromQuestionID(String questionID) throws SQLException {
        List<AnswerDTO> result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT answerID,answer_content,questionID,answer_correct,status \n" +
                             "FROM tblAnswers\n" +
                             "where questionID=?";
                stm = conn.prepareStatement(sql);
                stm.setString(1,questionID); 
                rs = stm.executeQuery();
                while (rs.next()) {
                    
                    String answerID =rs.getString("answerID");
                    String answer_content=rs.getString("answer_content");
                    boolean answer_correct=rs.getBoolean("answer_correct");
                    boolean status=rs.getBoolean("status");
                    if (result == null) {
                        result = new ArrayList<>();
                    }
                    result.add(new AnswerDTO(answerID, answer_content, answer_correct, questionID, status));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }
    
    public void update(AnswerDTO answerDTO) throws SQLException{
        Connection conn=null;
        PreparedStatement stm=null;
        try {
            conn=DBUtils.getConnection();
            if(conn!=null){
                String sql="UPDATE tblAnswers\n" +
                           "SET answer_content=?,answer_correct=?\n" +
                           "WHERE answerID = ?";
                stm=conn.prepareStatement(sql);           
                stm.setString(1, answerDTO.getAnswer_content());             
                stm.setBoolean(2, answerDTO.isAnswer_correct());
                stm.setString(3,answerDTO.getAnswerID());
                stm.executeUpdate();          
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            if(stm!=null)stm.close();
            if(conn!=null)conn.close();
        }
    }
    
    public void create(AnswerDTO answer) throws SQLException{
        Connection conn=null;
        PreparedStatement stm=null;
        try {
            conn=DBUtils.getConnection();
            if(conn!=null){
                String sql="INSERT INTO tblAnswers\n" +
                           "values(?,?,?,1)";
                stm=conn.prepareStatement(sql);
                stm.setString(1,answer.getAnswer_content());
                stm.setString(2,answer.getQuestionID());
                stm.setBoolean(3,answer.isAnswer_correct());        
                stm.executeUpdate();          
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            if(stm!=null)stm.close();
            if(conn!=null)conn.close();
        }
    }
    
    public boolean checkAnswerCorrect(int answerID) throws SQLException{
        boolean result=false;
        Connection conn=null;
        PreparedStatement stm=null;
        ResultSet rs=null;
        try {
            conn=DBUtils.getConnection();
            if(conn!=null){
                String sql="SELECT answerID\n" +
                           "from tblAnswers \n" +
                           "where answerID= ? and answer_correct='1'";
                stm=conn.prepareStatement(sql);
                stm.setInt(1,answerID);
                rs=stm.executeQuery();
                if(rs.next()){
                    result=true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            if(rs!=null)rs.close();
            if(stm!=null)stm.close();
            if(conn!=null)conn.close();
        }
        return result;
    }
    
    public List<AnswerDTO> getAnswerHistory(String quizID) throws SQLException {
        List<AnswerDTO> result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT A.answerID,A.answer_content,A.answer_correct,A.questionID\n" +
                            "from tblQuizs Q,tblQuizDetail D,tblQuestions QE,tblAnswers A\n" +
                            "where Q.quizID= ? and Q.quizID=D.quizID and D.questionID=QE.questionID and QE.questionID=A.questionID";
                stm = conn.prepareStatement(sql);
                stm.setString(1,  quizID );
                rs = stm.executeQuery();
                while (rs.next()) {
                    String answerID = rs.getString("answerID");
                    String answer_content = rs.getString("answer_content");
                    String questionID = rs.getString("questionID");
                    boolean answerCorrect=rs.getBoolean("answer_correct");
                    if (result == null) {
                        result = new ArrayList<>();
                    }
                    result.add(new  AnswerDTO(answerID, answer_content, answerCorrect, questionID, true));
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }
}
