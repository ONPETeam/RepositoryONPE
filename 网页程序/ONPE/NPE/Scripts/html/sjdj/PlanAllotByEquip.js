//var userName = "guest"; //parent.userinfo.user_name;
//var branchID = '13'; //parent.userinfo.branch_id;
var userID = parent.userinfo.employee_code; //;
var Name = parent.userinfo.employee_name; //;
var branchID = parent.userinfo.branch_id; //;

$(document).ready(function () {
    //loadCombo();
    $('#dg').datagrid({
        url: '../../ashx/Mobile/dxj/planShow.ashx?type=para8',
        queryParams: {
            branch_id: branchID
        },
        method: 'post',
        singleSelect: false,
        checkOnSelect: false,
        loadMsg: "正在努力加载数据，请稍后...",
        pageSize: 10,
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        remoteSort: false,
        rownumbers: true,
        fit: true,
        striped: true, //行背景交换
        columns: [[
                { field: 'equip_code', checkbox: true },
                { field: 'equip_name', title: '设备名称', align: 'center' },

                { field: 'area_id', title: '区域ID', hidden: true },
                { field: 'area_name', title: '区域名称', align: 'center' },
                { field: 'equip_header', title: '负责人', align: 'center' }
            ]]
//            ,
//        onLoadSuccess: function (row, data) {
//            if (data) {
//                $.each(data.rows, function (index, item) {
//                    if (!item.employee_code || item.employee_code == "") {
//                        $('#dg').datagrid('checkRow', index);
//                    }
//                });
//            }
//        }
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 10, //每页显示的记录条数，默认为10 
        pageList: [10, 20, 30], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    $('#ShowWin').window({
        title: '',
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
});

//显示计划分配人员选择窗口
function ShowPlanAllot() {
    var selectRows = $('#dg').datagrid('getChecked');
    if (selectRows.length > 0) {
        //弹出添加框之前的操作，比如初始化下拉框、设定默认值等
        loadCompanyCombo();
        $('#ShowWin').window('open').panel({ title: '选择分配目标' });
    }
    else {
        showMsg("操作提示", "您未选择任何计划！", "info");
    }

};
//保存操作
function SaveContent() {
    var save_error_number = 0;
    var employeeCode = $('#employee_code').combobox('getValue');
    if (employeeCode && employeeCode != "") {
        var selectRows = $('#dg').datagrid('getChecked');
        if (selectRows.length > 0) {
            $.messager.confirm("操作提示", "您确定要将当前选择的【" + selectRows.length + "】台设备分配给当前选择的人员吗？", function (data) {
                if (data) {
                    $.each(selectRows, function (index, item) {
                        var planAllot_equip = {
                            user: userID,
                            userName: Name,
                            employeecode: $('#employee_code').combobox('getValue'),
                            equipCode: item.equip_code,
                            remark: $('#planAllot_remark').textbox('getValue')
                        }
                        $.ajax({
                            url: '../../ashx/Mobile/dxj/PlanMethod.ashx?type=para31',
                            type: 'post',
                            data: planAllot_equip,
                            dataType: 'text',
                            success: function (data) {
                                if (data && data.toString() == "0") {
                                    //save_error_number = save_error_number;
                                } else {
                                    //save_error_number = save_error_number + 1;
                                }
                                //                                if (save_error_number > 2) {
                                //                                    showMsg("操作提示", "当前数据保存过程中出现错误或已经分配,请勿重复分配!，请刷新后列表后重新分配", "error");
                                //                                }
                                //                                else {
                                //                                    showMsg("操作提示", "计划分配成功！", "info");
                                //                                }
                                if (data == "1") {
                                    showMsg("操作提示", "计划重新分配成功！", "info");
                                }
                                if (data == "0") {
                                    showMsg("操作提示", "计划分配成功！", "info");
                                }
                                if (data == "2") {
                                    showMsg("操作提示", "当前数据保存过程中出现错误或已经分配,请勿重复分配!，请刷新后列表后重新分配！", "error");
                                }
                            },
                            error: function (xhr, responseData, state) {
                                save_error_number = save_error_number + 1;
                            }
                        });
                    });

                    $('#dg').datagrid('reload');
                }
            });
        }
    }
};
function closeWin() {
    $('#ShowWin').window('close');
    $('#dg').datagrid('reload');
};
function loadCombo() {
    
    $('#search_equip_code').combobox({
        valueField: 'id',
        textField: 'text',
        multiple: true,
        url: '../../ashx/Mobile/dxj/PlanShow.ashx?type=para11',
        onBeforeLoad: function (param) {
            //alert(branchID);
            param.branchID = branchID;
        }
    });
};
function loadCompanyCombo() {
    $('#company_id').combotree({
        url: '../../ashx/Company/CompanyHandler.ashx?action=combo',
        animate: true,
        onSelect: function (companyID) {
            $('#branch_id').combotree({
                url: '../../ashx/Branch/branchHandler.ashx?action=combo&branch_parent=0&company_id=' + companyID.id,
                animate: true,
                onLoadSuccess: function (node, data) {
                    var t = $("#branch_id").combotree('tree'); //获取tree  
                    for (var i = 0; i < data.length; i++) {
                        node = t.tree("find", data[i].id);
                        t.tree('expandAll', node.target); //展开所有节点  
                    }
                },
                onSelect: function (branchID) {
                    $('#employee_code').combobox({
                        url: '../../ashx/employee/employeeHandler.ashx?action=combo&branch_id=' + branchID.id,
                        valueField: 'id',
                        textField: 'text'
                    });
                }
            });
        }
    });
};
function SearchPlan() {
    var equip_code = $('#search_equip_code').combobox('getValues').join(',');
    $('#dg').datagrid('reload', {
        branchID: branchID,
        PatrolGradeID: $('#search_patrol_grade').combotree('getValue'),
        checkState: $('#search_check_state').combobox('getValue'),
        equipCode: equip_code,
        startdate: $('#search_start_date').datebox('getValue'),
        enddate: $('#search_end_date').datebox('getValue')
    });
};