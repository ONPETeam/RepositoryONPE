var gzmc;
var gzxx;
var gzyy;
var gzlx;
$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/plc/ahplcgzdc.ashx?action=grid',
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
                { field: 'dIntGzID', title: '故障id', width: 60, align: 'right' },
                { field: 'dVchGzName', title: '故障名称', width: 100, align: 'right', sortable: true },
                { field: 'dVchGzXx', title: '故障详细', width: 200, align: 'right' },
                { field: 'dVchGzYy', title: '故障原因', width: 200, align: 'right' },
                { field: 'dVchGzCL', title: '故障处理对策', width: 250, align: 'right' },
                { field: 'dIntGzType', title: '故障类型', width: 60, align: 'right', hidden: true },
                { field: 'dVchGzTypeName', title: '故障分类名称', width: 50, align: 'right' }
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
    $('#dg').datagrid('hideColumn', 'dIntGzID')
    //        $('#dg').datagrid('hideColumn', 'dIntGongYiXitongID')

    //设置dialog的信息
    $('#dlg').dialog({
        title: 'My Dialog',
        width: 400,
        height: 400,
        cache: false,
        href: 'test.htm',
        closed: true,
        modal: true,
        buttons: "#dlg-buttons",
        //            queryParams: { va: 'abc' },
        onLoad: function () {
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                $("#iGzName").val(row.dVchGzName);
                $("#iGzxx").val(row.dVchGzXx);
                $("#iGzyy").val(row.dVchGzYy);
                $("#iGzclbf").val(row.dVchGzCL);
                $("#iGzfl").combobox('select', row.dIntGzType);
            } 
        }
    });

});

    //添加、修改、删除
    var url;
    function Add() {
        $('#dlg').dialog('open').dialog('setTitle', '添加');
        $('#fm').form('clear');
        url = '../../ashx/plc/ahplcgzdc.ashx?action=add';
    }
    function edit() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $('#dlg').dialog('open').dialog('setTitle', '编辑');
            $('#fm').form('load', row);
            url = '../../ashx/plc/ahplcgzdc.ashx?action=Edit&vID=' + row.dIntGzID;

            
            
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
                    $.post('../../ashx/plc/ahplcgzdc.ashx?action=Del&vID=' + row.dIntGzID, "", function (result) {
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
