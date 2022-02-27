<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*"%>
<%@ page import="com.sun.deploy.net.HttpResponse" %>
<% request.setCharacterEncoding("utf-8");%>

<%
    List<String> chatList = new ArrayList<String>();
    String name=request.getParameter("name");
    String type=request.getParameter("ty");


    if (type!=null){
        String wbeng=request.getParameter("wbeng");
        chatList=(List<String>)application.getAttribute("chatList");
        chatList.add(wbeng);
        application.setAttribute("chatList",chatList);
    }
    chatList=(List<String>) application.getAttribute("chatList");
    if (chatList==null){
        chatList= new ArrayList<String>();
        chatList.add("系统提示：本房暂无人说话");
        application.setAttribute("chatList", chatList);
    }
    int count=0;
    try{
         count = Integer.parseInt((String) request.getParameter("count"));
    }catch (Exception e){
         count=chatList.size()+1;
    }

    HttpServletResponse response1
    if (count< chatList.size()){

        out.print(true);
    }else{
        out.print(false);
    }

%>
<!DOCTYPE html>
<html lang="en">
<link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>

    var username="<%=name%>";
    window.setInterval("showContent();",1000);
    $(function(){
        var h = $("#text").height()-$(window).height();
        $("#text").scrollTop($("#text").height());
        showContent();
    });


    function showContent(){
        <%
        List<String> wordList=(List<String>)application.getAttribute("chatList");
        %>
        var len=$('#text').children().length;
        $.ajax({
            url: 'chat.jsp',
            type: 'get',
            data: 'count=' + len,
            success: function(returnObj){
                var flag=returnObj;
            }
        });
        if (flag){
            alert("test");
            $("#text").empty();
        <%
        for (String word : wordList) {
            %>
            if ($('#text').children().length==0){
                $("#text").append("<span><%=word%></span>");
            }else{
                $("#text span").last().after("<span><%=word%></span>");
                location.reload();
            }
            <%
        }
        %>
        }

    }
    function send(){
        var wenzi=$("#nr").val();
        $.ajax({
            url: 'chat.jsp',
            type: 'get',
            data: 'wbeng=' + wenzi,
            success: function(returnObj){
                $("#nr").val("");

            }
        });

    }


</script>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        #chatDiv{
            filter:blur(0.5px);
            top:20px;
            width:300px;
            height:600px;
            position: relative;
            background: rgba(70, 63, 63, 0.1);
            overflow: hidden;
        }
        #inputb{
            position: absolute;
            bottom:2px;
        }
        #text{
            padding-top:2px;
            position: absolute;
            top:0px;
            width:99%;
            height:540px;
            overflow-y: auto;
        }
        #text span{
            background-color: rgb(9,218,249,0.4);
            border-radius: 0.5em;
            float:left;
            width:90%;
            height: auto;
            text-align:left;
            padding-left:1em;
            padding-right:1em;
            margin-left: 1em;
            margin-top:5px;
            font-size:1.5em;
            word-wrap:break-word;
            word-break:break-all;
            overflow: hidden;
        }
    </style>

    <title>chat</title>
</head>
<body>
<center>
    <div id="chatDiv">
        <center>
            <div id="text">
                <span>derderder</span>
            </div>
        </center>
        <form>
            <div id="inputb" class="input-group" style="margin-bottom:0;">
                <input type="text" id="nr" class="form-control">
                <span class="input-group-addon" onclick="send()">发送</span>
            </div>
        </form>
    </div>
</center>
</body>
</html>