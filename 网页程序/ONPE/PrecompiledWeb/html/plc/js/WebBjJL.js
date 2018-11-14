$(document).ready(function () {
    setDate();
    $('#dg').datagrid({
        url: '../../ashx/plc/ahplcGycs.ashx?action=bjsj',
        queryParams: {
            vks: $('#iks').datetimebox('getValue'),
            vjs: $('#ijs').datetimebox('getValue')
        },
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        remoteSort: true,
        pagePosition: 'bottom', //分页控件位置
        rownumbers: true,
        singleSelect: true,
        //            rowStyler: function (index, row) {
        //                if (row.dIntGzOrQd == 1) {
        //                    return 'background-color:#6293BB;color:#fff;font-weight:bold;';
        //                }
        //            },

        //            selectOnCheck: true,
        //            checkOnSelect: true,
        //            onLoadSuccess:function(data){
        //                            if(data){
        //                                $.each(data.rows,function(index,item){
        //                                    if(item.checked){
        //                                        $('#dg').datagrid('checkRow',index);
        //                                    }
        //                                });
        //                            }
        //                        },
        fit: true,
        striped:true,
        columns: [[
        // { field: 'ck',checkbox:true},
                {field: 'dIntID', title: '序号', hidden: true, width: 40, align: 'right' },
                { field: 'equip_name', title: '设备名称', width: 150, align: 'right' },
                { field: 'dVchAdress', title: '点地址', width: 60, align: 'right' },
                { field: 'dVchName', title: '名称', width: 150, align: 'right' },
                { field: 'dDaeGzCs', title: '故障产生时间', width: 200, align: 'right', formatter: function (value, row, index) {
                    if (value != '0001-01-01T00:00:00') {
                        var unixTimestamp = new Date(value);
                        return unixTimestamp.toLocaleString();
                    }
                    else {
                        return '';
                    }
                }
                },
                { field: 'dDaeGzHf', title: '故障恢复时间', width: 200, align: 'right', formatter: function (value, row, index) {
                    if (value != '0001-01-01T00:00:00') {
                        var unixTimestamp = new Date(value);
                        return unixTimestamp.toLocaleString();
                    }
                    else {
                        return '';
                    }
                }
                },
                { field: 'dVchValue', title: '当前值', width: 100, align: 'right' },
                { field: 'dVchRemark', title: '备注', width: 100, align: 'right' },
            ]],

        width: 1200,
        //rowStyler: function (index, row) { if (index % 2 == 0) { return 'background-color:#ccccff;'; } },
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
    //        $('#dg').datagrid('hideColumn', 'dIntID');

    $('#sgyxt').combobox({
        url: '../../ashx/plc/ahplcXitong.ashx?action=topcombobox',
        method: 'get',
        valueField: 'dIntAreaID',
        textField: 'dVchArea',
        panelHeight: 'auto'
    });

});
function doSearch() {
    $('#dg').datagrid('load', {
        vqy: $('#sgyxt').combobox('getValue'),
        vks: $('#iks').datetimebox('getValue'),
        vjs: $('#ijs').datetimebox('getValue'),
        vmh: $('#imh').val(),
        vhf: $('#iHf').combobox('getValue'),
        vsb: $('#isb').val()
    });
}
function p(s) {
    return s < 10 ? '0' + s : s;
}
function setDate() {
    var myDate = new Date();
    //获取当前年
    var year = myDate.getFullYear();
    //获取当前月
    var month = myDate.getMonth() + 1;
    //获取当前日
    var date = myDate.getDate();
    var h = myDate.getHours();       //获取当前小时数(0-23)
    var m = myDate.getMinutes();     //获取当前分钟数(0-59)
    var s = myDate.getSeconds();

    h = 00;
    m = 00;
    s = 00;
    var ks = year + '-' + p(month) + "-" + p(date) + " " + p(h) + ':' + p(m) + ":" + p(s);
    $('#iks').datetimebox('setValue', ks);

    h = 23;
    m = 59;
    s = 59;
    var js = year + '-' + p(month) + "-" + p(date) + " " + p(h) + ':' + p(m) + ":" + p(s);
    $('#ijs').datetimebox('setValue', js);

}