var oldSelectMenuGroupCode;
var action;
var show_set_menu = null;
var show_all_menu = null;
var separatorData = {
    'menu_id': 'fgx000000001',
    'menu_iconcls': 'icon-separator',
    'menu_title': '------------',
    'menu_link': '------------------'
}
$(document).ready(function () {
    LoadComboData();
    $('#dg').datagrid(
    {
        url: '../../ashx/user/right/menuGroupHandler.ashx?action=grid',
        method: 'post',
        striped: true,
        singleSelect: true,
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        remoteSort: true,
        singleSelect: true,
        columns: [[
                { field: 'menugroup_id', title: '菜单组编号', width: 150, align: 'center', hidden: true },
                { field: 'menugroup_class', title: '菜单组类型', width: 120, align: 'center', sortable: true,
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
                { field: 'menugroup_name', title: '菜单组名称', width: 300, align: 'center', sortable: true },
                { field: 'menugroup_sort', title: '显示顺序', width: 150, align: 'center', sortable: true },
                { field: 'font_color', title: '字体颜色', width: 150, align: 'center', hidden: true },
                { field: 'font_size', title: '字体大小', width: 150, align: 'center', hidden: true },
                { field: 'background_color', title: '背景颜色', width: 150, align: 'center', hidden: true }
            ]],
        toolbar:
            [
            {
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
                iconCls: 'icon-no',
                handler: function () {
                    showDel();
                }
            }, {
                text: '设置菜单',
                iconCls: 'icon-ok',
                handler: function () {
                    showMenuSet();
                }
            }],

        onSelect: function (rowIndex, rowData) {
            var $menugroup_layout = $("#menugroup_layout");
            var eastMenu = $menugroup_layout.layout("panel", "east");
            if (oldSelectMenuGroupCode == rowData.menugroup_id) {  //点选的是相同的组就不再请求数据
                if (eastMenu.panel("options").collapsed) {   //判断是否展开
                    $menugroup_layout.layout("expand", "east");
                } else {
                    $menugroup_layout.layout("collapse", "east");
                }
                return;
            }
            oldSelectMenuGroupCode = rowData.menugroup_id;   //赋值
            if (eastMenu.panel("options").collapsed) {   //判断是否展开
                $menugroup_layout.layout("expand", "east");
            }
            eastMenu.panel("setTitle", '菜单组【' + rowData.menugroup_name + "】包含的菜单");
            $("#menugroup_dg").datagrid({       //初始化datagrid
                url: "../../ashx/user/right/munugroupmenuHandler.ashx?action=grid&menugroup_id=" + rowData.menugroup_id,
                striped: true,
                rownumbers: true,
                singleSelect: true,
                idField: 'menu_id',
                loadMsg: "正在努力加载数据，请稍后...",
                columns: [[
                                { field: 'menu_id', title: '菜单编码', hidden: true },
                                { field: 'menu_name', title: '菜单名称', hidden: true },
                                { field: 'menu_title', title: '菜单标题', sortable: true, width: 100, align: 'center' },
                                { field: 'menu_link', title: '链接地址', width: 120, align: 'center' },
                                { field: 'menu_no', title: '分组序号', sortable: true, width: 80 },
                                { field: 'menu_sort', title: '显示顺序', sortable: true, width: 80 }
                             ]]

            });
        }
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
        striped: true,
        modal: true,
        closed: true,
        minimizable: false,
        draggable: true,
        collapsible: true
    });
    $('#showMenuSet').window({
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        closable: true,
        minimizable: true,
        draggable: true,
        collapsible: true
    });

    $('#menu_dg').datagrid({
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: false, //分页控件
        singleSelect: false,
        remoteSort: false,
        fit: true,
        columns: [[
                { field: 'menu_id', title: '菜单编号', hidden: true },
                { field: 'menu_iconcls', title: '图标', width: 40, align: 'center',
                    formatter: function (value, row, index) {
                        if (value != "") {
                            return '<span class="icon-span ' + value + '" style="top:0px;margin:0px" title="' + value + '" ></span>'
                        }
                    }
                },
                { field: 'menu_title', title: '菜单标题', width: 75, align: 'center' },
                { field: 'menu_link', title: '链接地址', width: 120, align: 'center' }
            ]],
        onClickRow: function (rowIndex, rowData) {
            var menu_select = $('#menu_dg').datagrid('getSelections');
            if (menu_select.length > 0) {
                $('#axBtnMoveSelect').linkbutton('enable');
            }
            else {
                $('#axBtnMoveSelect').linkbutton('disable');
            }
        }
    });

    $('#select_dg').datagrid({
        pagination: false, //分页控件
        singleSelect: true,
        remoteSort: false,
        fit: true,
        columns: [[
                { field: 'menu_id', title: '菜单编号', hidden: true },
                { field: 'menu_iconcls', title: '图标', width: 40, align: 'center',
                    formatter: function (value, row, index) {
                        if (value != "") {
                            return '<span class="icon-span ' + value + '" style="top:0px;margin:0px" title="' + value + '" ></span>'
                        }
                    }
                },
                { field: 'menu_title', title: '菜单标题', width: 75, align: 'center' },
                { field: 'menu_link', title: '链接地址', width: 120, align: 'center' }
            ]],
        onLoadSuccess: function () {
            $('#select_dg').datagrid('enableDnd');
        },
        onSelect: function (rowIndex, rowData) {
            if (rowData.menu_id == 'fgx000000001') {
                $('#axBtnRemove').linkbutton('enable');
                $('#axBtnBackSelect').linkbutton('disable');
            }
            else {
                $('#axBtnBackSelect').linkbutton('enable');
                $('#axBtnRemove').linkbutton('disable');
            }
        }
    });
    $('#axBtnRemove').linkbutton('disable');
    $('#axBtnBackSelect').linkbutton('disable');
    $('#axBtnMoveSelect').linkbutton('disable');
});
function LoadComboData() {
    $('#menugroup_class').combobox({
        valueField: 'id',
        textField: 'text',
        data: rightClass
    });
};

//显示添加
function showAdd() {
    action = 'add';
    $('#ShowWin').panel({ title: '添加菜单组' }).window('open');
};

//显示编辑
function showEdit() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm("操作提示", "您确定要执行编辑操作吗？", function (data) {
            if (data) {
                action = 'edit';
                $('#menugroup_id').val(row.menugroup_id);
                $('#menugroup_class').combobox('setValue', row.menugroup_class);
                $('#menugroup_name').textbox('setValue', row.menugroup_name);
                $('#menugroup_sort').textbox('setValue', row.menugroup_sort);
                $('#font_color').textbox('setValue', row.font_color);
                $('#font_size').textbox('setValue', row.font_size);
                $('#background_color').textbox('setValue', row.background_color);
                $('#ShowWin').panel({ title: '编辑菜单组' }).window('open');
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
        $.messager.confirm("操作提示", "您确定要执行编辑操作吗？", function (data) {
            if (data) {
                delMenuGroup(row.menugroup_id);
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
function delMenuGroup(menugroup_id) {
    $.ajax({
        url: '../../ashx/user/right/menuGroupHandler.ashx',
        data:
        {
            "action": "del",
            "menugroup_id": menugroup_id
        },
        type: 'post',
        dataType: 'text',
        success: function (msg) {
            var result = eval('(' + msg + ')');
            if (result.success == true) {
                showMsg("操作提示", "删除成功！", "info")
                $('#dg').datagrid('reload');
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        }
    });
};
//保存操作
function SaveContent() {
    switch (action) {
        case 'add':
            addMenuGroup();
            break;
        case 'edit':
            saveMenuGroup();
            break;
    }
};
function addMenuGroup() {
    if ($('#ff').form('validate')) {
        var menuGroupInfo = {
            menugroup_class: $('#menugroup_class').combobox('getValue'),
            menugroup_name: $('#menugroup_name').textbox('getValue'),
            menugroup_sort: $('#menugroup_sort').textbox('getValue'),
            font_color: $('#font_color').textbox('getValue'),
            font_size: $('#font_size').val(),
            background_color: $('#background_color').val()
        };
        $.ajax({
            url: '../../ashx/user/right/menuGroupHandler.ashx?action=add',
            data: menuGroupInfo,
            type: 'post',
            dataType: 'text',
            success: function (msg) {
                var result = eval('(' + msg + ')');
                if (result.success == true) {
                    showMsg("操作提示", "添加成功！", "info")
                    $('#dg').datagrid('reload');
                    closeWin();
                } else {
                    showMsg("操作提示", result.msg, "error")
                }
            }
        });
    }
};
function saveMenuGroup() {
    if ($('#ff').form('validate')) {
        var menuGroupInfo = {
            menugroup_id: $('#menugroup_id').val(),
            menugroup_class: $('#menugroup_class').combobox('getValue'),
            menugroup_name: $('#menugroup_name').textbox('getValue'),
            menugroup_sort: $('#menugroup_sort').textbox('getValue'),
            font_color: $('#font_color').textbox('getValue'),
            font_size: $('#font_size').val(),
            background_color: $('#background_color').val()
        };
        $.ajax({
            url: '../../ashx/user/right/menuGroupHandler.ashx?action=edit',
            data: menuGroupInfo,
            type: 'post',
            dataType: 'text',
            success: function (msg) {
                var result = eval('(' + msg + ')');
                if (result.success == true) {
                    showMsg("操作提示", "编辑成功！", "info")
                    closeWin();

                } else {
                    showMsg("操作提示", result.msg, "error")
                }
            }
        });
    }
}
function closeWin() {
    $('#ShowWin').window('close');
    $('#dg').datagrid('reload');
};

//显示设置菜单窗口
function showMenuSet() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        LoadMenuSet(row.menugroup_id, row.menugroup_class);
        $("#set_menugroup_id").val(row.menugroup_id);
        $("#set_menu_class").val(row.menugroup_class);
        $('#showMenuSet').window('open').panel({ title: "设置【" + row.menugroup_name + "】菜单" });

    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
////加载菜单设置树
//function LoadMenuTree(tree, menugroup_id, menu_class) {
//    if (tree.data('tree')) {
//        var requestUrl = "../../ashx/user/right/munugroupmenuHandler.ashx?action=menutree&menugroup_id=" + menugroup_id + "&menu_class=" + menu_class;
//        tree.tree({
//            url: requestUrl,
//            method: 'post',
//            cascadeCheck: true,
//            animate: true,
//            checkbox: true,
//            selectOnCheck: true,
//            checkOnSelect: true
//        });
//    }
//};
//加载菜单设置
function LoadMenuSet(menugroup_id, menu_class) {
    var all_menu = null;
    var set_menu = null;

    $.ajax({
        url: '../../ashx/user/right/munugroupmenuHandler.ashx?action=grid&menugroup_id=' + menugroup_id,
        data: {
            page: 1,
            rows: 500
        },
        datatype: 'json',
        type: 'get',
        success: function (data) {
            set_menu = eval('(' + data + ')');  //字符串转json
            show_set_menu = ShowSetMenu(set_menu);
            $('#select_dg').datagrid('loadData', show_set_menu);
            $.ajax({
                url: '../../ashx/user/right/menuHandler.ashx?action=grid&menu_class=' + menu_class,
                data: {
                    page: 1,
                    rows: 500
                },
                datatype: 'json',
                type: 'get',
                success: function (data) {
                    all_menu = eval('(' + data + ')');  //字符串转json
                    show_all_menu = ShowAllMenu(all_menu, set_menu);
                    $('#menu_dg').datagrid('loadData', show_all_menu);
                },
                error: function (xhr, responseData, status) {

                }
            });
        },
        error: function (xhr, responseData, status) {

        }
    });

};
var ShowSetMenu = function (set_menu_data) {
    var sort = 0;
    var insertNum = 0;
    var arrayTemp = { total: set_menu_data.total, rows: [] };
    for (var i = 0; i < set_menu_data.rows.length; i++) {
        if (sort == 0) {
            sort = set_menu_data.rows[i].menu_no;
        }
        else {
            if (sort < set_menu_data.rows[i].menu_no) {
                arrayTemp.total += 1;
                arrayTemp.rows.push(separatorData);
                insertNum += 1;
                sort = set_menu_data.rows[i].menu_no;
            }
            else {

            }
        }
        arrayTemp.rows.push(set_menu_data.rows[i]);
    }
    return arrayTemp;
}
var ShowAllMenu = function (all_menu_data, set_menu_data) {
    var arraytemp = { total: 0, rows: [] };
    arraytemp.rows = array_diff(all_menu_data.rows, set_menu_data.rows);
    arraytemp.total = arraytemp.rows.length;
    return arraytemp;
}
function array_diff(a, b) {
    for (var i = 0; i < b.length; i++) {
        for (var j = 0; j < a.length; j++) {
            if (a[j].menu_id == b[i].menu_id) {
                a.splice(j, 1);
                j = j - 1;
            }
        }
    }
    return a;
}
function MoveAllMenu() {
    var pageDatas = $('#menu_dg').datagrid('getData');
    for (var i = 0; i < pageDatas.rows.length; i++) {
        $('#select_dg').datagrid('appendRow', pageDatas.rows[i]);
    }
    $('#menu_dg').datagrid(
            { data:
                {
                    'total': 0,
                    'rows': []
                }
            }
        );
    $('#select_dg').datagrid('enableDnd');
    $('#axBtnRemove').linkbutton('disable');
    $('#axBtnBackSelect').linkbutton('disable');
    $('#axBtnMoveSelect').linkbutton('disable');
};
function MoveSelectMenu() {
    var selectRows = $('#menu_dg').datagrid('getSelections');
    for (var i = 0; i < selectRows.length; i++) {
        $('#select_dg').datagrid('appendRow', selectRows[i]);
        var selectRowIndex = $('#menu_dg').datagrid('getRowIndex', selectRows[i]);
        $('#menu_dg').datagrid('deleteRow', selectRowIndex);
    }
    $('#select_dg').datagrid('enableDnd');
    $('#axBtnRemove').linkbutton('disable');
    $('#axBtnMoveSelect').linkbutton('disable');
};
function BackSelectMenu() {
    var selectRows = $('#select_dg').datagrid('getSelections');
    for (var i = 0; i < selectRows.length; i++) {
        $('#menu_dg').datagrid('appendRow', selectRows[i]);
        var selectRowIndex = $('#select_dg').datagrid('getRowIndex', selectRows[i]);
        $('#select_dg').datagrid('deleteRow', selectRowIndex);
    }
    $('#select_dg').datagrid('enableDnd');
    $('#axBtnRemove').linkbutton('disable');
    $('#axBtnBackSelect').linkbutton('disable');
};
function BackAllMenu() {
    var pageDatas = $('#select_dg').datagrid('getData');
    for (var i = 0; i < pageDatas.rows.length; i++) {
        var select_menu_id = pageDatas.rows[i].menu_id
        if (pageDatas.rows[i].menu_id != null && pageDatas.rows[i].menu_id != 'fgx000000001') {
            $('#menu_dg').datagrid('appendRow', pageDatas.rows[i]);
        }
    }
    $('#select_dg').datagrid(
            { data:
                {
                    'total': 0,
                    'rows': []
                }
            }
        );
    $('#axBtnRemove').linkbutton('disable');
    $('#axBtnBackSelect').linkbutton('disable');
};
function AddSeparate() {
    $('#select_dg').datagrid('appendRow', separatorData);
    $('#select_dg').datagrid('enableDnd');
};
function RemoveSeparator() {
    var selectRow = $('#select_dg').datagrid('getSelected');
    var selectRowIndex = $('#select_dg').datagrid('getRowIndex', selectRow);
    $('#select_dg').datagrid('deleteRow', selectRowIndex);
    $('#axBtnRemove').linkbutton('disable');
};
//还原菜单设置
function RestoreMenu() {
    LoadMenuSet($("#set_menugroup_id").val(),$("#set_menu_class").val());
    $('#axBtnRemove').linkbutton('disable');
    $('#axBtnBackSelect').linkbutton('disable');
    $('#axBtnMoveSelect').linkbutton('disable');
};
//保存菜单设置
function SaveMenuSet() {
    var selectData = $('#select_dg').datagrid('getData');
    var menuSelected = [];
    var menuNo = 1;
    var menuSort = 1;
    for (var i = 0; i < selectData.rows.length; i++) {
        if (selectData.rows[i].menu_id.toString() != "fgx000000001") {
            menuSelected.push({ "menu_id": selectData.rows[i].menu_id.toString(), "menu_no": menuNo, "menu_sort": menuSort });
            menuSort += 1;
        }
        else {
            menuNo += 1;
            menuSort = 1;
        }
    }
    var menuSelectedString = JSON.stringify(menuSelected);
    var menuSetInfo = {
        menugroup_id: $("#set_menugroup_id").val(),
        menu_select: menuSelectedString
    };
    $.ajax({
        url: '../../ashx/user/right/munugroupmenuHandler.ashx?action=setmenu',
        data: menuSetInfo,
        type: 'post',
        datatype: 'json',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success == "true") {
                closeMenuSetWin();
                $('#dg').datagrid('reload');
                showMsg("操作提示", "编辑成功！", "info");
                $('#menugroup_dg').datagrid('reload');
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        eror: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};
//关闭设置菜单窗口
function closeMenuSetWin() {
    $('#showMenuSet').window('close');
    $('#menu_dg').datagrid({ data: null });
    $('#select_dg').datagrid({ data: null });
    show_all_menu = null;
    show_set_menu = null;
};

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

    var selectBgColor = $('#background_color').textbox('getValue');
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