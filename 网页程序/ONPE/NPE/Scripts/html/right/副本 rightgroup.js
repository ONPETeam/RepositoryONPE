var oldSelectGroupCode;
var action;
$(document).ready(function () {
    loadRightTypeCombo();
    $('#dg').datagrid({
        url: '../../ashx/user/right/rightGroupHandler.ashx?action=grid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pageSize: 20,
        pagePosition: 'bottom', //分页控件位置
        singleSelect: true,
        rownumbers: true,
        remoteSort: false,
        columns: [[
				{ field: 'group_code', title: '组编号', width: 100, align: 'center', hidden: true },
				{ field: 'group_name', title: '组名称', width: 100, align: 'center' },
				{ field: 'group_type', title: '组类型', width: 100, align: 'center', sortable: true,
				    formatter: function (value, row, index) {
				        if (value != "") {
				            for (var i = 0; i < rightgrouptype.length; i++) {
				                var item = rightgrouptype[i]
				                if (value == item['id']) {
				                    return item['text'];
				                }
				            }
				            return '未定义类型';
				        }
				    }
				},
				{ field: 'group_discript', title: '组说明', width: 100, align: 'center', hidden: true },
                { field: 'flag_valid', title: '是否有效', width: 100, align: 'center', sortable: true,
                    formatter: function (value, row, index) {
                        if (value != "") {
                            if (value === 1) {
                                return "有效";
                            } else {
                                return "过期";
                            }
                        }
                    }
                },
                { field: 'create_time', title: '创建时间', width: 100, align: 'center', sortable: true },
				{ field: 'lost_time', title: '失效时间', width: 100, align: 'center', sortable: true,
				    formatter: function (value, row, index) {
				        if (row.flag_valid === 1) {
				            return "永久有效";
				        }
				    }
				}

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
                text: "设置权限",
                iconCls: 'icon-ok',
                handler: function () {
                    showRight();
                }
            }
            ],
        onSelect: function (rowIndex, rowData) {
            var $rightGroup_layout = $("#rightGroup_layout");
            var eastRightGroup = $rightGroup_layout.layout("panel", "east");
            if (oldSelectGroupCode == rowData.group_code) {  //点选的是相同的组就不再请求数据
                if (eastRightGroup.panel("options").collapsed) {   //判断是否展开
                    $rightGroup_layout.layout("expand", "east");
                } else {
                    $rightGroup_layout.layout("collapse", "east");
                }
                return;
            }
            if (eastRightGroup.panel("options").collapsed) {   //判断是否展开
                $rightGroup_layout.layout("expand", "east");
            }

            oldSelectGroupCode = rowData.group_code;   //赋值
            eastRightGroup.panel("setTitle", "【" + rowData.group_name + "】成员");
            if (rowData.group_type == "2") {   //用户组
                $("#rightGroup_dg").datagrid({       //初始化datagrid
                    url: "../../ashx/user/right/userGroupHandler.ashx?action=grid&group_code=" + rowData.group_code,
                    striped: true, rownumbers: true, pagination: true, pageSize: 20, singleSelect: true,
                    idField: 'user_code',
                    pageList: [20, 40, 60, 80, 100],
                    loadMsg: "正在努力加载数据，请稍后...",
                    columns: [[
                                { field: 'user_code', title: '用户编码', hidden: true, width: 100 },
                                { field: 'user_name', title: '用户名', sortable: true, width: 80 },
                                { field: 'auto_lock', title: '自动锁定', sortable: true, width: 60, align: 'center',
                                    formatter: function (value, row, index) {
                                        return value === "1" ? '锁定' : '不锁定';
                                    }
                                },
                                { field: 'user_state', title: '用户状态', sortable: true, width: 60, align: 'center',
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
                                { field: 'login_num', title: '登录次数', sortable: true, width: 130 }
                             ]]
                });
            };
            if (rowData.group_type == "1") {  //角色组
                $("#rightGroup_dg").datagrid({       //初始化datagrid
                    url: "../../ashx/user/right/roleGroupHandler.ashx?action=grid&role_code=" + rowData.Id,
                    striped: true, rownumbers: true, pagination: true, pageSize: 20, singleSelect: true,
                    idField: 'UserId',
                    pageList: [20, 40, 60, 80, 100],
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
                    ]]
                });
                var p = $('#rightGroup_dg').datagrid('getPager');
                $(p).pagination({
                    pageSize: 20, //每页显示的记录条数，默认为20 
                    pageList: [10, 20, 50], //可以设置每页记录条数的列表 
                    beforePageText: '第', //页数文本框前显示的汉字 
                    afterPageText: '页    共 {pages} 页',
                    displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
                });
            }
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
    $('#rightGroup_layout').layout('collapse', 'east');

});

//执行搜索
function doSearch() {
    $('#dg').datagrid('load', {
        menu_title: $('#search_menu_title').textbox('getValue'),
        menu_name: $('#search_menu_name').textbox('getValue')
    });
};

//显示详细
function showData() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        loadCombo();

        $('#group_code').val(row.group_code);
        $('#group_name').textbox('setValue', row.group_name);
        $('#group_discript').textbox('setValue', row.group_discript);
        $('#flag_valid').prop('checked', row.flag_valid === 1);
        $('#group_type').combobox('setValue', row.group_type);
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
                $('#group_code').val(row.group_code);
                $('#group_name').textbox('setValue', row.group_name);
                $('#group_discript').textbox('setValue', row.group_discript);
                $('#flag_valid').prop('checked', row.flag_valid === 1);
                $('#group_type').combobox('setValue', row.group_type);
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
                delData(row.group_code);
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};

//显示权限设置对话框
function showRight() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $('#right_set_group_code').val(row.group_code);
        loadRightSetGrid($('#rightSet_dg'), row.group_code,$('#right_class').combobox('getValue'));
        $('#showRightSet').window('open').panel({ title: '【' + row.group_name + '】分配权限' });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }

};

//加载权限设置列表
function loadRightSetGrid(grid, groupCode, rightClass) {
    if (grid.data('datagrid')) {
        grid.datagrid({
            url: '../../ashx/user/right/grouprightHandler.ashx?action=grid&group_code='+ groupCode,
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
}
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
    var groupRightInfo = {
        group_code: $('#right_set_group_code').val(),
        right_type: rightType,
        author_end: authorEnd,
        right_set: rightSet
    }
    $.messager.confirm("操作提示", "您确定要设置组权限信息么？", function (data) {
        if (data) {
            $.ajax({
                url: '../../ashx/user/right/grouprightHandler.ashx?action=set',
                type: 'post',
                data: groupRightInfo,
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
}


//关闭权限设置对话框
function closeRightSetWin() {
    $('#dg').datagrid('reload');
    $('#showRightSet').window('close');
};


//关闭弹出框
function closeWin() {
    $('#tt').form('clear');
    $('#ShowWin').window('close');
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
    var add_RightGroupInfo = {
        group_name: $('#group_name').textbox('getValue'),
        group_discript: $('#group_discript').textbox('getValue'),
        flag_valid: $('#flag_valid').val() == "true" ? 1 : 0,
        group_type: $('#group_type').combobox('getValue'),
        lost_time: $('#lost_time').datetimebox('getValue')

    };
    $.ajax({
        url: '../../ashx/user/right/rightGroupHandler.ashx?action=add',
        data: add_RightGroupInfo,
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
    var edit_RightGroupInfo = {
        group_code: $('#group_code').val(),
        group_name: $('#group_name').textbox('getValue'),
        group_discript: $('#group_discript').textbox('getValue'),
        flag_valid: $('#flag_valid').val() == "true" ? 1 : 0,
        group_type: $('#group_type').combobox('getValue'),
        lost_time: $('#lost_time').datetimebox('getValue')
    };
    $.ajax({
        url: '../../ashx/user/right/rightGroupHandler.ashx?action=edit',
        data: edit_RightGroupInfo,
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
    var del_RightGroupInfo = {
        group_code: dataid
    };
    $.ajax({
        url: '../../ashx/user/right/rightGroupHandler.ashx?action=del',
        data: del_RightGroupInfo,
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

    $('#group_type').combobox({
        valueField: 'id',
        textField: 'text',
        data: rightgrouptype
    });
    
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