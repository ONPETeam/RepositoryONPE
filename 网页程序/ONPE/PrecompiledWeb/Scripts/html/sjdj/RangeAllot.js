var oldSelectCode;
//var userName = 'guest'; //parent.userinfo.user_name
var userName = parent.userinfo.employee_code; //改成用  employee_code
var branchID = parent.userinfo.branch_id; //;
$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/Mobile/dxj/PlanShow.ashx?type=para1',
        queryParams: {
            PatrolGradeID: $('#search_patrol_grade').combobox('getValue'),
            equipCode: $('#search_equip_code').combobox('getValues').join(',')
        },
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
//        pageSize: 15,
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        remoteSort: false,
        singleSelect: false,
        checkOnSelect: true,
        rownumbers: true,
        fit: true,
        striped: true, //行背景交换
        columns: [[
                { field: 'equip_code', title: '设备编码', hidden: true },
                { field: 'equip_name', title: '设备名称', align: 'center' },
                { field: 'dIntPartNote', title: '巡检部位编号', hidden: true },
                { field: 'dVchPartName', title: '巡检部位', align: 'center' },
                { field: 'dIntContentNote', title: '巡检内容编号', hidden: true },
                { field: 'dVchContentName', title: '巡检内容', align: 'center' },
                { field: 'dIntStandardNote', title: '标准编号', hidden: true },
                { field: 'dVchStandardName', title: '标准', align: 'center' },
                { field: 'area_id', title: '区域编号', hidden: true },
                { field: 'area_name', title: '区域名称', align: 'center' },
                { field: 'dVchUser', title: '分配者', align: 'center' },
                { field: 'dVchPostName', title: '专业编号', hidden: true },
                { field: 'major_name', title: '专业名称', align: 'center' },
                { field: 'dIntPatrolGrade', title: '巡检级别编号', hidden: true },
                { field: 'patrolgrade_name', title: '巡检级别', align: 'center' },
                { field: 'dIntBranchID', title: '部门编号', hidden: true },
                { field: 'dVchBranchName', title: '部门名称', align: 'center' }

            ]],
        onSelect: function (rowIndex, rowData) {
            var $plan_layout_layout = $("#plan_layout");
            var eastPlanContextGroup = $plan_layout_layout.layout("panel", "east");
            if (oldSelectCode == rowIndex.standard_name) {  //点选的是相同的组就不再请求数据
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
            //$('#plan_standard_name').html(rowIndex.standard_name);
            oldSelectCode = rowIndex.dVchTCPlan;   //赋值
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
    loadCombo();
});
function loadCombo() {
    $('#allot_equip_area').combotree({
        url: '../../ashx/sbgl/areaHandler.ashx?action=combo&area_parent=0',
        animate: true,
        multiple: true,
        panelWidth: 350,
        panelHeight: 500,
        onBeforeExpand: function (node) {
            $('#allot_equip_area').combotree("tree").tree("options").url = "../../ashx/sbgl/areaHandler.ashx?action=combo&area_parent=" + node.id;
        }
    });
    $('#allot_major_time').combobox({
        valueField: 'id',
        textField: 'text',
        url: '../../ashx/major/majorHandler.ashx?action=combobox'
    });
    $('#allot_patrol_grade').combobox({
        valueField: 'id',
        textField: 'text',
        url: '../../ashx/publicHandler.ashx?name=patrolgrade&action=combo'
    });
    $('#allot_company_id').combotree({
        url: '../../ashx/Company/CompanyHandler.ashx?action=combo',
        animate: true,
        onSelect: function (companyID) {
            $('#allot_branch_code').combotree({
                url: '../../ashx/Branch/branchHandler.ashx?action=combo&branch_parent=0&company_id=' + companyID.id,
                animate: true,
                onLoadSuccess: function (node, data) {
                    var t = $("#allot_branch_code").combotree('tree'); //获取tree  
                    for (var i = 0; i < data.length; i++) {
                        node = t.tree("find", data[i].id);
                        t.tree('expandAll', node.target); //展开所有节点  
                    }
                }
            });
        }
    });
    $('#search_patrol_grade').combobox({
        valueField: 'id',
        textField: 'text',
        url: '../../ashx/publicHandler.ashx?name=patrolgrade&action=combo'
    });
    $('#search_equip_code').combobox({
        valueField: 'id',
        textField: 'text',
        multiple: true,
        url: '../../ashx/Mobile/dxj/PlanShow.ashx?type=para12',
        onBeforeLoad: function (param) {
            param.PatrolGradeID = $('#search_patrol_grade').combobox('getValue');
        }
    });
};
function AllotEquipStandard() {
    var allot_equip_area = $('#allot_equip_area').combotree('getValues');
    var allot_major_time = $('#allot_major_time').combobox('getValue');
    var allot_patrol_grade = $('#allot_patrol_grade').combobox('getValue');
    var allot_branch_code = $('#allot_branch_code').combotree('getValues');
    if (!allot_equip_area || allot_equip_area.toString() == "") {
        showMsg("操作提示", "请选择设备区域！", "info");
        return false;
    }
    if (!allot_major_time || allot_major_time.toString() == "") {
        showMsg("操作提示", "请选择巡检专业！", "info");
        return false;
    }
    if (!allot_patrol_grade || allot_patrol_grade.toString() == "") {
        showMsg("操作提示", "请选择巡检级别！", "info");
        return false;
    }
    if (!allot_branch_code || allot_branch_code.toString() == "") {
        showMsg("操作提示", "请选择分配部门！", "info");
        return false;
    }
    $.ajax({
        url: '../../ashx/Mobile/dxj/PlanMethod.ashx?type=para1',
        data: {
            'user': userName.toString(),
            'branchID': allot_branch_code.toString(),
            'areaid': allot_equip_area.toString(),
            'postID': allot_major_time.toString(),
            'PatrolGrade': allot_patrol_grade.toString()
        },
        type: 'post',
        datatype: 'json',
        success: function (data) {
            var result = data;
            if (result.toString() == "0") {
                $('#dg').datagrid('reload');
                showMsg("操作提示", "分配成功！", "info")
            } else {
                showMsg("操作提示", "分配失败！", "error")
            }
        },
        eror: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};
function SearchPlan() {
    $('#dg').datagrid('reload', {
        PatrolGradeID: $('#search_patrol_grade').combobox('getValue'),
        equipCode: $('#search_equip_code').combobox('getValues').join(',')
    });
};
