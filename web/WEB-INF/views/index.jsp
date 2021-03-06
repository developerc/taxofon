<%@ include file = "header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Page Content -->
<script>
    var service = 'http://localhost:8080/';
    var jsonObjTaxofon = {};
    var jsonObjDamage = {};
    var jsonArrDamage = [];

    var RestGetAllTaxofon = function () {
        $.ajax({
            type: 'GET',
            url: service + 'taxofon/all',
            dataType: 'json',
            async: false,
            success: function (result) {
                var output = '';
                var stringData = JSON.stringify(result);
                // output += '<br>' + stringData;
                var arrData = JSON.parse(stringData);
                output+= '<table class="table-row-cell" border="1">';
                output+= '<tr>';
                output+= '<th>ID</'+'th>';
                output+= '<th>Тлф номер</'+'th>';
                output+= '<th>ID таксофона</'+'th>';
                output+= '<th>Longitude</'+'th>';
                output+= '<th>Latitude</'+'th>';
                output+= '<th>SAM модуль</'+'th>';
                output+= '<th>Модель</'+'th>';
                output+= '<th>Адрес</'+'th>';
                output+= '<th>Версия</'+'th>';
                output+= '</' +'tr>';

                for (i in arrData) {
                    output += '<tr>';
                    output += '<th>' + arrData[i].id + '</' + 'th>';
                    output += '<th>' + arrData[i].tlfnum + '</' + 'th>';
                    output += '<th>' + arrData[i].krdid + '</' + 'th>';
                    output += '<th>' + arrData[i].lon + '</' + 'th>';
                    output += '<th>' + arrData[i].lat + '</' + 'th>';
                    output += '<th>' + arrData[i].numsam + '</' + 'th>';
                    output += '<th>' + arrData[i].type + '</' + 'th>';
                    output += '<th>' + arrData[i].adres + '</' + 'th>';
                    output += '<th>' + arrData[i].version + '</' + 'th>';
                    output += '</' + 'tr>';
                }

                output+= '</' +'table>';
                $('#response').html(output);
                RestGetAllDamages();
            },
            error: function (jqXHR, testStatus, errorThrown) {
                $('#response').html(JSON.stringify(jqXHR))
            }

        });
    };

    var RestGetAllDamages = function () {
        $.ajax({
            type: 'GET',
            url: service + 'dmgdescription/all',
            dataType: 'json',
            async: false,
            success: function (result) {
                var output = '';
                var stringData = JSON.stringify(result);
                var arrData = JSON.parse(stringData);
                output+='<select name="typeDamage" id="typeDamage">';
                for (i in arrData) {
                    output+='<option>' + arrData[i].itemDamage + '</' + 'option>';
                    /*output+=
                <option>неисправность 1</option>*/
                }
                output+='</' + 'select>'
                $('#selectTypeDamage').html(output);
            },
            error: function (jqXHR, testStatus, errorThrown) {
                $('#selectTypeDamage').html(JSON.stringify(jqXHR))
            }
        });
    };

    //------
    $( function() {
        $( "#dialog" ).dialog({
            autoOpen: false,
            height: 400,
            width: 400,
            modal: true
        });
    } );

    $( function() {
        var now = new Date();
        var year = now.getFullYear();
        var month = now.getMonth() + 1;
        var day = now.getDate();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();
        if (month < 10){
            month = "0" + month;
        }
        if (day < 10){
            day ="0" + day;
        }
        if (hours < 10){
            hours ="0" + hours;
        }
        if (minutes < 10){
            minutes ="0" + minutes;
        }
        $( "#datepicker" ).datepicker();
        $( "#datepicker" ).datepicker("option", "dateFormat", "yy-mm-dd");
        $("#datepicker").val(year + "-" + month + "-" + day);

        $("#timecurrent").val(hours + ":" + minutes);
    } );


    var OpenModalForm = function () {
      $("#dialog").dialog('open');
    };

    var CloseModalForm = function () {
        $("#dialog").dialog('close');
    };

    var RestAddTaxofon = function (tlfnum,krdid,lon,lat,numsam,type,adres,version) {
        var JSONObject =  {
            'tlfnum': tlfnum,
            'krdid': krdid,
            'lon': lon,
            'lat': lat,
            'numsam': numsam,
            'type': type,
            'adres': adres,
            'version': version,
        };
        $.ajax({
            type: 'POST',
            url: service + "taxofon/add",
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(JSONObject),
            dataType: 'json',
            async: false,
            success: function (result) {
                CloseModalForm();
                RestGetAllTaxofon();
            },
            error: function (jqXHR, testStatus, errorThrown) {
                alert('Ошибка сохранения таксофона');
            }
        });
    };

    var RestDelIdTaxofon = function (idTaxofon) {
        $.ajax({
            type: 'DELETE',
            url: service + "taxofon/delete?id=" + idTaxofon,
            dataType: 'json',
            async: false,
            success: function (result) {
                CloseModalForm();
                RestGetAllTaxofon();
            },
            error: function (jqXHR, testStatus, errorThrown) {
                alert('Ошибка удаления таксофона');
            }
        });
    };

    var  OpenTroubleReport = function (idDamagedTaxofon, typeDamage) {
        var idDmgTax = idDamagedTaxofon;
        var typDmg = typeDamage;
        // var jsonObjTaxofon = {};
       // alert(idDmgTax + '___' + typDmg);
        //получили экземпляр таксофона от сервера
        GetTaxofonById(idDmgTax, typDmg);
        //добавляем неисправность в таблицу неисправностей
        // PostDamage(typDmg);
        //обьект неисправности приклеиваем к обьекту таксофона и делаем Update таксофона
        // PutJsonTaxofonAddDamage();
        // alert(jsonObjTaxofon.tlfnum);
        // alert(JSON.stringify(jsonObjTaxofon));
        // alert(jsonObjTaxofon);

    };

    var GetTaxofonById = function (idTaxofon, typDmg) {
        $.ajax({
            type: 'GET',
            url: service + 'taxofon/get/' + idTaxofon,
            dataType: 'json',
            async: false,
            success: function (result) {
                // alert(JSON.stringify(result));
                jsonObjTaxofon = result;
                PostDamage(typDmg);
            },
            error: function (jqXHR, testStatus, errorThrown) {
                alert('Ошибка получения таксофона по ID');
            }
        });
    };
    
    var PostDamage = function (typDmg) {
        var dtb = $("#datepicker").val() + "T" +$("#timecurrent").val();
        var JSONObject =  {
            'tlfnum':jsonObjTaxofon.tlfnum,
            'description': typDmg,
            'krdid': jsonObjTaxofon.adres,
            // 'dateTimeBegin': "2018-05-23T13:50:00"
            'dateTimeBegin': dtb
        };
        // alert(JSON.stringify(JSONObject));
        $.ajax({
            type: 'POST',
            url: service + "damage/add",
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(JSONObject),
            dataType: 'json',
            async: false,
            success: function (result) {
                jsonObjDamage =result;
                PutJsonTaxofonAddDamage();
                // alert("dateTimeBegin:" + dtb);
            },
            error: function (jqXHR, testStatus, errorThrown) {
                alert('Ошибка добавления неисправности');
            }
        });
    };
    
    var PutJsonTaxofonAddDamage = function () {
        // jsonObjTaxofon.damageLists = jsonObjDamage;
        // jsonObjTaxofon.damageLists.add(jsonObjDamage);
        jsonArrDamage = jsonObjTaxofon.damageLists;
        jsonArrDamage.push(jsonObjDamage);
        jsonObjTaxofon.damageLists = jsonArrDamage;
        // alert(JSON.stringify(jsonObjTaxofon));
        $.ajax({
           //здесь будет тело PUT запроса
            type: 'PUT',
            url: service + "taxofon/upd",
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(jsonObjTaxofon),
            dataType: 'json',
            async: false,
            success: function (result) {
                // alert(JSON.stringify(result));
                alert("Заявка о неисправности добавлена")
            },
            error: function (jqXHR, testStatus, errorThrown) {
                alert('Ошибка добавления неисправности');
            }
        });
    };

    var PutDateTimeNow = function () {

    };

    window.onload = RestGetAllTaxofon;
</script>
<body>
<br>
<br>
<br>


<div id="dialog" title="Данные для нового таксофона">
    <form>
    <p><input type="text" name="tlfnum" id="tlfnum" value="41256" class="text ui-widget-content ui-corner-all"><label for="tlfnum">Тлф номер</label></p>
    <p><input type="text" name="krdid" id="krdid" value="253" class="text ui-widget-content ui-corner-all"><label for="krdid">ID таксофона</label></p>
    <p><input type="text" name="lon" id="lon" value="45.568" class="text ui-widget-content ui-corner-all"><label for="lon">Longitude</label></p>
    <p><input type="text" name="lat" id="lat" value="23.432" class="text ui-widget-content ui-corner-all"><label for="lat">Latitude</label></p>
    <p><input type="text" name="numsam" id="numsam" value="2435" class="text ui-widget-content ui-corner-all"><label for="numsam">Номер SAM модуля</label></p>
    <p><input type="text" name="type" id="type" value="УТЭК" class="text ui-widget-content ui-corner-all"><label for="type">Модель</label></p>
    <p><input type="text" name="adres" id="adres" value="Адрес установки" class="text ui-widget-content ui-corner-all"><label for="adres">Адрес</label></p>
    <p><input type="text" name="version" id="version" value="Версия" class="text ui-widget-content ui-corner-all"><label for="version">Версия</label></p>
    <p><button type="button" onclick="RestAddTaxofon($('#tlfnum').val(), $('#krdid').val(), $('#lon').val(), $('#lat').val(), $('#numsam').val(), $('#type').val(), $('#adres').val(), $('#version').val())">OK</button>
        <button type="button" onclick="CloseModalForm()">CANCEL</button>
    </p>
    </form>
</div>

<div class="container">

    <div class="panel panel-default">
        <div class="panel-heading">
            <strong>Список таксофонов ЛТЦ Тихорецкий район</strong>
        </div>
        <div class="panel-body" id="response"></div>
        <div class="panel-body">
            <table class="table-row-cell">
                <tr>
                    <th>Добавить таксофон</th>
                    <th><%--<input id="addTaxofon" value="тип неисправности"/>--%></th>
                    <%--<th><button type="button" onclick="AddTaxofon($('#addTaxofon').val())">OK</button></th>--%>
                    <th><button type="button" onclick="OpenModalForm()">OK</button></th>
                </tr>
                <tr>
                    <th>Удалить по ID</th>
                    <th><input id="delIdTaxofon" value="ID"/></th>
                    <th><button type="button" onclick="RestDelIdTaxofon($('#delIdTaxofon').val())">OK</button></th>
                </tr>
            </table>
        </div>
    </div>
    <hr>
    <hr>
    <div class="panel">
        <div class="panel-heading"><strong>Неисправности Таксофонов</strong></div>
        <div class="panel-body">
            <table class="table-row-cell">
                <tr>
                    <th>Открыть заявку</th>
                    <th> <input id="idDamagedTaxofon" value="ID"> </th>
                    <th id="selectTypeDamage"></th>
                    <th>Дата: <input type="text" id="datepicker" size="30"></th>
                    <th>Время: <input id="timecurrent" type="text"></th>
                    <th><button type="button" onclick="OpenTroubleReport($('#idDamagedTaxofon').val(),$('#typeDamage').val())">OK</button></th>
                    <%--<th><button type="button" onclick="GetTaxofonById($('#idDamagedTaxofon').val())">OK</button></th>--%>
                </tr>

                <%--<tr>
                    <th>Закрыть заявку</th>
                    <th> <input id="idRepairedTaxofon" value="ID"> </th>
                    <th><button type="button" onclick="CloseTroubleReport($('#idRepairedTaxofon').val())">OK</button></th>
                </tr>--%>
            </table>
        </div>
    </div>

    </div>
</body>
<%@ include file = "footer.jsp" %>