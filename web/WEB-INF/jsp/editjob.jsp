<%-- 
    Document   : createlesson
    Created on : 30-ene-2017, 14:59:17
    Author     : nmohamed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <%@ include file="menu.jsp" %>
        
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SOW</title>
    
        <script>
$(document).ready(function(){
    var userLang = navigator.language || navigator.userLanguage;
        $('#dateStart').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: userLang.valueOf(),
            daysOfWeekDisabled: [0, 6]
        });
        
        $('#dateEnd').datetimepicker({
            
            format: 'YYYY-MM-DD',
            locale: userLang.valueOf(),
            daysOfWeekDisabled: [0, 6]
        });
        
        $("#dateStart").on("dp.change", function (e) {
            $('#dateEnd').data("DateTimePicker").minDate(e.date);
        });       
        
        $("#dateEnd").on("dp.change", function (e) {
            $('#dateStart').data("DateTimePicker").maxDate(e.date);
        });


        

});

          

            var ajax;
            
            var subjectValue = $('#subject').select("selected").val();
            var objectiveValue = $('#objective').select("selected").val();
            var contentValue = $('#content').select("selected").val();
            var editValue = $('#method').select("selected").val();
            
            function funcionCallBackObjective()
            {
                if (ajax.readyState === 4) {
                    if (ajax.status === 200) {
                        document.getElementById("objective").innerHTML = ajax.responseText;
                    }
                }
            }

            function comboSelectionSubject()
            {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }
                //Al seleccionar un subject activamos el boton Add
                if( subjectValue !== null, subjectValue !== ""){
                   $('#addObjective').attr("disabled", false);
                };
                //Al seleccionar un subject desactivamos el boton Edit
                if( objectiveValue !== null, objectiveValue !== ""){
                   $('#editObjective').attr("disabled", true);
                };
                //Ocultamos los div para add o edit otros niveles
                $('#formEditobjetive').addClass("hidden");
                $('#formAddcontent').addClass("hidden");
                $('#formEditcontent').addClass("hidden");
                //Activamos el select de objetives
                $('#objective').attr("disabled", false);
                //
                $('#objectiveSelectedForAdd').text($('#subject option:selected').text());
                
                $('#namenewobjective').empty();
                $('#descriptionnewobjective').empty();
                $('#content').empty();
                
                ajax.onreadystatechange = funcionCallBackObjective;
                var seleccion2 = document.getElementById("subject").value;
                ajax.open("GET", "objectivelistSubject.htm?seleccion2=" + seleccion2, true);

                ajax.send("");

            }

            function funcionCallBackContent()
            {
                if (ajax.readyState === 4) {
                    if (ajax.status === 200) {
                        document.getElementById("content").innerHTML = ajax.responseText;
                    }
                }
            }
            function comboSelectionObjective()
            {
//              
                    var seleccion3 = document.getElementById("objective").value;
                    //var p = "&seleccion3"
                    $.ajax({
                    type: "GET",
                        url: "contentlistObjective.htm?seleccion3="+seleccion3,
                        data: seleccion3,
                        dataType: 'text' ,           
                     
                        success: function(data) {
                            //console.log("success:",data);
                            
                            display(data);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });
                function display(data) {
		var json = JSON.parse(data);
                var objective = JSON.parse(json.objective);
                var content = JSON.parse(json.content);
                
                //$('#editObjective').removeClass("disabled");
                //Ocultamos el div add objective
                $('#formAddobjetive').addClass("hidden");
                $('#formAddcontent').addClass("hidden");
                $('#formEditcontent').addClass("hidden");
                //Activamos el select de content
                $('#content').attr("disabled", false);
                //Cambiamos el nombre al que añadimos del objetive al que añadimos el content
                $('#contentSelectedForAdd').text($('#objective option:selected').text());
                //Mostramos los valores del objective seleccionado cuando editamos
                $('#editNameObjective').val(objective.name);
                $('#editDescriptionObjective').val(objective.description);
                //Al seleccionar un objective activamos el boton del Content
                if( objectiveValue !== null, objectiveValue !== ""){
                   $('#delObjective').attr("disabled", false);
                };
                //Al seleccionar un objective activamos el boton add Content
                if( objectiveValue !== null, objectiveValue !== ""){
                   $('#addContent').attr("disabled", false);
                };
                //Al seleccionar un objective activamos el boton edit
                if( objectiveValue !== null, objectiveValue !== ""){
                   $('#editObjective').attr("disabled", false);
                };
                //Al seleccionar un objective desactivamos el boton add
                if( subjectValue !== null, subjectValue !== ""){
                   $('#addObjective').attr("disabled", true);
                };
                //Al seleccionar un objective desactivamos el boton edit content
                if( contentValue !== null, contentValue !== ""){
                    //$('#addContent').attr("disabled", true);
                    $('#editContent').attr("disabled", true);
                };
                //Al seleccionar un objective desactivamos el boton del content
                if( contentValue !== null, contentValue !== ""){
                    //$('#addContent').attr("disabled", true);
                    $('#delContent').attr("disabled", true);
                };
                //Añadimos los content del objective
                $('#content').empty();
                $.each(content, function(i, item) { 
                    $('#content').append('<option value ="'+content[i].id+'">' + content[i].name + '</option>');
                });
	}
}
            function comboSelectionContent()
            {
                 
             }
                

            
            function deleteObjective()
            {
                var seleccion = document.getElementById("objective").value;
                 $.ajax({
                    type: 'POST',
                        url: 'delObjective.htm?id='+seleccion,
                      data: seleccion,
                        dataType: 'text' ,           
                     
                        success: function(data) {                          
                           if(data==='success')  {           
                               $('#objective option:selected').remove();
           //         $('#objective').remove('option:selected');
                            }else{
                                $('#buttomModalObjective').click();
                                $('#modal-objectiveLinkLessons').replaceWith('<div class="col-xs-12 text-center"><h3>'+ data +'</h3></div>');
                            }
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });    
            }
            function deleteContent()
            {
                var seleccion = document.getElementById("content").value;
                 $.ajax({
                    type: 'POST',
                        url: 'delContent.htm?id='+seleccion,
                        data: seleccion,
                        dataType: 'text' ,           
                     
                        success: function(data) {                          
                            if(data==='success')  {
                                $('#content option:selected').remove();
           //         $('#objective').remove('option:selected');
                            }else{
                                $('#buttomModalContent').click();
                                $('#modal-contentLinkLessons').replaceWith('<div class="col-xs-12 text-center"><h3>'+ data +'</h3></div>');
                            }
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });    
            }
            function saveaddObjective()
            {

     //   var seleccion = document.getElementById("objective").value;
        var name = document.getElementById("titleJobBN").value;
        var type = document.getElementById("typeJob").value;
        var message = CKEDITOR.instances.NotificationMessage.getData();
        var messagetitle = document.getElementById("messagetitleBN").value;
        var runfreq =$("input[name='runBN']:checked").val();
        var setting = $("input[name='meritBN']:checked").val();
        var test = $("input[name='eventBN']:checked").val();
        var sender;
        if(test==='rep')
        {
            sender = document.getElementById("schoolRep").value;
        }
        else
        {
           sender = 'creator'; 
        }
        var myObj = {};
                myObj["name"] = name;
                myObj["type"] = type;
                myObj["runfreq"] = runfreq;
                myObj["message"] = message;
                myObj["messagetitle"] = messagetitle;
                myObj["setting"] = setting;
                myObj["sender"] = sender;
                var json = JSON.stringify(myObj);
            $.ajax({
                    type: 'POST',
                        url: 'save.htm',
                        data: json,
                       datatype:"json",
                        contentType: "application/json",          
                     
                        success: function(data) {                          
                                   
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });    
                }
            
            function saveeditObjective()
            {

        var seleccion = document.getElementById("objective").value;
        var name = document.getElementById("editNameObjective").value;
        var description = document.getElementById("editDescriptionObjective").value;
        var subjectid = document.getElementById("subject").value;
        var myObj = {};
                myObj["name"] = name;
                myObj["description"] = description;
                myObj["id"] = seleccion;
                myObj["subjectid"] = subjectid;
                var json = JSON.stringify(myObj);
            $.ajax({
                    type: 'POST',
                        url: 'editObjective.htm?data='+json,
                        data: json,
                        dataType: 'text' ,           
                     
                        success: function(data) {
                            $('#objective').empty();
                            var json = JSON.parse(data);                            
                            $.each(json, function(i, item) { 
                            $('#objective').append('<option value = "'+json[i].id[0]+'" >' + json[i].name + '</option>');
                            });
                           $('#formEditobjetive').addClass("hidden");
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });    
                }
            function saveeditContent()
            {

        var seleccion = document.getElementById("content").value;
        var name = document.getElementById("editNameContent").value;
        var description = document.getElementById("editCommentsContent").value;
        var objid = document.getElementById("objective").value;
        var myObj = {};
                myObj["name"] = name;
                myObj["description"] = description;
                myObj["id"] = seleccion;
                myObj["objid"] = objid;
                var json = JSON.stringify(myObj);
            $.ajax({
                    type: 'POST',
                        url: 'editContent.htm?data='+json,
                        data: json,
                        dataType: 'text' ,           
                     
                        success: function(data) {
                            $('#content').empty();
                            var json = JSON.parse(data);                            
                            $.each(json, function(i, item) { 
                            $('#content').append('<option value = "'+json[i].id[0]+'" >' + json[i].name + '</option>');
                            $('#formEditcontent').addClass("hidden");
                        });
                           
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });    
                } 
            function saveaddContent()
            {

     //   var seleccion = document.getElementById("objective").value;
        var name = document.getElementById("namenewcontent").value;
        var description = document.getElementById("commentsnewcontent").value;
        var objid = document.getElementById("objective").value;
        var myObj = {};
                myObj["name"] = name;
                myObj["description"] = description;
    //            myObj["id"] = seleccion;
                myObj["objid"] = objid;
                var json = JSON.stringify(myObj);
            $.ajax({
                    type: 'POST',
                        url: 'addContent.htm?data='+json,
                        data: json,
                        dataType: 'text' ,           
                     
                        success: function(data) {                          
                            var json = JSON.parse(data);                               
                            $('#content').append('<option value = "'+json.id[0]+'" >' + json.name + '</option>');
                            $('#formAddcontent').addClass("hidden");           
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });    
                }
            function deleteMethod()
            {
                var seleccion = document.getElementById("method").value;
                 $.ajax({
                    type: 'POST',
                        url: 'delMethod.htm?id='+seleccion,
                        data: seleccion,
                        dataType: 'text' ,           
                     
                        success: function(data) {                          
                            if(data==='success')  {
                                $('#method option:selected').remove();
           //         $('#objective').remove('option:selected');
                            }else{
                                $('#buttomModalMethod').click();
                                $('#modal-methodLinkLessons').replaceWith('<div class="col-xs-12 text-center"><h3>'+ data +'</h3></div>');
                            }
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });    
            }
            function saveaddMethod()
            {

     //   var seleccion = document.getElementById("objective").value;
        var name = document.getElementById("namenewmethod").value;
        var description = document.getElementById("commentsnewmethod").value;
        var myObj = {};
                myObj["name"] = name;
                myObj["description"] = description;
                var json = JSON.stringify(myObj);
            $.ajax({
                    type: 'POST',
                        url: 'addMethod.htm?data='+json,
                        data: json,
                        dataType: 'text' ,           
                     
                        success: function(data) {                          
                            var json = JSON.parse(data);                               
                        $('#method').append('<option value = "'+json.id[0]+'" >' + json.name + '</option>');
                        $('#formAddmethod').addClass("hidden");               
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });    
                }
                function saveeditMethod()
            {

        var seleccion = document.getElementById("method").value;
        var name = document.getElementById("editNameMethod").value;
        var description = document.getElementById("editCommentsMethod").value;
        var myObj = {};
                myObj["name"] = name;
                myObj["description"] = description;
                myObj["id"] = seleccion;
                var json = JSON.stringify(myObj);
            $.ajax({
                    type: 'POST',
                        url: 'editMethod.htm?data='+json,
                        data: json,
                        dataType: 'text' ,           
                     
                        success: function(data) {
                            $('#method').empty();
                            var json = JSON.parse(data);                            
                            $.each(json, function(i, item) { 
                            $('#method').append('<option value="'+json[i].id[0]+'" data-title="' + json[i].name + '" data-content="'+json[i].description+'">' + json[i].name + '</option>');
                            $('#formEditmethod').addClass("hidden");
                        });
                           
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });    
                }
                function funcionCallBackJob()
            {
//                if (ajax.readyState === 4) {
//                    if (ajax.status === 200) {
                        //document.getElementById("subject").innerHTML = ajax.responseText;
                        //Capturamos el valor del type jobs seleccionado
                        var jobselected = $('#typeJob').select("selected").val();
                        //Mostramos el div para cada job
                        if( jobselected === '1'){
                         $('#AccountingNotification').removeClass("hidden");
                         $('#AttendanceNotification').addClass("hidden");
                         $('#BehaviorNotification').addClass("hidden");
                         $('#gradeBook').addClass("hidden");
                       }else if(jobselected === '2'){
                         $('#AttendanceNotification').removeClass("hidden");
                         $('#AccountingNotification').addClass("hidden");
                         $('#BehaviorNotification').addClass("hidden");
                         $('#gradeBook').addClass("hidden");
                       }else if(jobselected === '3'){
                         $('#BehaviorNotification').removeClass("hidden");
                         $('#AccountingNotification').addClass("hidden");
                         $('#AttendanceNotification').addClass("hidden");
                         $('#gradeBook').addClass("hidden");
                       }else if(jobselected === '6'){
                         $('#gradeBook').removeClass("hidden");
                         $('#AccountingNotification').addClass("hidden");
                         $('#AttendanceNotification').addClass("hidden");
                         $('#BehaviorNotification').addClass("hidden");
                       };
//                    }
//                }
            }
            function comboSelectionJob()
            {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                $('#namenewobjective').empty();
                $('#descriptionnewobjective').empty();
                $('#content').empty();
                
                ajax.onreadystatechange = funcionCallBackJob;
                var seleccion1 = document.getElementById("typeJob").value;
                ajax.open("GET", "subjectlistLevel.htm?seleccion1=" + seleccion1, true);

                ajax.send("");

            }
            $(function () {
                
                $("input[name='TimeFrame']").change(function () {
                   if($('#TimeFrame').is(':checked')) 
                   { 
                      $('#TXTdateStart').attr("disabled", false);
                      $('#TXTdateEnd').attr("disabled", false);
                   }else{
                      $('#TXTdateStart').attr("disabled", true);
                      $('#TXTdateEnd').attr("disabled", true);
                   }
                });
                
                
                $('#addObjective').click(function () {
                    $('#formAddobjetive').removeClass("hidden");
                    $('#formAddcontent').addClass("hidden");
                    $('#formEditcontent').addClass("hidden");
                    $('#objectiveSelectedForAdd').text($('#subject option:selected').text());
                });
                
                $('#editObjective').click(function () {
                    $('#formAddobjetive').addClass("hidden");
                    $('#formEditobjetive').removeClass("hidden");
                    $('#formAddcontent').addClass("hidden");
                    $('#formEditcontent').addClass("hidden");
                    $('#objectiveSelectedForEdit').text($('#subject option:selected').text());
                });
                $('#content').click(function () {
                    $('#formAddobjetive').addClass("hidden");
                    $('#formEditobjetive').addClass("hidden");
                    $('#formAddcontent').addClass("hidden");
                    $('#formEditcontent').addClass("hidden");;
                    $('#editContent').attr("disabled", false);
                    $('#delContent').attr("disabled", false);
                    
                    //Al seleccionar un objective desactivamos el boton add
                    if( contentValue !== null, contentValue !== ""){
                       $('#addContent').attr("disabled", true);
                    };
                });
                $('#delContent').click(function () {
                    $('#formAddobjetive').addClass("hidden");
                    $('#formEditobjetive').addClass("hidden");
                    $('#formAddcontent').addClass("hidden");
                    $('#formEditcontent').addClass("hidden");
                    //$('#addContent').attr("disabled", false);
                    $('#editContent').attr("disabled", false);
                    $('#delContent').attr("disabled", false);
                    
                    //Al seleccionar un objective desactivamos el boton add
                    if( contentValue !== null, contentValue !== ""){
                       $('#addContent').attr("disabled", true);
                    };
                });
                $('#addContent').click(function () {
                    $('#formAddcontent').removeClass("hidden");
                    $('#formEditobjetive').addClass("hidden");
                    $('#contentSelectedForAdd').text($('#objective option:selected').text());
                });
                $('#editContent').click(function () {
                    $('#formAddcontent').addClass("hidden");
                    $('#formEditcontent').removeClass("hidden");
                    //Añadimos el nombre del content para editarlo
                    $('#editNameContent').val($('#content option:selected').text());
                    //Añadimos el nombre del objective para saber a que objective pertenece el content que estamos editando
                    $('#contentSelectedForEdit').text($('#objective option:selected').text());
                });
                $('#method').click(function () {
                    $('#formAddmethod').addClass("hidden");
                    $('#formEditmethod').addClass("hidden");
                    $('#formAddmethod').addClass("hidden");
                    $('#addMethod').attr("disabled", false);
                    $('#editMethod').attr("disabled", false);
                    $('#delMethod').attr("disabled", false);
                    
                    //Al seleccionar un objective desactivamos el boton add
//                    if( editValue !== null, editValue !== ""){
//                       $('#editMethod').attr("disabled", true);
//                    };
                });
                $('#addMethod').click(function () {
                    $('#formAddmethod').removeClass("hidden");
                    $('#formEditmethod').addClass("hidden");
                });
                $('#editMethod').click(function () {
                    $('#formAddmethod').addClass("hidden");
                    $('#formEditmethod').removeClass("hidden");
                    //Añadimos el nombre del method para editarlo
                    $('#editNameMethod').val($('#method option:selected').text());
                    //Añadimos el comentario del method para editarlo
                    $('#editCommentsMethod').val($('#method option:selected').attr('data-content'));
                    //Añadimos el nombre del method para saber que estamos editando
                    $('#methodSelectedForEdit').text($('#method option:selected').text());
                });
                $('#delMethod').click(function () {
                    $('#methodSelectForDelete').text($('#method option:selected').text());
                });
                
                 $('#level').click(function () {
                    $('#objective').empty();
                    $('#namenewobjective').val('');
                    $('#descriptionnewobjective').val('');
                    $('#content').empty();
                });
            });
            function AddVariable()
           {
               var value = $('#variables option:selected').val();
               CKEDITOR.instances['NotificationMessage'].insertText(value);
   
               }
        </script>
        <style>
            textarea 
            {
                resize: none;
            }
             .popover{
                width: 500px;
            }
        </style>
    </head>
    <body>
         <div class="container">
            <h1 class="text-center">Create Jobs</h1>


            <form:form id="formSettings" method ="post" action="createsetting.htm?select=createsetting" >
                <fieldset>
                    <legend>Select type Jobs</legend>

                    <div class="col-xs-12">
                        <div class="col-xs-6 form-group">
                            <label class="control-label"><spring:message code="etiq.txtlevels"/></label>
                            <select class="form-control" name="TXTlevel" id="typeJob" onchange="comboSelectionJob()">
                                <option value="0" >Select type</option>
                                <option value="1" >Accounting notification</option>
                                <option value="2" >Attendance notification</option>
                                <option value="3" >Behaviour notification</option>
                                <option value="4" >Create day attendance</option>
                                <option value="5" >Custom maintenance Job</option>
                                <option value="6" >Grade book</option>
                                <option value="7" >Library late fee</option>
                                <option value="8" >Library late notification</option>
                                <option value="9" >NelNet/Pay now notification</option>
                                <option value="10" >Web form notification</option>
                                <%--<c:forEach var="levels" items="${typejob}">
                                    <option value="${job.id[0]}" >${job.name}</option>
                                </c:forEach>--%>
                            </select>
                        </div>
                    </div>
                </fieldset>
            </form:form>
            <form:form id="formpepi" method ="post"  >
                <fieldset class="hidden" id="AccountingNotification">
                    <legend>Accounting Notification</legend>

                        <div class="col-xs-3 center-block form-group" id="addObjective">
                            <label class="control-label">Job title</label>
                            <input type="text" class="form-control" name="TXTnamenewobjective" id="titleJob"  placeholder="Name">
                        </div>
                    <div class="col-xs-3 center-block form-group" id="messageTitle">
                            <label class="control-label">Message title</label>
                            <input type="text" class="form-control" name="TXTnamenewmessage" id="messagetitle"  placeholder="Name">
                        </div>
                        <div class="col-xs-12 center-block form-group">
                            <label class="control-label">Notification Message</label>
                            <textarea type="text" class="form-control" name="TXTnamenewobjective" id="descriptionnewobjective"  placeholder="Comments"></textarea>
                        </div>
                        <div class="col-xs-12 center-block form-group">
                            <label class="control-label">Frecuency</label>
                            <label class="radio-inline"><input type="radio" name="frecuency">Off</label>
                            <label class="radio-inline"><input type="radio" name="frecuency">Daily</label>
                            <label class="radio-inline"><input type="radio" name="frecuency">Weekly</label>
                            <label class="radio-inline"><input type="radio" name="frecuency">Parent preference</label>
                        </div>
                        <div class="col-xs-2 text-center form-group paddingLabel">
                            <input type="button" name="AddObjective" value="save" class="btn btn-success" id="AddObjective" data-target=".bs-example-modal-lg" onclick="saveaddObjective()"/>
                        </div>
                </fieldset>
                <fieldset class="hidden" id="AttendanceNotification">
                    <legend>Attendance Notification</legend>
                    <%--Edit objective--%>
                        <div class="col-xs-3 center-block form-group" id="addObjective">
                            <label class="control-label">Edit objective</label>
                            <input type="text" class="form-control" name="TXTeditNameObjective" id="editNameObjective"  placeholder="Name">
                        </div>
                        <div class="col-xs-7 center-block form-group">
                            <label class="control-label">Comments</label>
                            <textarea type="text" class="form-control" name="TXTeditDescriptionObjective" id="editDescriptionObjective"  placeholder="Comments"></textarea>
                        </div>
                        <div class="col-xs-2 center-block form-group paddingLabel">
                            <input type="button" name="AddObjective" value="Save" class="btn btn-success" id="savedEditObjective" data-target=".bs-example-modal-lg" onclick="saveeditObjective()"/> 
                        </div>
                </fieldset>
                <fieldset class="hidden" id="BehaviorNotification">
                    <legend>Behavior notification</legend>
                    
                        <div class="col-xs-3 center-block form-group">
                            <label class="control-label">Title Job</label>
                            <input type="text" class="form-control" name="TXTnamenewobjective" id="titleJobBN"  placeholder="Name">
                        </div>
                    <div class="col-xs-3 center-block form-group" id="messageTitle">
                            <label class="control-label">Message title</label>
                            <input type="text" class="form-control" name="TXTnamenewmessage" id="messagetitleBN"  placeholder="Name">
                        </div>
                        <div class="col-xs-12 center-block form-group">
                            <div class="col-xs-3 center-block form-group">
                                <label class="radio"><input type="radio" name="meritBN" value="demerit">Demerit</label>
                                <label class="radio"><input type="radio" name="meritBN" value="merit">Merit</label>
                            </div>
<!--                            <div class="col-xs-3 center-block form-group">
                                <label class="radio"><input type="radio" name="event">Single event</label>
                                <label class="radio"><input type="radio" name="event">Cumulative events</label>
                            </div>-->
                            <div class="col-xs-3 center-block form-group">
                                <label class="radio"><input type="radio" name="runBN" value="disable">Disable</label>
                                <label class="radio"><input type="radio" name="runBN" value="daily">Run daily</label>
                                <label class="radio"><input type="radio" name="runBN" value="weekly">Run weekly</label>
                            </div>
                            <div class="col-xs-3 center-block form-group">
<!--                            <label class="control-label">Run at:</label>
                            <select class="form-control" name="TXTrunAt">
                                <option value="0">00:00</option>
                                <option value="1">01:00</option>
                                <option value="2">02:00</option>
                                <option value="3">03:00</option>
                                <option value="4">04:00</option>
                                <option value="5">05:00</option>
                                <option value="6">06:00</option>
                                <option value="7">07:00</option>
                                <option value="8">08:00</option>
                                <option value="9">09:00</option>
                                <option value="10">10:00</option>
                                <option value="11">11:00</option>
                                <option value="12">12:00</option>
                                <option value="13">13:00</option>
                                <option value="14">14:00</option>
                                <option value="15">15:00</option>
                                <option value="16">16:00</option>
                                <option value="17">17:00</option>
                                <option value="18">18:00</option>
                                <option value="19">19:00</option>
                                <option value="20">20:00</option>
                                <option value="21">21:00</option>
                                <option value="22">22:00</option>
                                <option value="23">23:00</option>
                                
                            </select>-->
                        </div>
                        </div>
                        <div class="col-xs-12 center-block form-group">
<!--                            <div class="col-xs-4 center-block form-group" style="padding: 0px;">
                                <label class="control-label">Time Frame</label>
                                <div class="col-xs-12 table table-bordered">
                                    <div class="col-xs-6">
                                        <label class="radio"><input type="radio" name="TimeFrame">Single Day</label>
                                        <label class="radio"><input type="radio" name="TimeFrame">Current Term</label>
                                    </div>
                                    <div class="col-xs-6">
                                        <label class="radio"><input type="radio" name="TimeFrame">Current Semester</label>
                                        <label class="radio"><input type="radio" name="TimeFrame">Current Year</label>
                                    </div>
                                    <div class="col-xs-12">
                                        <label class="radio">
                                            <input type="radio" name="TimeFrame" id="TimeFrame">Custom Dates
                                        </label>
                                        <div class="col-xs-6">
                                            <div class='input-group date' id='dateStart'>
                                                <input type='text' name="TXTdateStart" id="TXTdateStart" class="form-control" disabled="true"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class='input-group date' id='dateEnd'>
                                                <input type='text' name="TXTdateEnd" id="TXTdateEnd" class="form-control" disabled="true"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>-->
                            <div class="col-xs-4 center-block form-group">
                                <label class="control-label">Notification Source</label>
                                <div class="col-xs-12 table-bordered">
                                    <div class="col-xs-12">
                                    <label class="radio"><input type="radio" name="eventBN" value="creator">Creator of Event</label>
                                    <label class="radio"><input type="radio" name="eventBN" value="rep">School representative</label>
                                    </div>
                                         <input type="text" class="form-control" name="TXTSchoolRepresentative" id="schoolRep"  placeholder="Email Address">
                                    
                                </div>
                            </div>
<!--                            <div class="col-xs-4 center-block form-group">
                                <label class="control-label">Send Notification to:</label>
                                <div class="col-xs-12 table-bordered">
                                    <div class="col-xs-12">
                                    <label class="checkbox"><input type="checkbox" name="SendNotification">Student</label>
                                    <label class="checkbox"><input type="checkbox" name="SendNotification">Parent</label>
                                    <label class="checkbox"><input type="checkbox" name="SendNotification">Advisor</label>
                                
                                    <label class="radio">School Representative (email address)</label>
                                    <input type="text" name="emailSchoolRepresentative">
                                    </div>
                                </div>
                            </div>-->
                            
                        </div>
                        <div class="col-xs-9 center-block form-group" style="padding-right: 0px;">
                            <label class="control-label">Notification Message</label>
                            <textarea name="NotificationMessage" id="NotificationMessage">
                                
                            </textarea>
                            <script>
                // Replace the <textarea id="editor1"> with a CKEditor
                // instance, using default configuration.
                CKEDITOR.replace( 'NotificationMessage' );
            </script>
                        </div>
                        <div class="col-xs-3 center-block form-group" style="padding-left: 0px;">
                            <label class="control-label">Variable List</label>
                            <select multiple="true" size="10" class="form-control" placeholder="" id="variables" ondblclick="AddVariable()">
                                <option value="{date}">Date of incident</option>
                                <option value="{description}">Description of incident</option>
<!--                                <option value="{event}">Event</option>-->
                                <option value="{ParentName}">Parent Name</option>
                                <option value="{Stud_firstName}">Student First Name</option>
                                <option value="{Stud_fullName}">Student Full Name</option>
                                <option value="{Teacher_fullName}">Teacher Name</option>
<!--                                <option value="{Weight}">Weight</option>-->
                            </select>
                        </div>
                    
                        
                        <div class="col-xs-2 text-center form-group paddingLabel">
                            <input type="button" name="AddObjective" value="save" class="btn btn-success" id="AddObjective" data-target=".bs-example-modal-lg" onclick="saveaddObjective()"/>
                        </div>
                </fieldset>
                <fieldset class="hidden" id="gradeBook">
                    <legend>Grade book</legend>
                    
                        <div class="col-xs-3 center-block form-group">
                            <label class="control-label">Title Job</label>
                            <input type="text" class="form-control" name="TXTnamenewobjective" id="titleJob"  placeholder="Name">
                        </div>
                            <div class="col-xs-12 center-block form-group">
                            <div class="col-xs-3 center-block form-group">
                                <label class="radio"><input type="radio" name="merit" value="Demerit">Demerit</label>
                                <label class="radio"><input type="radio" name="merit" value="Merit">Merit</label>
                            </div>
<!--                            <div class="col-xs-3 center-block form-group">
                                <label class="radio"><input type="radio" name="event">Single event</label>
                                <label class="radio"><input type="radio" name="event">Cumulative events</label>
                            </div>-->
                            <div class="col-xs-3 center-block form-group">
                                <label class="radio"><input type="radio" name="run">Disable</label>
                                <label class="radio"><input type="radio" name="run">Run daily</label>
                                <label class="radio"><input type="radio" name="run">Run weekly</label>
                            </div>
                            <div class="col-xs-3 center-block form-group">
<!--                            <label class="control-label">Run at:</label>
                            <select class="form-control" name="TXTrunAt">
                                <option value="0">00:00</option>
                                <option value="1">01:00</option>
                                <option value="2">02:00</option>
                                <option value="3">03:00</option>
                                <option value="4">04:00</option>
                                <option value="5">05:00</option>
                                <option value="6">06:00</option>
                                <option value="7">07:00</option>
                                <option value="8">08:00</option>
                                <option value="9">09:00</option>
                                <option value="10">10:00</option>
                                <option value="11">11:00</option>
                                <option value="12">12:00</option>
                                <option value="13">13:00</option>
                                <option value="14">14:00</option>
                                <option value="15">15:00</option>
                                <option value="16">16:00</option>
                                <option value="17">17:00</option>
                                <option value="18">18:00</option>
                                <option value="19">19:00</option>
                                <option value="20">20:00</option>
                                <option value="21">21:00</option>
                                <option value="22">22:00</option>
                                <option value="23">23:00</option>
                                
                            </select>-->
                        </div>
                        </div>
                        <div class="col-xs-12 center-block form-group">
                            <label class="control-label">Notification Message</label>
                            <textarea type="text" class="form-control" name="TXTnamenewobjective" id="descriptionnewobjective"  placeholder="Comments"></textarea>
                        </div>
                        
                        <div class="col-xs-2 text-center form-group paddingLabel">
                            <input type="button" name="AddObjective" value="save" class="btn btn-success" id="AddObjective" data-target=".bs-example-modal-lg" onclick="saveaddObjective()"/>
                        </div>
                </fieldset>
  
                       
            </form:form>
                      
        </div>
<!--        ANTIGUO CREATE LESSONS USADO COMO REFERENCIA-->
<%--        <div class="container">
            <h1 class="text-center">Create Scheme of Work</h1>


            <form:form id="formSettings" method ="post" action="createsetting.htm?select=createsetting" >

                <fieldset>
                    <legend>Select an item to edit</legend>

                    <div class="col-xs-12">
                        <div class="col-xs-3 form-group">
                            <label class="control-label"><spring:message code="etiq.txtlevels"/></label>
                            <select class="form-control" name="TXTlevel" id="level" onclick="comboSelectionLevel()">
                                <c:forEach var="levels" items="${gradelevels}">
                                    <option value="${levels.id[0]}" >${levels.name}</option>
                                </c:forEach>
                            </select>

                        </div>
                        <div class="col-xs-3 center-block">
                            <label class="control-label"><spring:message code="etiq.txtsubject"/></label>
                            <select class="form-control" disabled="true" name="TXTsubject" id="subject" multiple size="10" onclick="comboSelectionSubject()">
                                <c:forEach var="subject" items="${subjects}">
                                    <option value="${subject.id[0]}" >${subject.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-xs-3 center-block">
                            <label class="control-label">Objective</label>
                            <select class="form-control" disabled="true" name="TXTobjective" id="objective" multiple size="10" onclick="comboSelectionObjective()">
                                <c:forEach var="objective" items="${objectives}">
                                    <option value="${objective.id[0]}" >${objective.name}</option>
                                </c:forEach>
                            </select>
                            <div class="col-xs-12" style="padding-top: 10px;">
                                <div class="col-xs-4 text-center">
                                    <input type="button" class="btn btn-success" disabled data-toggle="tooltip" data-placement="bottom" value="add" id="addObjective"/>
                                </div>
                                <div class="col-xs-4 text-center">
                                    <input type="button" class="btn btn-warning" disabled data-toggle="tooltip" data-placement="bottom" value="edit" id="editObjective"/>
                                </div>
                                <div class="col-xs-4 text-center">
                                    <input type="button" class="btn btn-danger" disabled data-toggle="modal" data-target="#confirmedDeleteObjective" data-placement="bottom" value="del" id="delObjective"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3 center-block">
                            <label class="control-label">Content</label>
                            <select class="form-control" disabled="true" name="TXTcontent" id="content" multiple size="10" onclick="comboSelectionContent()">
                                <c:forEach var="content" items="${contents}">
                                    <option value="${content.id[0]}" >${content.name}</option>
                                </c:forEach>
                            </select>
                            <div class="col-xs-12" style="padding-top: 10px;">
                                <div class="col-xs-4 text-center">
                                    <input type="button" class="btn btn-success" disabled data-toggle="tooltip" data-placement="bottom" value="add" id="addContent">
                                </div>
                                <div class="col-xs-4 text-center">
                                    <input type="button" class="btn btn-warning" disabled data-toggle="tooltip" data-placement="bottom" value="edit" id="editContent">
                                </div>
                                <div class="col-xs-4 text-center">
                                    <input type="button" class="btn btn-danger" disabled data-toggle="modal" data-target="#confirmedDeleteContent" data-placement="bottom" value="del" id="delContent" >
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </form:form>
            <form:form id="formpepi" method ="post"  >
                <fieldset class="hidden" id="formAddobjetive">
                    <legend>Add objective to <span id="objectiveSelectedForAdd"></span></legend>
                    Add objective
                        <div class="col-xs-3 center-block form-group" id="addObjective">
                            <label class="control-label">Name new objective</label>
                            <input type="text" class="form-control" name="TXTnamenewobjective" id="namenewobjective"  placeholder="Name">
                        </div>
                        <div class="col-xs-7 center-block form-group">
                            <label class="control-label">Comments</label>
                            <textarea type="text" class="form-control" name="TXTnamenewobjective" id="descriptionnewobjective"  placeholder="Comments"></textarea>
                        </div>
                        <div class="col-xs-2 text-center form-group paddingLabel">
                            <input type="button" name="AddObjective" value="save" class="btn btn-success" id="AddObjective" data-target=".bs-example-modal-lg" onclick="saveaddObjective()"/>
                        </div>
                </fieldset>
                <fieldset class="hidden" id="formEditobjetive">
                    <legend>Edit objective in <span id="objectiveSelectedForEdit"></span></legend>
                    Edit objective
                        <div class="col-xs-3 center-block form-group" id="addObjective">
                            <label class="control-label">Edit objective</label>
                            <input type="text" class="form-control" name="TXTeditNameObjective" id="editNameObjective"  placeholder="Name">
                        </div>
                        <div class="col-xs-7 center-block form-group">
                            <label class="control-label">Comments</label>
                            <textarea type="text" class="form-control" name="TXTeditDescriptionObjective" id="editDescriptionObjective"  placeholder="Comments"></textarea>
                        </div>
                        <div class="col-xs-2 center-block form-group paddingLabel">
                            <input type="button" name="AddObjective" value="Save" class="btn btn-success" id="savedEditObjective" data-target=".bs-example-modal-lg" onclick="saveeditObjective()"/>
   
                        </div>
                </fieldset>
                <fieldset class="hidden" id="formAddcontent">
                    <legend>Add content to <span id="contentSelectedForAdd"></span></legend>  
                    <div class="col-xs-12" style="margin-top: 20px;">

                        <div class="col-xs-3 center-block form-group">
                            <label class="control-label">Name new content</label>
                            <input type="text" class="form-control" name="TXTnamenewcontent" id="namenewcontent"  placeholder="Name new content">
                        </div>
                        <div class="col-xs-6 center-block form-group">
                            <label class="control-label">Comments</label>
                            <input type="text" class="form-control" name="TXTnamenewcontent" id="commentsnewcontent"  placeholder="Comments">
                        </div>
                        <div class="col-xs-3 center-block form-group paddingLabel">
                            <input type="button" name="AddContent" value="save" class="btn btn-success" id="AddContent" data-target=".bs-example-modal-lg" onclick="saveaddContent()"/>
                                
                            
                        </div>

                    </div>
                </fieldset>
                <fieldset class="hidden" id="formEditcontent">
                    <legend>Edit content in <span id="contentSelectedForEdit"></span></legend>  
                    <div class="col-xs-12" style="margin-top: 20px;">

                        <div class="col-xs-3 center-block form-group">
                            <label class="control-label">Edit content</label>
                            <input type="text" class="form-control" name="TXTnameeditcontent" id="editNameContent"  placeholder="Name new content">
                        </div>
                        <div class="col-xs-6 center-block form-group">
                            <label class="control-label">Comments</label>
                            <input type="text" class="form-control" name="TXTnameeditcontent" id="editCommentsContent"  placeholder="Comments">
                        </div>
                        <div class="col-xs-3 center-block form-group paddingLabel">
                            <input type="button" name="EditContent" value="save" class="btn btn-success" id="EditContent" data-target=".bs-example-modal-lg" onclick="saveeditContent()"/> 
                        </div>
                    </div>
                </fieldset>        
            </form:form>
                <fieldset>
                    <legend>Select a method to edit</legend>
                    <div class="col-xs-12">
                        <div class="col-xs-3 center-block form-group">
                            <label class="control-label">Method</label>
                            <select class="form-control methodSelect" size="2" name="method" id="method">
                                <c:forEach var="method" items="${methods}">
                                    <option value="${method.id[0]}"  data-title="${method.name}" data-content="${method.description}">${method.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-xs-9 form-group paddingLabel">
                            <div class="col-xs-2 text-center ">
                                <input type="button" class="btn btn-success" data-toggle="tooltip" data-placement="bottom" value="add" id="addMethod">
                            </div>
                            <div class="col-xs-2 text-center">
                                <input type="button" class="btn btn-warning" disabled data-toggle="tooltip" data-placement="bottom" value="edit" id="editMethod">
                            </div>
                            <div class="col-xs-2 text-center">
                                <input type="button" class="btn btn-danger" disabled data-toggle="modal" data-target="#confirmedDeleteMethod" data-placement="bottom" value="del" id="delMethod" >
                            </div>
                        </div>
                    </div>
                    
                </fieldset>
                <fieldset class="hidden" id="formAddmethod">
                    <legend>Add method</legend>  
                    <div class="col-xs-12">

                        <div class="col-xs-3 center-block form-group">
                            <label class="control-label">Name new method</label>
                            <input type="text" class="form-control" name="TXTnamenewmethod" id="namenewmethod"  placeholder="Name new method">
                        </div>
                        <div class="col-xs-6 center-block form-group">
                            <label class="control-label">Comments</label>
                            <input type="text" class="form-control" name="TXTnamenewmethod" id="commentsnewmethod"  placeholder="Comments">
                        </div>
                        <div class="col-xs-3 center-block form-group paddingLabel">
                            <input type="button" name="Addmethod" value="save" class="btn btn-success" id="Addmethod" data-target=".bs-example-modal-lg" onclick="saveaddMethod()"/>
                        </div>
                    </div>
                </fieldset>
                <fieldset class="hidden" id="formEditmethod">
                    <legend>Edit method in <span id="methodSelectedForEdit"></span></legend>  
                    <div class="col-xs-12">

                        <div class="col-xs-3 center-block form-group">
                            <label class="control-label">Edit method</label>
                            <input type="text" class="form-control" name="TXTnameeditethod" id="editNameMethod"  placeholder="Name new method">
                        </div>
                        <div class="col-xs-6 center-block form-group">
                            <label class="control-label">Comments</label>
                            <input type="text" class="form-control" name="TXTcommenteditmethod" id="editCommentsMethod"  placeholder="Comments">
                        </div>
                        <div class="col-xs-3 center-block form-group paddingLabel">
                            <input type="button" name="EditMethod" value="save" class="btn btn-success" id="EditMethod" data-target=".bs-example-modal-lg" onclick="saveeditMethod()"/> 
                        </div>
                    </div>
                </fieldset>        
        </div>--%>
        
        <div id="modalConfirmeDeleteObjective">
            <!-- Modal -->
            <div class="modal fade" id="confirmedDeleteObjective" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Are you sure you want to delete this objective?</h4>
                        </div>
                        <div class="modal-body">
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="" onclick="deleteObjective()">Yes</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" >No</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="modalConfirmeDeleteContent">
            <!-- Modal -->
            <div class="modal fade" id="confirmedDeleteContent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Are you sure you want to delete this content?</h4>
                        </div>
                        <div class="modal-body">
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="" onclick="deleteContent()">Yes</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" >No</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="modalConfirmeDeleteMethod">
            <!-- Modal -->
            <div class="modal fade" id="confirmedDeleteMethod" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Are you sure you want to delete this method?</h4>
                            <h1 id="methodSelectForDelete"></h1>
                        </div>
                        <div class="modal-body">
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="" onclick="deleteMethod()">Yes</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" >No</button>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
        <div id="modalObjective">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary btn-lg hidden" data-toggle="modal" data-target="#myModal" id="buttomModalObjective">
                Launch demo modal
            </button>

            <!-- Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Modal Objective</h4>
                        </div>
                        <div class="modal-body" id="modal-objectiveLinkLessons">
                            ...
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="modalContent">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary btn-lg hidden" data-toggle="modal" data-target="#myModal" id="buttomModalContent">
                Launch demo modal
            </button>

            <!-- Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Modal Content</h4>
                        </div>
                        <div class="modal-body" id="modal-contentLinkLessons">
                            ...
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="modalMethod">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary btn-lg hidden" data-toggle="modal" data-target="#myModal" id="buttomModalMethod">
                Launch demo modal
            </button>

            <!-- Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Modal Method</h4>
                        </div>
                        <div class="modal-body" id="modal-methodLinkLessons">
                            ...
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    <%---    <%= request.getParameter("message")%>---%>
    </body>
</html>
