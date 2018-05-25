<%@ include file = "header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
    var service = 'http://localhost:8080/';
    var blocksize = 10;
    var endArrDamages = blocksize;
    var DmgCount = 0;
    var jsonObjDamage = {};

    var RestGetAllDamages = function () {
        var i = endArrDamages -blocksize;
        dtArr = [];
        var durTime = 0;
        $.ajax({
            type: 'GET',
            url: service + 'damage/all',
            dataType: 'json',
            async: false,
            success: function (result) {
                var output = '';
                var stringData = JSON.stringify(result);
                 //output += '<br>' + stringData;
                var arrData = JSON.parse(stringData);
                DmgCount = arrData.length;
               // alert("DmgCount=" + DmgCount);

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
                    output += '<th>' + arrData[i].id + '</' + 'th>';
                    output += '<th>' + arrData[i].tlfnum + '</' + 'th>';
                    output += '<th>' + arrData[i].description + '</' + 'th>';
                    // output += '<th>' + arrData[i].dateTimeBegin + '</' + 'th>';
                    if (arrData[i].dateTimeBegin !== null) {
                        dtArr = arrData[i].dateTimeBegin;
                        output += '<th>' + dtArr[0] + '-' + (dtArr[1]<10?"0"+dtArr[1]:dtArr[1]) + '-' + dtArr[2] + ' ' + dtArr[3] + ':' + dtArr[4] +'</' + 'th>';
                    } else {
                        output += '<th>' + "не задано" + '</' + 'th>';
                    }
                    if (arrData[i].dateTimeEnd !== null) {
                        dtArr = arrData[i].dateTimeEnd;
                        output += '<th>' + dtArr[0] + '-' + (dtArr[1]<10?"0"+dtArr[1]:dtArr[1]) + '-' + dtArr[2] + ' ' + dtArr[3] + ':' + dtArr[4] +'</' + 'th>';
                    } else {
                        output += '<th>' + "не задано" + '</' + 'th>';
                    }
                    // output += '<th>' + arrData[i].duration + '</' + 'th>';
                    // output += '<th>' + arrData[i].duration + '</' + 'th>';

                    if (arrData[i].dateTimeBegin !== null) {
                        durTime = new Date(arrData[i].dateTimeBegin[0],arrData[i].dateTimeBegin[1]-1,arrData[i].dateTimeBegin[2],arrData[i].dateTimeBegin[3],arrData[i].dateTimeBegin[4],0,0);
                        output+= '<th>' +GetDuration(durTime) +'</' + 'th>';
                    } else {
                        output += '<th>' + "не задано" + '</' + 'th>';
                    }
                    output += '<th>' + arrData[i].krdid + '</' + 'th>';
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
        RestGetAllDamages();
    };

    var ToLeft = function () {
        if((endArrDamages - blocksize) > 0) {
            endArrDamages = endArrDamages - blocksize;
        }
        RestGetAllDamages();
    };

    var CloseTroubleReport = function (idDamage) {
        var now = new Date();
      $.ajax({
          type: 'GET',
          url: service + 'damage/get/' + idDamage,
          dataType: 'json',
          async: false,
          success: function (result) {
              alert(JSON.stringify(result));
              jsonObjDamage = result;
              // var now = new Date();
              jsonObjDamage.dateTimeEnd = now;
              alert(JSON.stringify(jsonObjDamage));
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

        quotient = Math.floor(durmlsc/1000); //общее количество секунд 4691
        mlsc = durmlsc - (quotient * 1000);
        min = Math.floor(quotient / 60); //общее количество минут
        sec = quotient - (min * 60);
        quotient = Math.floor(min/60); //общее количество часов
        min = min - (quotient * 60);
        dy = Math.floor(quotient/24); //общее количество суток
        hr = quotient - (dy * 24);


        return dy + " дней, " + hr + " час, " + min + " мин, " + sec + " сек, " +mlsc + " млсек";
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
                <th></th>
                <th>Показать все неисправности</th>
                <th><button type="button" onclick="RestGetAllDamages()">ОК</button></th>
            </tr>
        </table>
        <div class="panel-body" id="response"></div>
    </div>
</div>
</body>
<%@ include file = "footer.jsp" %>