$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/tsd/TSDQueryHandler.ashx?action=poweroffdata&request_status=0',
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
            ]]
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    $('#win_examine_poweroff_request').window({
        title: '审核停电申请',
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
})

/*查询*/
function SearchData() {
    $('#dg').datagrid('load', {
        request_start: $("#search_request_start").datetimebox("getValue"),
        request_end: $("#search_request_end").datetimebox("getValue"),
        poweroff_start: $("#search_stop_start").datetimebox("getValue"),
        poweroff_end: $("#search_stop_end").datetimebox("getValue")
    });
};
/*显示审核单*/
function ExaminPowerOffRequest() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $('#win_examine_poweroff_request').window('open').panel({ title: '审核停电申请' });
        LoadDefaultValue(row);
        GetEquipState();
    }
    else {
        showMsg("操作提示", "请选择要审核的停电申请", "error");
    }
};
/*获取设备运行状态*/
function GetEquipState() {
    $('btn_get_equip_state').linkbutton('disable');
    $.ajax({
        url: '../../ashx/sbgl/equipHandler.ashx',
        data: {
            action: 'getstate',
            equip_code: $('#txt_equip_code').val()
        },
        dataType: 'json',
        type: 'post',
        success: function (data) {
            if (data) {
                var result = eval(data);
                if (result.success.toString() == "true") {
                    switch (result.msg.equip_state.toString()) {
                        case "-1":
                            $('#txt_equip_state').val('-1');
                            $('#txt_state_name').textbox('setValue', "未知");
                            $('#txt_state_name').textbox('textbox').css('background', '#FFFF00');
                            $('#txt_value_time').textbox('setValue', result.msg.value_time.toString());
                            break;
                        case "0":
                            $('#txt_equip_state').val('0');
                            $('#txt_state_name').textbox('setValue', "停止");
                            $('#txt_state_name').textbox('textbox').css('background', '#FF0000');
                            $('#txt_value_time').textbox('setValue', result.msg.value_time.toString());
                            break;
                        case "1":
                            $('#txt_equip_state').val('1');
                            $('#txt_state_name').textbox('setValue', "运行");
                            $('#txt_state_name').textbox('textbox').css('background', '#00FF00');
                            $('#txt_value_time').textbox('setValue', result.msg.value_time.toString());
                            break;
                    }
                }
                else {
                    $('#txt_equip_state').val('-1');
                    $('#txt_state_name').textbox('setValue', "未知");
                    $('#txt_state_name').textbox('textbox').css('background', '#FFFF00');
                    $('#txt_value_time').textbox('setValue', (new Date()).toLocaleString().replace(/[年月]/g, '/').replace(/[日上下午]/g, '').replace(/[‎]‎/g, '').replace(/[‎]/g, ''));
                }
            }
        },
        error: function (xhr, responseData, status) {
            $('#txt_equip_state').val('-1');
            $('#txt_state_name').textbox('setValue', "未知");
            $('#txt_state_name').textbox('textbox').css('background', '#FFFF00');
            $('#txt_value_time').textbox('setValue', (new Date()).toLocaleString().replace(/[年月]/g, '/').replace(/[日上下午]/g, '').replace(/[‎]‎/g, '').replace(/[‎]/g, ''));
        }
    })
    $('btn_get_equip_state').linkbutton('enable');
}
/*获取审核单中默认值*/
function LoadDefaultValue(rowData) {
    $('#poweroff_id').val(rowData.poweroff_id.toString());
    $('#poweroff_descript').html(rowData.stop_time.toString() + "--" + rowData.equip_name + "--停电时长:" + rowData.stop_duration + "(小时)");
    $('#txt_equip_code').val(rowData.stop_equip.toString());
    $('#txt_equip_name').textbox('setValue', rowData.equip_name.toString());
    $('#examine_employee').val(parent.userinfo.employee_code);
    $('#txt_examine_employee').textbox('setValue', parent.userinfo.employee_name);
};
/*清除选择*/
function ClearSelectPowerOff() {
    $('#poweroff_id').val('');
    $('#poweroff_descript').html('');
}
/*关闭审核单*/
function CloseAddWin() {
    $('#win_examine_poweroff_request').window('close');
};
/*提交审核*/
function ExaminePowerOff() {
    $.messager.progress();
    $('#ff').form('submit', {
        url: '../../ashx/tsd/TSDOperateHandler.ashx',
        onSubmit: function (param) {
            var isValid = ValidateForm();
            if (!isValid) {
                $.messager.progress('close');
            }
            param.action = "examinepoweroff";
            param.poweroff_id = $('#poweroff_id').val();
            param.equip_code = $('#txt_equip_code').val();
            param.equip_value = $('#txt_equip_state').val();
            param.value_time = $('#txt_value_time').textbox('getValue');
            param.examine_people = $('#examine_employee').val();
            param.examine_time = (new Date()).toLocaleString().replace(/[年月]/g, '/').replace(/[日上下午]/g, '').replace(/[‎]‎/g, '').replace(/[‎]/g, '');
            param.examine_result = $('#swb_examine_result').switchbutton('options').checked == true ? 1 : 0;
            param.examine_remark = $('#txt_examine_remark').textbox('getValue');
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
};
/*审核单验证*/
function ValidateForm() {
    var formValidate = $('#ff').form('validate');
    if (formValidate) {
        if ($('#poweroff_id').val() != "") {
            return true;
        }
        else {
            showMsg("操作提示", "请选择要审核的停电单！", "error");
            return false;
        }
    }
    else {
        return false;
    }
}