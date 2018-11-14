var action = "add";
$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/admin/AndroidBuildID/AndroidBuildIDHandler.ashx?action=grid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        remoteSort: false,
        singleSelect: true,
        rownumbers: true,
        fit: true,
        striped: true, //行背景交换
        columns: [[
            { field: 'data_id', title: '数据编号', hidden: true },
            { field: 'build_name', title: '样式名称', width: 100 },
            { field: 'build_id', title: '样式编号', width: 100 },
            { field: 'build_remark', title: '样式说明', width: 100 }
        ]]
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 10, //每页显示的记录条数，默认为10 
        pageList: [5, 10, 15], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    $('#win_android_buildid').window({
        title: '',
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
})
function AddAndroidBuildID() {
    action = "add";
    $('#win_android_buildid').window('open').panel({ title: "添加新的推送样式" });
}
function EditAndroidBuildID() {
    var rows = $('#dg').datagrid('getSelected');
    if (rows) {
        $.messager.confirm("操作提示", "您确定要执行编辑操作吗？", function (data) {
            if (data) {
                $('#txt_data_id').val(rows.data_id);
                $('#txt_build_name').textbox('setValue', rows.build_name);
                $('#txt_build_id').numberbox('setValue', rows.build_id);
                $('#txt_build_remark').textbox('setValue', rows.build_remark);
                action = "edit";
                $('#win_android_buildid').window('open').panel({ title: '编辑推送样式信息' });
            }
        });
    }
    else {
        showMsg("操作提示", "您未选择任何数据行", "error")
    }
}
function DelAndroidBuildID() {
    var rows = $('#dg').datagrid('getSelected');
    if (rows) {
        $.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
            if (data) {
                var del_androidbuildid_data = { data_id: rows.data_id };
                $.messager.progress();
                $.ajax({
                    url: '../../ashx/admin/AndroidBuildID/AndroidBuildIDHandler.ashx?action=del',
                    data: del_androidbuildid_data,
                    type: 'post',
                    datatype: 'json',
                    success: function (data) {
                        $.messager.progress('close');
                        var result = eval('(' + data + ')');
                        if (result.success == true) {
                            CloseWin();
                            $('#dg').datagrid('reload');
                            showMsg("操作提示", "删除推送声音成功！", "info")
                        } else {
                            showMsg("操作提示", result.msg, "error")
                        }
                    },
                    error: function (xhr, responseData, status) {
                        $.messager.progress('close');
                        showMsg("操作提示", xhr.responseText, "error")
                    }
                });
            }
        });
    }
    else {
        showMsg("操作提示", "您未选择任何数据行", "error")
    }
}
function CloseWin() {
    $('#win_android_buildid').window('close');
}

function SaveAndroidBuildID() {
    $.messager.progress();
    $('#ff').form('submit', {
        url: '../../ashx/admin/AndroidBuildID/AndroidBuildIDHandler.ashx',
        onSubmit: function (param) {
            var isValid = $(this).form('validate');
            if (!isValid) {
                $.messager.progress('close'); // hide progress bar while the form is invalid
            }
            param.action = action;
            param.data_id = $('#txt_data_id').val();
            param.build_name = $('#txt_build_name').textbox('getValue');
            param.build_id = $('#txt_build_id').numberbox('getValue');
            param.build_remark = $('#txt_build_remark').textbox('getValue');
            return isValid;
        },
        success: function (data) {
            $.messager.progress('close');
            var result = eval('(' + data + ')');
            if (result.success == true) {
                $('#dg').datagrid('reload');
                CloseWin();
                showMsg("操作提示", result.msg, "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        error: function (xhr, responseData, status) {
            $.messager.progress('close');
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};