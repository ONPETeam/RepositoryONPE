
    $(document).ready(function () {
        $('#dg').datagrid({
            url: '../../ashx/plc/ahplcXitong.ashx?action=grid',
            method: 'post',
            loadMsg: "正在努力加载数据，请稍后...",
            pagination: true, //分页控件
            remoteSort: true,
            pagePosition: 'bottom', //分页控件位置
            rownumbers: true,
            singleSelect: true,
            onClickCell: onClickCell,
            onEndEdit: onEndEdit,
            fit: true,
            striped:true,
            columns: [[
                { field: 'dIntNoteID', title: '系统ID', width: 60, align: 'left',hidden:true },
                { field: 'dVchPointType', title: '系统名称', width: 150, align: 'center', editor: 'textbox' },
                { field: 'dVchRemark', title: '区域名称', width: 120, align: 'right',hidden:true},
                { field: 'dIntSjNoteID', title: '区域', width: 120, align: 'right', formatter: function (value, row) {
                    return row.dVchRemark;
                }, editor: { type: 'combobox',
                    options: {
                        valueField: 'dIntAreaID',
                        textField: 'dVchArea',
                        method: 'get',
                        url: '../../ashx/plc/ahplcXitong.ashx?action=topcombobox',
                        required: true
                    }
                }
            },
                { field: 'dIntPx', title: '排序', width: 120, align: 'right',editor:'numberbox'},
            ]],

            width: 1066,
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
        $('#iArea').combobox({
            url: '../../ashx/plc/ahplcXitong.ashx?action=topcombobox',
            method: 'get',
            required: true,
            valueField: 'dIntAreaID',
            textField: 'dVchArea',
            panelHeight: 'auto'
        });
        $('#iCArea').combobox({
            url: '../../ashx/plc/ahplcXitong.ashx?action=topcombobox',
            method: 'get',
            required: true,
            valueField: 'dIntAreaID',
            textField: 'dVchArea',
            panelHeight: 'auto'
        });


    });
    var url;
    function Add() {
        $('#dlg').dialog('open').dialog('setTitle', '添加窗口');
        $('#iXtName').textbox('setValue', '');
        $('#iArea').combobox('clear');
        url = "../../ashx/plc/ahplcXitong.ashx?action=PTAdd";
    }

    function Edit() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {

            $('#dlg').dialog('open').dialog('setTitle', '编辑窗口');
            $('#fm').form('load', row);
            $('#iXtName').textbox('setValue', row.dVchPointType);
            $('#iArea').combobox('setValue', row.dIntSjNoteID);
            url = "../../ashx/plc/ahplcXitong.ashx?action=PTEdit&vID=" + row.dIntNoteID;
        }
    }

    function Save() {
        $('#fm').form('submit', {
            url: url,
            onSubmit: function (param) {
                param.vXtName = $('#iXtName').textbox('getValue');
                param.vAreaID = $('#iArea').combobox('getValue');
                param.vAreaName = $('#iArea').combobox('getText');
                return $(this).form('validate');
            },
            success: function (result) {
                var result = eval('(' + result + ')');
                //		            var result = eval(result);                 
                //		            if (result.success) {
                if (result == 0) {
                    $('#dlg').dialog('close'); 	// close the dialog
                    $('#dg').datagrid('reload'); // reload the user data
                } else {
                    $.messager.show({
                        title: 'Error',
                        msg: result.msg
                    });
                }
            }
        });
    }

    function Del() {
        
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
    function onClickCell(index, field) {
        if (editIndex != index) {
            url = "../../ashx/plc/ahplcXitong.ashx?action=PTEdit";
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
    function onEndEdit(index, row) {
        var ed = $(this).datagrid('getEditor', {
            index: index,
            field: 'dIntSjNoteID'
        });
        var a = $(ed.target).combobox('getText');
        var vdata = {
            vID: row.dIntNoteID,
            vXtName: row.dVchPointType,
            vAreaID:row.dIntSjNoteID,
            vAreaName: a,
            vPx: row.dIntPx
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
    function append() {

        if (endEditing()) {
            url = "../../ashx/plc/ahplcXitong.ashx?action=PTAdd";
            $('#dg').datagrid('appendRow', { status: 'P' });
            editIndex = $('#dg').datagrid('getRows').length - 1;
            $('#dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
        }
    }
    function removeit() {
        if (editIndex == undefined) { return }
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm('Confirm', '你确定要删除这条记录吗?', function (r) {
                if (r) {
                    url = "../../ashx/plc/ahplcXitong.ashx?action=PTDel";
                    $.post(url, { vID: row.dIntNoteID }, function (result) {
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
    function accept() {
        if (endEditing()) {
            $('#dg').datagrid('acceptChanges');
        }
    }
    function reject() {
        $('#dg').datagrid('rejectChanges');
        editIndex = undefined;
    }

    function doSearch() {
        $('#dg').datagrid('load', {
            vSArea: $('#iCArea').combobox('getValue')
            
        });
    }
