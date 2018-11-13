<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function () {
        //console.log("${param.id}");
        $("#updataUser").form('load',
            '${pageContext.request.contextPath}/all/queryOne?id=${param.id}');
    })

</script>

<div style="text-align: center;margin-top: 30px;">
    <form id="updataUser" method="get">
        <input type="hidden" name="id">
        name: <input type="text" name="name" class="easyui-textbox"><br><br>
        age: <input type="text" name="age" class="easyui-textbox"><br><br>
        address: <input type="text" name="address" class="easyui-textbox"><br><br>
        birthday: <input type="text" name="birthday" class="easyui-datebox">
    </form>
</div>

