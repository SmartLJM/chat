package com.normal.jim.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "getNum", urlPatterns = "/getNum")
public class getNum extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> list=(List<String>)this.getServletContext().getAttribute("context");
        int len=Integer.parseInt((String)request.getParameter("length"));
        int num=list.size();
        String result="";
        if (len<num){
            for (int i=len;i<num;i++){
                result=result+list.get(i)+",";
            }
            result=result.substring(0, result.length() - 1);
        }
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out=response.getWriter();
        out.write(result);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
