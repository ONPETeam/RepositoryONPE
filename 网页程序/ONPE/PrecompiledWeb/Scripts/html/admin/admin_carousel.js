var action = "add";
$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/admin/Carousel/carouselHandler.ashx?action=grid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        remoteSort: false,
        singleSelect: true,
        rownumbers: true,
        fit: true,
        striped: true, //行背景交换
        columns: [[
            { field: 'data_id', title: '图片编号', hidden: true },
            { field: 'image_name', title: '图片名称', width: 100 },
            { field: 'image_address', title: '图片地址', width: 100,
                formatter: function (value, row, index) {
                    return '<a href="../..' + value + '">预览图片</a>';
                }
            },
            { field: 'image_state', title: '图片状态', width: 100,
                formatter: function (value, row, index) {
                    if (value == "1") {
                        return "启用";
                    }
                    else {
                        return "停用";
                    }
                }
            }
        ]]
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 10, //每页显示的记录条数，默认为10 
        pageList: [5, 10, 15], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    $('#win_carousel_manage').window({
        title: '',
        striped: true,
        singleSelect: true,
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
})
function AddImage() {
    action = "add";
    $('#win_carousel_manage').window('open').panel({ title: '添加新轮播图' });
};
function SaveContent() {
    $.messager.progress();
    $('#ff').form('submit', {
        url: '../../ashx/admin/Carousel/carouselHandler.ashx',
        onSubmit: function (param) {
            var isValid = $(this).form('validate');
            if (!isValid) {
                $.messager.progress('close'); // hide progress bar while the form is invalid
            }
            param.action = action;
            param.data_id = $('#data_id').val();
            param.image_state = $('#image_state').switchbutton('options').checked == true ? 1 : 0;
            return isValid;
        },
        success: function (data) {
            $.messager.progress('close');
            var result = eval('(' + data + ')');
            if (result.success == true) {
                $('#dg').datagrid('reload');
                $('#ff').form("clear");
                showMsg("操作提示", result.msg, "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        error: function (xhr, responseData, status) {
            $.messager.progress('close');
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
}
function CloseWin() {
    $('#win_carousel_manage').window('close');
};

function EditImage() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm("操作提示", "您确定要执行编辑操作吗？", function (data) {
            $('#data_id').val(row.data_id);
            $('#image_state').switchbutton(row.image_state == 1 ? 'check' : 'uncheck');
            action = "edit";
            $('#win_carousel_manage').window('open').panel({ title: '替换轮播图' });
        });
    }
    else {
        showMsg("操作提示", "您未选择任何数据行", "error")
    }
}
function DelImage() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
            if (data) {
                var del_carousel_data = { data_id: row.data_id };
                $.ajax({
                    url: '../../ashx/admin/Carousel/carouselHandler.ashx?action=del',
                    data: del_carousel_data,
                    type: 'post',
                    datatype: 'json',
                    success: function (data) {
                        var result = eval('(' + data + ')');
                        if (result.success == true) {
                            CloseWin();
                            $('#dg').datagrid('reload');
                            showMsg("操作提示", "删除轮播图成功！", "info")
                        } else {
                            showMsg("操作提示", result.msg, "error")
                        }
                    },
                    error: function (xhr, responseData, status) {
                        showMsg("操作提示", xhr.responseText, "error")
                    }
                });
            }
        });
    }
    else {
        showMsg("操作提示", "您未选择任何数据行", "error")
    }
}
function UpdateState() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        var mStrContext = "";
        if (row.image_state == 1) {
            mStrContext = "停用";
        }
        else {
            mStrContext = "启用";
        }
        $.messager.confirm("操作提示", "您确定要" + mStrContext + "该轮播图片吗？", function (data) {
            if (data) {
                var update_carousel_data = {
                    data_id: row.data_id,
                    image_state: row.image_state.toString() == "1" ? 0 : 1
                }
                $.messager.progress();
                $.ajax({
                    url: '../../ashx/admin/Carousel/carouselHandler.ashx?action=state',
                    data: update_carousel_data,
                    type: 'post',
                    datatype: 'json',
                    success: function (data) {
                        $.messager.progress('close');
                        var result = eval('(' + data + ')');
                        if (result.success.toString() == "true") {
                            $('#dg').datagrid('reload');
                            showMsg("操作提示", mStrContext + "轮播图成功！", "info")
                        } else {
                            showMsg("操作提示", result.msg, "error")
                        }
                    },
                    error: function (xhr, responseData, status) {
                        $.messager.progress('close');
                        showMsg("操作提示", xhr.responseText, "ok")
                    }
                })
            }
        });
    }
    else {
        showMsg("操作提示", "您未选择任何数据行", "error")
    }
}