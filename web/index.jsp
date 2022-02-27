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
      function loadFile(file){
        $("#filePos").html(file.name);
      }

      function sendfile() {
        var formData = new FormData();
        formData.append("crowd_file",$('#file')[0].files[0]);
        $.ajax({
          url:'sendfile',
          dataType:'json',
          type:'POST',
          async: false,
          data: formData,
          processData : false,
          contentType : false,
          success: function(data){
              $("#close").click();
          },
          error:function(response){
            $("#close").click();
          }
        });
      }
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
            <span class="input-group-addon" onclick="" data-toggle="modal"   data-target="#myModal">+</span>
          </div>
    </div>

    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
              &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
              上传文件
            </h4>
          </div>
          <div class="modal-body input-group">
            <input type="file" name="fileName" id="file" style="width: 0;height: 0" onchange="loadFile(this.files[0])"><br>
            <label class="btn btn-info" for="file">选择文件</label>
            <label id="filePos">未上传</label>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭
            </button>
            <button type="button" class="btn btn-primary" onclick="sendfile()">
              发送文件
            </button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal -->
    </div>
  </center>
  </body>
</html>
