
    var equid_code;
    var equid_name;
    $(document).ready(function () {
//        var var_equidid = $(parent.frames['leftFrame1'].document).find('#equidid');
        var var_equidid = parent.$('#leftFrame1').contents().find('#equidid');
        var var_equidName = parent.$('#leftFrame1').contents().find('#equidname');
//        var var_equidName = $(parent.frames['leftFrame1'].document).find('#equidname');
        equid_code = var_equidid.val();
        equid_name = var_equidName.val();
        
        //绑定
        $('#dgbd').datagrid({
            idField: 'dIntDataID',
            view: fileview,
            url: '../../ashx/plc/ahplcddz.ashx?action=grid',
            method: 'post',
            loadMsg: "正在努力加载数据，请稍后...",
            pagination: true, //分页控件
            remoteSort: true,
            pagePosition: 'bottom', //分页控件位置
            rownumbers: true,
            singleSelect: false,
            selectOnCheck: true,
            checkOnSelect: true,
            onLoadSuccess: function (data) {
                if (data) {
                    $.each(data.rows, function (index, item) {
                        if (item.checked) {
                            $('#dgbd').datagrid('checkRow', index);
                        }
                    });
                }
            },
            //            fit:true,
            //plc绑定需要用到

            columns: [[
                { field: 'ck', checkbox: true },
                { field: 'dIntDataID', title: '点地址ID', width: 40, align: 'right' },
                { field: 'dVchAddress', title: '点地址', width: 60, align: 'right', sortable: true },
                { field: 'dVchAdressName', title: '简称', width: 100, align: 'right' },
                { field: 'dVchDescription', title: '描述', width: 200, align: 'right' },
                { field: 'dIntGongType', title: '功能分类', width: 60, align: 'right', formatter: function (value, row, index) {
                    if (row.dIntGongType == 3) {
                        return "开关量"
                    }
                    if (row.dIntGongType == 1) {
                        return "模拟量"
                    }

                }
                },

                { field: 'dVchRemark', title: 'PLC名称', width: 250, align: 'right' },
                { field: 'dVchPLCXitongName', title: '工艺系统', width: 100, align: 'right' },

            ]],

            //            rowStyler: function (index, row) { if (index % 2 == 0) { return 'background-color:#ccccff;'; } },
            //striped: true, pagination: true, rownumbers: true, singleSelect: true, pageNumber: 1, pageSize: 8, pageList: [1, 2, 4, 8, 16, 32], showFooter: true,
            toolbar: '#tb'
//            [{
//                text: 'plc <input id="splc" />'
//            },'-',{
//                text: '地址查找 <input id="sddzbd"/>'

//            }, '-', {
//                text: '查询',
//                iconCls: 'icon-search',
//                handler: function () { doSearchbd() }
//            }]

        });

        var p = $('#dgbd').datagrid('getPager');
        $(p).pagination({
            pageSize: 10, //每页显示的记录条数，默认为10 
            pageList: [10, 20, 30], //可以设置每页记录条数的列表 
            beforePageText: '第', //页数文本框前显示的汉字 
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
        });
        $('#dgbd').datagrid('hideColumn', 'dIntDataID')
        
    
    });
    //全选记忆
    var fileview = $.extend({}, $.fn.datagrid.defaults.view, { onAfterRender: function (target) { ischeckItem(); } });
    var checkedItems = [];
    function ischeckItem() {
        for (var i = 0; i < checkedItems.length; i++) {
            $('#dg').datagrid('selectRecord', checkedItems[i]); //根据id选中行 
        }
    };

    function findCheckedItem(ID) {
        for (var i = 0; i < checkedItems.length; i++) {
            if (checkedItems[i] == ID) return i;
        }
        return -1;
    }

    function addcheckItem() {
        var row = $('#dg').datagrid('getChecked');
        for (var i = 0; i < row.length; i++) {
            if (findCheckedItem(row[i].id) == -1) {
                checkedItems.push(row[i].id);
            }
        }
    }
    function removeAllItem(rows) {

        for (var i = 0; i < rows.length; i++) {
            var k = findCheckedItem(rows[i].id);
            if (k != -1) {
                checkedItems.splice(i, 1);
            }
        }
    }
    function removeSingleItem(rowIndex, rowData) {
        var k = findCheckedItem(rowData.id);
        if (k != -1) {
            checkedItems.splice(k, 1);
        }
    }

    function getck() {
        //    $.ajax({
        //        type: "post",

        //        //    datatype:"json",traditional:true,
        //        data: { "aa": checkedItems },
        //        datatype: "json",
        //        traditional: true, //这个设置为true，data:{"steps":["qwe","asd","zxc"]}会转换成steps=qwe&steps=asd&...
        //        
        //        url: '../../ashx/plc/ahplcddzOp.ashx'
        //    });
        var checkedItems = $('#dgbd').datagrid('getChecked');
        var names = [];
        $.each(checkedItems, function (index, item) {
            names.push(item.dIntDataID);
        });
        $("#abc").val(names);
        url = '../../ashx/plc/ahplcddzOp.ashx?type=ck&ckv=' + names + '&eqd=' + $('#ddzRef').val();

        $('#fmbd').form('submit', {
            url: url,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = eval('(' + result + ')');
                //	var result = eval(result);                 
                //	if (result.success) {
                if (result == 0) {
                    $('#dlgbd').window('close'); 	// close the window
                    $('#dg').datagrid('reload'); // reload the user data
                }
                else if (result == -1) {
                    $.messager.show({
                        title: 'Error',
                        msg: '请在设备树中选择一个设备进行绑定!'
                    });
                }
                else if (result == -2) {
                    $.messager.show({
                        title: 'Error',
                        msg: '请勾选需要绑定的plc点地址!'
                    });
                }
                else {
                    $.messager.show({
                        title: 'Error',
                        msg: '请选择要绑定的设备和plc点地址！'
                    });
                }
            }
        });
    }
    //全选记忆end

    var url;
    
    function doSearch() {
        $('#dg').datagrid('load', {
            plc: $('#splc').combobox('getValue'),
            ddz: $('#sddz').val()
        });
    }
    function doSearchbd() {
        $('#dgbd').datagrid('load', {
            //            plcbd: $('#splcbd').combobox('getValue'),
            ddz: $('#sddzbd').val(),
            plc:$('#splc').combobox('getValue')
        });
    }

    function dotanchu() {
        if ($("#abc").val() != "") {

//            $('#dlgbd').datagrid('uncheckAll');
//            $("#abc").val("");
        }
        var title = $('#idsb').val();
        $('#dlgbd').dialog('open').dialog('setTitle', title);

        $('#dgbd').datagrid('clearChecked');
        $('#splc').combobox({
            url: '../../ashx/plc/plcmanager.ashx?action=combox',
            method: 'get',
            valueField: 'dIntPLCID',
            textField: 'dVchPLCName',
            groupField: 'dVchPLCXitongName'

        });
    };

    function SetValueAndSearch() {
        $('#dg').datagrid({
            //            idField: 'dIntDataID',
            //            view: fileview , 

            url: '../../ashx/plc/ahplcAndSb.ashx?action=gridbd',
            queryParams: {
                eqd: $('#ddzRef').val(),
                eqdn: $('#ddzname').val()
            },
            method: 'post',
            loadMsg: "正在努力加载数据，请稍后...",
            pagination: true, //分页控件
            remoteSort: true,
            pagePosition: 'bottom', //分页控件位置
            rownumbers: true,
            singleSelect: true,
            // selectOnCheck: true,
            // checkOnSelect: true,
            //            onLoadSuccess:function(data){
            //                if(data){
            //                    $.each(data.rows,function(index,item){
            //                        if(item.checked){
            //                            $('#dg').datagrid('checkRow',index);
            //                        }
            //                    });
            //                }
            //            },
            //            fit:true,

            columns: [[
            //                { field: 'ck',checkbox:true},
                {field: 'dIntID', title: '数据ID', width: 50, align: 'right',hidden:true },
                {field: 'dIntDataID', title: '点地址ID', width: 50, align: 'right' },
                { field: 'dVchAddress', title: '点地址', width: 150, align: 'right', sortable: true },
                { field: 'dVchAdressName', title: '简称', width: 150, align: 'right' },
                { field: 'dVchDescription', title: '描述', width: 250, align: 'right' },
                { field: 'dVchDataValue', title: '当前值', width: 100, align: 'right' },
                { field: 'dIntBaojingType', title: '状态', width: 100, align: 'right', styler: cellStyler, formatter: function (value, row, index) {
                    if (value == 2) {
                        return "异常"
                    }
                    else {
                        return "正常"
                    }
                }
                },

            ]],


            //rowStyler: function (index, row) { if (index % 2 == 0) { return 'background-color:#ccccff;'; } },
            //striped: true, pagination: true, rownumbers: true, singleSelect: true, pageNumber: 1, pageSize: 8, pageList: [1, 2, 4, 8, 16, 32], showFooter: true,
            toolbar: [{
                text: '绑定新数据',
                iconCls: 'icon-add',
                handler: function () { dotanchu() }
            }, '-', {
                text: '删除',
                iconCls: 'icon-cut',
                handler: function () { delbd() }
            }]

        });
        $('#dg').datagrid('hideColumn', 'dIntDataID')
        var p = $('#dg').datagrid('getPager');
        $(p).pagination({
            pageSize: 10, //每页显示的记录条数，默认为10 
            pageList: [10, 20, 30], //可以设置每页记录条数的列表 
            beforePageText: '第', //页数文本框前显示的汉字 
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
        });
//        $('#dg').datagrid('load',{
//            eqd: $('#ddzRef').val(),
//            eqdn:$('#ddzname').val()
//        });
        var title = $('#ddzname').val();
        $('#dlgbd').window('setTitle', title);
    };
    
    function cellStyler(value, row, index) {
        if (value == 2) {
            return 'background-color:#ff3300;';
        }
        else {
            return 'background-color:#66ff66;';
        }
    }
   
    function delbd() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm('Confirm', '你确定要删除这条记录吗?', function (r) {
                if (r) {
                    $.post('../../ashx/plc/ahplcAndSb.ashx?action=del&ID=' + row.dIntID, { id: row.dIntID }, function (result) {
                        if (result == 1) {
                            $('#dg').datagrid('reload'); // reload the user data
                        } else {
                            $.messager.show({	// show error message
                                title: 'Error',
                                msg: result.msg
                            });
                        }

                    }, 'json');
                }
            });
        }
    }
