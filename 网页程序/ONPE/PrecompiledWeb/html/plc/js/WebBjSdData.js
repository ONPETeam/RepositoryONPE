$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/plc/ahplcGycs.ashx?action=bjd',
        //            queryParams: {
        //                eqd: equid_code
        //            },
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
                {field: 'dIntDataID', title: '序号', width: 40, align: 'right' },
                { field: 'equip_name', title: '设备名称', width: 150, align: 'right' },
                { field: 'dVchAdress', title: '点地址', width: 60, align: 'right' },
                { field: 'dVchName', title: '名称', width: 150, align: 'right' },
                { field: 'dFltSjMin', title: '实际最小值', width: 100, align: 'right' },
                { field: 'dFltSjMax', title: '实际最大值', width: 100, align: 'right' },
                { field: 'dFltBdMin', title: '标定最小值', width: 100, align: 'right' },
                { field: 'dFltBdMax', title: '标定最大值', width: 100, align: 'right' },
                { field: 'dVchUnit', title: '单位', width: 50, align: 'right' }

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
    $('#dg').datagrid('hideColumn', 'dIntDataID')

});
//取消报警点
function bjdqx() {
    var row = $('#dg').datagrid('getSelected');
    var para = {
        vDid: row.dIntdizhiID,
        vCjdz: row.dVchCjdz,
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
function doSearch() {
    $('#dg').datagrid('load', {
        vsb: $('#isb').val(),
        vmh: $('#imh').val()
    });
}