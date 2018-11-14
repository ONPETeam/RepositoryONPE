$(document).ready(function () {
    $('#dg').datagrid({
        title: '申请单',
        url: '../../ashx/tsd/TSDQueryHandler.ashx?action=poweroffdata',
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
                { field: 'request_status', title: '申请单状态', align: 'center',
                    formatter: function (value, row, index) {
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
                { field: 'company_name', title: '停电申请公司', align: 'center' },
                { field: 'branch_name', title: '停电申请部门', align: 'center' },
                { field: 'employee_name', title: '停电申请人', align: 'center' },
                { field: 'request_time', title: '申请时间', align: 'center' },
                { field: 'equip_name', title: '停电设备', align: 'center' },
                { field: 'stop_time', title: '停电时间', align: 'center' },
                { field: 'stop_duration', title: '停电时长（小时）', align: 'center' },
                { field: 'request_remark', title: '申请备注', align: 'center' }

            ]],
        onSelect: function (rowIndex, rowData) {
            if (rowData.request_status.toString() == "0") {
                $("#btn_cancle_power_off_request").linkbutton('enable');
            }
            else {
                $("#btn_cancle_power_off_request").linkbutton('disable');
            }
        }
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    $('#win_add_poweroff_request').window({
        title: '添加停电申请',
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
});
function AddPowerOffRequest() {
    $('#win_add_poweroff_request').window('open').panel({ title: '添加停电申请' });
    LoadDefaultValue();
    LoadCombo();
}
function CloseAddWin() {
    $('#win_add_poweroff_request').window('close');
}
function LoadDefaultValue() {
    $('#request_company').val(parent.userinfo.company_id);
    $('#txt_request_company').textbox('setValue', parent.userinfo.company_name);
    $('#request_branch').val(parent.userinfo.branch_id);
    $('#txt_request_branch').textbox('setValue', parent.userinfo.branch_name);
    $('#request_employee').val(parent.userinfo.employee_code);
    $('#txt_request_employee').textbox('setValue', parent.userinfo.employee_name);
}
function LoadCombo() {
    $('#cmt_area_id').combotree({
        url: '../../ashx/sbgl/areaHandler.ashx?action=combo&area_parent=0',
        animate: true,
        onBeforeExpand: function (node) {
            $('#cmt_area_id').combotree("tree").tree("options").url = "../../ashx/sbgl/areaHandler.ashx?action=combo&area_parent=" + node.id;
        },
        onSelect: function (areanode) {
            $('#cmt_stop_equip').combotree({
                url: '../../ashx/sbgl/equipHandler.ashx?action=combo&area_id=' + areanode.id,
                animate: true,
                onBeforeExpand: function (node) {
                    $('#cmt_stop_equip').combotree("tree").tree("options").url = "../../ashx/sbgl/equipHandler.ashx?action=combo&equip_parent=" + node.id + '&area_id=' + areanode.id;
                }
            });
        }
    });
};
function RequestPowerOff() {
    $.messager.progress();
    $('#ff').form('submit', {
        url: '../../ashx/tsd/TSDOperateHandler.ashx',
        onSubmit: function (param) {
            var isValid = $(this).form('validate');
            if (!isValid) {
                $.messager.progress('close');
            }
            param.action = 'poweroffrequest';
            param.request_company = $('#request_company').val();
            param.request_branch = $('#request_branch').val();
            param.request_people = $('#request_employee').val();
            param.request_time = (new Date()).toLocaleString().replace(/[年月]/g,'/').replace(/[日上下午]/g,'').replace(/[‎]‎/g,'').replace(/[‎]/g,'');
            param.stop_equip = $('#cmt_stop_equip').combotree('getValue');
            param.stop_time = $('#dtb_stop_time').datetimebox('getValue');
            param.stop_duration = $('#nbb_stop_duration').numberbox('getValue');
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
function CancelPowerOffRequest() {
    var row = $("#dg").datagrid("getSelected");
    if (row) {
        $.messager.confirm("操作提示", "您确定要撤销该申请吗？", function (data) {
            if (data) {
                $.messager.progress();
                var poweroffRequestID = row.poweroff_id.toString();
                $.ajax({
                    url: '../../ashx/tsd/TSDOperateHandler.ashx?action=cancelpoweroff',
                    data: { poweroff_id: poweroffRequestID },
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        var result = eval(data);
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
        request_start:$("#search_request_start").datetimebox("getValue"),
        request_end: $("#search_request_end").datetimebox("getValue"),
        stop_start: $("#search_stop_start").datetimebox("getValue"),
        stop_end: $("#search_stop_end").datetimebox("getValue")
    });
}