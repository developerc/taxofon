<%@ include file = "header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Page Content -->
<script>
    var service = 'http://localhost:8080/';

    var RestGetAllTaxofon = function () {
        $.ajax({
            type: 'GET',
            url: service + 'taxofon/all',
            dataType: 'json',
            async: false,
            success: function (result) {
                var output = '';
                var stringData = JSON.stringify(result);
                output += '<br>' + stringData;
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
            },
            error: function (jqXHR, testStatus, errorThrown) {
                $('#response').html(JSON.stringify(jqXHR))
            }

        });
    };

    window.onload = RestGetAllTaxofon;
</script>
<body>
<br>
<br>
<br>
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
                    <th><input id="addTaxofon" value="тип неисправности"/></th>
                    <th><button type="button" onclick="AddTaxofon($('#addTaxofon').val())">OK</button></th>
                </tr>
                <tr>
                    <th>Удалить по ID таксофон</th>
                    <th><input id="delIdTaxofon" value="ID таксофона"/></th>
                    <th><button type="button" onclick="DelTaxofonId($('#delIdTaxofon').val())">OK</button></th>
                </tr>
            </table>
        </div>
    </div>
    <hr>
    <hr>
</div>
</body>
<%@ include file = "footer.jsp" %>