
    var plcddz_code;
    $(document).ready(function () {
//        var var_plcddzid = $(parent.frames['leftFrame58'].document).find('#iplcddzid');
        var var_plcddzid = parent.$("leftFrame58").contents().find("#iplcddzid");
        plcddz_code = var_plcddzid.val();
        $('#dg').datagrid({
            url: '../../ashx/plc/ahplckglcj.ashx?action=grid',
            queryParams: {
                ddzcz: plcddz_code
            },
            method: 'post',
            loadMsg: "正在努力加载数据，请稍后...",
            pagination: true, //分页控件
            remoteSort: true,
            pagePosition: 'bottom', //分页控件位置
            rownumbers: true,
            singleSelect: true,
            fit: true,
            striped:true,
            columns: [[
                { field: 'dIntDataID', title: '数据id', width: 60, align: 'right' },
                { field: 'dIntdizhiID', title: '点地址ID', width: 100, align: 'right' },
                { field: 'dVchAddress', title: '点地址', width: 100, align: 'right', sortable: true },
                { field: 'dVchAllAdress', title: '采集地址', width: 100, align: 'right' },
           
                { field: 'dDatGetTime', title: '获取时间', width: 200, align: 'right', formatter: function (value, row, index) {
                    var unixTimestamp = new Date(value);
                    return unixTimestamp.toLocaleString();
                }
                },
                { field: 'dIntState', title: '数据类型（报警）', width: 150, align: 'right' },
                { field: 'dVchDanwei', title: '单位', width: 150, align: 'right' },
                { field: 'dVchRemark', title: '备注', width: 350, align: 'right' },

            ]],

            width: 1066

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
        $('#dg').datagrid('hideColumn', 'dVchAllAdress')
        $('#dg').datagrid('hideColumn', 'dIntdizhiID')
        $('#dg').datagrid('hideColumn', 'dVchDanwei')
    });
    function lsclick() {

        $('#dg').datagrid('load', {
            ddzcz: $('#ilssj').val()
        });
    };
//    $('body').everyTime('5s', function () {
//        $('#dg').datagrid('reload');
//    });
