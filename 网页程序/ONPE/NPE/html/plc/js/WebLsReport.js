//var employee_code = parent.userinfo.employee_code;
//var employee_code = 'aaa';
$(document).ready(function () {

    $('#dg').datagrid({
        url: '../../ashx/plc/ahLsReport.ashx?action=GetLsTotalData',
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
                {field: 'dIntCjdzId', title: '地址id', width: 50, align: 'right', hidden: true },
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
                { field: 'dVchValue', title: '数值', width: 100, align: 'right' },
                { field: 'dVchUser', title: '用户', width: 100, align: 'right', hidden: true },
                { field: 'dIntRead', title: '读取标识', width: 60, align: 'right', hidden: true }
            ]],
        toolbar: '#tb'

    });
    //分页控件
    var p = $('#dg').datagrid('getPager');
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
    GetCombogrid_ddz();
});
var m_url;
var m_Cjdz;
var m_Dataid = -1;
var m_Address;
var m_CjdzId;
function GetCombogrid_ddz() {
    $('#iAddress').combogrid({
        panelWidth: 500,
        url: '../../ashx/plc/ahLsReport.ashx?action=GetDdzCombogrid',
        required: true,
        method: 'get',
        idField: 'dIntHistoryDataSet_Cloudid',
        textField: 'dVchAddress',
        columns: [[
                { field: 'dIntHistoryDataSet_Cloudid', title: '历史数据id', width: 60, align: 'right', hidden: true },
				{ field: 'dVchAllAdress', title: '采集地址', width: 100, align: 'right' },
                { field: 'dVchAdressName', title: '名称', width: 100, align: 'right' },
                { field: 'dVchAddress', title: '点地址', align: 'right' },
                { field: 'dIntDataType', title: '变量类型id', align: 'right' },
                { field: 'dIntGongType', title: '类别id', align: 'right' },
                { field: 'dIntIsCollect', title: '是否采集', align: 'right' },
                { field: 'dIntCollectSec', title: '采集周期', width: 50, align: 'right' },
                { field: 'dIntCollectType', title: '采集类型', align: 'right', hidden: true },
                { field: 'dIntCollectIndex', title: '采集地址id', align: 'right', hidden: true },
			]],
        fitColumns: true,
        onSelect: function () {
            var grid = $('#iAddress').combogrid('grid');
            var row = grid.datagrid('getSelected');

            m_Cjdz = row.dVchAllAdress;
            m_CjdzId = row.dIntCollectIndex
        }
    });
}
function getdate(value) {
            var t = new Date(value);//long转换成date
            y = t.getFullYear();
            m = t.getMonth() + 1;
            d = t.getDate();
            h = t.getHours();
            i = t.getMinutes();
            s = t.getSeconds();
            // 可根据需要在这里定义时间格式  
            return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i) + ':' + (s < 10 ? '0' + s : s);
        }
        function getconvertTime(value) {
            var t = new Date(value); //long转换成date
            y = t.getFullYear();
            m = t.getMonth() + 1;
            d = t.getDate();
            h = t.getHours();
            i = t.getMinutes();
            s = t.getSeconds();

            return m + '/' + d + '/' + y + ' ' + h + ':' + i;
        }

function doSearch(){
}

function Add() {
    $('#dlg').dialog('open').dialog('setTitle','添加');
    $('#fm-ls').form('clear');
    $('#ileiji').combobox("setValue","0");
    $('#istarttime').timespinner('setValue', '00:00');
    $('#iendtime').timespinner('setValue', '00:00');
    m_url = '../../ashx/plc/ahLsReport.ashx?action=AddLsTotalData';
}
function Edit() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        m_Dataid = row.dIntHistoryReportRequestId;
        m_url = '../../ashx/plc/ahLsReport.ashx?action=EditLsTotalData';
        $('#dlg').dialog('open').dialog('setTitle', '修改');

        $('#iName').textbox('setValue', row.dVchName);
        $('#iAddress').textbox('setValue', row.dVchAddress);
        //var startime = getconvertTime(row.dDeaStartTime);
        $('#istarttime').timespinner('setValue', row.dVchStartTime);
        //var endtime = getconvertTime(row.dDeaEndTime);
        $('#iendtime').timespinner('setValue', row.dVchEndTime);
        $('#ileiji').combobox('setValue', row.dIntalgorithm);
    }
}
function Del() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm('Confirm', '你确定要删除这条记录吗?', function (r) {
            if (r) {
                $.post('../../ashx/plc/ahLsReport.ashx?action=DelLsTotalData', { p_Dataid: row.dIntHistoryReportRequestId }, function (result) {
                    if (result == "True") {
                        $.messager.alert('Warning', '删除成功！');
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
function Save() {
    $('#fm-ls').form('submit', {
        url: m_url,
        onSubmit: function (param) {
            param.p_Cjdz = m_Cjdz;
            param.p_Dataid = m_Dataid;
            param.p_Address = $('#iAddress').textbox('getText');
            param.p_CjdzId = m_CjdzId;
        },
        success: function (data) {
            if (data == "True") {
                $.messager.alert('Warning', '操作成功！');
                $('#dlg').dialog('close'); 	// close the dialog
                $('#dg').datagrid('reload'); // reload the user data
            } else {

                $.messager.show({
                    title: 'Error',
                    msg: data.msg
                });
            }
        }

    });
}
function handle() {
    $('#dlg_load').dialog('open');
    postchange();
    $('#p').progressbar('setValue', 0);
    start();
}
function postchange() {
    var para = {
        vIntState: 1
    }
    $.ajax({
        type: 'post',
        url: '../../ashx/plc/ahLsReport.ashx?action=ChangeState',
        data: para,
        dataType: "text",
        success: function (msg) {
            if (msg == "True") {
               
            }
        }
    });
}

function start() {
    var label = document.getElementById("lb");
    var value = $('#p').progressbar('getValue');
    
    if (value < 100) {
        value += 10
        $('#p').progressbar('setValue', value);
        setTimeout(arguments.callee, 500);

        label.innerText = " ...请稍等!";
        $("#lb").html("数据处理上传中...请稍等!");
    }

    else if (value = 100) {
        label.innerText = "数据上传成功...更新报表!";
        $('#dlg_load').dialog('close');
        $("#lb").html("数据上传成功...更新报表!");
        $('#dg').datagrid('reload');

    }

};
