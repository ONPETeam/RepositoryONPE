$(document).ready(function () {
    $('#dg').datagrid({
        url: '../../ashx/tsd/TSDQueryHandler.ashx?action=examinedata',
        method: 'post',
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        pageSize: 20, //每页显示的记录条数，默认为20 
        pageList: [10, 20, 50], //可以设置每页记录条数的列表 
        remoteSort: false,
        singleSelect: true,
        rownumbers: true,
        fit: true,
        striped: true, //行背景交换
        columns: [[
                { field: 'examine_id', title: '审核单编号', hidden: true },
                { field: 'examine_status', title: '审核单状态', align: 'center',
                    formatter: function (value, rowIndex, rowData) {
                        if (value != null) {
                            if (value.toString() == "-99") {
                                return "已撤销";
                            }
                            if (value.toString() == "0") {
                                return "正常";
                            }
                        }
                    }
                },
                { field: 'examine_time', title: '审核时间', align: 'center' },
                { field: 'examine_people', title: '审核人编号', hidden: true },
                { field: 'employee_name', title: '审核人', align: 'center' },
                { field: 'examine_result', title: '审核结果', align: 'center',
                    formatter: function (value, rowIndex, rowData) {
                        if (value != null) {
                            if (value.toString() == "0") {
                                return "审核拒绝";
                            }
                            if (value.toString() == "1") {
                                return "审核通过";
                            }
                        }
                    }
                },

                { field: 'equip_code', title: '设备编号', hidden: true },
                { field: 'equip_name', title: '设备', align: 'center' },
                { field: 'equip_value', title: '设备状态', align: 'center',
                    formatter: function (value, rowIndex, rowData) {
                        if (value != null) {
                            if (value.toString() == "0") {
                                return "停止";
                            }
                            if (value.toString() == "1") {
                                return "运行";
                            }
                        }
                        return "未知";
                    }
                },
                { field: 'value_time', title: '设备状态取值时间', align: 'center' },
                { field: 'examine_remark', title: '审核备注', align: 'center' }

            ]]
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
})
function SearchData() {
    $('#dg').datagrid('load', {
        request_type: $("#search_request_type").combobox("getValue"),
        examine_start: $("#search_examine_start").datetimebox("getValue"),
        examine_end: $("#search_examine_end").datetimebox("getValue"),
        examine_result: $("#search_examine_result").datetimebox("getValue")
    });
}