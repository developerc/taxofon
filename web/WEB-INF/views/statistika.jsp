<%@ include file = "header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
    var service = 'http://localhost:8080/';
    var blocksize = 10;
    var endArrDamages = blocksize;
    var DmgCount = 0;
    var jsonObjDamage = {};
    var dataArray = [];

    var RestGetAllDamages = function () {
        $.ajax({
            type: 'GET',
            url: service + 'damage/all',
            dataType: 'json',
            async: false,
            success: function (result) {
                var stringData = JSON.stringify(result);
                dataArray = JSON.parse(stringData);
                DmgCount = dataArray.length;
                ShowDataTable();

                RestSetInputDamages();
            },
            error: function (jqXHR, testStatus, errorThrown) {
                $('#response').html(JSON.stringify(jqXHR))
            }
        });
    };

    var ToRight = function () {
     if(endArrDamages < DmgCount ){
          endArrDamages = endArrDamages + blocksize;
     } ;
        // RestGetAllDamages();
        ShowDataTable();
    };

    var ToLeft = function () {
        if((endArrDamages - blocksize) > 0) {
            endArrDamages = endArrDamages - blocksize;
        }
        // RestGetAllDamages();
        ShowDataTable();
    };

    var CloseTroubleReport = function (idDamage) {
        var now = new Date();
      $.ajax({
          type: 'GET',
          url: service + 'damage/get/' + idDamage,
          dataType: 'json',
          async: false,
          success: function (result) {
              // alert(JSON.stringify(result));
              jsonObjDamage = result;
              // var now = new Date();
              jsonObjDamage.dateTimeEnd = now;
              // alert(JSON.stringify(jsonObjDamage));
              PutDamage();
          },
          error: function (jqXHR, testStatus, errorThrown) {
              alert('Ошибка получения неисправности по ID');
          }
      });
    };

    var PutDamage = function () {
        $.ajax({
            type: 'PUT',
            url: service + "damage/upd",
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(jsonObjDamage),
            dataType: 'json',
            async: false,
            success: function (result) {
                // alert(JSON.stringify(result));
                alert("Заявка о неисправности изменена")
            },
            error: function (jqXHR, testStatus, errorThrown) {
                alert('Ошибка добавления неисправности');
            }
        });
    };

    var GetDuration = function (beginTime) {
        var timeNow = new Date();
        // var durTime = new Date(timeNow.getTime() - beginTime.getTime());
        // var formatDurDate = durTime.getFullYear() + " yy, " + durTime.getMonth() + " mm" + durTime.getDate() + " dd," + durTime.getHours() + " hh," + durTime.getMinutes() + " min," + durTime.getSeconds() + " sec";
        var durmlsc = timeNow.getTime() - beginTime.getTime();
        var mlsc;
        var sec;
        var min;
        var hr;
        var dy;
        var mnth;
        var yer;
        var quotient;

        quotient = Math.floor(durmlsc/1000); //общее количество секунд
        mlsc = durmlsc - (quotient * 1000);
        min = Math.floor(quotient / 60); //общее количество минут
        sec = quotient - (min * 60);
        quotient = Math.floor(min/60); //общее количество часов
        min = min - (quotient * 60);
        dy = Math.floor(quotient/24); //общее количество суток
        hr = quotient - (dy * 24);

        return dy + " дней, " + hr + " час, " + min + " мин, " + sec + " сек";
    };

    var RestSetInputDamages = function () {
        $.ajax({
            type: 'GET',
            url: service + 'dmgdescription/all',
            dataType: 'json',
            async: false,
            success: function (result) {
                var output = '';
                var stringData = JSON.stringify(result);
                var arrData = JSON.parse(stringData);
                output+='<select name="typeDamage" id="typeDamage" onclick="ZeroingCounter()">';
                for (i in arrData) {
                    output+='<option>' + arrData[i].itemDamage + '</' + 'option>';
                }
                output+='</' + 'select>';
                output+='<br><input id="idInputTlfNum" value="номер телефона" onclick="ZeroingCounter()">';
                $('#selectTypeDamage').html(output);
            },
            error: function (jqXHR, testStatus, errorThrown) {
                $('#selectTypeDamage').html(JSON.stringify(jqXHR))
            }
        });
    };

    var FindDamages = function () {
        var requestParam = '';
        //Выбрано Radio кнопка "Выбрать все"
        if ($('#radio1').is(':checked')){
            requestParam += "damage/get/all/" + "closed/";
            if ($('#closedCheck1').is(':checked')) {
                requestParam += "true";
            } else {
                requestParam += "false";
            }
        }
        //Выбрано Radio кнопка "Поиск по типу неисправности"
        if ($('#radio2').is(':checked')){
            requestParam += "damage/get/description/" + $('#typeDamage').val() + "/closed/";
            if ($('#closedCheck1').is(':checked')) {
                requestParam += "true";
            } else {
                requestParam += "false";
            }
        }
        //Выбрано Radio кнопка "Поиск по номеру телефона"
        if ($('#radio3').is(':checked')) {
            requestParam += "damage/get/tlfnum/" + $('#idInputTlfNum').val() + "/closed/";
            if ($('#closedCheck1').is(':checked')) {
                requestParam += "true";
            } else {
                requestParam += "false";
            }
        }
        // alert(service + requestParam);
        $.ajax({
            type: 'GET',
            url: service + requestParam,
            dataType: 'json',
            async: false,
            success: function (result) {
                // alert(JSON.stringify(result));
                // jsonObjDamage = result;
                //здесь будем отрисовывать таблицу записей неисправностей
                var stringData = JSON.stringify(result);
                dataArray = JSON.parse(stringData);
                DmgCount = dataArray.length;
                ShowDataTable();
            },
            error: function (jqXHR, testStatus, errorThrown) {
                $('#response').html(JSON.stringify(jqXHR))
            }
        });
    };

    var ShowDataTable = function () {
        // var stringData = JSON.stringify(result);
        //output += '<br>' + stringData;
        // var arrData = JSON.parse(stringData);
        // DmgCount = arrData.length;
        // alert("DmgCount=" + DmgCount);
        var i = endArrDamages -blocksize;
        dtArr = [];
        var durTime = 0;
        var output = '';
        output+= '<table class="table-row-cell" border="1">';
        output+= '<tr>';
        output+= '<th>ID</'+'th>';
        output+= '<th>Тлф номер</'+'th>';
        output+= '<th>Описание неисправности</'+'th>';
        output+= '<th>Дата время начало</'+'th>';
        output+= '<th>Дата время окончание</'+'th>';
        output+= '<th>Продолжительность</'+'th>';
        output+= '<th>Адрес</'+'th>';
        output+= '</' +'tr>';

        // for (i = beginArrDamages; i < beginArrDamages+10; i++) {
        //  for (i in arrData) {
        while (i < endArrDamages){
            if (i == DmgCount){
                break;
            }
            output += '<tr>';
            output += '<th>' + dataArray[i].id + '</' + 'th>';
            output += '<th>' + dataArray[i].tlfnum + '</' + 'th>';
            output += '<th>' + dataArray[i].description + '</' + 'th>';
            // output += '<th>' + arrData[i].dateTimeBegin + '</' + 'th>';
            if (dataArray[i].dateTimeBegin !== null) {
                dtArr = dataArray[i].dateTimeBegin;
                output += '<th>' + dtArr[0] + '-' + (dtArr[1]<10?"0"+dtArr[1]:dtArr[1]) + '-' + dtArr[2] + ' ' + dtArr[3] + ':' + dtArr[4] +'</' + 'th>';
            } else {
                output += '<th>' + "не задано" + '</' + 'th>';
            }
            if (dataArray[i].dateTimeEnd !== null) {
                dtArr = dataArray[i].dateTimeEnd;
                output += '<th>' + dtArr[0] + '-' + (dtArr[1]<10?"0"+dtArr[1]:dtArr[1]) + '-' + dtArr[2] + ' ' + dtArr[3] + ':' + dtArr[4] +'</' + 'th>';
            } else {
                output += '<th>' + "не задано" + '</' + 'th>';
            }
            // output += '<th>' + arrData[i].duration + '</' + 'th>';
            // output += '<th>' + arrData[i].duration + '</' + 'th>';

            if (dataArray[i].dateTimeBegin !== null && dataArray[i].dateTimeEnd == null) {
                durTime = new Date(dataArray[i].dateTimeBegin[0],dataArray[i].dateTimeBegin[1]-1,dataArray[i].dateTimeBegin[2],dataArray[i].dateTimeBegin[3],dataArray[i].dateTimeBegin[4],0,0);
                output+= '<th>' +GetDuration(durTime) +'</' + 'th>';
            } else {
                output += '<th>' + "не задано" + '</' + 'th>';
            }
            output += '<th>' + dataArray[i].krdid + '</' + 'th>';
            output += '</' + 'tr>';
            // beginArrDamages ++;
            i ++;
        }
        output+= '<tr>';
        output+= '<th></'+'th>';
        output+= '<th><button type="button" onclick="ToLeft()">В начало</button></'+'th>';
        output+= '<th><button type="button" onclick="ToRight()">В конец</button></'+'th>';
        // output+= '<th>Описание неисправности</'+'th>';
        output+= '<th></'+'th>';
        output+= '<th></'+'th>';
        output+= '<th></'+'th>';
        output+= '</' +'tr>';

        output+= '</' +'table>';

        $('#response').html(output);
    };

    var ZeroingCounter = function () {
        endArrDamages = blocksize;
    };

    window.onload = RestGetAllDamages;
</script>
<body>
<br><br><br>
<div class="panel panel-default">
    <div class="panel-heading">
        <strong>Статистика неисправностей</strong>
    </div>

    <div class="panel-body">
        <table class="table-row-cell">
            <tr>
                <th>Закрыть неисправность</th>
                <th> <input id="idDamage" value="ID"> </th>
                <th><button type="button" onclick="CloseTroubleReport($('#idDamage').val())">OK</button></th>
            </tr>
            <tr>
                <th>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="" id="closedCheck1" onclick="ZeroingCounter()">
                        <label class="form-check-label" for="closedCheck1">
                            Показывать закрытые неисправности
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="findRadio" id="radio1" value="option1" onclick="ZeroingCounter()" checked>
                        <label class="form-check-label" for="radio1">
                            Выбрать все
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="findRadio" id="radio2" value="option2" onclick="ZeroingCounter()">
                        <label class="form-check-label" for="radio2">
                            Поиск по типу неисправности
                        </label>
                    </div>
                    <div class="form-check disabled">
                        <input class="form-check-input" type="radio" name="findRadio" id="radio3" value="option3" onclick="ZeroingCounter()">
                        <label class="form-check-label" for="radio3">
                            Поиск по номеру телефона
                        </label>
                    </div>

                </th>
                <th valign="bottom" id="selectTypeDamage"></th>
                <th valign="bottom"><button type="button" onclick="FindDamages()">OK</button></th>
            </tr>
        </table>
        <div class="panel-body" id="response"></div>
    </div>
</div>
</body>
<%@ include file = "footer.jsp" %>