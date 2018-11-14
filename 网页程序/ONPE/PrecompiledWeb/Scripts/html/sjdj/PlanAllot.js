var oldSelectCode;
//var userName = "guest"; //parent.userinfo.user_name;
//var branchID = '13'; //parent.userinfo.branch_id;

//parent.userinfo.employee_code
var userID = parent.userinfo.employee_code; //;
var Name = parent.userinfo.employee_name; //;
var branchID = parent.userinfo.branch_id; //;

var checkState = [
                    {
                        "text": "未完成",
                        "value": "未完成"
                    },
                    {
                        "text": "已完成",
                        "value": "已完成"
                    },
                    {
                        "text": "未分配",
                        "value": "未分配"
                    },
                    {
                        "text": "已分配",
                        "value": "已分配"
                    },
                    {
                        "text": "已过期",
                        "value": "已过期"
                    }
                  ];
$(document).ready(function () {
    loadCombo();
    $('#dg').datagrid({
        url: '../../ashx/Mobile/dxj/planShow.ashx?type=para3',
        queryParams: {
            branchID: branchID,
            PatrolGradeID: $('#search_patrol_grade').combobox('getValue'),
            checkState: $('#search_check_state').combobox('getValue'),
            equipCode: $('#search_equip_code').combobox('getValues').join(','),
            startdate:$('#search_start_date').datebox('getValue'),
            enddate:$('#search_end_date').datebox('getValue')
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
                { field: 'dIntgPlanNote', checkbox: true }, //计划ID
                { field: 'dVchName', title: '标准设备', align: 'center'},
                { field: 'equip_code', title: '设备编码', align: 'center'},
                { field: 'equip_name', title: '设备名称', align: 'center'},
                { field: 'dIntPartNote', title: '部位ID', hidden: true },
                { field: 'dIntContentNote', title: '内容ID', align: 'center', hidden: true },
                { field: 'dIntStandardNote', title: '标准ID', hidden: true },
                { field: 'dVchPartName', title: '部位名称', align: 'center' },
                { field: 'dVchContentName', title: '内容名称', align: 'center' },
                { field: 'dVchStandardName', title: '标准名称', align: 'center' },
                { field: 'dDaeTCDetailDate', title: '点检时间', align: 'center'},
                { field: 'dDaeTCNextDate', title: '下次点检时间', align: 'center'},
                { field: 'dVchCheckState', title: '巡检状态', align: 'center' },
                { field: 'employee_code', title: '员工EmployeeCode', align: 'center', hidden: true },
                { field: 'employee_Name', title: '员工名', align: 'center' },
                { field: 'dDaePlanSystime', title: '计划生成时间', align: 'center'},
                { field: 'dIntPlanLevel', title: '优先级别'},
                { field: 'dDaePlanCompuleted', title: '完成时间', align: 'center'},
                { field: 'major_name', title: '岗位名称', align: 'center'},
                { field: 'dVchPostName', title: '岗位ID', align: 'center'},
                { field: 'dIntPatrolGrade', title: '级别ID', align: 'center'},
                { field: 'patrolgrade_name', title: '巡检级别', align: 'center'}
            ]],
        onSelect: function (rowIndex, rowData) {
            var $plan_layout_layout = $("#plan_layout");
            var eastPlanContextGroup = $plan_layout_layout.layout("panel", "east");
            if (oldSelectCode == rowIndex.dIntgPlanNote) {  //点选的是相同的组就不再请求数据
                if (eastPlanContextGroup.panel("options").collapsed) {   //判断是否展开
                    $plan_layout_layout.layout("expand", "east");
                } else {
                    $plan_layout_layout.layout("collapse", "east");
                }
                return;
            }
            if (eastPlanContextGroup.panel("options").collapsed) {   //判断是否展开
                $plan_layout_layout.layout("expand", "east");
            }
            $('#plan_standard_name').html(rowIndex.dVchStandardName);
            oldSelectCode = rowIndex.dIntgPlanNote;   //赋值

        },
        onLoadSuccess: function (row, data) {
            if (data) {
                $.each(data.rows, function (index, item) {
                    if (!item.employee_code || item.employee_code == "") {
                        $('#dg').datagrid('checkRow', index);
                    }
                });
            }
        }
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
            $.messager.confirm("操作提示", "您确定要将当前选择的【" + selectRows.length + "】条点检分配给当前选择的人员吗？", function (data) {
                if (data) {
                    $.each(selectRows, function (index, item) {
                        var planAllot_info = {
                            PlanNote: item.dIntgPlanNote,
                            user: userID,
                            userName: Name,
                            employeecode: $('#employee_code').combobox('getValue'),
                            remark: $('#planAllot_remark').textbox('getValue')
                        }
                        $.ajax({
                            url: '../../ashx/Mobile/dxj/PlanMethod.ashx?type=para3',
                            type: 'post',
                            data: planAllot_info,
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
    $('#search_patrol_grade').combobox({
        valueField: 'id',
        textField: 'text',
        url: '../../ashx/publicHandler.ashx?name=patrolgrade&action=combo'
    });
    $('#search_check_state').combobox({
        valueField: 'value',
        textField: 'text',
        data: checkState
    });
    $('#search_equip_code').combobox({
        valueField: 'id',
        textField: 'text',
        multiple: true,
        url: '../../ashx/Mobile/dxj/PlanShow.ashx?type=para11',
        onBeforeLoad: function (param) {
            //alert(branchID);
            param.branchID = branchID;
            param.PatrolGradeID = $('#search_patrol_grade').combobox('getValue');
            param.checkState = $('#search_check_state').combobox('getValue');
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