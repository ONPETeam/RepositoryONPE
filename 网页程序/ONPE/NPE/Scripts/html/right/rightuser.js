var action;
var oldSelectUserCode;
$(document).ready(function () {
    loadRightTypeCombo();
    $('#dg').datagrid({
        url: '../../ashx/user/userHandler.ashx?action=grid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pageSize: 20,
        pagePosition: 'bottom', //分页控件位置
        singleSelect: true,
        rownumbers: true,
        remoteSort: false,
        columns: [[
                { field: 'employee_code', title: "员工编号", hidden: true },
                { field: 'user_id', title: "用户编号", hidden: true },
				{ field: 'company_name', title: '公司名称', width: 180, align: 'center' },
                { field: 'branch_name', title: '部门名称', width: 120, align: 'center' },
                { field: 'employee_name', title: '员工姓名', sortable: true, width: 80, align: 'center' },
                { field: 'telphone_no', title: '手机号', sortable: true, width: 80, align: 'center' },
            ]],
        toolbar: '#tb'
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 20, //每页显示的记录条数，默认为20 
        pageList: [10, 20, 50], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });

    $('#ShowGroupSet').window({
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        closable: false,
        minimizable: false,
        collapsible: true
    });
    $('#ShowRoleSet').window({
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        closable: false,
        minimizable: false,
        collapsible: true
    });
    $('#showRightSet').window({
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        closable: false,
        minimizable: false,
        collapsible: true
    });
});

//执行搜索
function doSearch() {
    $('#dg').datagrid('load', {
        employee_name: $('#search_employee_name').textbox('getValue')
        //要搜索的列名:$('#要搜索的列名').textbox('getValue')
    });
};



//显示用户组设置
function showUserGroupSet() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $('#group_user_code').val(row.user_id);
        loadGroupTree($('#userGroup_tree'), row.user_id);
        $('#ShowGroupSet').window('open').panel({ title: '员工【' + row.employee_name + '】所属分组' });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};

//加载用户分组设置中的用户组树
function loadGroupTree(tree, userId) {
    if (tree.data('tree')) {
        tree.tree({
            url: "../../ashx/user/right/getUserGroupTreeHandler.ashx?user_code=" + userId,
            method: 'post',
            cascadeCheck: true,
            animate: true,
            checkbox: true
        });
    }
};

//保存用户分组
function SaveGroupSet() {
    $.messager.confirm("操作提示", "您确定要保存用户分组信息么？", function (data) {
        if (data) {
            var groupCodes = "";
            var nodes = $('#userGroup_tree').tree('getChecked');
            for (var i = 0; i < nodes.length; i++) {
                groupCodes += nodes[i].id + ",";
            }
            var groupSet_info = {
                user_code: $('#group_user_code').val(),
                group_set: groupCodes,
                action: 'set'
            };
            $.ajax({
                url: '../../ashx/user/right/usergroupHandler.ashx',
                type: 'post',
                data: groupSet_info,
                dataType: 'text',
                success: function (data) {
                    var result = eval('(' + data + ')');
                    if (result.success == true) {
                        closeGroupSetWin();
                        showMsg("操作提示", "保存用户分组信息成功！", "info");
                    } else {
                        showMsg("操作提示", result.msg, "error");
                    }
                },
                error: function (xhr, responseData, state) {
                    showMsg("操作提示", xhr.responseData, "info");
                }
            });
        }
    });
};

//关闭用户组设置弹出框
function closeGroupSetWin() {
    $('#ff').form('clear');
    $('#ShowGroupSet').window('close');
};

//显示用户角色设置
function showUserRoleSet() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $('#role_user_code').val(row.user_id);
        loadRoleTree($('#userRole_tree'), 2, row.user_id);
        $('#ShowRoleSet').window('open').panel({ title: '员工【' + row.employee + '】所属角色' });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};

//加载用户角色设置中的用户角色树
function loadRoleTree(tree, userId) {
    if (tree.data('tree')) {
        tree.tree({
            url: "../../ashx/user/right/getUserRoleTreeHandler.ashx?user_code=" + userId,
            method: 'post',
            cascadeCheck: true,
            animate: true,
            checkbox: true
        });
    }
};

//保存用户角色设置
function SaveRoleSet() {
    $.messager.confirm("操作提示", "您确定要保存员工分组信息么？", function (data) {
        if (data) {
            var roleCodes = "";
            var nodes = $('#userRole_tree').tree('getChecked');
            for (var i = 0; i < nodes.length; i++) {
                roleCodes += nodes[i].id + ",";
            }
            var roleSet_info = {
                user_code: $('#role_user_code').val(),
                role_set: roleCodes,
                action: 'set'
            };
            $.ajax({
                url: '../../ashx/user/right/userroleHandler.ashx',
                type: 'post',
                data: roleSet_info,
                dataType: 'text',
                success: function (data) {
                    var result = eval('(' + data + ')');
                    if (result.success == true) {
                        closeRoleSetWin();
                        showMsg("操作提示", "保存员工角色信息成功！", "info");
                    } else {
                        showMsg("操作提示", result.msg, "error");
                    }
                },
                error: function (xhr, responseData, state) {
                    showMsg("操作提示", xhr.responseData, "info");
                }
            });
        }
    });
};

//关闭用户角色设置弹出框
function closeRoleSetWin() {
    $('#ffRole').form('clear');
    $('#ShowRoleSet').window('close');
};

//显示权限设置对话框
function showRightSet() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $('#right_set_user_code').val(row.user_id);
        loadRightSetGrid($('#rightSet_dg'), row.user_id, $('#right_class').combobox('getValue'));
        $('#showRightSet').window('open').panel({ title: '【' + row.employee_name + '】分配权限' });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }

};
//加载权限设置列表
function loadRightSetGrid(grid, userId, rightClass) {
    if (grid.data('datagrid')) {
        grid.datagrid({
            url: '../../ashx/user/right/userrightHandler.ashx?action=grid&user_code=' + userId,
            queryParams: { 'right_class': rightClass },
            method: 'post',
            loadMsg: "正在努力加载数据，请稍后...",
            pagination: true, //分页控件
            pageSize: 20,
            pagePosition: 'bottom', //分页控件位置
            singleSelect: true,
            rownumbers: true,
            remoteSort: false,
            fit: true,
            columns: [[
				{ field: 'right_code', checkbox: true },
				{ field: 'right_name', title: '权限名称', width: 100, align: 'center' },
				{ field: 'right_menugroup', title: '菜单组编号', hidden: true },
                { field: 'right_menugroup_name', title: '菜单组名称', width: 100, align: 'center' },
                { field: 'right_menu', title: '菜单编号', hidden: true },
                { field: 'right_menu_title', title: '菜单名称', width: 100, align: 'center' },
                { field: 'right_item', title: '页面项编号', hidden: true },
                { field: 'right_item_title', title: '页面项名称', width: 100, align: 'center' },
				{ field: 'right_type', title: '授权类型', width: 100, align: 'center',
				    formatter: function (value, row, index) {

				        for (var i = 0; i < righttype.length; i++) {
				            var item = righttype[i]
				            if (value == item['id']) {
				                return item['text'];
				            }
				        }
				        return '无权限';

				    }
				},
                { field: 'author_end', title: '结束时间', width: 130, align: 'center', sortable: true,
                    formatter: function (value, row, index) {
                        if (value != "") {
                            if (value === '1900/1/1 0:00:00') {
                                return "永久有效";
                            } else {
                                return value;
                            }
                        }
                    }
                }
            ]],
            singleSelect: false,
            selectOnCheck: true,
            checkOnSelect: true,
            onLoadSuccess: function (data) {
                if (data) {
                    $.each(data.rows, function (index, item) {
                        if (item.checked) {
                            $('#dg').datagrid('checkRow', index);
                        }
                    });
                }
            },
            toolbar: "#RightSetToolbar"
        });
        var p = grid.datagrid('getPager');
        $(p).pagination({
            pageSize: 20, //每页显示的记录条数，默认为20 
            pageList: [10, 20, 50], //可以设置每页记录条数的列表 
            beforePageText: '第', //页数文本框前显示的汉字 
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
        });
    }
};
//设置是否失效
function authorOffCheck() {
    if ($('#set_author_off').prop('checked')) {
        $('#set_author_end').datetimebox({ required: false });
        $('#set_author_end').datetimebox({ disable: true });
    }
    else {
        $('#set_author_end').datetimebox({ required: true });
        $('#set_author_end').datetimebox({ missingmessage: '请选择失效时间！' });
        $('#set_author_end').datetimebox({ disable: false });
    }
};
//保存权限设置
function SaveRightSet() {
    var authorEnd = "";
    if (!$('#set_author_off').prop('checked')) {
        if ($('#set_author_end').datetimebox('getValue') === "") {
            showMsg("操作提示", "请设置失效时间!", "error");
            return;
        }
        else {
            authorEnd = $('#set_author_end').datetimebox('getValue');
        }
    }
    var rightType = "";
    if ($('#set_right_type').combobox('getValue') == "") {
        showMsg("操作提示", "请选择授权类型!", "error");
        return;
    }
    else {
        rightType = $('#set_right_type').combobox('getValue');
    }
    var rightSet = "";
    var selectRows = $('#rightSet_dg').datagrid('getChecked');
    if (selectRows.length > 0) {
        $.each(selectRows, function (index, item) {
            rightSet += item.right_code + ',';
        });
    }
    else {
        showMsg("操作提示", "请选择要授权的权限项!", "error");
        return;
    }
    var userRightInfo = {
        user_code: $('#right_set_user_code').val(),
        right_type: rightType,
        author_end: authorEnd,
        right_set: rightSet
    }
    $.messager.confirm("操作提示", "您确定要设置组权限信息么？", function (data) {
        if (data) {
            $.ajax({
                url: '../../ashx/user/right/userrightHandler.ashx?action=set',
                type: 'post',
                data: userRightInfo,
                dataType: 'text',
                success: function (data) {
                    var result = eval('(' + data + ')');
                    if (result.success == true) {
                        $('#rightSet_dg').datagrid('reload');
                        showMsg("操作提示", "保存组权限设置信息成功！", "info");
                    } else {
                        showMsg("操作提示", result.msg, "error");
                    }
                },
                error: function (xhr, responseData, state) {
                    showMsg("操作提示", xhr.responseData, "info");
                }
            });
        }
    });
};

//关闭权限设置对话框
function closeRightSetWin() {
    $('#dg').datagrid('reload');
    $('#showRightSet').window('close');
};
var loadRightTypeCombo = function () {

    $('#set_right_type').combobox({
        valueField: 'id',
        textField: 'text',
        data: righttype
    });
    $('#right_class').combobox({
        valueField: 'id',
        textField: 'text',
        data: rightClass,
        onSelect: function () {
            $('#rightSet_dg').datagrid('reload', { 'right_class': $('#right_class').combobox('getValue') });
        }
    });
}

