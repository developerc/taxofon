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
                output+= '<th>Все типы неисправностей</'+'th>';
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
        //заполняем таблицу неисправностb доступных таксофонов
        $.ajax({
            type: 'GET',
            url: service + 'acctax/all',
            dataType: 'json',
            async: false,
            success: function (result) {
                var output = '';
                var stringData = JSON.stringify(result);
                var arrData = JSON.parse(stringData);
                output+= '<table class="table-row-cell" border="1">';
                output+= '<tr>';
                output+= '<th>ID</'+'th>';
                output+= '<th>Тип неисправности доступного таксофона</'+'th>';
                output+= '</' +'tr>';

                for (i in arrData) {
                    output += '<tr>';
                    output += '<th>' + arrData[i].id + '</' + 'th>';
                    output += '<th>' + arrData[i].accDamage + '</' + 'th>';
                    output += '</' + 'tr>';
                }

                output+= '</' +'table>';
                $('#acctable').html(output);
            },
            error: function (jqXHR, testStatus, errorThrown) {
                $('#acctable').html(JSON.stringify(jqXHR))
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
                // RestGetAllDamages();
                // AddDTAcc(addDamageType)
            },
            error: function (jqXHR, testStatus, errorThrown) {
                alert('Ошибка сохранения типа неисправности');
            }
        });
        if ($('#accessCheck1').is(':checked')){
            AddDTAcc(addDamageType);
        }


    };

    //добавляем неисправность доступного таксофона
    var AddDTAcc = function (addDamageType) {
        var JSONObject2 =  {
            'accDamage': addDamageType
        };
        $.ajax({
            type: 'POST',
            url: service + "acctax/add",
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(JSONObject2),
            dataType: 'json',
            async: false,
            success: function (result) {
                alert('Тип неисправности доступного таксофона сохранен');
                RestGetAllDamages();
            },
            error: function (jqXHR, testStatus, errorThrown) {
                alert('Ошибка сохранения типа неисправности доступного таксофона');
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
            DelAccTaxDamage(result);
            RestGetAllDamages();
        },
        error: function (jqXHR, testStatus, errorThrown) {
            alert('Ошибка удаления неисправности');
        }
    });
    };

    var DelAccTaxDamage = function (result) {
        //удаляем рабочую неисправность таксофона
        // alert(JSON.stringify(result));
        var description = result.itemDamage;
        alert('itemDamage:' + description);
        $.ajax({
            type: 'GET',
            url: service + 'acctax/get/description/' + description,
            dataType: 'json',
            async: false,
            success: function (result) {
            alert(JSON.stringify(result));
            //получили массив здесь будем удалять элементы массива
            },
            error: function (jqXHR, testStatus, errorThrown) {
                alert('Ошибка получения неисправности по description');
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
                <th>
                    <input class="form-check-input" type="checkbox" value="" id="accessCheck1" >
                    <label class="form-check-label" for="accessCheck1">
                        Для доступного таксофона
                    </label>
                </th>
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
    <div class="panel-body" id="acctable"></div>
</div>
</body>
<%@ include file = "footer.jsp" %>