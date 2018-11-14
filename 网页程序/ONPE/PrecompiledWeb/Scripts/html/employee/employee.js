

var action;


$(document).ready(function () {

    LoadComboData();

    $('#dg').datagrid({
        url: '../../ashx/employee/employeeHandler.ashx?action=grid',
        method: 'post',
        singleSelect: true,
        //collapsible: true,
        loadMsg: "正在努力加载数据，请稍后...",
        striped: true, //行背景交换
        nowap: true, //列内容多时自动折至第二行
        pagination: true, //分页控件
        pageSize: 20,
        pagePosition: 'bottom', //分页控件位置
        remoteSort: false,
        fit: true,
        frozenColumns: [[
                    { field: 'company_id', title: '公司编号', hidden: true },
                    { field: 'company_name', title: '公司名称', width: 60, align: 'center' },
                    { field: 'branch_id', title: '部门编号', hidden: true },
                    { field: 'branch_name', title: '部门名称', width: 60, align: 'center' },
                    { field: 'employee_code', title: '员工编号', hidden: true },
                    { field: 'employee_innum', title: '员工编码', width: 60, align: 'center' },
                    { field: 'major_code', title: '专业分类编号', hidden: true },
                    { field: 'major_name', title: '专业分类', width: 60, align: 'center' },
                    { field: 'patrolgrade_id', title: '点巡检级别编号', hidden: true },
                    { field: 'patrolgrade_name', title: '点巡检级别', width: 60, align: 'center' },
                    { field: 'employee_name', title: '员工姓名', width: 65, align: 'center', sortable: true }
                ]],
        columns: [[
                { title: '基础信息', colspan: 9 },
                { title: '联系方式', colspan: 3 },
                { title: '受教育度', colspan: 4 }
                ],
                [
                { field: 'employee_sex', title: '性别', width: 30, align: 'center', rowspan: 1 },
                { field: 'nation_id', title: '民族', width: 30, align: 'center', rowspan: 1, hidden: 'true' },
                { field: 'nation_name', title: '民族', width: 30, align: 'center', rowspan: 1 },
                { field: 'visagetype_id', title: '政治面貌', width: 60, align: 'center', rowspan: 1, hidden: 'true' },
                { field: 'visagetype_name', title: '政治面貌', width: 60, align: 'center', rowspan: 1 },
                { field: 'marital_status', title: '婚姻状况', width: 60, align: 'center', rowspan: 1 },
                { field: 'idcard_no', title: '身份证', width: 150, align: 'center', rowspan: 1 },
                { field: 'city_id', title: '籍贯', width: 60, align: 'center', rowspan: 1, hidden: 'true' },
                { field: 'city_name', title: '籍贯', width: 60, align: 'center', rowspan: 1 },
                { field: 'telphone_no', title: '手机号', width: 100, align: 'center', rowspan: 1 },
                { field: 'home_address', title: '家庭住址', width: 100, align: 'center', rowspan: 1, formatter: remarkFormater },
                { field: 'education_id', title: '文化程度', width: 60, align: 'center', rowspan: 1, hidden: 'true' },
                { field: 'education_name', title: '文化程度', width: 60, align: 'center', rowspan: 1 },
                { field: 'graduate_time', title: '毕业时间', width: 100, align: 'center', rowspan: 1 },
                { field: 'graduate_school', title: '毕业学院', width: 100, align: 'center', rowspan: 1 },
                { field: 'specialty_name', title: '专业名称', width: 100, align: 'center', rowspan: 1 }

             ]],
        rownumbers: true,
        toolbar: '#tb_query_employee',
        onSelect: function (index, row) {
            selRow = row.employee_code;
        },
        onLoadSuccess: function (data) {
            for (var i = 0; i < data.rows.length; i++) {
                if (data.rows[i].home_address != undefined) {
                    var content = data.rows[i].home_address;
                    toolcontent = "<tr><td>具体内容：" + content + " </td></tr>";
                }
                //拼写tooltip的内容   
                tooltipcontent = "<table style='width:200px;'>" + toolcontent + "</table>";
                addTooltip(tooltipcontent, 'content-' + i);
            }
        }
    });

    $('#search_employee_name').textbox({});
    $('#search_major').combobox({
        valueField: 'id',
        textField: 'text',
        animate: true,
        url: '../../ashx/DD/majorHandler.ashx?action=combo'
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 20, //每页显示的记录条数，默认为20 
        pageList: [10, 20, 50], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    $('#ShowWin').window({
        title: '添加员工信息',
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });

});
function ShowAdd() {
    action = "add";
    $('#ShowWin').window('open').panel({ title: '添加员工' });
};
function ShowEdit() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        parent.$.messager.confirm("操作提示", "您确定要执行修改操作吗？", function (data) {
            if (data) {
                action = "edit";
                $('#ShowWin').window('open').panel({ title: '编辑员工信息' });
                $('#employee_code').val(row.employee_code);
                $('#employee_innum').textbox('setValue', row.employee_innum);
                $('#employee_name').textbox('setValue', row.employee_name);
                $('#employee_sex').combobox('select', row.employee_sex);
                $('#idcard_no').textbox('setValue', row.idcard_no);


                $('#city_id').combotree('setValue', row.city_id);
                $('#city_id').combotree('setValue', row.city_name);

                $('#home_address').textbox('setValue', row.home_address);
                $('#nation_id').combobox('select', row.nation_id);
                $('#visagetype_id').combobox('select', row.visagetype_id);
                $('#marital_status').combobox('select', row.marital_status);
                $('#telphone_no').textbox('setValue', row.telphone_no);
                $('#education_id').combobox('select', row.education_id);

                $('#graduate_time').datebox('setValue', row.graduate_time === "" ? "1900-01-01" : row.graduate_time);
                $('#graduate_school').textbox('setValue', row.graduate_school);
                $('#specialty_name').textbox('setValue', row.specialty_name);

                var setNode = $('#company_id').combotree('tree').tree('find', row.company_id);
                $('#company_id').combotree('tree').tree('select', setNode.target);
                $('#company_id').combotree('setValue', row.company_id);

                $('#branch_id').combotree('setValue', row.branch_id);

                $('#major_code').combobox('select', row.major_code);

                $('#patrolgrade_id').combobox('select', row.patrolgrade_id);
            }
        });
    }
    else {
        parent.$.messager.alert("操作提示", "请选择要修改的数据！", "提示");
    }

};
var LoadComboData = function () {
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
                }
            });
        }
    });
    $('#city_id').combotree({
        url: '../../ashx/publicHandler.ashx?name=geog&action=combotree&parent_id=1',
        animate: true,
        onBeforeExpand: function (node) {
            $('#city_id').combotree("tree").tree("options").url = "../../ashx/publicHandler.ashx?name=geog&action=combotree&parent_id=" + node.id;
        },
        onBeforeSelect: function (node) {
            if (!$('#city_id').tree('isLeaf', node.target)) {
                return false;
            }
        }
    });
    $('#major_code').combobox({
        valueField: 'id',
        textField: 'text',
        url: '../../ashx/major/majorHandler.ashx?action=combobox'
    });
    $('#visagetype_id').combobox({
        valueField: 'id',
        textField: 'text',
        url: '../../ashx/publicHandler.ashx?name=visagetype&action=combo'
    });
    $('#patrolgrade_id').combobox({
        valueField: 'id',
        textField: 'text',
        url: '../../ashx/publicHandler.ashx?name=patrolgrade&action=combo'
    });
    $('#nation_id').combobox({
        valueField: 'id',
        textField: 'text',
        url: '../../ashx/publicHandler.ashx?name=nation&action=combo'
    });

    $('#education_id').combobox({
        valueField: 'id',
        textField: 'text',
        url: '../../ashx/publicHandler.ashx?name=education&action=combo'
    });
};
function doSearch() {
    $('#dg').datagrid('load', {
        employee_name: $('#search_employee_name').val(),
        major_code: $('#search_major').combobox('getValue')
    })
};

//删除操作提示
function delMsgDialog() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        parent.$.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
            if (data) {
                delNode();
            }
            else {
            }
        });
    }
    else {
        parent.$.messager.alert("操作提示", "请选择要删除的数据！", "提示");
    }
};
function delNode() {
    $.ajax({
        url: '../../ashx/employee/employeeHandler.ashx?action=del',
        data: { employee_code: selRow },
        type: 'post',
        dataType: 'text',
        success: function (msg) {
            var result = eval('(' + msg + ')');
            if (result.success) {
                parent.$.messager.alert("操作提示", "删除成功！", "info");
                $('#dg').datagrid('reload');
            } else {
                parent.$.messager.alert("操作提示", result.msg, "error");
            }
        }
    });
};
function closeAddWin() {
    $('#ShowWin').window('close');
    $('#dg').datagrid('reload');
};
function saveEmployee() {
    $.messager.progress();
    $('#ff').form('submit', {
        url: '../../ashx/employee/employeeHandler.ashx',
        onSubmit: function (param) {
            var isValid = $(this).form('validate');
            if (!isValid) {
                $.messager.progress('close'); // hide progress bar while the form is invalid
            }
            param.action = action;
            param.employee_code = $('#employee_code').val();
            param.employee_innum = $('#employee_innum').textbox('getValue');
            param.employee_name = $('#employee_name').textbox('getValue');
            param.employee_sex = $('#employee_sex').combobox('getValue');
            param.idcard_no = $('#idcard_no').textbox('getValue');
            param.city_id = $('#city_id').combotree('getValue');
            param.home_address = $('#home_address').textbox('getValue');
            param.nation_id = $('#nation_id').combobox('getValue');
            param.visagetype_id = $('#visagetype_id').combobox('getValue');
            param.marital_status = $('#marital_status').combobox('getValue');
            param.telphone_no = $('#telphone_no').textbox('getValue');
            param.eductaion_id = $('#education_id').combobox('getValue');
            param.graduate_time = $('#graduate_time').datebox('getValue') == "" ? "1900-01-01" : $('#graduate_time').datebox('getValue');
            param.graduate_school = $('#graduate_school').textbox('getValue');
            param.specialty_name = $('#specialty_name').textbox('getValue');
            param.branch_id = $('#branch_id').combotree('getValue');
            param.major_code = $('#major_code').combobox('getValue');
            param.patrolgrade_id = $('#patrolgrade_id').combobox('getValue');
            return isValid;
        },
        success: function (data) {
            $.messager.progress('close');
            var result = eval('(' + data + ')');
            if (result.success) {
                showMsg("操作提示", "保存成功！", "info");
                $('#dg').datagrid('reload');
            } else {
                showMsg("操作提示", result.data, "error");
            }
        },
        error: function (xhr, responseData, status) {
            $.messager.progress('close');
            showMsg("操作提示", xhr.responseText, "error")
        }
    });

};
//    function endEditing() {
//        if (editIndex == undefined) { return true }
//        if ($('#dg').datagrid('validateRow', editIndex)) {
//            $('#dg').datagrid('endEdit', editIndex);
//            editIndex = undefined;
//            return true;
//        } else {
//            return false;
//        }
//    }

