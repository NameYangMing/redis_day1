<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/9
  Time: 17:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/back/easyui/themes/black/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/back/easyui/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/back/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/back/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/back/easyui/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/back/easyui/form.validator.rules.js"></script>

    <script>
        $(function () {
            var name;
            $("#pp").datagrid({
                url: "${pageContext.request.contextPath}/all/findAll",
                fit: true,
                striped: true,//斑马线效果
                toolbar: '#tb',//显示头部标签
                rownumbers: true,//显示行列号
                pagination: true,//显示分页工具栏
                remoteSort: false,//关闭服务器排序
                pageSize: 5,//每页显示记录数
                pageList: [2, 5, 10, 15, 30],//设置页面分页属性
                //请求远程数据时发送额外参数
                queryParams: {
                    name: $("#name").val(),
                },
                //在数据请求发送之前，将输入框的内容重新发送
                onBeforeLoad: function (param) {
                    //console.log(param);
                    param.name = $("#name").val();
                },
                columns: [[
                    {title: "cks", field: "cks", checkbox: true},
                    {title: "部门ID", field: "id"},
                    {title: "部门编号", field: "no"},
                    {title: "部门名称", field: "name"},
                    {title: "部门创建时间", field: "createDate", sortable: true, order: 'asc'},
                    {title: "部门人数", field: "number"},
                    {title: "部门描述", field: "mark"},
                    {
                        title: "options", field: "options", width: 200,
                        formatter: function (value, row, index) {
                            //console.log(row);
                            return "<a href='javascript:;' class='bb' onclick=\"delRow('" + row.id + "')\" " +
                                "data-options=\"iconCls:'icon-remove'\">删除</a>&nbsp;&nbsp;" +
                                "<a href='javascript:;' class='bb' onclick=\"openEditUserDialog('" + row.id + "')\" " +
                                "data-options=\"iconCls:'icon-edit'\">修改</a>"
                        }
                    }
                ]],
                //将删除和修改变成linkbutton
                onLoadSuccess: function () {
                    $(".bb").linkbutton();
                },

            })
        })

        //删除一行事件
        function delRow(id) {
            //获取当前点击的id 发送ajax请求 删除该id信息
            $.post("${pageContext.request.contextPath}/all/delete", {"id": id},
                function (result) {//请求成功之后的回调函数
                    //console.log(result);
                    if (result.success) {
                        //提示修改信息
                        $.messager.show({title: '提示', msg: '删除成功！'});
                    } else {
                        //提示修改信息
                        $.messager.show({title: '提示', msg: result.message});
                    }
                    //刷新datagrid数据
                    $("#pp").datagrid('reload');//刷新当前datagrid
                });
        }

        //修改一行事件  打开修改用户信息对话框
        function openEditUserDialog(id) {
            //console.log(id);
            $("#editUserDialog").dialog({
                href: '${pageContext.request.contextPath}/back/dept/updata.jsp?id=' + id,
                buttons: [
                    {
                        iconCls: 'icon-save',
                        text: '修改',
                        handler: function () {
                            $("#updataUser").form('submit', {
                                url: '${pageContext.request.contextPath}/all/update',
                                success: function (result) {//注意一定是json字符串  需要转成js对象
                                    var resultObj = $.parseJSON(result);
                                    console.log(resultObj);
                                    if (resultObj.success) {
                                        //提示修改信息
                                        $.messager.show({title: '提示', msg: '用户信息修改成功！'});
                                    } else {
                                        //提示修改信息
                                        $.messager.show({title: '提示', msg: resultObj.message});
                                    }
                                    //关闭dialog
                                    $("#editUserDialog").dialog('close');
                                    //刷新dislog
                                    $("#pp").datagrid('reload');
                                }
                            })
                        }
                    }, {
                        iconCls: 'icon-cancel',
                        text: '取消',
                        handler: function () {
                            //关闭dialog
                            $("#editUserDialog").dialog('close');
                        }
                    }
                ]
            })
        }

        //添加一行事件  打开添加用户信息对话框
        function openSaveUserDialog() {
            $("#saveUserDialog").dialog({
                buttons: [{
                    iconCls: 'icon-save',
                    text: '保存',
                    handler: function () {
                        //保存用户信息
                        $("#saveUser").form('submit', {
                            url: '${pageContext.request.contextPath}/all/save',
                            success: function (result) {//响应的是json格式字符串 因该先转换为js对象
                                var resultObj = $.parseJSON(result);
                                //console.log(resultObj);
                                if (resultObj.success) {
                                    //提示信息
                                    $.messager.show({title: '提示', msg: '用户添加成功！'});
                                } else {
                                    //提示信息
                                    $.messager.show({title: '提示', msg: resultObj.message});
                                }
                                //关闭对话框
                                $("#saveUserDialog").dialog('close');
                                //刷新diagird
                                $("#pp").datagrid('reload');
                            }
                        })
                    }
                }, {
                    iconCls: 'icon-cancel',
                    text: '取消',
                    handler: function () {
                        //关闭dialog
                        $("#saveUserDialog").dialog('close');
                    },
                }]
            })
        };

        //批量删除
        function delBatchRows() {
            //获取选中的对象
            var rows = $("#pp").datagrid('getSelections');
            console.log(rows);
            if (rows.length <= 0) {
                $.messager.show({title: '提示', msg: '至少选中一行！'});
            } else {
                var ids = [];
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
                //获取选中的id集合
                console.log(ids);
                //发送AjAx请求
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/all/deleteMany",
                    data: {"ids": ids},
                    traditional: true,
                    success: function (result) {
                        console.log(result);
                        if (result.success) {
                            //提示信息
                            $.messager.show({title: '提示', msg: '删除成功！'});
                        } else {
                            //提示信息
                            $.messager.show({title: '提示', msg: result.message});
                        }
                        //刷新diagird
                        $("#pp").datagrid('reload');
                    }
                });

            }
        }

        //模糊查询
        function searchMath() {
            $("#pp").datagrid('reload');
        }


    </script>
</head>
<body>

<%--表格--%>
<table id="pp" class="easyui-datagrid"></table>


<%--标签--%>
<div id="tb">
    <a href="javascript:;" onclick="openSaveUserDialog();" class="easyui-linkbutton"
       data-options="iconCls:'icon-add',plain:true">添加</a>
    <a href="javascript:;" onclick="delBatchRows();" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove',plain:true">批量删除</a>
    <%--模糊查询--%>
    <input type="text" id="name" name="name" class="easyui-textbox">
    <input type="button" onclick="searchMath()" value="搜索" class="easyui-linkbutton" data-options="width:80,height:25,">
</div>

<%--增加用户对话框--%>
<div id="saveUserDialog"
     data-options="closable:false,href:'${pageContext.request.contextPath}/back/main/save.jsp',draggable:false,width:500,height:400,title:'保存用户信息'"></div>

<%--修改用户信息对话框--%>
<div id="editUserDialog"
     data-options="closable:false,draggable:false,width:500,height:300,iconCls:'icon-edit',title:'更新用户信息'"></div>

</body>
</html>



