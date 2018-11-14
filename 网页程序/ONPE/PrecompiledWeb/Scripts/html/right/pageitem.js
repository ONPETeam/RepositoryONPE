var selRow;
var action;
$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/user/right/pageitemHandler.ashx?action=grid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pageSize: 20,
        pagePosition: 'bottom', //分页控件位置
        singleSelect: true,
        rownumbers: true,
        remoteSort: false,
        columns: [[
						{ field: 'item_id', title: '项目编号', width: 100, align: 'center', hidden: true },
						{ field: 'item_name', title: '项目名称', width: 100, align: 'center' },
						{ field: 'item_class', title: '项目类型', width: 100, align: 'center',
						    formatter: function (value, row, index) {
						        if (value != "") {
						            for (var i = 0; i < pageItemClass.length; i++) {
						                var item = pageItemClass[i]
						                if (value == item['id']) {
						                    return item['text'];
						                }
						            }
						            return '未定义类型';
						        }
						    }
                        },
						{ field: 'item_parent', title: '上级项目', width: 100, align: 'center', hidden: true },
                        { field: 'item_title', title: '项目标题', width: 100, align: 'center', sortable: true },
						{ field: 'item_code', title: '编码', width: 100, align: 'center', sortable: true },
						{ field: 'item_icon', title: '图标', width: 100, align: 'center' },
						{ field: 'item_iconalign', title: '图标对齐方式', width: 100, align: 'center', hidden: true },
						{ field: 'item_iconsize', title: '图标大小', width: 100, align: 'center', hidden: true },
						{ field: 'add_time', title: '添加时间', width: 100, align: 'center', sortable: true },
						{ field: 'item_remark', title: '备注说明', width: 100, align: 'center', hidden: true }
            ]],
        toolbar: [
            {
                text: '查看详细',
                iconCls: 'icon-info',
                handler: function () {
                    showData();
                }
            }, '-', {
                text: '新增记录',
                iconCls: 'icon-add',
                handler: function () {
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
            },
            '-', {
                text: '菜单标题: <input id="search_item_title">'
            },
            {
                text: '菜单名: <input id="search_item_name">'
            },
        //{......
        //    text: '要搜索列的显示名: <input id="要搜索的列名" class="easyui-textbox">'....
        //},.....
            {
            text: '搜索',
            iconCls: 'icon-search',
            handler: function () {
                doSearch();
            }
        }]
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
});
//执行搜索
function doSearch() {
    $('#dg').datagrid('load', {
        item_title: $('#search_item_title').textbox('getValue'),
        item_name: $('#search_item_name').textbox('getValue')
    });
};
//显示详细
function showData() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        loadCombo();

        $('#item_id').val(row.item_id);
        $('#item_name').textbox('setValue', row.item_name);
        $('#item_code').textbox('setValue', row.item_code);
        $('#item_title').textbox('setValue', row.item_title);
        $('#item_icon').textbox('setValue', row.item_icon);
        $('#item_iconalign').combobox('setValue', row.item_iconalign);
        $('#item_iconsize').combobox('setValue', row.item_iconsize);
        $('#item_class').combobox('setValue', row.item_class);
        $('#item_parent').combobox('setValue', row.item_parent);
        $('#item_remark').textbox('setValue', row.item_remark);

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
                $('#item_id').val(row.item_id);
                $('#item_name').textbox('setValue', row.item_name);
                $('#item_code').textbox('setValue', row.item_code);
                $('#item_title').textbox('setValue', row.item_title);
                $('#item_icon').textbox('setValue', row.item_icon);
                $('#item_iconalign').combobox('setValue', row.item_iconalign);
                $('#item_iconsize').combobox('setValue', row.item_iconsize);
                $('#item_class').combobox('setValue', row.item_class);
                $('#item_parent').combobox('setValue', row.item_parent);
                $('#item_remark').textbox('setValue', row.item_remark);

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
                delItem(row.item_id);
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
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
            addItem();
            break;
        case 'edit':
            editItem();
            break;
    }
};

//添加操作
function addItem() {
    var add_iteminfo = {
        item_name: $('#item_name').textbox('getValue'),
        item_code: $('#item_code').textbox('getValue'),
        item_title: $('#item_title').textbox('getValue'),
        item_icon: $('#item_icon').textbox('getValue'),
        item_iconalign: $('#item_iconalign').combobox('getValue'),
        item_iconsize: $('#item_iconsize').combobox('getValue'),
        item_class: $('#item_class').combobox('getValue'),
        item_parent: $('#item_parent').combobox('getValue'),
        item_remark: $('#item_remark').textbox('getValue')
    };
    $.ajax({
        url: '../../ashx/user/right/pageitemHandler.ashx?action=add',
        data: add_iteminfo,
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
function editItem() {
    var edit_iteminfo = {
        item_id: $('#item_id').val(),
        item_name: $('#item_name').textbox('getValue'),
        item_code: $('#item_code').textbox('getValue'),
        item_title: $('#item_title').textbox('getValue'),
        item_icon: $('#item_icon').textbox('getValue'),
        item_iconalign: $('#item_iconalign').combobox('getValue'),
        item_iconsize: $('#item_iconsize').combobox('getValue'),
        item_class: $('#item_class').combobox('getValue'),
        item_parent: $('#item_parent').combobox('getValue'),
        item_remark: $('#item_remark').textbox('getValue')
    };
    $.ajax({
        url: '../../ashx/user/right/pageitemHandler.ashx?action=edit',
        data: edit_iteminfo,
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
function delItem(dataid) {
    var del_iteminfo = {
        item_id: dataid
    };
    $.ajax({
        url: '../../ashx/user/right/pageitemHandler.ashx?action=del',
        data: del_iteminfo,
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
    $('#item_class').combobox({
        valueField: 'id',
        textField: 'text',
        data: pageItemClass
    });
    $('#item_parent').combobox({
        url:'../../ashx/user/right/pageitemHandler.ashx?action=combo',
        valueField: 'id',
        textField: 'text'
    });
    $('#item_iconalign').combobox({
        valueField: 'id',
        textField: 'text',
        data: iconAlign
    });

    $('#item_iconsize').combobox({
        valueField: 'id',
        textField: 'text',
        data: iconSize
    });
};