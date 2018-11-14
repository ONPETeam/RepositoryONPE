var selRow;
var action;
var table = { 'total': 0, 'rows': [] };
$(document).ready(function () {

    var cssSheet = document.styleSheets[0].cssRules;

    table.total = cssSheet.length;
    for (var i = 0; i < cssSheet.length; i++) {
        var iconInfo = { 'text': '', 'value': '' };
        iconInfo.text = cssSheet[i].selectorText.replace(".", "").toString();
        iconInfo.value = cssSheet[i].selectorText.replace(".", "").toString();
        table.rows.push(iconInfo);
    }
    initTable();
    $('#cc').combo({
        editable: false,
        panelWidth: 'auto',
        panelHeight: 'auto'
    });
    $('#iconSelectPanel').appendTo($('#cc').combo('panel'));
    $('#iconList').delegate('span', 'click', function () {
        var value = $(this).data('icon');
        var title = $(this).attr('title');

        var formatter = '<span class="icon-span ' + value + '" title="' + title + '" ></span>';
        $('#selectedIcon').html(formatter);
        $('#cc').combo('setValue', value).combo('setText', title).combo('hidePanel');
    });

    $('#pp').pagination({
        pageNumber: 1,
        pageSize: 180,
        pageList: [180],
        showPageList: false,
        displayMsg: '',
        onSelectPage: function (pageNumber, pageSize) {
            $(this).pagination('loading');
            $(this).pagination('loaded');
            initTable();
        }
    });
    $('#dg').datagrid({
        url: '../../ashx/user/right/menuHandler.ashx?action=grid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pageSize: 20,
        pagePosition: 'bottom', //分页控件位置
        singleSelect: true,
        rownumbers: true,
        remoteSort: false,
        fit: true,
        frozenColumns: [[
            { field: 'menu_class', title: '菜单组类型', width: 120, align: 'center', sortable: true,
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
            { field: 'menu_title', title: '菜单标题', width: 100, align: 'center', sortable: true }
        ]],
        columns: [[
            { field: 'menu_id', title: '菜单编号', width: 100, align: 'center', hidden: true },
            { field: 'menu_name', title: '菜单名称', width: 100, align: 'center' },
			{ field: 'menu_parent', title: '上级菜单', width: 100, align: 'center', hidden: true },
			{ field: 'menu_code', title: '编码', width: 100, align: 'center', sortable: true },
			{ field: 'menu_link', title: '链接地址', width: 100, align: 'center', hidden: true },
            { field: 'font_color', title: '字体颜色', width: 100, align: 'center', hidden: true },
            { field: 'font_size', title: '字体大小', width: 100, align: 'center', hidden: true },
            { field: 'background_color', title: '背景颜色', width: 100, align: 'center', hidden: true },
            { field: 'menu_link', title: '链接地址', width: 100, align: 'center', hidden: true },
			{ field: 'menu_iconcls', title: '图标', width: 100, align: 'center',
			    formatter: function (value, row, index) {
			        if (value != "") {
			            return '<span class="icon-span ' + value + '" style="top:0px;margin:0px" title="' + value + '" ></span>'
			        }
			    }
			},
			{ field: 'menu_iconalign', title: '图标对齐', width: 100, align: 'center', hidden: true },
			{ field: 'menu_iconsize', title: '图标大小', width: 100, align: 'center', hidden: true },
			{ field: 'add_time', title: '添加时间', width: 140, align: 'center', sortable: true }
            ]]
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

    loadSerachCombo();
});

function initTable() {
    $('#pp').pagination({ total: table.total });
    $('#iconList').html($('#iconTemplate').render(table));
};

//执行搜索
function searchData() {
    $('#dg').datagrid('load', {
        menu_class: $('#search_menu_class').combobox('getValue')
    });
};

//显示详细
function showData() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        loadCombo();

        $('#menu_id').val(row.menu_id);
        $('#menu_class').combobox('setValue', row.menu_class);
        $('#menu_name').textbox('setValue', row.menu_name);
        $('#menu_code').textbox('setValue', row.menu_code);
        $('#menu_title').textbox('setValue', row.menu_title);
        $('#menu_link').textbox('setValue', row.menu_link);

        $('#font_color').textbox('setValue', row.font_color);
        $('#font_size').textbox('setValue', row.font_size);
        $('#background_color').textbox('setValue', row.background_color);

        $('#cc').combo('setValue', row.menu_iconcls).combo('setText', row.menu_iconcls);
        $('#selectedIcon').html('<span class="icon-span ' + row.menu_iconcls + '" title="' + row.menu_iconcls + '" ></span>');
        $('#menu_iconalign').combobox('setValue', row.menu_iconalign);
        $('#menu_iconsize').combobox('setValue', row.menu_iconsize);
        $('#menu_parent').combobox('setValue', row.menu_parent);
        $('#menu_remark').textbox('setValue', row.menu_remark);

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
                $('#menu_id').val(row.menu_id);
                $('#menu_class').combobox('setValue', row.menu_class);
                $('#menu_name').textbox('setValue', row.menu_name);
                $('#menu_code').textbox('setValue', row.menu_code);
                $('#menu_title').textbox('setValue', row.menu_title);
                $('#menu_link').textbox('setValue', row.menu_link);

                $('#font_color').textbox('setValue', row.font_color);
                $('#font_size').textbox('setValue', row.font_size);
                $('#background_color').textbox('setValue', row.background_color);

                $('#cc').combo('setValue', row.menu_iconcls).combo('setText', row.menu_iconcls);
                $('#selectedIcon').html('<span class="icon-span ' + row.menu_iconcls + '" title="' + row.menu_iconcls + '" ></span>');
                $('#menu_iconalign').combobox('setValue', row.menu_iconalign);
                $('#menu_iconsize').combobox('setValue', row.menu_iconsize);
                //$('#menugroup_id').combobox('setValue', row.menugroup_id);
                $('#menu_parent').combobox('setValue', row.menu_parent);

                //$('#menu_no').textbox('setValue', row.menu_no);
                //$('#menu_sort').textbox('setValue', row.menu_sort);
                $('#menu_remark').textbox('setValue', row.menu_remark);
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
                delMenu(row.menu_id);
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
    if ($('#ff').form('validate')) {
        switch (action) {
            case 'add':
                addMenu();
                break;
            case 'edit':
                editMenu();
                break;
        }
    }
};

//添加操作
function addMenu() {
    var add_menuinfo = {
        menu_class: $('#menu_class').combobox('getValue'),
        menu_name: $('#menu_name').textbox('getValue'),
        menu_code: $('#menu_code').textbox('getValue'),
        menu_title: $('#menu_title').textbox('getValue'),
        menu_link: $('#menu_link').textbox('getValue'),

        font_color: $('#font_color').textbox('getValue'),
        font_size: $('#font_size').numberbox('getValue'),
        background_color: $('#background_color').textbox('getValue'),

        menu_iconcls: $('#cc').combo('getValue'),
        menu_iconalign: $('#menu_iconalign').combobox('getValue'),
        menu_iconsize: $('#menu_iconsize').combobox('getValue'),
        //menugroup_id: $('#menugroup_id').combobox('getValue'),
        //menu_parent: $('#menu_parent').combobox('getValue'),

        //menu_no:$('#menu_no').textbox('getValue'),
        //menu_sort:$('#menu_sort').textbox('getValue'),
        menu_remark: $('#menu_remark').textbox('getValue')
    };
    $.ajax({
        url: '../../ashx/user/right/menuHandler.ashx?action=add',
        data: add_menuinfo,
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
function editMenu() {
    var edit_menuinfo = {
        menu_id: $('#menu_id').val(),
        menu_class: $('#menu_class').combobox('getValue'),
        menu_name: $('#menu_name').textbox('getValue'),
        menu_code: $('#menu_code').textbox('getValue'),
        menu_title: $('#menu_title').textbox('getValue'),
        menu_link: $('#menu_link').textbox('getValue'),

        font_color: $('#font_color').textbox('getValue'),
        font_size: $('#font_size').numberbox('getValue'),
        background_color: $('#background_color').textbox('getValue'),

        menu_iconcls: $('#cc').combo('getValue'),
        menu_iconalign: $('#menu_iconalign').combo('getValue'),
        menu_iconsize: $('#menu_iconsize').combo('getValue'),
        //menugroup_id: $('#menugroup_id').combo('getValue'),
        //menu_parent: $('#menu_parent').combo('getValue'),

        //menu_no: $('#menu_no').textbox('getValue'),
        //menu_sort: $('#menu_sort').textbox('getValue'),
        menu_remark: $('#menu_remark').textbox('getValue')
    };
    $.ajax({
        url: '../../ashx/user/right/menuHandler.ashx?action=edit',
        data: edit_menuinfo,
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
function delMenu(dataid) {
    var del_menuinfo = {
        menu_id: dataid
    };
    $.ajax({
        url: '../../ashx/user/right/menuHandler.ashx?action=del',
        data: del_menuinfo,
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
    //    $('#menugroup_id').combobox({
    //        url: '../../ashx/user/right/menugrouphandler.ashx?action=combo',
    //        valueField: 'id',
    //        textField: 'text'
    //    });
    $('#menu_iconalign').combobox({
        valueField: 'id',
        textField: 'text',
        data: iconAlign
    });

    $('#menu_iconsize').combobox({
        valueField: 'id',
        textField: 'text',
        data: iconSize
    });
    $('#menu_class').combobox({
        valueField: 'id',
        textField: 'text',
        data: rightClass
    });
};

var loadSerachCombo = function () {
    $('#search_menu_class').combobox({
        valueField: 'id',
        textField: 'text',
        data: rightClass
    });
}

function ShowFontColorPicker() {
    var selectFontColor = $('#font_color').textbox('getValue');
    
    $('#font_color_picker').colpick({
        layout: 'full',
        color: selectFontColor,
        submitText: "选定",
        onSubmit: function (bsh, hex) {
            $('#font_color').textbox('setValue', hex);
            $('#font_color_picker').colpickHide();
        }
    });
    $('#font_color_picker').colpickSetColor(selectFontColor, true);
};

function ShowBgColorPicker() {
    
    var selectBgColor=$('#background_color').textbox('getValue');
    $('#background_color_picker').colpick({
        layout: 'full',
        color: selectBgColor,
        submitText: "选定",
        onSubmit: function (bsh, hex) {
            $('#background_color').textbox('setValue', hex);
            $('#background_color_picker').colpickHide();
        }
    });
    $('#background_color_picker').colpickSetColor(selectBgColor, true);
};