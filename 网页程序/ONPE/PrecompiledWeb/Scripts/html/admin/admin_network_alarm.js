var pageset = {};
$(document).ready(function () {
    InitPage();
    GetSet();
    loadCompanyCombo();
    $('#alarm_when_disconnect').combobox({
        onSelect: function (record) {
            if (record) {
                if (record.value == "0") {
                    $("#txt_alarm_time_span").numberbox({ disabled: true });
                    $("#disconnect_employee_code").combotree({ disabled: true });
                    $("#disconnect_employee_code").combotree({ required: false });
                } else {
                    $("#txt_alarm_time_span").numberbox({ disabled: false });
                    $("#disconnect_employee_code").combotree({ disabled: false });
                    $("#disconnect_employee_code").combotree({ required: true });
                }
            }
        }
    });
    $('#alarm_when_disconnect').combobox("select", 0);
    $('#alarm_when_connect').combobox({
        onSelect: function (record) {
            if (record) {
                if (record.value == "0") {
                    $("#connect_employee_code").combotree({ disabled: true });
                    $("#connect_employee_code").combotree({ required: false });
                } else {
                    $("#connect_employee_code").combotree({ disabled: false });
                    $("#connect_employee_code").combotree({ required: true });
                }
            }
        }
    })
    $('#alarm_when_connect').combobox("select", 0);
});
function loadCompanyCombo() {
    $.ajax({
        url: "../../ashx/employee/employeeHandler.ashx?action=tree",
        dataType: 'json',
        type: "post",
        success: function (data) {
            $("#disconnect_employee_code").combotree({ data: data }).tree({
                checkbox: function (node) {
                    if (node.attributes == "employee") {
                        return true;
                    }
                }
            });
            $("#connect_employee_code").combotree({ data: data }).tree({
                checkbox: function (node) {
                    if (node.attributes == "employee") {
                        return true;
                    }
                }
            });
        },
        error: function (xhr, responseData, status) {
            $("#disconnect_employee_code").combotree({ data: [] });
            $("#connect_employee_code").combotree({ data: [] });
        }

    })
};

function EditSet() {
    $.messager.confirm("操作提示", "您确定要执行编辑操作吗？", function (data) {
        if (data) {
            $('#div_show_set').hide();
            $('#div_edit_set').show();
            $('#btn_edit_set').hide();
            $('#btn_save_set').show();
            $('#btn_exit_save').show();
            if (pageset && JSON.stringify(pageset) != "{}") {
                $('#alarm_when_disconnect').combobox('select', pageset.alarm_when_disconnect);
                $("#txt_alarm_time_span").numberbox("setValue", pageset.alarm_time_span);
                $('#disconnect_employee_code').combotree('setValues', pageset.disconnect_employee_code);
                $('#disconnect_employee_code').combotree('setText', pageset.disconnect_employee_name);
                $('#alarm_when_connect').combobox('select', pageset.alarm_when_connect);
                $('#connect_employee_code').combotree('setValues', pageset.connect_employee_code);
                $('#connect_employee_code').combotree('setText', pageset.connect_employee_name);
            }
        }
    });
};
function InitPage() {
    $('#div_show_set').show();
    $('#div_edit_set').hide();
    $('#btn_edit_set').show();
    $('#btn_save_set').hide();
    $('#btn_exit_save').hide();
    
};
function GetSet() {
    $.messager.progress();
    $.ajax({
        url: '../../ashx/admin/NetworkState/NetworkStateHandler.ashx',
        data: { action: 'get' },
        type: 'post',
        async: false,
        datatype: 'json',
        success: function (data) {
            $.messager.progress('close');
            if (data) {
                var result = eval("(" + data + ")");
                pageset = result;
                ShowSet(result);
            }
        },
        error: function (xhr, responseData, status) {
            $.messager.progress('close');
        }
    });
};
function ShowSet(result) {
    if (result && JSON.stringify(result) != "{}") {
        $('#lbl_alarm_when_disconnect').html(result.alarm_when_disconnect == 0 ? "不推送" : "推送");
        $("#lbl_alarm_time_span").html(result.alarm_when_disconnect==0?"":(result.alarm_time_span.toString()+"秒"));
        $('#txt_disconnect_employee_code').val(result.alarm_when_disconnect == 0 ? "" : result.disconnect_employee_code);
        $('#lbl_disconnect_employee_name').html(result.alarm_when_disconnect == 0 ? "无" : result.disconnect_employee_name);
        $('#lbl_alarm_when_connect').html(result.alarm_when_connect == 0 ? "不推送" : "推送");
        $('#txt_connect_employee_code').val(result.alarm_when_connect == 0 ? "" : result.connect_employee_code);
        $('#lbl_connect_employee_name').html(result.alarm_when_connect == 0 ? "无" : result.connect_employee_name);
    }
};
function SaveSet() {
    $.messager.confirm("操作提示", "您确定要保存该配置吗？", function (data) {
        if (data) {
            $('#ff').form('submit', {
                url: '../../ashx/admin/NetworkState/NetworkStateHandler.ashx',
                onSubmit: function (param) {
                    var isValid = $(this).form('validate');
                    if (!isValid) {
                        $.messager.progress('close'); // hide progress bar while the form is invalid
                    }
                    param.action = "set";
                    param.alarm_time_span = $("#txt_alarm_time_span").numberbox("getValue");
                    param.alarm_when_disconnect = $('#alarm_when_disconnect').combobox('getValue');
                    param.disconnect_employee_code = $('#disconnect_employee_code').combotree('getValues');
                    param.disconnect_employee_name = $('#disconnect_employee_code').combotree('getText');
                    param.alarm_when_connect = $('#alarm_when_connect').combobox('getValue');
                    param.connect_employee_code = $('#connect_employee_code').combotree('getValues');
                    param.connect_employee_name = $('#connect_employee_code').combotree('getText');
                    return isValid;
                },
                success: function (data) {
                    $.messager.progress('close');
                    var result = eval('(' + data + ')');
                    if (result.success.toString() == "true") {
                        InitPage();
                        GetSet();
                        showMsg("操作提示", result.msg, "info")
                    } else {
                        showMsg("操作提示", result.msg, "error")
                    }
                },
                error: function (xhr, responseData, status) {
                    $.messager.progress('close');
                    showMsg("操作提示", xhr.responseText, "error")
                }
            });
        }
    });
};

function ExitSave() {
    $.messager.confirm("操作提示", "您确定要放弃编辑操作吗？", function (data) {
        if (data) {
            InitPage();
            ShowSet(pageset);
        }
    });
}