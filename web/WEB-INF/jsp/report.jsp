<%-- 
    Document   : homepage
    Created on : 24-ene-2017, 12:12:45
    Author     : nmohamed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <%@ include file="menu.jsp" %>
        
    <head>
        <title>Home</title>

    <script type="text/javascript">
    

    
    $(document).ready( function () {
    
        //VARIABLE CUANDO HEMOS CREADO UNA LESSONS CORRECTAMENTE
        
   <%--      var lessondelete = '<%= request.getParameter("messageDelete") %>'; --%>
            var userLang = navigator.language || navigator.userLanguage;
      $('#start').datetimepicker({
            
            format: 'YYYY-MM-DD',
            locale: userLang.valueOf(),
            daysOfWeekDisabled: [0, 6],
            useCurrent: false//Important! See issue #1075
            //defaultDate: '08:32:33',

  
        });
        $('#end').datetimepicker({
            
            format: 'YYYY-MM-DD',
            locale: userLang.valueOf(),
            daysOfWeekDisabled: [0, 6],
            useCurrent: false//Important! See issue #1075
            //defaultDate: '08:32:33',

  
        }); 
     
    $('#table_id').DataTable({
    "aLengthMenu": [[5, 10, 20, -1], [5, 10, 20, "All"]],
    "iDisplayLength": 5,
    "columnDefs": [
        {
            "targets": [ 0 ],
            "visible": false,
            "searchable": false
        }]
    });
        $('#table_datelessons').DataTable();
       
    $('#table_id tbody').on('click', 'tr', function () {
        table = $('#table_id').DataTable();
        data = table.row( this ).data();
        nameLessons = data[1];
    } );

    } );
function deleteSelectSure(deleteLessonsSelected, deleteLessonsName) {

        $('#lessonDelete').empty();
        $('#lessonDelete').append(deleteLessonsName);
        $('#buttonDelete').val(deleteLessonsSelected);
        $('#deleteLesson').modal('show');
}
//   
var ajax;
// function funcionCallBackdetailsLesson()
//    {
//           if (ajax.readyState===4){
//                if (ajax.status===200){
//                   var object = JSON.parse(ajax.responseText);
//                   var s = JSON.parse(object.students);
//                   var c =  JSON.parse(object.contents);
//                   
////                   var cntContent = (object.contents).toString();
////                   var Contents = cntContent.substr(1,cntContent.length - 2);
////                   var r = Contents.split(",");
//                        //var tableObjective = $('#tableobjective').DataTable();
//                        $('#nameLessonDetails').empty();
//                        $('#nameLessonDetails').append('Details '+nameLessons);
//                        //$('#detailsStudents').empty();
//                        $('#studentarea').append('<table id="detailsStudents" class="table table-striped">');
//                        $.each(s, function (i,student){
//                            $('#detailsStudents').append('<tr><td class="studentDetails">'+s[i].studentname+'</td></tr>');
//                            $("tr:odd").addClass("par");
//                            $("tr:even").addClass("impar");
//                        //    $("tr:odd").css("background-color", "lightgray");
//                        });
//                        $('#contentDetails').empty();
//                        $.each(c, function (i, content){
//                            $('#contentDetails').append('<li>'+c[i]+'</li>');
//                        });
//                        
//                        
//                        $('#methodDetails').empty();
//                        $('#methodDetails').append('<tr><td>'+object.method+'</td></tr>');
//                        $('#commentDetails').empty();
//                        $('#commentDetails').append('<tr><td>'+object.comment+'</td></tr>');
//                        $('#detailsLesson').modal('show');
////                        });
////                        var commentgeneral = $('#tableobjective tbody tr td:eq(2)').text();
////                        $('#tableobjective tbody tr td:eq(2)').empty();
////                        $('#tableobjective tbody tr td:eq(2)').append("<input value='"+commentgeneral+"'></input>");   
//                           
//                         
////     $('#tableobjective tbody tr td:eq(4)').on('click', 'tr', 'td:eq(4)', function () {
////        
////        var dataObjective = tableObjective.row( this ).data();
////        dataObjective1 = dataObjective['col5'];
////        selectionObjective();
////    } ); 
//                    }
//                }
//            }
   function rowselect(LessonsSelected)
    {
        //ESTO PARA PINCHAR EN LA FILAvar LessonsSelected = data1;
        //var LessonsSelected = $(data1).html();
        //var LessonsSelected = 565;

        
        
//        if (window.XMLHttpRequest) //mozilla
//        {
//            ajax = new XMLHttpRequest(); //No Internet explorer
//        }
//        else
//        {
//            ajax = new ActiveXObject("Microsoft.XMLHTTP");
//        }
        
//ajax.onreadystatechange=funcionCallBackLessonsprogress;
 //       window.location.href = "/lessonprogress/loadRecords.htm?LessonsSelected="+LessonsSelected;
       window.open("<c:url value="/lessonprogress/loadRecords.htm?LessonsSelected="/>"+LessonsSelected);
//        ajax.open("POST","lessonprogress.htm?select6=loadRecords&LessonsSelected="+LessonsSelected,true);
//        ajax.send("");
  };
   function detailsSelect(LessonsSelected)
    {
        if (window.XMLHttpRequest) //mozilla
        {
            ajax = new XMLHttpRequest(); //No Internet explorer
        }
        else
        {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        }
        ajax.onreadystatechange = funcionCallBackdetailsLesson;
        ajax.open("POST","detailsLesson.htm?LessonsSelected="+LessonsSelected,true);
        ajax.send("");
  };
   function modifySelect(LessonsSelected)
    {
       window.open("<c:url value="/editlesson/start.htm?LessonsSelected="/>"+LessonsSelected);
  };
   function funcionCallBackdeleteLesson()
    {
           if (ajax.readyState===4){
                if (ajax.status===200){
                <%--    var lessondeleteconfirm = '<%= request.getParameter("messageDelete") %>'; --%>
                    var lessondeleteconfirm = ""; 
                var lessondeleteconfirm = JSON.parse(ajax.responseText);
//                   var s = JSON.parse(object.students);
//                   var c =  JSON.parse(object.contents);
//                   
//                        $('#nameLessonDetails').empty();
//                        $('#nameLessonDetails').append('Details '+nameLessons);
//                        //$('#detailsStudents').empty();
//                        $('#studentarea').append('<table id="detailsStudents" class="table table-striped">');
//                        $.each(s, function (i,student){
//                            $('#detailsStudents').append('<tr><td class="studentDetails">'+s[i].studentname+'</td></tr>');
//                            $("tr:odd").addClass("par");
//                            $("tr:even").addClass("impar");
//                        });
//                        $('#contentDetails').empty();
//                        $.each(c, function (i, content){
//                            $('#contentDetails').append('<li>'+c[i]+'</li>');
//                        });
//                        
//                        
//                        $('#methodDetails').empty();
//                        $('#methodDetails').append('<tr><td>'+object.method+'</td></tr>');
//                        $('#commentDetails').empty();
//                        $('#commentDetails').append('<tr><td>'+object.comment+'</td></tr>');
//                         $('#lessonDeleteMessage').empty();
//                         document.getElementById("lessonDeleteMessage").innerHTML = ajax.responseText;
                       if (lessondeleteconfirm.message === 'Presentation has progress records,it can not be deleted' ){
                            $('#lessonDeleteMessage').append('<H1>'+lessondeleteconfirm.message+'</H1>');
                            $('#deleteLessonMessage').modal('show');
                        }else {
                            $('#lessonDeleteMessage').append('<H1>'+lessondeleteconfirm.message+'</H1>');
                            $('#deleteLessonMessage').modal('show'); //  Presentation deleted successfully
                        };  
                        
                        

                    }
                }
            }
  function deleteSelect(LessonsSelected)
  {
       if (window.XMLHttpRequest) //mozilla
        {
            ajax = new XMLHttpRequest(); //No Internet explorer
        }
        else
        {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        }
        
        ajax.onreadystatechange = funcionCallBackdeleteLesson;
        ajax.open("POST","deleteLesson.htm?LessonsSelected="+LessonsSelected,true);
    <%-- window.open("<c:url value="/homepage/deleteLesson.htm?LessonsSelected="/>"+LessonsSelected); --%>
        ajax.send("");
      
      
  };
    function refresh()
    {
         location.reload();
    }
      
    
    </script>
    <style>
        .title
        {
            font-size: medium;
            font-weight: bold;
            color: gray;
            margin-top: 5px;
            padding-left: 5px;
        }
        .par
        {
            background-color: lightgrey;
            
        }
        .impar
        {
           border-bottom: solid 1px grey;
        }
        .studentDetails{
            padding-top: 5px;
            padding-bottom: 5px;
            padding-left: 10px;
        }
        .modal-header-details
        {
            background-color: #99CC66;
        }
        .modal-header-delete
        {
            background-color: #CC6666;
        }

    </style>
    </head>
    <body>
        <c:url var="post_url"  value="/html" />
        <form:form name="activitylog" action="${post_url}" method="POST">
        <div class="container">
            <div class="col-xs-3 form-group">
                <label class="control-label" for="fecha">Date</label>
                <div class='input-group date' id='fecha'>
                    <input type='text' name="TXTfecha" class="form-control" id="start"/>
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
            <div class="col-xs-3 form-group">
                <label class="control-label" for="fecha">Date</label>
                <div class='input-group date' id='fecha'>
                    <input type='text' name="TXTfecha" class="form-control" id="end"/>
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
            <div class="col-xs-3 form-group">
                <input type="submit" class="btn" value="Run" name="Run" />
            </div>
        </div>
</form:form>
        
    </body>
</html>
