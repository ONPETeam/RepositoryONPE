$(document).ready(function () {
    //变量类型combobox数据
    LoadVariableType();
    $('#iBLBH').textbox('textbox').css('background', '#ccc');
    //数据表格显示
    $('#dg').datagrid({
        url: '../../ashx/plc/ahplcddz.ashx?action=grid',
        //            queryParams: {
        //                eqd: equid_code
        //            },
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pageSize: 50,
        remoteSort: true,
        pagePosition: 'bottom', //分页控件位置
        rownumbers: true,
        singleSelect: true,
        fit: true,
        striped: true,
        //        fitColumns:true,
        columns: [[
        // { field: 'ck',checkbox:true},
                {field: 'dIntDataID', title: '点地址ID', width: 40, align: 'right' },
                { field: 'dVchAddress', title: '点地址', width: 80, align: 'right', sortable: false, styler: function cellStyler(value, row, index) {
                    if (row.dIntBjBz == 1) {
                        return 'background-color:#ffee00;';
                    }
                }
                },
                { field: 'dVchAdressName', title: '简称', width: 150, align: 'right', styler: function cellStyler(value, row, index) {
                    if (row.dIntIsCollect) {
                        return 'background-color:#E0FFFF;';
                    }
                }
                },
                { field: 'dVchDescription', title: '详细描述', width: 200, align: 'right' },
                { field: 'dIntGongType', title: '功能分类', width: 60, align: 'right', formatter: function (value, row, index) {
                    if (row.dIntGongType == 3) {
                        return "开关量"
                    }
                    if (row.dIntGongType == 1) {
                        return "模拟量"
                    }
                }
                },
                { field: 'dIntPLCID', title: 'PLC名称id', width: 150, align: 'right' },
                { field: 'plcqm', title: 'PLC名称', width: 300, align: 'right' },
                { field: 'dVchPLCXitongName', title: '工艺系统', width: 100, align: 'right', hidden: true },
                { field: 'dVchVariableName', title: '变量类型', width: 80, align: 'right' },
                 //{ field: 'dFltMoniMax', title: '实际最大值', width: 70, align: 'right' },
                 //{ field: 'dFltMoniMin', title: '实际最小值', width: 70, align: 'right' },
                 //{ field: 'dFltSjMax', title: '标定最大值', width: 70, align: 'right' },
                 //{ field: 'dFltSjMin', title: '标定最小值', width: 70, align: 'right' },
                {field: 'dVchIOTypeName', title: 'IO类型', width: 60, align: 'right' },
                { field: 'gStrPointType', title: '系统', width: 250, align: 'right' },
                { field: 'dIntShouJiPx', title: '排序', width: 50, align: 'right' },
                { field: 'dVchDanwei', title: '单位', width: 50, align: 'right' },
                { field: 'dVchAllAdress', title: '采集', width: 50, align: 'right' },
                { field: 'equip_code', title: '设备编号', hidden: true },
                { field: 'dIntJsBz', title: '计算量', hidden: true },
                { field: 'dIntCollectSec', title: '', hidden: true },
                { field: 'dIntIsCollect', title: '', hidden: true }
            ]],

        //width: 1200,
        //rowStyler: function (index, row) { if (index % 2 == 0) { return 'background-color:#ccccff;'; } },
        //striped: true, pagination: true, rownumbers: true, singleSelect: true, pageNumber: 1, pageSize: 8, pageList: [1, 2, 4, 8, 16, 32], showFooter: true,
        toolbar: '#tb'
    });
    //分页控件
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 50, //每页显示的记录条数，默认为10 
        pageList: [50, 100, 200], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    //datagrid隐藏列代码
    $('#dg').datagrid('hideColumn', 'dIntPLCID')
    $('#dg').datagrid('hideColumn', 'dIntDataID')
    $('#dg').datagrid('hideColumn', 'dVchAllAdress')

    //plc信息combobox下拉框
    $('#splc').combobox({
        url: '../../ashx/plc/plcmanager.ashx?action=combox',
        method: 'get',
        required: true,
        panelWidth: 'auto',
        valueField: 'dIntPLCID',
        textField: 'dVchPLCName',
        groupField: 'dVchArea'
    });
    //系统下拉框
    $('#sxt').combobox({
        url: '../../ashx/plc/ahplcXitong.ashx?action=combobox',
        method: 'get',
        required: true,

        valueField: 'dIntNoteID',
        textField: 'dVchPointType',
        groupField: 'dVchRemark'
    });
    //参数a的combotree下拉框（设备下选择plc点地址）
    $('#icsa').combotree({
        url: '../../ashx/sbgl/areaHandler.ashx?action=tree&area_parent=0',
        required: false,
        multiple: false,
        onlyLeafCheck: true,
        onBeforeExpand: function (node) {
            //                if (node.attributes == 'area') {
            //                    $('#icsa').combotree('tree').tree('options').url = "../../ashx/plc/plcmanager.ashx?action=treeIP&area_parent=" + node.id;
            //                }
            //                if (node.attributes == 'lastArea') {

            //                    $('#icsa').combotree('tree').tree('options').url = "../../ashx/plc/plcmanager.ashx?action=PlcIP&area_parent=" + node.id;
            //                }
            //                if (node.attributes == "ddz") {
            //                    $('#icsa').combotree('tree').tree('options').url = "../../ashx/plc/ahplcddzOp.ashx?type=ddz&area_parent=" + node.id;
            //                }

            if (node.attributes == 'area') {
                $('#icsa').combotree('tree').tree('options').url = "../../ashx/sbgl/areaHandler.ashx?action=tree&area_parent=" + node.id;
            }
            if (node.attributes == 'lastArea') {

                $('#icsa').combotree('tree').tree('options').url = "../../ashx/plc/ahplcddz.ashx?action=eqddz&area_id=" + node.id;
            }
            if (node.attributes == 'equip') {
                $('#icsa').combotree('tree').tree('options').url = "../../ashx/plc/ahplcddz.ashx?action=ddz&sb=" + node.id;
            }

        }

    });
    //参数b
    $('#icsb').combotree({
        url: '../../ashx/sbgl/areaHandler.ashx?action=tree&area_parent=0',
        required: false,
        multiple: false,
        onlyLeafCheck: true,
        onBeforeExpand: function (node) {
            if (node.attributes == 'area') {
                $('#icsb').combotree('tree').tree('options').url = "../../ashx/sbgl/areaHandler.ashx?action=tree&area_parent=" + node.id;
            }
            if (node.attributes == 'lastArea') {

                $('#icsb').combotree('tree').tree('options').url = "../../ashx/plc/ahplcddz.ashx?action=eqddz&area_id=" + node.id;
            }
            if (node.attributes == 'equip') {
                $('#icsb').combotree('tree').tree('options').url = "../../ashx/plc/ahplcddz.ashx?action=ddz&sb=" + node.id;
            }
        }

    });
    //参数c
    $('#icsc').combotree({
        url: '../../ashx/sbgl/areaHandler.ashx?action=tree&area_parent=0',
        required: false,
        multiple: false,
        onlyLeafCheck: true,
        onBeforeExpand: function (node) {
            if (node.attributes == 'area') {
                $('#icsc').combotree('tree').tree('options').url = "../../ashx/sbgl/areaHandler.ashx?action=tree&area_parent=" + node.id;
            }
            if (node.attributes == 'lastArea') {

                $('#icsc').combotree('tree').tree('options').url = "../../ashx/plc/ahplcddz.ashx?action=eqddz&area_id=" + node.id;
            }
            if (node.attributes == 'equip') {
                $('#icsc').combotree('tree').tree('options').url = "../../ashx/plc/ahplcddz.ashx?action=ddz&sb=" + node.id; ;
            }
        }

    });
    //公式说明显示
    $(function () {
        $('#dd').tooltip({
            content: $('<div></div>'),
            showEvent: 'click',
            onUpdate: function (content) {
                content.panel({
                    width: 100,
                    height: 150,
                    border: false,
                    title: '公式填写帮助',
                    content: '<p>公式填写例子：如a*b+c.除了正常的加、减、乘、除用+、-、*、/来表示。取反用!a，与&&，或||。</p>'
                    // href: '_dialog.html'
                });
            },
            onShow: function () {
                var t = $(this);
                t.tooltip('tip').unbind().bind('mouseenter', function () {
                    t.tooltip('show');
                }).bind('mouseleave', function () {
                    t.tooltip('hide');
                });
            }
        });
    });
    //设置accordion的属性
    $('#aa').accordion({
    });
    //radio添加绑定事件
    $("input:radio[name='njs'][value=0]").attr("checked", true);
    $(":radio").click(
    function () {
        var a = $("input[name='njs']:checked").attr("value");
        //        var b = $("input[name='njs']").val();
        //        alert(a + ',' + b);
        if (a == 1) {
            $('#aa').accordion('select', 1);
        }
        else {
            $('#aa').accordion('select', 0);
        }
    }
    );
    //---------------

    //layout
    $('#lt').layout('collapse', 'west')


});
//单元格黄色显示
function cellStyler(value, row, index) {
    if (value < 30) {
        return 'background-color:#ffee00;color:red;';
    }
}
//变量类型下拉框
function LoadVariableType() {
    $('#iDataType').combobox({
        url: '../../ashx/plc/ahPlcDtTemp.ashx?action=VT',
        width: 150,
        method: 'get',
        valueField: 'dVchVariableCode',
        textField: 'dVchVariableName',
        panelHeight: 'auto'
        //            panelWidth: 'auto'

    });
   

    $('#iVariableType').combobox('setValue', '0');
}


//数据表格信息查询
function doSearch() {
    var aa = $('#ilsOrbj').combobox('getValue');
    $('#dg').datagrid('load', {
        plc: $('#splc').combobox('getValue'),
        ddz: $('#sddz').val(),
        xt: $('#sxt').combobox('getValue'),
        sb: $('#isb').val(),
        lsOrbj: $('#ilsOrbj').combobox('getValue')
    });
}
//添加点地址信息弹出对话框
var url;
function Add() {
    $('#dlg').dialog('open').dialog('setTitle', '窗体信息');
    // $('#fm').form('clear');
    $('#fm').form('reset');
   
    //        $("#iAddress").val("");
    //        $('#iAddress').textbox('clear');
    //        $("#iAdressName").textbox('clear');
    //        $("#iNeiBuBL1").val("");
    //        $("#iDescription").textbox('clear');
    //        $("#iNeiBuBL2").val("");
    //        $("#iDanwei").textbox('clear');
    $('#iXS').val("0");
    //        $("#iDataType").combobox('clear');
    //        $("#iDataType").combobox('setValue', '0');
    //        $("#iGongType ").combobox('clear');
    //        $("#iIOType").combobox('clear');
    //        $('#iplc').combobox('clear');
    //        //        $("#ikglzt").combobox('select', 0);
    //        $('#ikglzt').combobox('clear');
    //        //        $('#iXitong').combobox('clear');
    $('#iXitong').combobox('setValue', '1');
    $('#iBLXT').combobox('setValue','1');
    //        $('#iyt').combobox('setValue', '0');

    //        //计算公式
    //        $('#ijsg2').attr("checked", "checked");
    //        $('input:radio[name=njs][value=0]').attr('checked', true);
    ////        $("[name='njs']:eq(1)").attr("checked", true);
    //        $(":radio").click(function () {
    //            if ($(this).val() == 1) {
    //                $('#iMoniMax').val("0");
    //                $('#iMoniMin').val("0");
    //                $('#iSjMax').val("0");
    //                $('#iSjMin').val("0");
    //            }
    //        });
    //        $("#icsa").combotree('clear');
    //        $("#icsb").combotree('clear');
    //        $("#icsc").combotree('clear');
    //        $("#igs").textbox('clear');
    $('#aa').accordion('select',0)

    url = '../../ashx/plc/ahplcddzOp.ashx?type=add';
}
//修改点地址弹出对话框
function Edit() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $('#dlg').dialog('open').dialog('setTitle', '编辑');
        $('#fm').form('load', row);
        var GzOrQd;
        GzOrQd = row.dIntGzOrQd;
        url = '../../ashx/plc/ahplcddzOp.ashx?type=edit&ID=' + row.dIntDataID + '&vGz=' + GzOrQd;
        //判断是否计算变量
        // $("input:radio[name='njs'][value=" + row.dIntJsBz + "]").attr("checked", true);
        var js = $("input[name='njs']:checked").attr('value');
        if (row.dIntJsBz == 1) {
            $("input[name='njs']").get(1).checked = true;
            $('#aa').accordion('select', 1);
            //点地址/变量编号
            $('#iBLBH').textbox('setValue', row.dVchAddress);
            //描述/变量名称
            $("#iBLName").textbox('setValue', row.dVchDescription);
            //单位
            $("#iBLDW").textbox('setValue', row.dVchDanwei);
            //功能分类
            $("#iBLGT").combobox('select', row.dIntGongType);
            //系统/变量系统
            // $("#iBLXT").combobox('select', row.dIntPointType);
            //$("#iBLXT").combobox("setValues", row.dIntPointType).combobox("setText", row.dVchPointTypeName).combobox('select', row.dIntPointType);
            $("#iBLXT").combobox('setValues', row.gStrPointTypeid);
            //排序/变量排序
            $("#iBLXS").textbox('setValue', row.dIntShouJiPx);
        }
        else {
            $("input[name='njs']").get(0).checked = true;
            $('#aa').accordion('select', 0);
            //点地址/变量编号
            $('#iAddress').textbox('setValue', row.dVchAddress);
            //描述/变量名称
            $("#iDescription").textbox('setValue', row.dVchDescription);
            //单位
            $("#iDanwei").textbox('setValue', row.dVchDanwei);
            //功能分类
            $("#iGongType").combobox('select', row.dIntGongType);
            //系统/变量系统
            //$("#iXitong").combobox('select', row.dIntPointType);
            $("#iXitong").combobox('setValues', row.gStrPointTypeid);
            //排序/变量排序
            $("#iXS").textbox('setValue', row.dIntShouJiPx);
        }
        
        $("#iDataType").combobox('select', row.dVchDataType);
        $("#iAdressName").textbox('setValue', row.dVchAdressName);
        $("#iNeiBuBL1").val(row.dVchNeiBuBL1);
        $("#iNeiBuBL2").val(row.dVchNeiBuBL2);
        $("#iMoniMin").numberbox('setValue', row.dFltMoniMin);
        $("#iMoniMax").numberbox('setValue', row.dFltMoniMax);
        $("#iSjMin").numberbox('setValue', row.dFltSjMin);
        $("#iSjMax").numberbox('setValue', row.dFltSjMax);
        $("#iIOType").combobox('select', row.dIntIOType);
        $("#iplc").combobox('select', row.dIntPLCID);
        $("#ikglzt").combobox('select', row.dIntGzOrQd);
        $('#iyt').combobox('select', row.dIntNengYuanType);
//        $("input[name='ZongGZ'][value=" + row.dIntZongGZ + "]").attr("checked", true);
        $("#icsa").combotree('clear');
        $("#icsb").combotree('clear');
        $("#icsc").combotree('clear');
        $("#igs").textbox('clear');

        var datas = {
            svar: row.dVchAllAdress
        };
        $.ajax({
            type: 'post',
            url: '../../ashx/plc/ahplcddzOp.ashx?type=gscs',
            data: datas,
            dataType: 'text',
            success: function (msg) {
                //                var aaa = msg.split(',')[0].split('.')[2];
                //                bbb = aaa.split('.')[2];
                if (msg != "") {
                    $("#igs").textbox('setValue', msg.split('=')[3]);
//                    $('#icsa').combotree('setValue', { id: msg.split(',')[0], text: msg.split(',')[0].split('.')[2] });
//                    $('#icsb').combotree('setValue', { id: msg.split(',')[1], text: msg.split(',')[1].split('.')[2] });
//                    $('#icsc').combotree('setValue', { id: msg.split(',')[2], text: msg.split(',')[2].split('.')[2] });
                    $('#icsa').combotree('setValue', { id: msg.split('=')[0], text: msg.split('=')[0]});
                    $('#icsb').combotree('setValue', { id: msg.split('=')[1], text: msg.split('=')[1]});
                    $('#icsc').combotree('setValue', { id: msg.split('=')[2], text: msg.split('=')[2]});
                }
            }
        });
    }
}
//添加和修改后，点击保存
function Save() {
    $('#fm').form('submit', {
        url: url,
        onSubmit: function () {
            return $(this).form('validate');
        },
        success: function (result) {
            var result = eval('(' + result + ')');
            //	var result = eval(result);                 
            //	if (result.success) {
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
//删除点地址信息
function Del() {
    var row = $('#dg').datagrid('getSelected');
    var sb = $('#isb').val();
    if (row) {
        $.messager.confirm('Confirm', '你确定要删除这条记录吗?', function (r) {
            if (r) {

                $.post('../../ashx/plc/ahplcddzOp.ashx?type=delete&ID=' + row.dIntDataID + '&dsb=' + sb, { variable: row.dVchAllAdress, vjs: row.dIntJsBz }, function (result) {
                    if (result == 0) {
                        $('#dg').datagrid('reload'); // reload the user data
                    } else {
                        $.messager.show({	// show error message
                            title: 'Error',
                            msg: result.msg
                        });
                    }
                });
            }
        });
    }
}


function Delts() {
    var row = $('#dgtsp').datagrid('getSelected');
 
    if (row) {
        $.messager.confirm('Confirm', '你确定要删除这条记录吗?', function (r) {
            if (r) {
                $.post('../../ashx/plc/ahplcGycs.ashx?action=Tspdel', { vtspddz: row.dVchCjdz, vtspemp: row.employee_code }, function (result) {
                    if (result == 1) {
                        $('#dgtsp').datagrid('reload'); // reload the user data
                    } else {
                        $.messager.show({	// show error message
                            title: 'Error',
                            msg: result.msg
                        });
                    }
                });
            }
        });
    }
}

//
//设定报警点
function bjdsd() {
    $('#cc').combotree({
        url: '../../ashx/plc/ahplcGycs.ashx?action=tree',
        required: true,
        multiple: true,
        onlyLeafCheck: true,
        onBeforeExpand: function (node) {
            if (node.attributes == 'Company') {
                //$('#cc').combotree('tree').tree('options').url = "../../ashx/Branch/branchHandler.ashx?action=combo&branch_parent=0&company_id=" + node.id;
                $('#cc').combotree('tree').tree('options').url = "../../ashx/plc/ahplcGycs.ashx?action=CompanyT&vCompany=" + node.id;
            }
            if (node.attributes == 'Branch') {
                //$('#cc').combotree('tree').tree('options').url = " ../../ashx/employee/employeeHandler.ashx?action=combo&branch_id=" + node.id;
                $('#cc').combotree('tree').tree('options').url = "../../ashx/plc/ahplcGycs.ashx?action=BranchT&vBranch=" + node.id;
            }
        },
        onCheck: function (node, checked) {
        },
        onHidePanel: function () {
        }
    });
    var row = $('#dg').datagrid('getSelected');
    if (row != null) {
        $('#dlg-Bj').dialog('open');
    }
   
    //显示数据在弹出框中
    $('#cbjsb').html(row.equip_code);
    $('#cbjdz').html(row.dVchAllAdress);
    $('#cbjlb').combobox('setValue', row.dIntAdressTypeID);
    $('#cbjMin').textbox('setValue', row.dfltMin);
    $('#cbjMax').textbox('setValue', row.dfltMax);
    $('#cbkgl').textbox('setValue', row.dVchKgAlermValue);
    $('#cbjRemark').textbox('setValue', row.dVchRemark);

    GetTspDg(row.dVchAllAdress);
}

//保存设置报警点
function savebj() {
    var row = $('#dg').datagrid('getSelected');

    var nodes = $('#cc').combotree('getValues');
    var aaa = "";
    for (var i = 0; i < nodes.length; i++) {
        aaa = nodes[i] + ',' + aaa;
    }
    var para = {
        vDid: row.dIntDataID,
        vCjdz: row.dVchAllAdress,
        vBjBz: 1,
        vGz: 1,

        //报警上下限
        bjSbbm: $('#cbjsb').html(),
        bjcjdz: $('#cbjdz').html(),
        bjdzlb: $('#cbjlb').combobox('getValue'),
        bjMax: $('#cbjMax').textbox('getValue'),
        bjMin: $('#cbjMin').textbox('getValue'),
        bjKgl: $('#cbkgl').textbox('getValue'),
        bjRemark: $('#cbjRemark').textbox('getValue'),
        bjNodes: aaa
    };

    $.ajax({
        type: 'post',
        url: '../../ashx/plc/ahplcGycs.ashx?action=bj',
        data: para,
        success: function (msg) {

            if (msg == 0) {
                parent.$.messager.alert("操作提示", "设置成功!", "info");
                
                $('#dgtsp').datagrid('load', {
                    vtsp: row.dVchAllAdress
                });
                $('#dg').datagrid('reload');
                
            }
            else {
                $.messager.show({
                    title: 'Error',
                    msg: "设定失败！重新设置！"
                });
            }
        }
    });
}

//取消报警点
function bjdqx() {
    var row = $('#dg').datagrid('getSelected');
    if (row != null) {
        var para = {
            vDid: row.dIntDataID,
            vCjdz: row.dVchAllAdress,
            vBjBz: 0,
            vGz: 0
        };

        $.ajax({
            type: 'post',
            url: '../../ashx/plc/ahplcGycs.ashx?action=bjqx',
            data: para,
            success: function (msg) {
                if (msg == 0) {
                    parent.$.messager.alert("操作提示", "取消成功!", "info");
                    $('#dg').datagrid('reload');
                }
                else {
                    $.messager.show({
                        title: 'Error',
                        msg: "取消失败！重新设置！"
                    });
                }
            }
        });
    }
}
var lsck = 0;
var lsbl =0;
function SetLs() {
    
    var row = $('#dg').datagrid('getSelected');
    if (row != null) {
        $('#dlg-ls').dialog('open');
        var para = {
            vcjdz: row.dVchAllAdress
        };
        
        $('#ilsid').textbox('setValue', row.dIntDataID);
        $('#ilscjdz').textbox('setValue', row.dVchAllAdress);
        $('#ilsddz').textbox('setValue', row.dVchAddress);
        $('#ilsddzn').textbox('setValue', row.dVchAdressName);
        $('#ilsType').combobox('setValue', row.dIntGongType);
        $('#ilscjzq').combobox('setValue', row.dIntCollectSec);
        if (row.dIntIsCollect == 1) {
            //$('[name=item]:checkbox').prop('checked', this.checked);
            $('#ilsck').prop('checked', true);
        }
        else {
            $('#ilsck').prop('checked', false);
        }
        
        lsbl = row.dVchDataType;

    }

//    $.ajax({
//        type: 'post',
//        url: '',
//        data: para,
//        dataType: 'json',
//        success: function (tt) {
//            //解析json格式

//        }
//    });
}

//保存历史数据
function savels() {
    //这个应该是保存历史数据的时候用
   if ($("#ilsck").is(":checked")) {//选中
       lsck = 1;
   }
   else {
       lsck = 0;
   }
   var para = {
       vlsid: $('#ilsid').textbox('getValue'),
       vlscjdz: $('#ilscjdz').textbox('getValue'),
       vlsddz:$('#ilsddz').textbox('getValue'),
       vlsddzn:$('#ilsddzn').textbox('getValue'), 
       vlsType:$('#ilsType').combobox('getValue'),
       vlscjzq: $('#ilscjzq').combobox('getValue'),
       vlsCollect: lsck,
       vlsDataType: lsbl
   };

   $.ajax({
       type: 'post',
       url: '../../ashx/plc/ahplchistory.ashx?action=SaveHistoryData',
       data: para,
       dataType: 'text',
       success: function (msg) {
           if (msg == "True") {
               parent.$.messager.alert("操作提示", "设置成功!", "info");
               $('#dlg-ls').dialog('close');
               $('#dg').datagrid('reload');
           }
           else {
              
               $.messager.show({
                   title: 'Error',
                   msg: "设定失败！重新设置！"
               });
           }

       },
       error: function (msg) {
           alert(msg);

       }
   });
}
//取消历史点
function lsdqx() {
    var row = $('#dg').datagrid('getSelected');
    if (row != null) {
        var para = {
            vlsid: row.dIntDataID

        };

        $.ajax({
            type: 'post',
            url: '../../ashx/plc/ahplchistory.ashx?action=CancelHistoryData',
            data: para,
            dataType:'text',
            success: function (msg) {
                if (msg == "True") {
                    parent.$.messager.alert("操作提示", "取消成功!", "info");
                    $('#dg').datagrid('reload');
                }
                else {
                    $.messager.show({
                        title: 'Error',
                        msg: "取消失败！重新设置！"
                    });
                }
            }
        });
    }
}



//推送人员dg
function GetTspDg(vtsddz) {
    $('#dgtsp').datagrid({
        url: '../../ashx/plc/ahplcGycs.ashx?action=Tsp',
        queryParams: {
            vtsp: vtsddz
        },
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: false, //分页控件
        remoteSort: true,
//        pagePosition: 'bottom', //分页控件位置
        rownumbers: true,
        singleSelect: true,
        fit: true,
        striped: true,
        //        fitColumns:true,
        columns: [[
        // { field: 'ck',checkbox:true},
                {field: 'employee_name', title: '名字', width: 40, align: 'right' },
                { field: 'branch_name', title: '部门', width: 80, align: 'right' },
                { field: 'company_name', title: '公司', width: 80, align: 'right' }
            ]],
        //rowStyler: function (index, row) { if (index % 2 == 0) { return 'background-color:#ccccff;'; } },
        //striped: true, pagination: true, rownumbers: true, singleSelect: true, pageNumber: 1, pageSize: 8, pageList: [1, 2, 4, 8, 16, 32], showFooter: true,
        toolbar: '#tbts'
    });
    //分页控件
    var p = $('#dgtsp').datagrid('getPager');
    $(p).pagination({
        pageSize: 10, //每页显示的记录条数，默认为10 
        pageList: [10, 20, 30], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });


}

