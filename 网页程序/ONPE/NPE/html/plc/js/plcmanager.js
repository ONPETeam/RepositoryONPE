$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/plc/plcmanager.ashx?action=grid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        remoteSort: true,
        pagePosition: 'bottom', //分页控件位置
        rownumbers: true,
        singleSelect: true,
        fit: true,
        columns: [[
                { field: 'dIntPLCID', title: 'plcID', width: 60, align: 'right' },
                { field: 'dVchPLCName', title: 'plc名称', width: 200, align: 'center', sortable: true },
                { field: 'dVchIPAdress', title: 'plcIP地址', width: 120, align: 'right' },
                { field: 'dIntPLCPinPaiID', title: 'plc品牌', width: 100, align: 'right' },
                { field: 'dIntGongYiXitongID', title: 'plc系统', width: 100, align: 'right' },
                { field: 'dVchPLCPinPaiName', title: 'plc品牌', width: 150, align: 'right' },
                { field: 'dVchArea', title: '区域', width: 100, align: 'right' },
                { field: 'dVchPLCbianma', title: '编码', width: 150, align: 'right' },
                { field: 'dVchRemark', title: '备注', width: 200, align: 'right' },
            ]],

        //width: 1066,
        //rowStyler: function (index, row) { if (index % 2 == 0) { return 'background-color:#ccccff;'; } },
        //striped: true, pagination: true, rownumbers: true, singleSelect: true, pageNumber: 1, pageSize: 8, pageList: [1, 2, 4, 8, 16, 32], showFooter: true,
        toolbar: '#tb'


    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 10, //每页显示的记录条数，默认为10 
        pageList: [10, 20, 30], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    $('#dg').datagrid('hideColumn', 'dIntPLCID')
    $('#dg').datagrid('hideColumn', 'dIntPLCPinPaiID')
    $('#dg').datagrid('hideColumn', 'dIntGongYiXitongID')

    //        loadCombobox('#sgyxt');

    $('#sgyxt').combobox({
        url: '../../ashx/plc/ahplcXitong.ashx?action=topcombobox',
        method: 'get',
        valueField: 'dIntAreaID',
        textField: 'dVchArea',
        panelHeight: 'auto'
    });

});
//    var loadCombobox = function (id) {
//        $(id).combobox({
//            url: '../../ashx/plc/plcgyxt.ashx',
//            method: 'get',
//            valueField: 'id',
//            textField: 'text',
//            panelHeight: 'auto'
//        });
//    };

//添加、修改、删除
var url;
function newplc() {
    $('#dlg').dialog('open').dialog('setTitle', '添加窗口');
    $("#iPLCName").textbox('setValue', "");
    $("#iIPAdress").textbox('setValue', "");
    $("#idVchRemark").textbox('setValue', "");
    $('#iPlcCode').textbox('setValue', "");
    $("#iPP").combobox('clear');
    $("#iXT").combobox('clear');
    url = '../../ashx/plc/plcmanager.ashx?action=add';
}
function editplc() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $('#dlg').dialog('open').dialog('setTitle', '编辑窗口');
        $('#fm').form('load', row);
        url = '../../ashx/plc/plcmanager.ashx?action=edit&ID=' + row.dIntPLCID;
        $("#iPLCName").textbox('setValue', row.dVchPLCName);
        $("#iIPAdress").textbox('setValue', row.dVchIPAdress);
        $('#iPlcCode').textbox('setValue', row.dVchPLCbianma);
        $("#iRemark").textbox('setValue', row.dVchRemark);
        $("#iPP").combobox('select', row.dIntPLCPinPaiID);
        $("#iXT").combobox('select', row.dIntGongYiXitongID);
    }

}


function saveplc() {
    $('#fm').form('submit', {
        url: url,
        onSubmit: function () {
            return $(this).form('validate');
        },
        success: function (result) {
            // var result = eval('(' + result + ')');
            //	var result = eval(result);                 
            //if (result.success) {
            if (result == "成功") {
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
function removeplc() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm('Confirm', '你确定要删除这条记录吗?', function (r) {
            if (r) {
                $.post('../../ashx/plc/plcmanager.ashx?action=delete&ID=' + row.dIntPLCID, { id: row.dIntPLCID }, function (result) {
                    if (result == "成功") {
                        $('#dg').datagrid('reload'); // reload the user data
                    } else {
                        $.messager.show({	// show error message
                            title: 'Error',
                            msg: result.msg
                        });
                    }
                }, 'text');
            }
        });
    }
}

function doSearch() {
    $('#dg').datagrid('load', {
        plcname: $('#splcname').val(),
        gyxt: $('#sgyxt').combobox('getValue')
    });

}