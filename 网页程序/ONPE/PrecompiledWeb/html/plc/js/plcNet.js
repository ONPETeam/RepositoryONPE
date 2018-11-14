$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/plc/ahplcNet.ashx?action=grid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        remoteSort: true,
        pagePosition: 'bottom', //分页控件位置
        rownumbers: true,
        singleSelect: true,
        fit: true,
        striped: true,
        columns: [[
                { field: 'dIntDataID', title: '数据id', width: 60, align: 'right', hidden: true },
                { field: 'dVchName', title: '名称', width: 200, align: 'left', sortable: true },
                { field: 'dVchIP', title: 'IP地址', width: 200, align: 'right' },
                { field: 'dVchType', title: '分类', width: 200, align: 'right' },
                { field: 'dVchPointType', title: '区域系统', width: 200, align: 'right' },
                { field: 'dVchState', title: '状态', width: 50, align: 'right' }
            ]],

        width: 1066,
        //            rowStyler: function (index, row) { if (index % 2 == 0) { return 'background-color:#ccccff;'; } },
        //striped: true, pagination: true, rownumbers: true, singleSelect: true, pageNumber: 1, pageSize: 8, pageList: [1, 2, 4, 8, 16, 32], showFooter: true,
        toolbar: [{
            text: '添加',
            iconCls: 'icon-add',
            handler: function () { Add() }
        }, {
            text: '修改',
            iconCls: 'icon-edit',
            handler: function () { edit() }
        }, '-', {
            text: '删除',
            iconCls: 'icon-cut',
            handler: function () { del() }
        }]
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 10, //每页显示的记录条数，默认为10 
        pageList: [10, 20, 30], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    //        $('#dg').datagrid('hideColumn', 'dIntGzID')
    //        $('#dg').datagrid('hideColumn', 'dIntGongYiXitongID')
});

//添加、修改、删除
var url;
function Add() {
    $('#dlg').dialog('open').dialog('setTitle', '添加');
    $('#fm').form('clear');
    url = '../../ashx/plc/ahplcNet.ashx?action=add';
}
function edit() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $('#dlg').dialog('open').dialog('setTitle', '编辑');
        $('#fm').form('load', row);
        url = '../../ashx/plc/ahplcNet.ashx?action=Edit&vID=' + row.dIntDataID;
        $("#iName").val(row.dVchName);
        $("#iIP").val(row.dVchIP);
        $("#iLb").combobox('select', row.dIntType);
        $("#iXT").combobox('select', row.dIntAreaOrXt);

    }

}

function savedc() {
    $('#fm').form('submit', {
        url: url,
        onSubmit: function () {
            return $(this).form('validate');
        },
        success: function (result) {
            var result = eval('(' + result + ')');
            //		            var result = eval(result);                 
            //		            if (result.success) {
            if (result == 0) {
                $('#dlg').dialog('close'); 	// close the dialog
                $('#dg').datagrid('reload'); // reload the user data
            } else {
                $.messager.show({
                    title: 'Error',
                    msg: result.msg
                });
            }
        }
    });
}
function del() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm('Confirm', '你确定要删除这条记录吗?', function (r) {
            if (r) {
                $.post('../../ashx/plc/ahplcNet.ashx?action=Del&vID=' + row.dIntDataID, "", function (result) {
                    if (result == 0) {
                        $('#dg').datagrid('reload'); // reload the user data
                    } else {
                        $.messager.show({	// show error message
                            title: 'Error',
                            msg: result.msg
                        });
                    }
                }, 'json');
            }
        });
    }
}