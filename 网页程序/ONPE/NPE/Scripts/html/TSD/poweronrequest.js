$(document).ready(function () {
    $('#dg').datagrid({
        title: '送电申请单',
        url: '../../ashx/tsd/TSDQueryHandler.ashx?action=powerondata',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        pageSize: 20, //每页显示的记录条数，默认为20 
        pageList: [10, 20, 50], //可以设置每页记录条数的列表 
        remoteSort: false,
        singleSelect: true,
        rownumbers: true,
        fit: true,
        striped: true, //行背景交换
        columns: [[
                { field: 'poweron_id', title: '申请单编号', hidden: true },
                { field: 'request_status', title: '申请单状态', align: 'center',
                    formatter: function (value, row, index) {
                        switch (value.toString()) {
                            case "-99":
                                return "已撤销";
                                break;
                            case "0":
                                return "已申请/待审核";
                                break;
                            case "1":
                                return "已审核/待送电";
                                break;
                            case "2":
                                return "已送电";
                                break;
                        }
                    }
                },
                { field: 'request_company', title: '送电申请公司编号', hidden: true },
                { field: 'request_company_name', title: '送电申请公司', align: 'center' },
                { field: 'request_branch', title: '送电申请部门编号', hidden: true },
                { field: 'request_branch_name', title: '送电申请部门', align: 'center' },
                { field: 'request_people', title: '送电申请人编号', hidden: true },
                { field: 'employee_name', title: '送电申请人', align: 'center' },
                { field: 'equip_code', title: '送电设备编号', hidden: true },
                { field: 'equip_name', title: '申请送电设备', align: 'center' },
                { field: 'request_time', title: '申请时间', align: 'center' },
                { field: 'stop_time', title: '送电时间', align: 'center' },
                { field: 'request_remark', title: '申请备注', align: 'center' },
                { field: 'poweroff_id', title: '查看停电申请', align: 'center',
                    formatter: function (value, row, index) {
                        if (value != "") {
                            return '<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:\'icon-search\',plain:true" onclick="ShowPowerOffRequest(\'' + value + '\')">查看</a>';
                        }
                        else {
                            return '';
                        }
                    }
                }
            ]],
        onSelect: function (rowIndex, rowData) {
            if (rowData.request_status.toString() == "0") {
                $("#btn_cancle_power_on_request").linkbutton('enable');
            }
            else {
                $("#btn_cancle_power_on_request").linkbutton('disable');
            }
        }
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    $('#win_add_poweron_request').window({
        title: '添加送电申请',
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
    $('#win_show_poweroff_request_detail').window({
        title: '停电申请详情',
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
});
function AddPowerOnRequest() {
    $('#win_add_poweron_request').window('open').panel({ title: '添加送电申请' });
    LoadDefaultValue();
    LoadWaitForPowerOnData();
}
function CloseAddWin() {
    $('#win_add_poweron_request').window('close');
}
function LoadDefaultValue() {
    $('#request_company').val(parent.userinfo.company_id);
    $('#txt_request_company').textbox('setValue', parent.userinfo.company_name);
    $('#request_branch').val(parent.userinfo.branch_id);
    $('#txt_request_branch').textbox('setValue', parent.userinfo.branch_name);
    $('#request_employee').val(parent.userinfo.employee_code);
    $('#txt_request_employee').textbox('setValue', parent.userinfo.employee_name);
}
function LoadWaitForPowerOnData() {
    $('#dg_poweroff_request').datagrid({
        url: '../../ashx/tsd/TSDQueryHandler.ashx?action=poweroffdata&request_status=2',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        pageSize: 20, //每页显示的记录条数，默认为20 
        pageList: [10, 20, 50], //可以设置每页记录条数的列表 
        remoteSort: false,
        singleSelect: true,
        rownumbers: true,
        fit: true,
        striped: true, //行背景交换
        columns: [[
                { field: 'poweroff_id', title: '申请单编号', hidden: true },
                { field: 'company_name', title: '停电申请公司', align: 'center' },
                { field: 'branch_name', title: '停电申请部门', align: 'center' },
                { field: 'employee_name', title: '停电申请人', align: 'center' },
                { field: 'request_time', title: '申请时间', align: 'center' },
                { field: 'equip_name', title: '停电设备', align: 'center' },
                { field: 'stop_time', title: '停电时间', align: 'center' },
                { field: 'stop_duration', title: '停电时长（小时）', align: 'center' }
            ]],
        onSelect: function (rowIndex, rowData) {
            $('#poweroff_id').val(rowData.poweroff_id.toString());
            $('#poweroff_descript').html(rowData.stop_time.toString() + "--" + rowData.equip_name + "--停电时长:" + rowData.stop_duration + "(小时)");
        }
    });
    var p = $('#dg_poweroff_request').datagrid('getPager');
    $(p).pagination({
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
};

function ClearSelectPowerOff() {
    $('#poweroff_id').val('');
    $('#poweroff_descript').html('');
}

function RequestPowerOn() {
    $.messager.progress();
    $('#ff').form('submit', {
        url: '../../ashx/tsd/TSDOperateHandler.ashx?action=poweronrequest',
        onSubmit: function (param) {
            var isValid = ValidateForm();
            if (!isValid) {
                $.messager.progress('close');
            }
            param.action = "poweronrequest";
            param.poweroff_id = $('#poweroff_id').val();
            param.request_company = $('#request_company').val();
            param.request_branch = $('#request_branch').val();
            param.request_people = $('#request_employee').val();
            param.request_time = (new Date()).toLocaleString().replace(/[年月]/g, '/').replace(/[日上下午]/g, '').replace(/[‎]‎/g, '').replace(/[‎]/g, '');
            param.start_time = $('#dtb_start_time').datetimebox('getValue');
            param.request_remark = $('#txt_request_remark').textbox('getValue');
            return isValid;
        },
        success: function (data) {
            $.messager.progress('close');
            var result = eval('(' + data + ')');
            if (result.success.toString() == 'true') {
                $('#dg').datagrid('reload');
                $('#ff').form("reset");
                showMsg("操作提示", "提交成功！", "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        error: function (xhr, responseData, status) {
            $.messager.progress('close');
            showMsg("操作提示", xhr.responseText, "error");
        }
    });
}
function ValidateForm() {
    var formValidate = $('#ff').form('validate');
    if (formValidate) {
        if ($('#poweroff_id').val() != "") {
            return true;
        }
        else {
            showMsg("操作提示", "请选择要送电的停电单！", "error");
            return false;
        }
    }
    else {
        return false;
    }
}
function CancelPowerOnRequest() {
    var row = $("#dg").datagrid("getSelected");
    if (row) {
        $.messager.confirm("操作提示", "您确定要撤销该申请吗？", function (data) {
            if (data) {
                $.messager.progress();
                var poweronRequestID = row.poweron_id.toString();
                $.ajax({
                    url: '../../ashx/tsd/TSDOperateHandler.ashx?action=cancelpoweron',
                    data: { poweron_id: poweronRequestID },
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        var result = eval('(' + data + ')');
                        if (result.success.toString() == 'true') {
                            $('#dg').datagrid('reload');
                            showMsg("操作提示", "撤销成功！", "info")
                        } else {
                            showMsg("操作提示", result.msg, "error")
                        }
                    },
                    eror: function (xhr, responseData, status) {
                        showMsg("操作提示", xhr.responseText, "error")
                    }
                });

            }
        });
    }
    else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
}
function SearchData() {
    $('#dg').datagrid('load', {
        request_start: $("#search_request_start").datetimebox("getValue"),
        request_end: $("#search_request_end").datetimebox("getValue"),
        poweron_start: $("#search_poweron_start").datetimebox("getValue"),
        poweron_end: $("#search_poweron_end").datetimebox("getValue")
    });
}

function ShowPowerOffRequest(poweroffId) {
    $.messager.progress();
    $.ajax({
        url: '../../ashx/tsd/TSDQueryHandler.ashx',
        data: {
            action: 'poweroffdetail',
            poweroff_id: poweroffId
        },
        dataType: 'text',
        type: 'post',
        success: function (data) {
            $.messager.progress('close');
            var result = eval('(' + data + ')');
            $('#show_poweroff_id').val(result.poweroff_id.toString());
            var poweroff_status = '';
            switch (result.request_status.toString()) {
                case "0":
                    poweroff_status = "已申请/待审核";
                    break;
                case "-99":
                    poweroff_status = "已撤销";
                    break;
                case "-66":
                    poweroff_status = "审核未通过";
                    break;
                case "1":
                    poweroff_status = "已审核/待停电";
                    break;
                case "2":
                    poweroff_status = "已停电/待申请送电";
                    break;
                case "3":
                    poweroff_status = "已申请送电/待审核";
                    break;
                case "4":
                    poweroff_status = "已审核送电/待送电";
                    break;
                case "5":
                    poweroff_status = "已送电";
                    break;
            }
            $('#show_poweroff_status').textbox('setValue', poweroff_status);
            $('#show_request_company').textbox('setValue', result.company_name.toString());
            $('#show_request_branch').textbox('setValue', result.branch_name.toString());
            $('#show_request_employee').textbox('setValue', result.employee_name.toString());
            $('#show_request_time').textbox('setValue', result.request_time.toString());
            $('#show_poweroff_equip').textbox('setValue', result.equip_name.toString());
            $('#show_poweroff_time').textbox('setValue', result.stop_time.toString());
            $('#show_poweroff_duration').textbox('setValue', result.stop_duration.toString());
            $('#show_poweroff_remark').textbox('setValue', result.request_remark.toString());
            $('#win_show_poweroff_request_detail').window('open').panel({ title: '停电申请详情' });
        },
        error: function (xhr, responseData, status) {
            $.messager.progress('close');
            showMsg("系统提示", "当前网络或数据故障，请稍后再试！", "error");
        }
    })
}
function CloseShowWin() {
    $('#win_show_poweroff_request_detail').window('close');
}