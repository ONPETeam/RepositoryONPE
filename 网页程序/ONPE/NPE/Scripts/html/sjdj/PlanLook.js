var oldSelectCode;
//var employee_code = "PCHREP1703080075"; //parent.userinfo.employee_code;
var employee_code = parent.userinfo.employee_code; //;
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
        url: '../../ashx/Mobile/dxj/planShow.ashx?type=para4',
        queryParams: {
            employeecode: employee_code,
            checkState: $('#search_check_state').combobox('getValue'),
            equipCode: $('#search_equip_code').combobox('getValues').join(','),
            startdate: $('#search_start_date').datebox('getValue'),
            enddate: $('#search_end_date').datebox('getValue')
        },
        method: 'post',
        checkOnSelect: true,
        loadMsg: "正在努力加载数据，请稍后...",
//        pageSize: 10,
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        remoteSort: false,
        rownumbers: true,
        fit: true,
        singleSelect: true,
        striped: true, //行背景交换
        columns: [[
                { field: 'dIntgPlanNote', title: '计划ID', checkbox: false, hidden: false }, //计划ID
//                { field: 'dVchName', title: '标准设备', align: 'center', width: 120 },
                { field: 'equip_code', title: '设备编码', align: 'center'},
                { field: 'equip_name', title: '设备名称', align: 'center'},
                { field: 'dIntStandardNote', title: '标准ID', hidden: true },
                { field: 'dVchStandardName', title: '标准名称', align: 'center'},
                { field: 'dIntContentNote', title: '内容ID', align: 'center', hidden: true },
                { field: 'dVchContentName', title: '内容名称', align: 'center'},
                { field: 'dIntPartNote', title: '部位ID', hidden: true },
                { field: 'dVchPartName', title: '部位名称', align: 'center' },
                { field: 'area_name', title: '区域', align: 'center' },
                { field: 'dVchUser', title: '分配者', align: 'center' },
                { field: 'dVchPostName', title: '岗位ID', align: 'center', hidden: true },
                { field: 'major_name', title: '岗位名称', align: 'center' },
                { field: 'dIntPatrolGrade', title: '级别ID', align: 'center', hidden: true },
                { field: 'patrolgrade_name', title: '巡检级别', align: 'center' },
                { field: 'dDaeTCDetailDate', title: '点检时间', align: 'center' },
                { field: 'dDaeTCNextDate', title: '下次点检时间', align: 'center' },
                { field: 'dVchCheckState', title: '巡检状态', align: 'center' },
                { field: 'dDaeAllotSystime', title: '分配时间', align: 'center'},
                { field: 'dDaePlanSystime', title: '计划生成时间', align: 'center'}
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

function loadCombo() {
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
            param.branchID = branchID;
            param.checkState = $('#search_check_state').combobox('getValue');
        }
    });
};

function SearchPlan() {
    var equip_code = $('#search_equip_code').combobox('getValues').join(',');
    $('#dg').datagrid('reload', {
        employeecode: employee_code,
        checkState: $('#search_check_state').combobox('getValue'),
        equipCode: equip_code,
        startdate: $('#search_start_date').datebox('getValue'),
        enddate: $('#search_end_date').datebox('getValue')
    });
};