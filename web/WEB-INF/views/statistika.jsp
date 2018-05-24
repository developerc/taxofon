<%@ include file = "header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
    var service = 'http://localhost:8080/';
    var beginArrDamages = 0;
    var DmgCount = 0;

    var RestGetAllDamages = function () {
        dtArr = [];
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
                output+= '<th>Адрес</'+'th>';
                output+= '</' +'tr>';

                // for (i = beginArrDamages; i < beginArrDamages+10; i++) {
                 for (i in arrData) {
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
                    //output += '<th>' + arrData[i].dateTimeEnd + '</' + 'th>';
                    output += '<th>' + arrData[i].krdid + '</' + 'th>';
                    output += '</' + 'tr>';
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
     // if((beginArrDamages + 10) < DmgCount ){
          beginArrDamages = beginArrDamages + 10;
     // } ;
        RestGetAllDamages();
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
                <th>Показать все неисправности</th>
                <th><button type="button" onclick="RestGetAllDamages()">ОК</button></th>
            </tr>
        </table>
        <div class="panel-body" id="response"></div>
    </div>
</div>
</body>
<%@ include file = "footer.jsp" %>