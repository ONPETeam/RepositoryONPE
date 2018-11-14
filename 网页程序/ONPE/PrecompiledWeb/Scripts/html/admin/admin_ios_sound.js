var action = "add";
$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/admin/IOSSound/IOSSoundHandler.ashx?action=grid',
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
            { field: 'sound_id', title: '数据编号', hidden: true },
            { field: 'sound_name', title: '声音名称', width: 100 },
            { field: 'sound_code', title: '声音编码', width: 100 },
            { field: 'sound_remark', title: '声音说明', width: 100 }
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
    $('#win_ios_sound').window({
        title: '',
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
})
function AddIOSSound() {
    action = "add";
    $('#win_ios_sound').window('open').panel({ title: "添加新的推送声音" });
}
function EditIOSSound() {
    var rows = $('#dg').datagrid('getSelected');
    if (rows) {
        $.messager.confirm("操作提示", "您确定要执行编辑操作吗？", function (data) {
            if (data) {
                $('#txt_sound_id').val(rows.sound_id);
                $('#txt_sound_name').textbox('setValue', rows.sound_name);
                $('#txt_sound_code').textbox('setValue', rows.sound_code);
                $('#txt_sound_remark').textbox('setValue', rows.sound_remark);
                action = "edit";
                $('#win_ios_sound').window('open').panel({ title: '编辑推送声音信息' });
            }
        });
    }
    else {
        showMsg("操作提示", "您未选择任何数据行", "error")
    }
}
function DelIOSSound() {
    var rows = $('#dg').datagrid('getSelected');
    if (rows) {
        $.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
            if (data) {
                var del_iossound_data = { sound_id: rows.sound_id };
                $.messager.progress();
                $.ajax({
                    url: '../../ashx/admin/IOSSound/IOSSoundHandler.ashx?action=del',
                    data: del_iossound_data,
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
    $('#win_ios_sound').window('close');
}

function SaveIOSSound() {
    $.messager.progress();
    $('#ff').form('submit', {
        url: '../../ashx/admin/IOSSound/IOSSoundHandler.ashx',
        onSubmit: function (param) {
            var isValid = $(this).form('validate');
            if (!isValid) {
                $.messager.progress('close'); // hide progress bar while the form is invalid
            }
            param.action = action;
            param.sound_id = $('#txt_sound_id').val();
            param.sound_name = $('#txt_sound_name').textbox('getValue');
            param.sound_code = $('#txt_sound_code').textbox('getValue');
            param.sound_remark = $('#txt_sound_remark').textbox('getValue');
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