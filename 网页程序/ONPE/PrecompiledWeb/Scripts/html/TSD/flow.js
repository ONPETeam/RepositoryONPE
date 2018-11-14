var action = "";
$(document).ready(function () {
    $('#dg').datagrid({
        view: detailview,
        title: '停送电流程',
        url: '../../ashx/tsd/tsdqueryhandler.ashx?action=flowdata',
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
        frozenColumns: [[
                            { field: 'equip_code', title: '设备编号', hidden: true },
                            { field: 'equip_name', title: '设备名称', align: 'center' },
                            { field: 'flow_status', title: '流程状态', align: 'center',
                                formatter: function (value, row, index) {
                                    switch (value.toString()) {
                                        case "0":
                                            return "已申请/待确认停电";
                                            break;
                                        case "1":
                                            return "已人工确认未停电";
                                            break;
                                        case "2":
                                            return "已停电待申请送电";
                                            break;
                                        case "3":
                                            return "已申请待确认送电";
                                            break;
                                        case "4":
                                            return "已确认送电未送电";
                                            break;
                                        case "5":
                                            return "已送电";
                                            break;
                                        case "6":
                                            return "已归档";
                                            break;
                                        case "-99":
                                            return "已删除";
                                            break;
                                        default:
                                            return "";
                                            break;
                                    }
                                }
                            },
                        ]],
        columns: [[
                    { title: '停电确认信息', colspan: 8 },
                    { title: '停电信息', colspan: 5 },
                    { title: '送电确认信息', colspan: 8 },
                    { title: '送电信息', colspan: 5 },
                    { field: 'off_timespan', title: '停电时长', align: 'center',rowspan:2 }
                ], [
                    { field: 'confirmoff_id', title: '确认停电编号', hidden: true },
                    { field: 'confirmoff_people', title: '停电确认人编号', hidden: true },
                    { field: 'confirmoff_employee_name', title: '停电确认人', align: 'center' },
                    { field: 'confirmoff_time', title: '确认时间', align: 'center' },
                    { field: 'confirmoff_location', title: '地理信息', align: 'center' },
                    { field: 'confirmoff_equip_code', title: '确认设备', hidden: true },
                    { field: 'confirmoff_equip_state', title: '设备状态', align: 'center',
                        formatter: function (value, rowIndex, rowData) {
                            if (value != null) {
                                if (value.toString() == "0") {
                                    return "停止";
                                }
                                if (value.toString() == "1") {
                                    return "运行";
                                }
                            }
                            return "未知";
                        }
                    },
                    { field: 'confirmoff_remark', title: '确认备注', hidden: true },
                    { field: 'off_time', title: '停电时间', align: 'center' },
                    { field: 'offrun_branch', title: '停电部门', hidden: true },
                    { field: 'offrun_branch_name', title: '停电部门', align: 'center' },
                    { field: 'offrun_employee', title: '停电人', hidden: true },
                    { field: 'offrun_employee_name', title: '停电人', align: 'center' },
                    { field: 'confirmon_id', title: '确认送电编号', hidden: true },
                    { field: 'confirmon_people', title: '送电确认人编号', hidden: true },
                    { field: 'confirmon_employee_name', title: '送电确认人', align: 'center' },
                    { field: 'confirmon_time', title: '送电确认时间', align: 'center' },
                    { field: 'confirmon_location', title: '地理信息', hidden: true },
                    { field: 'confirmon_equip_code', title: '确认设备', hidden: true },
                    { field: 'confirmon_equip_state', title: '设备状态', align: 'center',
                        formatter: function (value, rowIndex, rowData) {
                            if (value != null) {
                                if (value.toString() == "0") {
                                    return "停止";
                                }
                                if (value.toString() == "1") {
                                    return "运行";
                                }
                            }
                            return "未知";
                        }
                    },
                    { field: 'confirmon_remark', title: '确认备注', hidden: true },
                    { field: 'on_time', title: '送电时间', align: 'center' },
                    { field: 'onrun_branch', title: '送电部门', hidden: true },
                    { field: 'onrun_branch_name', title: '送电部门', align: 'center' },
                    { field: 'onrun_employee', title: '送电人', hidden: true },
                    { field: 'onrun_employee_name', title: '送电人', align: 'center' }
                    
                ]],
        onSelect: function (rowIndex, rowData) {
            DisableAllButton();
            switch (rowData.flow_status.toString()) {
                case "0":
                    $("#btn_tsd_confirm_power_off").linkbutton("enable");
                    break;
                case "1":
                    $("#btn_tsd_power_off").linkbutton("enable");
                    break;
                case "3":
                    $("#btn_tsd_confirm_power_on").linkbutton("enable");
                    break;
                case "4":
                    $("#btn_tsd_power_on").linkbutton("enable");
                    break;
                case "5":
                    $("#btn_tsd_archive").linkbutton("enable");
                    break;
            }
        },
        detailFormatter: function (index, row) {
            return '<div style="padding:2px"><table id="ddv-' + index + '"></table></div>';
        },
        onExpandRow: function (index, row) {
            $('#ddv-' + index).datagrid({
                url: '../../ashx/tsd/tsdqueryhandler.ashx?action=flowdetail&flow_id=' + row.flow_id,
                method: 'post',
                loadMsg: "正在努力加载数据，请稍后...",
                pagination: true, //分页控件
                remoteSort: false,
                singleSelect: true,
                rownumbers: true,
                height: 'auto',
                striped: true, //行背景交换
                columns: [
                    [
                        { title: '停电申请', colspan: 13 },
                        { title: '停电审核', colspan: 10 },
                        { title: '送电申请', colspan: 10 },
                        { title: '送电审核', colspan: 10 }
                    ],
                    [
                        { field: 'poweroff_id', title: '停电申请编号', hidden: true },
                        { field: 'poweroff_request_status', title: '停电申请单状态', align: 'center',
                            formatter: function (value, rowIndex, rowData) {
                                switch (value.toString()) {
                                    case "0":
                                        return "已申请/待审核";
                                        break;
                                    case "-99":
                                        return "已撤销";
                                        break;
                                    case "-66":
                                        return "审核未通过";
                                        break;
                                    case "1":
                                        return "已审核/待停电";
                                        break;
                                    case "2":
                                        return "已停电/待申请送电";
                                        break;
                                    case "3":
                                        return "已申请送电/待审核";
                                        break;
                                    case "4":
                                        return "已审核送电/待送电";
                                        break;
                                    case "5":
                                        return "已送电";
                                        break;
                                }
                            }
                        },
                        { field: 'poweroff_request_company', title: '停电申请公司编号', hidden: true },
                        { field: 'poweroff_request_company_name', title: '停电申请公司', align: 'center' },
                        { field: 'poweroff_request_branch', title: '停电申请部门编号', hidden: true },
                        { field: 'poweroff_request_branch_name', title: '停电申请部门', align: 'center' },
                        { field: 'poweroff_request_employee', title: '停电申请员工编号', hidden: true },
                        { field: 'poweroff_request_employee_name', title: '停电申请员工', align: 'center' },
                        { field: 'poweroff_request_time', title: '停电申请时间', align: 'center' },
                        { field: 'stop_equip', title: '申请停电设备', hidden: true },
                        { field: 'stop_time', title: '申请停电时间', align: 'center' },
                        { field: 'stop_duration', title: '申请停电时长（小时）', align: 'center' },
                        { field: 'poweroff_request_remark', title: '停电申请备注', align: 'center' },
                        { field: 'poweroff_examine_id', title: '停电审核编号', hidden: true },
                        //{ field: 'poweroff_examine_status', title: '停电审核状态', align: 'center'},
                        { field: 'poweroff_examine_time', title: '停电审核时间', align: 'center' },
                        { field: 'poweroff_examine_people', title: '停电审核员工编号', hidden: true },
                        { field: 'poweroff_examine_employee_name', title: '停电审核员工', align: 'center' },
                        { field: 'poweroff_examine_proof_id', title: '停电审核凭据编号', hidden: true },
                        { field: 'poweroff_examine_equip_code', title: '停电审核设备编号', hidden: true },
                        { field: 'poweroff_examine_equip_value', title: '停电审核设备状态', align: 'center',
                            formatter: function (value, rowIndex, rowData) {
                                if (value != null) {
                                    if (value.toString() == "0") {
                                        return "停止";
                                    }
                                    if (value.toString() == "1") {
                                        return "运行";
                                    }
                                }
                                return "未知";
                            } 
                        },
                        { field: 'poweroff_examine_value_time', title: '停电审核设备状态时间', align: 'center' },
                        { field: 'poweroff_examine_result', title: '停电审核结果', align: 'center',
                            formatter: function (value, rowIndex, rowData) {
                                if (value != null) {
                                    if (value.toString() == "0") {
                                        return "审核拒绝";
                                    }
                                    if (value.toString() == "1") {
                                        return "审核通过";
                                    }
                                }
                            } 
                        },
                        { field: 'poweroff_examine_remark', title: '停电审核备注', align: 'center' },
                        { field: 'poweron_id', title: '送电申请编号', hidden: true },
                        { field: 'poweron_request_company', title: '送电申请公司编号', hidden: true },
                        { field: 'poweron_request_company_name', title: '送电申请公司', align: 'center' },
                        { field: 'poweron_request_branch', title: '送电申请部门编号', hidden: true },
                        { field: 'poweron_request_branch_name', title: '送电申请部门', align: 'center' },
                        { field: 'poweron_request_employee', title: '送电申请员工编号', hidden: true },
                        { field: 'poweron_request_employee_name', title: '送电申请员工', align: 'center' },
                        { field: 'poweron_request_time', title: '送电申请时间', align: 'center' },
                        { field: 'start_time', title: '申请送电时间', align: 'center' },
                        { field: 'poweron_request_remark', title: '送电申请备注', align: 'center' },
                        { field: 'poweron_examine_id', title: '送电审核编号', hidden: true },
                        //{ field: 'poweron_examine_status', title: '送电审核状态', align: 'center' },
                        { field: 'poweron_examine_time', title: '送电审核时间', align: 'center' },
                        { field: 'poweron_examine_employee', title: '送电审核员工编号', hidden: true },
                        { field: 'poweron_examine_employee_name', title: '送电审核员工', align: 'center' },
                        { field: 'poweron_examine_proof_id', title: '送电审核凭据编号', hidden: true },
                        { field: 'poweron_examine_equip_code', title: '送电审核设备编号', hidden: true },
                        { field: 'poweron_examine_equip_value', title: '送电审核设备状态', align: 'center',
                            formatter: function (value, rowIndex, rowData) {
                                if (value != null) {
                                    if (value.toString() == "0") {
                                        return "停止";
                                    }
                                    if (value.toString() == "1") {
                                        return "运行";
                                    }
                                }
                                return "未知";
                            } 
                        },
                        { field: 'poweron_examine_value_time', title: '送电审核设备状态时间', align: 'center' },
                        { field: 'poweron_examine_result', title: '送电审核结果', align: 'center',
                            formatter: function (value, rowIndex, rowData) {
                                if (value != null) {
                                    if (value.toString() == "0") {
                                        return "审核拒绝";
                                    }
                                    if (value.toString() == "1") {
                                        return "审核通过";
                                    }
                                }
                            } 
                        },
                        { field: 'poweron_examine_remark', title: '送电审核备注', align: 'center' }
                    ]
                ],
                onResize: function () {
                    $('#dg').datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    setTimeout(function () {
                        $('#dg').datagrid('fixDetailRowHeight', index);
                    }, 0);
                }
            });
            
            var ppg = $('#ddv-' + index).datagrid('getPager');
            $(ppg).pagination({
                beforePageText: '第', //页数文本框前显示的汉字 
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
            });
            $('#dg').datagrid('fixDetailRowHeight', index);
        }
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    $("#win_confirm").window({
        title: '确认停送电',
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    })
});
/*禁用所有操作按钮*/
function DisableAllButton() {
    $("#btn_tsd_confirm_power_off").linkbutton("disable");
    $("#btn_tsd_power_off").linkbutton("disable");
    $("#btn_tsd_confirm_power_on").linkbutton("disable");
    $("#btn_tsd_power_on").linkbutton("disable");
    $("#btn_tsd_archive").linkbutton("disable");
};
/*显示停电确认对话框*/
function ShowConfirm(type) {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        LoadDefaultValue(row);
        if (type == "off") {
            action = type;
            $('#win_confirm').window('open').panel({ title: '确认停电' });
        }
        if (type == "on") {
            action = type;
            $('#win_confirm').window('open').panel({ title: '确认送电' });
        }
    }
    else {
        showMsg("操作提示", "您未选择任何数据行！", "error");
    }
};
/*停电确认*/
function LoadDefaultValue(rowData) {
    $('#txt_comfirm_people').val(parent.userinfo.employee_code.toString());
    $('#txt_confirm_employee_name').textbox('setValue', parent.userinfo.employee_name.toString());
    $('#txt_equip_code').val(rowData.equip_code.toString());
    $('#txt_equip_name').textbox('setValue', rowData.equip_name.toString());
    $('#txt_flow_id').val(rowData.flow_id.toString());
};
/*停电确认*/
function ConfirmRequest() {
    $.messager.progress();
    $('#ff_confirm').form('submit', {
        url: '../../ashx/tsd/TSDOperateHandler.ashx',
        onSubmit: function (param) {
            var isValid = $('#ff_confirm').form('validate');
            if (!isValid) {
                $.messager.progress('close');
            }
            if (action == "off") {
                param.action = 'confirmpoweroff';
            }
            if (action == "on") {
                param.action = 'confirmpoweron';
            }
            param.flow_id = $('#txt_flow_id').val();
            param.confirm_people = $('#txt_comfirm_people').val();
            param.confirm_time = (new Date()).toLocaleString().replace(/[年月]/g, '/').replace(/[日上下午]/g, '').replace(/[‎]‎/g, '').replace(/[‎]/g, '');
            param.location_info = "";
            param.equip_code = $('#txt_equip_code').val();
            param.equip_status = $('#cmb_equip_status').combobox('getValue');
            param.confirm_remark = $('#txt_confirm_remark').textbox('getValue');
            return isValid;
        },
        success: function (data) {
            $.messager.progress('close');
            var result = eval('(' + data + ')');
            if (result.success.toString() == 'true') {
                $('#dg').datagrid('reload');
                $('#ff_confirm').form("reset");
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
};

function CloseConfirmWin() {
    $('#win_confirm').window('close');
}

function PowerSwitch(type) {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        var showmsg = "";
        var requestData = {};
        if (type == "off") {
            requestData = {
                action: "poweroff",
                flow_id: row.flow_id,
                poweroff_time: (new Date()).toLocaleString().replace(/[年月]/g, '/').replace(/[日上下午]/g, '').replace(/[‎]‎/g, '').replace(/[‎]/g, ''),
                poweroff_branch: parent.userinfo.branch_id,
                poweroff_employee: parent.userinfo.employee_code
            };

            showmsg = "您确认要给设备【" + row.equip_name + "】停电么？";
        }
        if (type == "on") {
            requestData = {
                action: "poweron",
                flow_id: row.flow_id,
                poweron_time: (new Date()).toLocaleString().replace(/[年月]/g, '/').replace(/[日上下午]/g, '').replace(/[‎]‎/g, '').replace(/[‎]/g, ''),
                poweron_branch: parent.userinfo.branch_id,
                poweron_employee: parent.userinfo.employee_code
            };
            showmsg = "您确认要给设备【" + row.equip_name + "】送电么？";
        }
        $.messager.confirm('操作提示！', showmsg, function (data) {
            if (data) {
                $.messager.progress();
                $.ajax({
                    url: '../../ashx/tsd/TSDOperateHandler.ashx',
                    data: requestData,
                    type: 'post',
                    dataType: 'text',
                    success: function (data) {
                        $.messager.progress('close');
                        var result = eval('(' + data + ')') || data;
                        if (result.success.toString() == 'true') {
                            $('#dg').datagrid('reload');
                            showMsg("操作提示", "操作成功！", "info")
                        } else {
                            showMsg("操作提示", result.msg, "error")
                        }
                    },
                    error: function (xhr, responseData, status) {
                        $.messager.progress('close');
                        showMsg("操作提示", xhr.responseText, "error");
                    }
                })
            }
        });
    }
    else {
        showMsg("操作提示", "您未选择任何数据行！", "error");
    }
}

function Archive() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm('操作提示', "您确认要将该数据进行归档么？", function (data) {
            if (data) {
                $.messager.progress();
                $.ajax({
                    url: '../../ashx/tsd/TSDOperateHandler.ashx',
                    data: {
                        flow_id: row.flow_id
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        $.messager.progress('close');
                        var result = eval('(' + data + ')');
                        if (result.success.toString() == 'true') {
                            $('#dg').datagrid('reload');
                            showMsg("操作提示", "操作成功！", "info")
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
        });
    }
    else {
        showMsg("操作提示", "您未选择任何数据行！", "error");
    }
}

function SearchData() {
    $('#dg').datagrid('load', {
        poweroff_start: $("#search_poweroff_start").datetimebox("getValue"),
        poweroff_end: $("#search_poweroff_end").datetimebox("getValue"),
        poweron_start: $("#search_poweron_start").datetimebox("getValue"),
        poweron_end: $("#search_poweron_end").datetimebox("getValue")
    });
}