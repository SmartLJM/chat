<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>chat</title>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%--    <script src="http://files.cnblogs.com/dachie/jquery.timers-1.2.js" type="text/javascript"></script>--%>
    <script>
      let len=0;
      function showContent(){
        clearInterval(dt);
         len=$('#sp span').length;
          $.ajax({
            url:'getNum',
            type: 'post',
            data: {length:len},
            success:function (data){
              if (data!=""){
                var words="";
                words=data.split(",");
                $("#text #sp span").first().html("最新的消息发送自"+new Date().toString());
                  words.forEach(function (word){
                    $("#text #sp span").last().after("<span>"+word+"</span>");
                    $("#text").scrollTop($("#sp").height());
                  })

              }
            }
          });
          start();
      }
      $(document).keyup(function(event){
        if(event.keyCode ==13){
          send();
        }
      });
      function send(){
        var wenzi=$("#nr").val();
        if (wenzi==""){
          alert("我说婷婷");
        }else{
          $.ajax({
            url: 'send',
            type: 'post',
            data: {wbeng:wenzi},
            success: function(returnObj){
              $("#nr").val("");
            },
            error:function (){
              alert("不知咋回事发送失败了");
            }
          });
        }
      }

    var dt=setInterval("showContent()",2000);
      function start(){
        dt=setInterval("showContent()",2000);
      }
      // $('body').everyTime('1s','B','showContent()',0,true);

    </script>
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
      #text #sp span{
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
      #sp{
        float: left;
        height: auto;
        width: 100%;
      }
    </style>
  </head>
  <body>
  <center>
    <div id="chatDiv">
      <center>
        <div id="text">
          <div id="sp">
          <span style="font-size: 0.5em;text-align: center; background-color:rgba(0,0,0,0);">房间首次打开暂无聊天</span>
          </div>
        </div>
      </center>
        <div id="inputb" class="input-group" style="margin-bottom:0;">
          <input type="text" id="nr" class="form-control">
            <span class="input-group-addon" onclick="send()">发送</span>
          </div>
    </div>
  </center>
  </body>
</html>
