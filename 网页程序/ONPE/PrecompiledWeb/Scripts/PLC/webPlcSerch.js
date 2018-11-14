var temp = 0;
var sbFactorybm;
var sbplcbm;
var sbddz;
var sbcjdz;
var sbFwqdh;

var dFactorybm;
var dplcbm;
var dddz;
var dbcjdz;
var dFwqdh;

var vfwqdh;
var vplcstate

$(document).ready(function () {
    LoadFactory();
    LoadPlc();
    Loadpd();
//    $("#ibd").click(function () {
//        //alert("您是..." + $(this).val());
//        $("#isjMin").removeAttr("disabled");
//        $("#isjMax").removeAttr("disabled");
//        $("#ibdMin").removeAttr("disabled");
//        $("#ibdMax").removeAttr("disabled");
//       
//    });
//    $("#ibd1").click(function () {
//        //alert("您是..." + $(this).val());
//        $("#isjMin").attr("disabled", "disabled");
//        $("#isjMax").attr("disabled", "disabled");
//        $("#ibdMin").attr("disabled", "disabled");
//        $("#ibdMax").attr("disabled", "disabled");
//    });
    var var_equidid = parent.$("#leftFrame1").contents().find("#equidid");
    var var_equidName = parent.$("#leftFrame1").contents().find("#equidname");

    // var var_equidid = $(parent.frames['leftFrame1'].document).find('#equidid');
    //  var var_equidName = $(parent.frames['leftFrame1'].document).find('#equidname');
    equid_code = var_equidid.val();
    equid_name = var_equidName.val();
    $('#dg').datagrid({
        idField: "dIntDataID",
        url: '../../ashx/plc/ahPlcDtTemp.ashx?action=grid',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        remoteSort: true,
        pagePosition: 'bottom', //分页控件位置
        rownumbers: true,
        singleSelect: true,
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
        columns: [[
                { field: 'ck', checkbox: true },
                { field: 'dIntDataID', title: '数据ID', width: 60, align: 'center', hidden: true },
                { field: 'dVchFactoryCode', title: '厂别代号', width: 100, align: 'center', hidden: true },
                { field: 'dVchFactoryName', title: '厂别', width: '10%', align: 'center' },
                { field: 'dVchPLCCode', title: 'PLC编码', width: 100, align: 'center', hidden: true },
                { field: 'dVchRemark', title: 'PLC', width: '30%', align: 'center' },
                { field: 'dVchAdress', title: '地址', width: '20%', align: 'center' },
                { field: 'dVchCjdz', title: '采集地址', width: 100, align: 'center', hidden: true },
                { field: 'dVchValue', title: '实时值', width: '20%', align: 'center'
                    //                    formatter: function (value, row, index) {
                    //                    if (row.dFltBdMax < value || row.dFltBdMin > value) {
                    //                        return '量程有误';
                    //                    }
                    //                    else {
                    //                        return value;
                    //                    }
                    //                }
                },
                { field: 'dVchSjValue', title: '转换值', width: '20%', align: 'center'
                    //                    formatter: function (value, row, index) {
                    //                    if (row.dFltBdMax < value || row.dFltBdMin > value) {
                    //                        return '量程有误';
                    //                    }
                    //                    else {
                    //                        return value;
                    //                    }
                    //                }
                },
                { field: 'dVchUnit', title: '单位', width: 100, align: 'center', hidden: true },
                { field: 'dIntDqBz', title: '读取标识', width: 400, align: 'center', hidden: true },
                { field: 'dFltSjMax', title: '', align: 'center', hidden: true },
                { field: 'dFltSjMin', title: '', align: 'center', hidden: true },
                { field: 'dFltBdMax', title: '', align: 'center', hidden: true },
                { field: 'dFltBdMin', title: '', align: 'center', hidden: true },

            ]],
        toolbar: [{
            text: '删除',
            iconCls: 'icon-cut',
            handler: function () { remove() }
        }]

    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 10, //每页显示的记录条数，默认为10 
        pageList: [10, 20, 30], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });

    $('#sgyxt').combobox({
        url: '../../ashx/plc/plcgyxt.ashx',
        method: 'get',
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });

    //combobox
    $('#iddz').combogrid({
        panelWidth: 500,
        url: '../../ashx/plc/ahplcddz.ashx?action=combobox',
        required: true,
        method: 'get',
        idField: 'dVchPLCAddress',
        textField: 'dVchAddress',
        columns: [[
				{ field: 'dVchAddress', title: '点地址', width: 60, align: 'right' },
                { field: 'dVchAdressName', title: '名称', width: 100, align: 'right' },
                { field: 'dVchAllAdress', title: '采集地址', align: 'right', hidden: true },
                { field: 'dVchFactoryCode', title: '厂名编码', align: 'right', hidden: true },
                { field: 'dVchFactoryName', title: '厂名', align: 'right', hidden: true },
                { field: 'dVchPLCbianma', title: 'PLC编码', align: 'right', hidden: true },
                { field: 'dVchDescription', title: '详细描述', width: 200, align: 'right' },
                { field: 'dFltMoniMax', title: '', align: 'right', hidden: true },
                { field: 'dFltMoniMin', title: '', align: 'right', hidden: true },
                { field: 'dFltSjMax', title: '', align: 'right', hidden: true },
                { field: 'dFltSjMin', title: '', align: 'right', hidden: true },
                { field: 'dVchFwqdh', title: '', align: 'right', hidden: true }
			]],
        fitColumns: true,
        onSelect: function () {
            var grid = $('#iddz').combogrid('grid');
            var row = grid.datagrid('getSelected');
            // $('#a1').val(row.dVchFactoryCode);
            // $('#a2').val(row.dVchPLCbianma);
            // $('#a3').val(row.dVchAllAdress);
            sbFactorybm = row.dVchFactoryCode;
            sbplcbm = row.dVchPLCbianma;
            sbcjdz = row.dVchAllAdress;
            sbFwqdh = row.dVchFwqdh;
            $('#isbSjMax').val(row.dFltMoniMax);
            $('#isbSjMin').val(row.dFltMoniMin);
            $('#isbBdMax').val(row.dFltSjMax);
            $('#isbBdMin').val(row.dFltSjMin);

        }
    });

    //图表
    Highcharts.setOptions({
        global: {
            useUTC: false
        }
    });

    $('#container').highcharts({
        chart: {
            type: 'spline',
            animation: Highcharts.svg, // don't animate in old IE
            marginRight: 10,
            events: {
                load: function () {
                    // set up the updating of the chart each second
                    var series = this.series[0];

                    setInterval(function () {
                        //根据每一次数值变化，把X值与Y值传入此X，Y中即可

                        var x = (new Date()).getTime(), // current time
                        //   y = Math.random();
                                 y = parseInt($("#abc").attr("value"));
                        series.addPoint([x, y], true, true);
                    }, 3000);

                }
            }
        },
        title: {
            text: '动态数据曲线图'
        },
        xAxis: {
            type: 'datetime',
            tickPixelInterval: 150
        },
        yAxis: {
            title: {
                text: 'Value'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            formatter: function () {
                return '<b>' + this.series.name + '</b><br/>' +
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                        Highcharts.numberFormat(this.y, 2);
            }
        },
        legend: {
            enabled: false
        },
        exporting: {
            enabled: false
        },
        series: [{
            name: 'Random data',
            data: (function () {
                // generate an array of random data
                var data = [],
                        time = (new Date()).getTime(),
                        i;
                for (i = -10; i <= 0; i += 1) {
                    data.push({
                        x: time + i * 1000,
                        y: null
                    });
                }
                return data;
            } ())
        }]
    });
    //end 图表

});


////添加、修改、删除
//var url;
//function newplc() {
//    $('#dlg').dialog('open').dialog('setTitle', '新增PLC');
//    //        $('#fm').form('clear');
//    //        $("#iPLCID").val("");
//    $("#iPLCName").val("");
//    $("#iIPAdress").val("");
//    //        $("#iPLCPinPaiID").val();
//    //        $("#iGongYiXitongID").val();
//    $("#idVchRemark").val("");
//    $("#d1 ").combobox('select', 0);
//    $("#d2").combobox('select', 0);

//    url = '../../ashx/plc/plcmanagerOperator.ashx?type=add';
//}
//function editplc() {
//    var row = $('#dg').datagrid('getSelected');
//    if (row) {
//        $('#dlg').dialog('open').dialog('setTitle', '编辑PLC');
//        $('#fm').form('load', row);
//        url = '../../ashx/plc/plcmanagerOperator.ashx?type=edit&ID=' + row.dIntPLCID;
//        // $("#iPLCID").val(row.dIntPLCID);
//        $("#iPLCName").val(row.dVchPLCName);
//        $("#iIPAdress").val(row.dVchIPAdress);
//        //$("#iPLCPinPaiID").val(row.dIntPLCPinPaiID);
//        $("#iGongYiXitongID").val(row.dIntGongYiXitongID);
//        $("#iRemark").val(row.dVchRemark);
//        $("#d1 ").combobox('select', row.dIntPLCPinPaiID);
//        $("#d2").combobox('select', row.dIntGongYiXitongID);
//    }

//}

function queren() {
    var equipInfo = {
        sfactory: sbFactorybm,
        splc: sbplcbm,
        saddress: $('#iddz').combobox('getText'),
        scjdz: sbcjdz,
        ssjmax: $('#isbSjMax').val(),
        ssjmin: $('#isbSjMin').val(),
        sbdmax: $('#isbBdMax').val(),
        sbdmin: $('#isbBdMin').val(),
        sFwqdh: sbFwqdh

    };

    $.ajax({
        type: 'post',
        url: '../../ashx/plc/ahPlcDtTemp.ashx?action=sadd',
        data: equipInfo,
        dataType: 'text',
        success: function (msg) {
            if (msg == "0") {
                parent.$.messager.alert("操作提示", "保存成功", "info");
                $('#dg').datagrid('reload');

            } else {
                $.messager.show({
                    title: 'Error',
                    msg: result.msg
                });
            }
        }
    });
}

function save() {
    //用了form表单提交申请后，可以直接接收form下的控件名字
//    $('#fm').form('submit', {
//        url: '../../ashx/plc/ahPlcDtTemp.ashx?action=add',
//        onSubmit: function () {
//            return $(this).form('validate');
//        },
//        success: function (result) {
//            var result = eval('(' + result + ')');
//            //	var result = eval(result);                 
//            //	if (result.success) {
//            if (result == 0) {

//                $('#dg').datagrid('reload'); // reload the user data
//            } else {
//                $.messager.show({
//                    title: 'Error',
//                    msg: result.msg
//                });
//            }
//        }
//    });
    var ndata = {
        nfactory: $('#ifactory').combobox('getValue'),
        nplc: $('#iplc').combobox('getValue'),
        naddress: $('#plclb').combobox('getText') + $('#iadress').val(),
        nsjmax: $('#isjMax').val(),
        nsjmin: $('#isjMin').val(),
        nbdmax: $('#ibdMax').val(),
        nbdmin: $('#ibdMin').val(),
        nfwqdh: vfwqdh

    };

    $.ajax({
        type: 'post',
        url: '../../ashx/plc/ahPlcDtTemp.ashx?action=add',
        data: ndata,
        dataType: 'text',
        success: function (msg) {
            if (msg == "0") {
//                parent.$.messager.alert("操作提示", "保存成功", "info");
                $('#dg').datagrid('reload');

            } else {
                $.messager.show({
                    title: 'Error',
                    msg: result.msg
                });
            }
        }
    });
}

function qingkong() {
    $('#ifactory').combobox('clear');
    $('#iplc').combobox('clear');
    $('#iadress').val("");
    $('#plclb').combobox('setText', '');

}

function begin() {
    $('body').everyTime('5s', function () {
        $('#dg').datagrid('reload');
        var checkedItems = $('#dg').datagrid('getChecked');
        var names = [];
        $.each(checkedItems, function (index, item) {
            temp = item.dVchValue;
            $("#abc").attr("value", temp); //
        });
    });
}
function stop() {
    $('body').stopTime();
}

function remove() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm('Confirm', '你确定要删除这条记录吗?', function (r) {
            if (r) {
                $.post('../../ashx/plc/ahPlcDtTemp.ashx?action=del&vID=' + row.dIntDataID, { cj: row.dVchCjdz }, function (result) {
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

function doSearch() {
    $('#dg').datagrid('load', {
        plcname: $('#splcname').val(),
        gyxt: $('#sgyxt').combobox('getValue')
    });

}
function loadcombobox() {
    var temp = $("#iplczh").val();
    //$('#iddz').combogrid('reload', '../../ashx/plc/ahplcddz.ashx?action=combobox&eqd=' + temp);
    $('#iddz').combogrid('grid').datagrid('load', {
        eqd: temp
    });
}

function loadddz() {
    var iddz = $('#iddzid').val();

    var datas = {
        iddz: $('#iddzid').val()
    };
    $.ajax({
        type: 'post',
        url: '../../ashx/plc/ahPlcDtTemp.ashx?action=ddzid',
        data: datas,
        dataType: 'text',
        success: function (msg) {
            $('#a1').val(msg.split(',')[0]);
            $('#a2').val(msg.split(',')[1]);
            $('#a3').val(msg.split(',')[2]);
            $('#a4').val(msg.split(',')[3]);

            $('#idSjMax').val(msg.split(',')[4]);
            $('#idSjMin').val(msg.split(',')[5]);
            $('#idBdMax').val(msg.split(',')[6]);
            $('#idBdMin').val(msg.split(',')[7]);
            dFwqdh = msg.split(',')[8];
        }
    });
}

//修改绑定Combobox
function LoadFactory() {
    $('#ifactory').combobox({
        url: '../../ashx/plc/ahPlcDtTemp.ashx?action=factory',
        method: 'get',
        required: true,
        valueField: 'dVchFactoryCode',
        textField: 'dVchFactoryName',
        panelHeight: 'auto',
        onSelect: function (rec) {
            $('#iplc').combobox({
                url: '../../ashx/plc/ahPlcDtTemp.ashx?action=plc&cb=' + rec.dVchFactoryCode,
                method: 'get',
                valueField: 'dVchPLCbianma',
                textField: 'dVchRemark',
                panelHeight: 'auto',
                panelWidth: 'auto',
                onSelect: function (rec) {
                    var datas = {
                        vplcbm: rec.dVchPLCbianma
                    };

                    $.ajax({
                        type: 'post',
                        url: '../../ashx/plc/ahPlcDtTemp.ashx?action=gpp',
                        data: datas,
                        dataType: 'text',
                        success: function (msg) {
                            vfwqdh = msg.split(',')[1];
                            $('#plclb').combobox({
                                width: 60,
                                url: '../../ashx/plc/ahPlcDtTemp.ashx?action=ppgz&vpp=' + msg.split(',')[0],
                                method: 'get',
                                valueField: 'dIntGZID',
                                textField: 'dVchGZQZ',
                                panelHeight: 'auto'
                            });
                        }
                    });
                }
            });
        }
    });
}
function LoadPlc() {
    $('#iplc').combobox({
        url: '../../ashx/plc/ahPlcDtTemp.ashx?action=plc',
        method: 'get',
        required: true,
        valueField: 'dVchPLCbianma',
        textField: 'dVchRemark',
        panelHeight: 'auto',
        panelWidth:'auto',
        formatter: function (row) {
            var imageFile = 'images/' + row.icon;
            return '<img class="item-img" src="' + imageFile + '"/><span class="item-text">' + row.dVchRemark + '</span>';
        }
//        onSelect: function (rec) {
//            var datas = {
//                vplcbm: rec.dVchPLCbianma
//            };
//            $.ajax({
//                type: 'post',
//                url: '../../ashx/plc/ahPlcDtTemp.ashx?action=gpp',
//                data: datas,
//                dataType: 'text',
//                success: function (msg) {
//                    var url = '../../ashx/plc/ahPlcDtTemp.ashx?action=ppgz&vpp=' + msg.split(',')[0];
//                    vfwqdh = msg.split(',')[1];
//                    

//                }
//            });


//        }
    });
}
function Loadpd() {
    $('#plclb').combobox({
        width: 60,
        required: true,
        url: '../../ashx/plc/ahPlcDtTemp.ashx?action=ppgz',
        method: 'get',
        valueField: 'dIntGZID',
        textField: 'dVchGZQZ',
        panelHeight: 'auto'
    });
}
function xuanzhong() {
    var data1 = {
        dfactory: $('#a1').val(),
        dplc: $('#a2').val(),
        daddress: $('#a3').val(),
        dcjdz: $('#a4').val(),
        dsjmax: $('#idSjMax').val(),
        dsjmin: $('#idSjMin').val(),
        dbdmax: $('#idBdMax').val(),
        dbdmin: $('#idBdMin').val(),
        dbFwqdh:dFwqdh
    };

    $.ajax({
        type: 'post',
        url: '../../ashx/plc/ahPlcDtTemp.ashx?action=dadd',
        data: data1,
        dataType: 'text',
        success: function (msg) {
            if (msg == "0") {
                parent.$.messager.alert("操作提示", "保存成功", "info");

                $('#dg').datagrid('reload');

            } else {
                $.messager.show({
                    title: 'Error',
                    msg: result.msg
                });
            }
        }
    });
}

$.extend($.fn.validatebox.defaults.rules, {
    idcard: {// 验证身份证
        validator: function (value) {
            return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
        },
        message: '身份证号码格式不正确'
    },
    minLength: {
        validator: function (value, param) {
            return value.length >= param[0];
        },
        message: '请输入至少（2）个字符.'
    },
    length: { validator: function (value, param) {
        var len = $.trim(value).length;
        return len >= param[0] && len <= param[1];
    },
        message: "输入内容长度必须介于{0}和{1}之间."
    },
    phone: {// 验证电话号码
        validator: function (value) {
            return /^((\d{2,3})|(\d{3}\-))?(0\d{2,3}|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
        },
        message: '格式不正确,请使用下面格式:020-88888888'
    },
    mobile: {// 验证手机号码
        validator: function (value) {
            return /^(13|15|18)\d{9}$/i.test(value);
        },
        message: '手机号码格式不正确'
    },
    intOrFloat: {// 验证整数或小数
        validator: function (value) {
            return /^\d+(\.\d+)?$/i.test(value);
        },
        message: '请输入数字，并确保格式正确'
    },
    currency: {// 验证货币
        validator: function (value) {
            return /^\d+(\.\d+)?$/i.test(value);
        },
        message: '货币格式不正确'
    },
    qq: {// 验证QQ,从10000开始
        validator: function (value) {
            return /^[1-9]\d{4,9}$/i.test(value);
        },
        message: 'QQ号码格式不正确'
    },
    integer: {// 验证整数 可正负数
        validator: function (value) {
            //return /^[+]?[1-9]+\d*$/i.test(value);

            return /^([+]?[0-9])|([-]?[0-9])+\d*$/i.test(value);
        },
        message: '请输入整数'
    },
    age: {// 验证年龄
        validator: function (value) {
            return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value);
        },
        message: '年龄必须是0到120之间的整数'
    },

    chinese: {// 验证中文
        validator: function (value) {
            return /^[\Α-\￥]+$/i.test(value);
        },
        message: '请输入中文'
    },
    english: {// 验证英语
        validator: function (value) {
            return /^[A-Za-z]+$/i.test(value);
        },
        message: '请输入英文'
    },
    unnormal: {// 验证是否包含空格和非法字符
        validator: function (value) {
            return /.+/i.test(value);
        },
        message: '输入值不能为空和包含其他非法字符'
    },
    username: {// 验证用户名
        validator: function (value) {
            return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test(value);
        },
        message: '用户名不合法（字母开头，允许6-16字节，允许字母数字下划线）'
    },
    faxno: {// 验证传真
        validator: function (value) {
            //            return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/i.test(value);
            return /^((\d{2,3})|(\d{3}\-))?(0\d{2,3}|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
        },
        message: '传真号码不正确'
    },
    zip: {// 验证邮政编码
        validator: function (value) {
            return /^[1-9]\d{5}$/i.test(value);
        },
        message: '邮政编码格式不正确'
    },
    ip: {// 验证IP地址
        validator: function (value) {
            return /d+.d+.d+.d+/i.test(value);
        },
        message: 'IP地址格式不正确'
    },
    name: {// 验证姓名，可以是中文或英文
        validator: function (value) {
            return /^[\Α-\￥]+$/i.test(value) | /^\w+[\w\s]+\w+$/i.test(value);
        },
        message: '请输入姓名'
    },
    date: {// 验证姓名，可以是中文或英文
        validator: function (value) {
            //格式yyyy-MM-dd或yyyy-M-d
            return /^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i.test(value);
        },
        message: '清输入合适的日期格式'
    },
    msn: {
        validator: function (value) {
            return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(value);
        },
        message: '请输入有效的msn账号(例：abc@hotnail(msn/live).com)'
    },
    same: {
        validator: function (value, param) {
            if ($("#" + param[0]).val() != "" && value != "") {
                return $("#" + param[0]).val() == value;
            } else {
                return true;
            }
        },
        message: '两次输入的密码不一致！'
    }
});