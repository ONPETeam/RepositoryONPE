var action = "";

var LoadComboData = function () {
    $('#company_id').combotree({
        url: '../../ashx/Company/CompanyHandler.ashx?action=combo',
        animate: true,
        onSelect: function (companyID) {
            $('#branch_parent').combotree({
                url: '../../ashx/Branch/branchHandler.ashx?action=combo&branch_parent=0&company_id=' + companyID.id,
                animate: true
            });
        }
    });
};
$(document).ready(function () {
    LoadComboData();
    $('#dg').datagrid({
        url: '../../ashx/Branch/branchHandler.ashx?action=show',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        remoteSort: false,
        singleSelect: true,
        rownumbers: true,
        striped: true, //行背景交换
        columns: [[
                { field: 'dIntBranchID', title: '部门编号', hidden: true },
                { field: 'dVchBranchName', title: '部门名称', width: 200, sortable: true, editor: 'textbox' },
                { field: 'dVchBranchPY', title: '部门编码', width: 100 },
                { field: 'dIntCompanyID', title: '所属公司', hidden: true },
                { field: 'dVchCompanyName', title: '所属公司', width: 200 },
                { field: 'dIntUpBranch', title: '上级部门', hidden: true },
                { field: 'dVchUpBranchName', title: '上级部门名称', width: 100 }
            ]],
        onSelect: function (index, row) {
            selRow = row.dIntBranchID;
        },
        toolbar: [{
            text: '添加',
            iconCls: 'icon-add',
            handler: function () {
                showAdd();
            }
        }, {
            text: '编辑',
            iconCls: 'icon-edit',
            handler: function () {
                showEdit();
            }
        }, {
            text: '删除',
            iconCls: 'icon-cut',
            handler: function () {
                showDel();
            }
        }]
    });

    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 10, //每页显示的记录条数，默认为10 
        pageList: [5, 10, 15], //可以设置每页记录条数的列表 
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
function showAdd() {
    $('#ShowWin').window('open').panel({ title: '添加新部门' });
    action = 'add';
};
function showEdit() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm("操作提示", "您确定要编辑该行数据吗？", function (data) {
            if (data) {
                $('#ShowWin').window('open').panel({ title: '编辑部门信息' });
                action = 'edit';
                $('#branch_id').val(row.dIntBranchID);
                $('#branch_name').textbox('setValue', row.dVchBranchName);
                $('#branch_innum').textbox('setValue', row.dVchBranchPY);
                var setNode = $('#company_id').combotree('tree').tree('find', row.dIntCompanyID);
                $('#company_id').combotree('tree').tree('select', setNode.target);
                $('#company_id').combotree('setValue', row.dIntCompanyID);
                $('#branch_parent').combotree('setValue', row.dIntUpBranch);
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
//删除操作提示
function showDel() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        parent.$.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
            if (data) {
                delNode();
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
function delNode() {
    $.ajax({
        url: '../../ashx/Branch/branchHandler.ashx?action=del&branch_id=' + selRow,
        data: null,
        type: 'post',
        dataType: 'text',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == true) {
                $('#tt').form('clear');
                $('#dg').datagrid('reload');
                showMsg("操作提示", "删除成功！", "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        error: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};
function SaveContent() {
    switch (action) {
        case 'add':
            addBranch();
            break;
        case 'edit':
            editBranch();
            break;
    }
};
function addBranch() {
    var branchinfo = {
        branch_name: $('#branch_name').val(),
        branch_innum: $('#branch_innum').textbox('getValue'),
        branch_parent: $('#branch_parent').combotree('getValue'),
        company_id: $('#company_id').combotree('getValue')
    };
    $.ajax({
        type: 'post',
        url: '../../ashx/Branch/branchHandler.ashx?action=add',
        data: branchinfo,
        dataType: 'text',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == true) {
                $('#tt').form('clear');
                $('#dg').datagrid('reload');
                showMsg("操作提示", "添加成功！", "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        error: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};

function editBranch() {
    var branchinfo = {
        branch_id: $('#branch_id').val(),
        branch_name: $('#branch_name').val(),
        branch_innum: $('#branch_innum').textbox('getValue'),
        branch_parent: $('#branch_parent').combotree('getValue'),
        company_id: $('#company_id').combotree('getValue')
    };
    $.ajax({
        type: 'post',
        url: '../../ashx/Branch/branchHandler.ashx?action=edit',
        data: branchinfo,
        dataType: 'text',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == true) {
                $('#tt').form('clear');
                $('#dg').datagrid('reload');
                showMsg("操作提示", "编辑成功！", "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        error: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};
function closeWin() {
    $('#ShowWin').window('close');
    $('#dg').datagrid('reload');
};