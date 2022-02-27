package com.normal.jim.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "send", urlPatterns = "/send")
public class send extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String text=request.getParameter("wbeng");
        List<String>list=(List<String>)this.getServletContext().getAttribute("context");
        text=text.replaceAll(",","&#44;");
        text=text.replaceAll("<span>","&lt;span&gt;");
        text=text.replaceAll("</span>","&lt;/span&gt;");
        list.add(text);
        this.getServletContext().setAttribute("context",list);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
