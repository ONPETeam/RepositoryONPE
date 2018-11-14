var action = "add";
$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/admin/PushClass/PushClassHandler.ashx?action=grid',
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
            { field: 'class_id', title: '等级编号', hidden: true },
            { field: 'class_name', title: '等级名称', width: 100 },
            
            { field: 'android_buildid_id', title: '安卓样式', hidden: true },
            { field: 'android_buildid_name', title: '安卓样式', width: 100 },
            { field: 'ios_sound_id', title: 'IOS声音', hidden: true },
            { field: 'ios_sound_name', title: 'IOS声音', width: 100 },
            { field: 'class_remark', title: '等级说明', width: 200 }
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
    $('#win_push_class').window({
        title: '',
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
})

function AddPushClass() { 
    action="add";
    $('#win_push_class').window('open').panel({ title: "添加新的推送等级" });
    LoadCombobox();
}
function EditPushClass() {
    var rows = $('#dg').datagrid('getSelected');
    if (rows) {
        $.messager.confirm("操作提示", "您确定要执行编辑操作吗？", function (data) {
            if (data) {
                LoadCombobox();
                $('#txt_class_id').val(rows.class_id);
                $('#txt_class_name').textbox('setValue', rows.class_name);
                $('#txt_class_remark').textbox('setValue', rows.class_remark);
                $('#cmb_android_buildid').combobox('setValue', rows.android_buildid_id).combobox('setText', rows.android_buildid_name);
                $('#cmb_ios_sound').combobox('setValue', rows.ios_sound_id).combobox('setText', rows.ios_sound_name);
                action = "edit";
                $('#win_push_class').window('open').panel({ title: '编辑推送等级信息' });
            }
        });
    }
    else {
        showMsg("操作提示", "您未选择任何数据行", "error")
    }
}

function DelPushClass() {
    var rows = $('#dg').datagrid('getSelected');
    if (rows) {
        $.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
            if (data) {
                var del_pushclass_data = { class_id: rows.class_id };
                $.messager.progress();
                $.ajax({
                    url: '../../ashx/admin/PushClass/PushClassHandler.ashx?action=del',
                    data: del_pushclass_data,
                    type: 'post',
                    datatype: 'json',
                    success: function (data) {
                        $.messager.progress('close');
                        var result = eval('(' + data + ')');
                        if (result.success == true) {
                            CloseWin();
                            $('#dg').datagrid('reload');
                            showMsg("操作提示", "删除推送等级成功！", "info")
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
    $('#win_push_class').window('close');
}

function SavePushClass() {
    $.messager.progress();
    $('#ff').form('submit', {
        url: '../../ashx/admin/PushClass/PushClassHandler.ashx',
        onSubmit: function (param) {
            var isValid = $(this).form('validate');
            if (!isValid) {
                $.messager.progress('close'); // hide progress bar while the form is invalid
            }
            param.action = action;
            param.class_id = $('#txt_class_id').val();
            param.class_name = $('#txt_class_name').textbox('getValue');
            param.class_remark = $('#txt_class_remark').textbox('getValue');
            param.android_buildid = $('#cmb_android_buildid').combobox('getValue');
            param.ios_sound = $('#cmb_ios_sound').combobox('getValue');
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

function LoadCombobox() {
    $('#cmb_android_buildid').combobox({
        valueField: 'id',
        textField: 'text',
        url: "../../ashx/admin/AndroidBuildID/AndroidBuildIDHandler.ashx?action=combo"
    });
    $('#cmb_ios_sound').combobox({
        valueField: 'id',
        textField: 'text',
        url: "../../ashx/admin/IOSSound/IOSSoundHandler.ashx?action=combo"
    });
};