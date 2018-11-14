$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/plc/ahplcXitong.ashx?action=AreaGrid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        remoteSort: true,
        pagePosition: 'bottom', //分页控件位置
        rownumbers: true,
        singleSelect: true,
        fit: true,
        striped: true,
        onClickCell: onClickCell,
        onEndEdit: onEndEdit,
        columns: [[
                { field: 'dIntAreaID', title: '区域ID', width: 60, align: 'left', hidden: true },
                { field: 'dVchArea', title: '区域名称', width: 150, align: 'center', editor: 'textbox' },
                { field: 'dIntSJAreaID', title: '上级区域ID', width: 120, align: 'right', hidden: true }
            ]],

//        width: 1066,
        //            rowStyler: function (index, row) { if (index % 2 == 0) { return 'background-color:#ccccff;'; } },
        //striped: true, pagination: true, rownumbers: true, singleSelect: true, pageNumber: 1, pageSize: 8, pageList: [1, 2, 4, 8, 16, 32], showFooter: true,
        toolbar: '#tb'


    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 10, //每页显示的记录条数，默认为10 
        pageList: [10, 20, 30], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });


});
var url;
function Del() {
    var row = $('#dg').datagrid('getSelected');

    if (row) {
        $.messager.confirm('Confirm', '你确定要删除这条记录吗?', function (r) {
            if (r) {
                url = "../../ashx/plc/ahplcXitong.ashx?action=AreaDel";
                $.post(url, { vID: row.dIntAreaID }, function (result) {
                    if (result == "成功") {
                        $('#dg').datagrid('reload'); // reload the user data
                    } else {
                        $.messager.show({	// show error message
                            title: 'Error',
                            msg: result.msg
                        });
                    }
                }, 'text');
            }
        });
    }
}
var editIndex = undefined;

function endEditing() {
    if (editIndex == undefined) { return true }
    if ($('#dg').datagrid('validateRow', editIndex)) {
        $('#dg').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
    } else {
        return false;
    }
}
//点击单元格
function onClickCell(index, field) {
    if (editIndex != index) {
        url = "../../ashx/plc/ahplcXitong.ashx?action=AreaEdit";
        if (endEditing()) {
            $('#dg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
            var ed = $('#dg').datagrid('getEditor', { index: index, field: field });
            if (ed) {
                ($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
            }
            editIndex = index;
        } else {
            setTimeout(function () {
                $('#dg').datagrid('selectRow', editIndex);
            }, 0);
        }
    }
}
//结束编辑时触发，在保存之后
function onEndEdit(index, row) {
    var ed = $(this).datagrid('getEditor', {
        index: index,
        field: 'dIntAreaID'
    });

    var vdata = {
        vID: row.dIntAreaID,
        vQyName: row.dVchArea
    }
    $.ajax({
        type: 'post',
        url: url,
        data: vdata,
        dataType: "text",
        success: function (msg) {
            if (msg == "成功") {
                //                    parent.$.messager.alert("操作提示", "保存成功", "info");
                $('#dg').datagrid('reload');

            } else {
                $.messager.show({
                    title: 'Error',
                    msg: msg
                });
            }
        }
    });
    //        row.productname = $(ed.target).combobox('getText');
}
//添加
function append() {

    if (endEditing()) {
        url = "../../ashx/plc/ahplcXitong.ashx?action=AreaAdd";
        $('#dg').datagrid('appendRow', { status: 'P' });
        editIndex = $('#dg').datagrid('getRows').length - 1;
        $('#dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
    }
}
//删除
function removeit() {
    if (editIndex == undefined) { return }
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm('Confirm', '你确定要删除这条记录吗?', function (r) {
            if (r) {
                url = "../../ashx/plc/ahplcXitong.ashx?action=AreaDel";
                $.post(url, { vID: row.dIntAreaID }, function (result) {
                    if (result == "成功") {
                        $('#dg').datagrid('cancelEdit', editIndex)
					        .datagrid('deleteRow', editIndex);
                        editIndex = undefined;
                        $('#dg').datagrid('reload'); // reload the user data
                    } else {
                        $.messager.show({	// show error message
                            title: 'Error',
                            msg: result.msg
                        });
                    }
                }, 'text');
            }
        });
    }
   
}
//保存
function accept() {
    if (endEditing()) {
        $('#dg').datagrid('acceptChanges');
    }
}
//撤销
function reject() {
    $('#dg').datagrid('rejectChanges');
    editIndex = undefined;
}
//    function getChanges() {
//        var rows = $('#dg').datagrid('getChanges');
//        alert(rows.length + ' rows are changed!');
//    }