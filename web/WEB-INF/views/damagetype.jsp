<%@ include file = "header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
    var service = 'http://localhost:8080/';
    arrCorrect = [];
    var RestGetAllDamages = function () {
        $.ajax({
            type: 'GET',
            url: service + 'dmgdescription/all',
            dataType: 'json',
            async: false,
            success: function (result) {
                var output = '';
                var stringData = JSON.stringify(result);
               // output += '<br><br>' + stringData;

                var arrData = JSON.parse(stringData);
                /*output +='<br><br>' + arrData.id + '---' + arrData.itemDamage;*/
                output+= '<table class="table-row-cell" border="1">';
                output+= '<tr>';
                output+= '<th>ID</'+'th>';
                output+= '<th>Тип неисправности</'+'th>';
                output+= '</' +'tr>';

                for (i in arrData) {
                    output += '<tr>';
                    output += '<th>' + arrData[i].id + '</' + 'th>';
                    output += '<th>' + arrData[i].itemDamage + '</' + 'th>';
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

    //-------------------------------
    var AddDamageType = function (addDamageType) {
        var JSONObject =  {
            'itemDamage': addDamageType
        };
        $.ajax({
           type: 'POST',
           url: service + "dmgdescription/add",
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(JSONObject),
            dataType: 'json',
            async: false,
            success: function (result) {
                alert('Тип неисправности сохранен');
                RestGetAllDamages();
            },
            error: function (jqXHR, testStatus, errorThrown) {
                alert('Ошибка сохранения типа неисправности');
            }
        });
    };

    var DelDamageId = function (idDamage) {
    $.ajax({
        type: 'DELETE',
        url: service + "dmgdescription/delete?id=" + idDamage,
        dataType: 'json',
        async: false,
        success: function (result) {
            alert('Тип неисправности удален');
            RestGetAllDamages();
        },
        error: function (jqXHR, testStatus, errorThrown) {
            alert('Ошибка удаления неисправности');
        }
    });
    };

    window.onload = RestGetAllDamages;
</script>
<body>
<div class="panel panel-default">
    <div class="panel-heading">
        <strong>Прохождение теста</strong>
    </div>
    <div class="panel-body">
        <table class="table-row-cell">
            <tr>
                <th>Добавить тип неисправности</th>
                <th><input id="addTypeDamage" value="тип неисправности"/></th>
                <th><button type="button" onclick="AddDamageType($('#addTypeDamage').val())">OK</button></th>
            </tr>
            <tr>
                <th>Удалить по ID неисправности</th>
                <th><input id="delIdDamage" value="ID неисправности"/></th>
                <th><button type="button" onclick="DelDamageId($('#delIdDamage').val())">OK</button></th>
            </tr>
        </table>
    </div>
    <div class="panel-body" id="response"></div>
</div>
</body>
<%@ include file = "footer.jsp" %>