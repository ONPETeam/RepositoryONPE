var oldSelectRoleCode;
var action;
$(document).ready(function () {
    loadRightTypeCombo();
    $('#dg').datagrid({
        url: '../../ashx/user/right/roleHandler.ashx?action=grid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pageSize: 20,
        pagePosition: 'bottom', //分页控件位置
        singleSelect: true,
        rownumbers: true,
        remoteSort: false,
        columns: [[
						{ field: 'role_code', title: '角色编号', width: 100, align: 'center', hidden: true },
						{ field: 'role_name', title: '角色名称', width: 100, align: 'center', sortable: true },
						{ field: 'role_discript', title: '角色说明', width: 120, align: 'center', sortable: true },
						{ field: 'flag_valid', title: '是否有效', width: 60, align: 'center', sortable: true,
						    formatter: function (value, row, index) {
						        if (value != "") {
						            if (value === "1") {
						                return "有效";
						            } else {
						                return "过期";
						            }
						        }
						    }
						},
                        { field: 'create_time', title: '创建时间', width: 130, align: 'center', sortable: true },
						{ field: 'lost_time', title: '失效时间', width: 130, align: 'center', sortable: true }

            ]],
        toolbar: [
            {
                "text": '查看详细',
                "iconCls": 'icon-bpbj',
                "handler": function () {
                    showData();
                }
            }, '-', {
                text: '新增记录',
                iconCls: 'icon-add',
                "handler": function () {
                    showAdd();
                }
            }, {
                text: '修改记录',
                iconCls: 'icon-cut',
                handler: function () {
                    showEdit();
                }
            }, {
                text: '删除记录',
                iconCls: 'icon-no',
                handler: function () {
                    showDel();
                }
            }, {
                text: '设置角色组',
                iconCls: 'icon-ok',
                handler: function () {
                    showRoleGroupSet();
                }
            }, {
                text: '分配权限',
                iconCls: 'icon-ok',
                handler: function () {
                    showRightSet();
                }
            }
            ],
        onSelect: function (rowIndex, rowData) {
            var $rightRole_layout = $("#rightRole_layout");
            var eastRightRole = $rightRole_layout.layout("panel", "east");
            if (oldSelectRoleCode == rowData.role_code) {  //点选的是相同的组就不再请求数据
                if (eastRightRole.panel("options").collapsed) {   //判断是否展开
                    $rightRole_layout.layout("expand", "east");
                } else {
                    $rightRole_layout.layout("collapse", "east");
                }
                return;
            }
            oldSelectRoleCode = rowData.role_code;   //赋值



            if (eastRightRole.panel("options").collapsed) {   //判断是否展开
                $rightRole_layout.layout("expand", "east");
            }


            eastRightRole.panel("setTitle", rowData.role_name + "成员");
            $("#rightRole_dg").datagrid({       //初始化datagrid
                url: "../../ashx/user/right/userRoleHandler.ashx?action=grid&role_code=" + rowData.role_code,
                striped: true, rownumbers: true, pagination: true, pageSize: 20, singleSelect: true,
                idField: 'user_code',
                pageList: [20, 40, 60, 80, 100],
                loadMsg: "正在努力加载数据，请稍后...",
                columns: [[
                                { field: 'user_code', title: '用户编码', hidden: true },
                                { field: 'user_name', title: '用户名', sortable: true, width: 120 },
                                { field: 'auto_lock', title: '自动锁定', sortable: true, width: 100, align: 'center',
                                    formatter: function (value, row, index) {
                                        return value === "1" ? '锁定' : '不锁定';
                                    }
                                },
                                { field: 'user_state', title: '用户状态', sortable: true, width: 100, align: 'center',
                                    formatter: function (value, row, index) {
                                        if (value === "0") {
                                            return "正常";
                                        } else if (value === 1) {
                                            return "已锁定";
                                        } else if (value === "-1") {
                                            return "已注销";
                                        } else {
                                            return "未知";
                                        }
                                    }
                                },
                                { field: 'user_create_time', title: '创建时间', sortable: true, width: 130 },
                                { field: 'lastlogin_time', title: '最后登录时间', sortable: true, width: 130 },
                                { field: 'login_num', title: '登录次数', sortable: true, width: 120 }
                             ]]
            });
        }
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
    $('#ShowGroupSet').window({
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
    //要搜索的列名:$('#要搜索的列名').textbox('getValue'),
    //要搜索的列名:$('#要搜索的列名').textbox('getValue')
});
};
//显示详细
function showData() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        loadCombo();

        $('#role_code').val(row.role_code);
        $('#role_name').textbox('setValue', row.role_name);
        $('#role_discript').textbox('setValue', row.role_discript);
        $('#flag_valid').prop('checked', row.flag_valid === "1");
        $('#lost_time').datetimebox('setValue', row.lost_time);


        $('#ShowWin').window('open').panel({ title: '查看详细' });
        document.getElementById('ss').style.display = 'none';
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
//显示添加
function showAdd() {
    action = 'add';
    //弹出添加框之前的操作，比如初始化下拉框、设定默认值等
    $('#ShowWin').window('open').panel({ title: '新增记录' });
    document.getElementById('ss').style.display = '';
    loadCombo();
};
//显示编辑
function showEdit() {
    action = 'edit';
    var row = $('#dg').datagrid('getSelected');
    //row为选中行
    if (row) {
        $.messager.confirm("操作提示", "您确定要执行编辑操作吗？", function (data) {
            loadCombo();
            if (data) {
                $('#role_code').val(row.role_code);
                $('#role_name').textbox('setValue', row.role_name);
                $('#role_discript').textbox('setValue', row.role_discript);
                $('#flag_valid').prop('checked', row.flag_valid === "1");
                $('#lost_time').datetimebox('setValue', row.lost_time);

                $('#ShowWin').window('open').panel({ title: '修改记录' });
                document.getElementById('ss').style.display = '';
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
//显示删除
function showDel() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
            if (data) {
                //删除操作
                delData(row.role_code);
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
//显示权限设置对话框
function showRightSet() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $('#right_set_role_code').val(row.role_code);
        loadRightSetGrid($('#rightSet_dg'), row.role_code,$('#right_class').combobox('getValue'));
        $('#showRightSet').window('open').panel({ title: '【' + row.role_name + '】分配权限' });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }

};
//加载权限设置列表
function loadRightSetGrid(grid, roleCode, rightClass) {
    if (grid.data('datagrid')) {
        grid.datagrid({
            url: '../../ashx/user/right/rolerightHandler.ashx?action=grid&role_code=' + roleCode,
            queryParams: { 'right_class': rightClass },
            method: 'post',
            loadMsg: "正在努力加载数据，请稍后...",
            pagination: true, //分页控件
            pageSize: 20,
            pagePosition: 'bottom', //分页控件位置
            singleSelect: true,
            rownumbers: true,
            remoteSort: false,
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
    var roleRightInfo = {
        role_code: $('#right_set_role_code').val(),
        right_type: rightType,
        author_end: authorEnd,
        right_set: rightSet
    }
    $.messager.confirm("操作提示", "您确定要设置组权限信息么？", function (data) {
        if (data) {
            $.ajax({
                url: '../../ashx/user/right/rolerightHandler.ashx?action=set',
                type: 'post',
                data: roleRightInfo,
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

//设置角色组
function showRoleGroupSet() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $('#group_role_code').val(row.role_code);
        loadGroupTree($('#roleGroup_tree'), 1, row.role_code);
        $('#ShowGroupSet').window('open').panel({ title: row.role_name + '所属分组' });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
//保存分组设置
function SaveGroupSet() {
    $.messager.confirm("操作提示", "您确定要执行保存操作吗？", function (data) {
        if (data) {
            //保存操作
            var groupCodes = "";
            var nodes = $('#roleGroup_tree').tree('getChecked');
            for (var i = 0; i < nodes.length; i++) {
                groupCodes += nodes[i].id + ",";
            }
            var groupSet_info = {
                role_code: $('#group_role_code').val(),
                group_set: groupCodes,
                action: 'set'
            };
            $.ajax({
                url: '../../ashx/user/right/rolegroupHandler.ashx',
                type: 'post',
                data: groupSet_info,
                dataType: 'text',
                success: function (data) {
                    var result = eval('(' + data + ')');
                    if (result.success == true) {
                        closeGroupSetWin();
                        showMsg("操作提示", "保存角色分组信息成功！", "info");
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
//关闭弹出框
function closeWin() {
    $('#tt').form('clear');
    $('#ShowWin').window('close');
};
//关闭分组设置弹出框
function closeGroupSetWin() {
    $('#ff').form('clear');
    $('#ShowGroupSet').window('close');
};
//保存操作
function SaveContent() {
    switch (action) {
        case 'add':
            addData();
            break;
        case 'edit':
            editData();
            break;
    }
};
//添加操作
function addData() {
    var add_DataInfo = {
        role_name: $('#role_name').textbox('getValue'),
        role_discript: $('#role_discript').textbox('getValue'),
        flag_valid: $('#flag_valid').val() === "on" ? 1 : 0,
        lost_time: $('#lost_time').datetimebox('getValue')
    };
    $.ajax({
        url: '../../ashx/user/right/roleHandler.ashx?action=add',
        data: add_DataInfo,
        type: 'post',
        datatype: 'json',
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
        eror: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};
//编辑操作
function editData() {
    var edit_DataInfo = {
        role_code: $('#role_code').val(),
        role_name: $('#role_name').textbox('getValue'),
        role_discript: $('#role_discript').textbox('getValue'),
        flag_valid: $('#flag_valid').val() === "on" ? 1 : 0,
        lost_time: $('#lost_time').datetimebox('getValue')
    };
    $.ajax({
        url: '../../ashx/user/right/roleHandler.ashx?action=edit',
        data: edit_DataInfo,
        type: 'post',
        datatype: 'json',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == true) {
                closeWin();
                $('#dg').datagrid('reload');
                showMsg("操作提示", "编辑成功！", "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        eror: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};
//删除操作
function delData(dataid) {
    var del_DataInfo = {
        role_code: dataid
    };
    $.ajax({
        url: '../../ashx/user/right/roleHandler.ashx?action=del',
        data: del_DataInfo,
        type: 'post',
        datatype: 'json',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == true) {
                $('#dg').datagrid('reload');
                showMsg("操作提示", "删除成功！", "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        eror: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};

var loadCombo = function () {

    /*$('#group_type').combobox({
    valueField: 'id',
    textField: 'text',
    data: rightgrouptype
    });*/
};


//group_type  1  load_code为角色编码, 2 load_code为用户编码,
function loadGroupTree(tree, group_type, load_code) {
    if (tree.data('tree')) {
        var requestUrl = "";
        if (group_type === 1) {
            requestUrl = "../../ashx/user/right/getRoleGroupTreeHandler.ashx?role_code=" + load_code;
        } else {
            requestUrl = "../../ashx/user/right/getUserGroupTreeHandler.ashx?user_code=" + load_code;
        }
        tree.tree({
            url: requestUrl,
            method: 'post',
            cascadeCheck: true,
            animate: true,
            checkbox: true
        });
    }
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