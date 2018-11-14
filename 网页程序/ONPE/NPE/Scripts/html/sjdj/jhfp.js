var oldSelectCode;
var userName = parent.userinfo.user_name;
var requestFrom = "PC";
$(document).ready(function () {
    loadCombo();
    $('#dg').datagrid({
        url: '../../ashx/Mobile/dxj/planHandler.ashx?action=treegrid',
        queryParams: {
            user_name: userName,
            equip_code: "",
            major_code: $('#search_major_name').combobox('getValue'),
            request_from: requestFrom
        },
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pageSize: 20,
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        remoteSort: false,
        singleSelect: false,
        //selectOnCheck: true,
        checkOnSelect: true,
        rownumbers: true,
        fit: true,
        striped: true, //行背景交换
        frozenColumns: [[
            { field: 'dVchTCPlan', checkbox: true },
            { field: 'dVchPlanData', title: '日期', width: 120 },
            { field: 'equip_name', title: '设备名称', sortable: true, width: 120 },
            { field: 'employee_code', title: '分配目标', hidden: true },
            { field: 'employee_name', title: '分配目标',
                formatter: function (value, row, index) {
                    if (value && value != "") {
                        return value;
                    }
                    else {
                        return '未分配';
                    }
                }
            }
        ]],
        columns: [[
                { field: 'equip_code', title: '设备编码', hidden: true },
                { field: 'dVchName', title: '标准设备', align: 'center', width: 120 },
                { field: 'dVchPartName', title: '点检部位', align: 'center', width: 120 },
                { field: 'dVchContentName', title: '检查内容', align: 'center', width: 120 },
                { field: 'dVchStandardName', title: '点检标准', hidden: true },
                { field: 'dIntStandardCheck', title: '检查周期', align: 'center', width: 120,
                    formatter: function (value, row, index) {
                        if (value && value != "") {
                            return value;
                        }
                        else {
                            return '';
                        }
                    }
                },
                { field: 'dVchMajorCode', title: '专业编码', hidden: true },
                { field: 'dVchMajorName', title: '专业名称', align: 'center', width: 120 },
                { field: 'dVchCheckState', title: '巡检状态', align: 'center', width: 120 },
                { field: 'dDaeTCDetailDate', title: '点检时间', align: 'center', sortable: true, width: 140,
                    formatter: function (value, row, index) {
                        if (value && value != "") {
                            return value;
                        }
                        else {
                            return '';
                        }
                    }
                },
                { field: 'dDaeTCNextDate', title: '下次点检时间', align: 'center', width: 140 },
                
                { field: 'dVchUser', title: '用户名', hidden: true }
            ]],
        onSelect: function (rowIndex, rowData) {
            var $plan_layout_layout = $("#plan_layout");
            var eastPlanContextGroup = $plan_layout_layout.layout("panel", "east");
            if (oldSelectCode == rowIndex.dVchTCPlan) {  //点选的是相同的组就不再请求数据
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
            oldSelectCode = rowIndex.dVchTCPlan;   //赋值

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
        pageSize: 50, //每页显示的记录条数，默认为10 
        pageList: [20, 50, 100], //可以设置每页记录条数的列表 
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
    loadEquipCombo();
});

//显示计划分配人员选择窗口
function ShowPlanAllot() {
    var selectRows = $('#dg').datagrid('getChecked');
    if (selectRows.length > 0) {
        //弹出添加框之前的操作，比如初始化下拉框、设定默认值等
        $('#ShowWin').window('open').panel({ title: '选择分配目标' });
        loadCompanyCombo();
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
                            planCode: item.dVchTCPlan,
                            employeecode: $('#employee_code').combobox('getValue')
                        }
                        $.ajax({
                            url: '../../ashx/Mobile/dxj/dxjHandler.ashx?type=para14',
                            type: 'post',
                            data: planAllot_info,
                            dataType: 'text',
                            success: function (data) {
                                if (data && data.toString() == "0") {
                                    save_error_number = save_error_number;
                                } else {
                                    save_error_number = save_error_number + 1;
                                }
                            },
                            error: function (xhr, responseData, state) {
                                save_error_number = save_error_number + 1;
                            }
                        });
                    });
                    $('#dg').datagrid('reload');
                    if (save_error_number > 0) {
                        showMsg("操作提示", "当前数据保存过程中出现错误，请刷新后列表后重新分配", "error");
                    }
                    else {
                        showMsg("操作提示", "计划分配成功！", "info");
                    }
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
    $('#search_major_name').combobox({
        valueField: 'id',
        textField: 'text',
        url: '../../ashx/major/majorHandler.ashx?action=combobox'
    });
};
function loadEquipCombo() {
    $('#search_equip_code').combobox({
        valueField: 'id',
        textField: 'text',
        multiple:true,
        url: '../../ashx/Mobile/dxj/planHandler.ashx?action=combo',
        onBeforeLoad: function (param) {
            param.user_name = userName;
            param.major_code = $('#search_major_name').combobox('getValue');
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
    var equipCode = $('#search_equip_code').combobox('getValues').join(',');
    var majorName = $('#search_major_name').combobox('getValue');
    $('#dg').datagrid('reload', {
        user_name: userName,
        equip_code: equipCode,
        major_code: majorName,
        request_from: requestFrom,
        plan_date: $('#search_note_time').datebox('getValue').replace(new RegExp('-',"gm"),'')
    });
};