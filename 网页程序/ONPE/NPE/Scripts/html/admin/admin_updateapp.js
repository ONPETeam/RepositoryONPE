var oldSelectCode;
var platformType = [
    {
        id: 1,
        text: 'Android'
    }, {
        id: 2,
        text: 'IOS'
    }];
$(document).ready(function () {
    $('#update_file').filebox({
        buttonText: '选择文件'
    });
    $('#dg').datagrid({
        url: '../../ashx/admin/updateapp/updateappHandler.ashx?action=grid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        remoteSort: false,
        singleSelect: true,
        rownumbers: true,
        fit: true,
        striped: true, //行背景交换
        frozenColumns: [[
            { field: 'record_id', title: '记录编号', hidden: true },
            { field: 'record_time', title: '记录时间', hidden: true },
            { field: 'app_name', title: '应用名称', width: 100 }
        ]],
        columns: [[
                { field: 'platform_type', title: '应用平台', width: 120,
                    formatter: function (value, row, index) {
                        if (value != "") {
                            for (var i = 0; i < platformType.length; i++) {
                                var item = platformType[i]
                                if (value == item['id']) {
                                    return item['text'];
                                }
                            }
                            return '未定义类型';
                        }
                    }
                },
                { field: 'platform_guid', title: '应用GUID', hidden: true },
                { field: 'region_name', title: '版本名称', width: 120 },
                { field: 'region_code', title: '版本号', width: 80, sortable: true },
                { field: 'low_region_code', title: '最低版本号',
                    formatter: function (value, row, index) {
                        if (value == "") {
                            return '无';
                        }
                        else {
                            return value;
                        }
                    }
                },
                { field: 'force_update', title: '是否强制更新', width: 100,
                    formatter: function (value, row, index) {
                        if (value == "1") {
                            return '<input type="checkbox" checked="checked"  />';
                        }
                        else {
                            return '<input type="checkbox" />';
                        }
                    }
                },
                { field: 'update_time', title: '更新时间', width: 100, sortable: true },
                { field: 'update_context', title: '更新内容', hidden: true }
            ]],
        onSelect: function (rowIndex, rowData) {
            var $updateapp_layout = $("#updateapp_layout");
            var eastRightGroup = $updateapp_layout.layout("panel", "east");
            if (oldSelectCode == rowData.record_id) {  //点选的是相同的组就不再请求数据
                if (eastRightGroup.panel("options").collapsed) {   //判断是否展开
                    $updateapp_layout.layout("expand", "east");
                } else {
                    $updateapp_layout.layout("collapse", "east");
                }
                return;
            }
            if (eastRightGroup.panel("options").collapsed) {   //判断是否展开
                $updateapp_layout.layout("expand", "east");
            }

            $('#lbl_update_context').html(rowData.update_context);   //赋值
            oldSelectCode = rowData.record_id;   //赋值
        },
        toolbar: [{
            text: '添加',
            iconCls: 'icon-add',
            handler: function () {
                showAdd();
            }
        }, {
            text: '编辑',
            iconCls: 'icon-edit',
            handler: function () {
                showEdit();
            }
        }, {
            text: '删除',
            iconCls: 'icon-cut',
            handler: function () {
                showDel();
            }
        }]
    });

    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 10, //每页显示的记录条数，默认为10 
        pageList: [5, 10, 15], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    $('#ShowWin').window({
        title: '',
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
});

//保存操作
function SaveContent() {
    switch (action) {
        case 'add':
            addData();
            break;
        case 'edit':
            editData();
            break;
    }
};
//显示添加
function showAdd() {
    action = 'add';
    //弹出添加框之前的操作，比如初始化下拉框、设定默认值等
    $('#ShowWin').window('open').panel({ title: '发布新版本' });
    $('#update_file').css('display', '');
    loadCombo();
};
//显示编辑
function showEdit() {
    action = 'edit';
    var row = $('#dg').datagrid('getSelected');
    //row为选中行
    if (row) {
        $.messager.confirm("操作提示", "您确定要执行编辑操作吗？", function (data) {
            loadCombo();
            if (data) {
                $('#record_id').val(row.record_id);
                $('#platform_type').combobox('setValue', row.platform_type);
                $('#platform_guid').textbox('setValue', row.platform_guid);
                $('#platform_guid').textbox('readonly', true); //禁止修改GUID
                $('#app_name').textbox('setValue', row.app_name);
                $('#region_name').textbox('setValue', row.region_name);
                $('#region_code').textbox('setValue', row.region_code);
                $('#low_region_code').textbox('setValue', row.low_region_code);
                $('#force_update').prop('checked', row.force_update === 1);
                $('#update_file').val(row.update_address);
                $('#update_file').css('display', 'none');
                $('#update_time').datetimebox('setValue', row.update_time);
                $('#update_context').textbox('setValue', row.update_context);
                $('#ShowWin').window('open').panel({ title: '修改版本更新记录' });
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
//显示删除
function showDel() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
            if (data) {
                //删除操作
                delData(row.record_id);
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
//添加操作
function addData() {
    $.messager.progress();
    $('#ff').form('submit', {
        url: '../../ashx/admin/updateapp/updateappHandler.ashx?action=add',
        onSubmit: function (param) {
            var isValid = $(this).form('validate');
            if (!isValid) {
                $.messager.progress('close'); // hide progress bar while the form is invalid
            }
            param.platform_type = $('#platform_type').combobox('getValue');
            param.platform_guid = $('#platform_guid').textbox('getValue');
            param.app_name = $('#app_name').textbox('getValue');
            param.region_name = $('#region_name').textbox('getValue');
            param.region_code = $('#region_code').textbox('getValue');
            param.low_region_code = $('#low_region_code').textbox('getValue');
            param.force_update = $('#force_update').val() == "true" ? 1 : 0;
            param.update_time = $('#update_time').datetimebox('getValue');
            param.update_context = $('#update_context').textbox('getValue');
            return isValid;
        },
        success: function (data) {
            $.messager.progress('close');
            var result = eval('(' + data + ')');
            if (result.success == true) {
                $('#dg').datagrid('reload');
                $('#ff').form("clear");
                loadCombo();
                showMsg("操作提示", "新版本发布成功！", "info")
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
//编辑操作
function editData() {
    var edit_UpdateAppInfo = {
        record_id: $('#record_id').val(),
        platform_type: $('#platform_type').combobox('getValue'),
        platform_guid: $('#platform_guid').textbox('getValue'),
        app_name: $('#app_name').textbox('getValue'),
        region_name: $('#region_name').textbox('getValue'),
        region_code: $('#region_code').textbox('getValue'),
        low_region_code: $('#low_region_code').textbox('getValue'),
        force_update: $('#force_update').val() == "true" ? 1 : 0,
        update_time: $('#update_time').datetimebox('getValue'),
        update_context: $('#update_context').textbox('getValue')
    };
    $.ajax({
        url: '../../ashx/admin/updateapp/updateappHandler.ashx?action=edit',
        data: edit_UpdateAppInfo,
        type: 'post',
        datatype: 'json',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == true) {
                closeWin();
                $('#dg').datagrid('reload');
                showMsg("操作提示", "编辑成功！", "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        error: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};
//删除操作
function delData(dataid) {
    var del_UpdateAppInfo = {
        record_id: dataid
    };
    $.ajax({
        url: '../../ashx/admin/updateapp/updateappHandler.ashx?action=del',
        data: del_UpdateAppInfo,
        type: 'post',
        datatype: 'json',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == true) {
                $('#dg').datagrid('reload');
                showMsg("操作提示", "删除成功！", "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        eror: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};
function closeWin() {
    $('#ShowWin').window('close');
    $('#dg').datagrid('reload');
    $('#ff').form("clear");
    loadCombo();
};

function loadCombo() {
    $('#platform_type').combobox({
        valueField: 'id',
        textField: 'text',
        data: platformType
    });
};