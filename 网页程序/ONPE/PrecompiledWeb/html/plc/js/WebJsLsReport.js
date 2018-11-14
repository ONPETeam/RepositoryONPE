//var employee_code = parent.userinfo.employee_code;
//var employee_code = 'aaa';
$(document).ready(function () {

    $('#dg_js').datagrid({
        url: '../../ashx/plc/ahLsReport.ashx?action=GetJsLsTotalData',
        //            queryParams: {
        //                eqd: equid_code
        //            },
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pageSize: 50,
        remoteSort: true,
        pagePosition: 'bottom', //分页控件位置
        rownumbers: true,
        singleSelect: true,
        //fit: true,
        striped: true,
        //fitColumns:true,
        columns: [[
        // { field: 'ck',checkbox:true},
                {field: 'dIntDataID', title: '数据id', width: 50, align: 'right', hidden: true },
                { field: 'dVchName', title: '名称', width: 150, align: 'right' },
                { field: 'dIntHistoryReport_A', title: '参数A', width: 100, align: 'right' },
                { field: 'dVchHistoryReport_A_Value', title: '参数A的值', width: 100, align: 'right' },
                { field: 'dIntHistoryReport_B', title: '参数B', width: 100, align: 'right' },
                { field: 'dVchHistoryReport_B_Value', title: '参数B的值', width: 100, align: 'right' },
                { field: 'dIntHistoryReport_C', title: '参数C', width: 100, align: 'right' },
                { field: 'dVchHistoryReport_C_Value', title: '参数C的值', width: 100, align: 'right' },
                { field: 'dVchFormula', title: '公式', width: 100, align: 'right' },
                { field: 'dVchValue', title: '数值', width: 100, align: 'right' },
                { field: 'dVchUser', title: '用户', width: 100, align: 'right', hidden: true },
                { field: 'dIntRead', title: '读取标识', width: 60, align: 'right', hidden: true }
            ]],
        toolbar: '#tb_js'

    });
    //分页控件
    var p = $('#dg_js').datagrid('getPager');
    $(p).pagination({
        pageSize: 50, //每页显示的记录条数，默认为10 
        pageList: [50, 100, 200], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    //datagrid隐藏列代码
    //    $('#dg').datagrid('hideColumn', 'dIntPLCID')
    //    $('#dg').datagrid('hideColumn', 'dIntDataID')
    //    $('#dg').datagrid('hideColumn', 'dVchAllAdress')

    GetCombogrid_Report('ijspara_a');
    GetCombogrid_Report('ijspara_b');
    GetCombogrid_Report('ijspara_c');

});



var m_url;

var m_Dataid = -1;

function GetCombogrid_Report(vcombogrid) {
    s = $('#' + vcombogrid);
    s.combogrid({
        panelWidth: 500,
        url: '../../ashx/plc/ahLsReport.ashx?action=GetDdzCombogrid_Js',
        required: true,
        method: 'get',
        idField: 'dIntHistoryReportRequestId',
        textField: 'dVchName',
        columns: [[
                { field: 'dIntCjdzId', title: '地址id', width: 50, align: 'right', hidden: true },
                { field: 'dVchName', title: '名称', width: 150, align: 'right' },
                { field: 'dVchAddress', title: '地址', width: 100, align: 'right' },
                { field: 'dVchStartTime', title: '开始时间', width: 150, align: 'right' },
                { field: 'dVchEndTime', title: '结束时间', width: 150, align: 'right' },
                { field: 'dVchCjdz', title: '采集地址', width: 150, align: 'right' },
                { field: 'dIntalgorithm', title: '累计算法', width: 100, align: 'right', formatter: function (value, row, index) {
                    if (row.dIntalgorithm == 0) {
                        return "无计算方法";
                    }
                    else if (row.dIntalgorithm == 1) {
                        return "积分";
                    }
                    else {
                        return "微分";
                    }
                }
                },
                { field: 'dVchValue', title: '数值', width: 100, align: 'right',hidden:true },
                { field: 'dVchUser', title: '用户', width: 100, align: 'right', hidden: true },
                { field: 'dIntRead', title: '读取标识', width: 60, align: 'right', hidden: true }
			]],
        fitColumns: true,
        onSelect: function () {


        }
    });
}


function doSearch_js(){
}

function Add_js() {
    $('#dlg_js').dialog('open').dialog('setTitle','添加');
    $('#fm-lsjs').form('clear');
    $('#ijsname').textbox("setValue", "");
    $('#ijspara_a').combogrid('setValue', '');
    $('#ijspara_b').combogrid('setValue', '');
    $('#ijspara_c').combogrid('setValue', '');
    $('#ijsgs').textbox('setValue','');
    m_url = '../../ashx/plc/ahLsReport.ashx?action=AddJsLsTotalData';
}
function Edit_js() {
    var row = $('#dg_js').datagrid('getSelected');
    if (row) {
        m_Dataid = row.dIntHistoryReportRequestId;
        m_url = '../../ashx/plc/ahLsReport.ashx?action=EditJsLsTotalData';
        $('#dlg_js').dialog('open').dialog('setTitle', '修改');
        $('#ijsname').textbox("setValue", row.dVchName);
        $('#ijspara_a').combogrid('setValue', row.dIntHistoryReport_A);
        $('#ijspara_b').combogrid('setValue', row.dIntHistoryReport_B);
        $('#ijspara_c').combogrid('setValue', row.dIntHistoryReport_C);
        $('#ijsgs').textbox('setValue', row.dVchFormula);
        m_Dataid = row.dIntDataID;
    }
}
function Del_js() {
    var row = $('#dg_js').datagrid('getSelected');
    var a = row.dintDataID
    if (row) {
        $.messager.confirm('Confirm', '你确定要删除这条记录吗?', function (r) {
            if (r) {
                $.post('../../ashx/plc/ahLsReport.ashx?action=DelJsLsTotalData', { vdataid: row.dIntDataID }, function (result) {
                    if (result == "True") {
                        $('#dg_js').datagrid('reload'); // reload the user data
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
function Savejs() {
    $('#fm-lsjs').form('submit', {
        url: m_url,
        onSubmit: function (param) {
            param.vdataid = m_Dataid;
            param.vjsname = $('#ijsname').textbox('getValue');
            param.vjsA = $('#ijspara_a').combobox('getValue');
            param.vjsB = $('#ijspara_b').combobox('getValue');
            param.vjsC = $('#ijspara_c').combobox('getValue');
            param.vformula = $('#ijsgs').textbox('getValue');
        },
        success: function (data) {
            if (data == "True") {
                $('#dlg_js').dialog('close'); 	// close the dialog
                $('#dg_js').datagrid('reload'); // reload the user data
            } else {

                $.messager.show({
                    title: 'Error',
                    msg: data.msg
                });
            }
        }

    });
}





