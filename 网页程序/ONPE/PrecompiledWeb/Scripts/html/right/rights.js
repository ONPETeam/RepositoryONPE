var selRow;
var action;


$(document).ready(function () {
    $('#dg').treegrid({
        url: '../../ashx/user/right/rightsHandler.ashx?action=grid',
        method: 'post',
//        url: '../../Scripts/1.json',
//        method: 'get',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pageSize: 20,
        pagePosition: 'bottom', //分页控件位置
        singleSelect: true,
        rownumbers: true,
        remoteSort: false,
        fit: true,
        idField: 'right_code',
        treeField: 'right_name',
        columns: [[
					{ field: 'right_code', title: '权限编号', width: 100, align: 'center',hidden:true },
					{ field: 'right_name', title: '权限名称', width: 100, align: 'center' },
                    { field: 'right_menugroup', title: '菜单组编号', width: 100, align: 'center', hidden: true },
                    { field: 'right_menu', title: '菜单编号', width: 100, align: 'center', hidden: true },
                    { field: 'right_item', title: '项目编号', width: 100, align: 'center', hidden: true },
                    { field: 'right_menugroup_name', title: '菜单组', width: 100, align: 'center', sortable: true,
                        formatter: function (value, row, index) {
                            if (!value) {
                                return "未设定";
                            } else {
                                return value;
                            }
                        }
                    },
                    { field: 'right_menu_title', title: '菜单', width: 100, align: 'center', sortable: true,
                        formatter: function (value, row, index) {
                            if (!value) {
                                return "未设定";
                            } else {
                                return value;
                            }
                        }
                    },
                    { field: 'right_item_title', title: '功能项', width: 100, align: 'center', sortable: true,
                        formatter: function (value, row, index) {
                            if (row.right_item == "PCQXXM9999990001") {
                                return "浏览";
                            } else {
                                return "";
                            }
                        }
                    },
					{ field: 'right_class', title: '权限类型', width: 100, align: 'center', sortable: true,
					    formatter: function (value, row, index) {
					        if (value != "") {
					            for (var i = 0; i < rightClass.length; i++) {
					                var item = rightClass[i]
					                if (value == item['id']) {
					                    return item['text'];
					                }
					            }
					            return '未定义类型';
					        }
					    }
					},
				{ field: 'right_remark', title: '备注说明', width: 100, align: 'center', sortable: true }
            ]],

        toolbar: [
            {
                text: '详细',
                iconCls: 'icon-info',
                handler: function () {
                    showData();
                }
            }, '-', {
                text: '新增',
                iconCls: 'icon-add',
                handler: function () {
                    showAdd();
                }
            }, {
                text: '修改',
                iconCls: 'icon-cut',
                handler: function () {
                    showEdit();
                }
            }, {
                text: '删除',
                iconCls: 'icon-no',
                handler: function () {
                    showDel();
                }
            }, {
                text: '设定功能',
                iconCls: 'icon-ok',
                handler: function () {
                    showFunctionSet();
                }
            }
        ]
    });
    var p = $('#dg').treegrid('getPager');
    $(p).pagination({
        pageSize: 20, //每页显示的记录条数，默认为20 
        pageList: [10, 20, 50], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    $('#showWin').window({
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        closable: false,
        minimizable: false,
        collapsible: true
    });
    $('#ShowSetFunction').window({
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        closable: false,
        minimizable: false,
        collapsible: true
    });

});
//显示详细
function showData() {
    var row = $('#dg').treegrid('getSelected');
    if (row) {
        loadCombo();

        $('#right_code').val(row.right_code);
        $('#right_name').textbox('setValue', row.right_name);
        $('#right_class').combobox('setValue', row.right_class);
        $('#right_remark').textbox('setValue', row.right_remark);

        $('#showWin').window('open').panel({ title: '查看权限' });
        document.getElementById('ss').style.display = 'none';
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
//显示添加
function showAdd() {
    action = "add";
    loadCombo();
    $('#showWin').window('open').panel({ title: '添加权限' });
    document.getElementById('ss').style.display = '';
};
//显示编辑
function showEdit() {
    action = "edit";
    var row = $('#dg').treegrid('getSelected');
    if (row) {
        loadCombo();

        $('#right_code').val(row.right_code);
        $('#right_name').textbox('setValue', row.right_name);
        $('#right_class').combobox('setValue', row.right_class);
        $('#right_remark').textbox('setValue', row.right_remark);
        $('#showWin').window('open').panel({ title: '编辑权限' });
        document.getElementById('ss').style.display = '';
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
//显示删除
function showDel() {
    var row = $('#dg').treegrid('getSelected');
    if (row) {
        $.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
            if (data) {
                //删除操作
                delData(row.right_code);
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};

//关闭弹出框
function closeWin() {
    $('#ttBind').form('clear');
    $('#showWin').window('close');
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
    var add_datainfo = {
        right_name: $('#right_name').textbox('getValue'),
        right_class: $('#right_class').combobox('getValue'),

        right_remark: $('#right_remark').textbox('getValue')
    };
    $.ajax({
        url: '../../ashx/user/right/rightsHandler.ashx?action=add',
        data: add_datainfo,
        type: 'post',
        datatype: 'json',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == true) {
                $('#tt').form('clear');
                $('#dg').treegrid('reload');
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
    var edit_datainfo = {
        right_code: $('#right_code').val(),
        right_name: $('#right_name').textbox('getValue'),
        right_class: $('#right_class').combobox('getValue'),

        right_remark: $('#right_remark').textbox('getValue')
    };
    $.ajax({
        url: '../../ashx/user/right/rightsHandler.ashx?action=edit',
        data: edit_datainfo,
        type: 'post',
        datatype: 'json',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == true) {
                closeWin();
                $('#dg').treegrid('reload');
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
    var del_data_info = {
        right_code: dataid
    };
    $.ajax({
        url: '../../ashx/user/right/rightsHandler.ashx?action=del',
        data: del_data_info,
        type: 'post',
        datatype: 'json',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == true) {
                $('#dg').treegrid('reload');
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

//控件初始化
var loadCombo = function () {
    $('#right_class').combobox({
        valueField: 'id',
        textField: 'text',
        data: rightClass
    });
};

//显示设置功能对话框
function showFunctionSet() {
    var row = $('#dg').treegrid('getSelected');
    if (row) {
        $('#set_right_code').val(row.right_code);
        loadFunctionSetCombo(row.right_class);

        $('#ShowSetFunction').window('open').panel({ title: '【' + row.right_name + '】绑定功能' });
        if (row.right_menugroup) {
            $('#menugroup_id').combobox('select', row.right_menugroup);
            if (row.right_menu) {
                $('#menu_id').combobox('select', row.right_menu);
            }
        }
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};

//加载设置功能对话框中的下拉框
function loadFunctionSetCombo(menuClass) {
    $('#menugroup_id').combobox({
        url: '../../ashx/user/right/menugroupHandler.ashx?action=combo&menugroup_class=' + menuClass,
        animate: true,
        valueField: 'id',
        textField: 'text',
        onSelect: function () {
            var select_menugroup_id = $("#menugroup_id").combobox('getValue')
            $('#menu_id').combobox({
                url: '../../ashx/user/right/menuhandler.ashx?action=combo&menugroup_id=' + select_menugroup_id + '&menu_class=' + menuClass,
                valueField: 'id',
                textField: 'text'
            });
        }
    });
    $('#rightitem_id').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{
            "id": "PCQXXM9999990001",
            "text": "浏览",
            "selected": true
        }]
    });
};

//保存功能设置
function SaveFunctionSet() {
    var functionSet = {
        right_code: $('#set_right_code').val(),
        right_menugroup: $('#menugroup_id').combobox('getValue'),
        right_menu: $('#menu_id').combobox('getValue'),
        right_item: $('#rightitem_id').combobox('getValue')
    };
    $.ajax({
        url: '../../ashx/user/right/rightsHandler.ashx?action=setfunction',
        type: 'post',
        datatype: 'text',
        data: functionSet,
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == true) {
                showMsg("操作提示", "设定功能成功!", "info");
                $('#dg').treegrid('reload');
                closeFunctionSetWin();
            } else {
                showMsg("操作提示", result.msg, "error");
            }
        },
        error: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseData, "error");
        }
    });
};
//关闭设置功能对话框
function closeFunctionSetWin() {
    $('#ShowSetFunction').window('close');
};