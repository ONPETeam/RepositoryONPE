
    var selRow;
    $(document).ready(function () {


        $('#dg').datagrid({
            url: '../../ashx/plc/ahplcgzbj.ashx?action=grid',
            idField: "dIntID",
            method: 'post',
            loadMsg: "正在努力加载数据，请稍后...",
            pagination: true, //分页控件
            remoteSort: true,
            pagePosition: 'bottom', //分页控件位置
            rownumbers: true,
            //            view: detailview,
            //            detailFormatter:function(index,row){
            //					return '<div id="ddv-' + index + '" style="padding:5px 0"></div>';
            //				},
            //				onExpandRow: function(index,row){
            //					$('#ddv-'+index).panel({
            //						border:false,
            //						cache:false,
            //						href: 'datagrid_data1.json?itemid=' + row.itemid,
            //						onLoad:function(){
            //							$('#dg').datagrid('fixDetailRowHeight',index);
            //						}
            //					});
            //					$('#dg').datagrid('fixDetailRowHeight',index);
            //				},
            fit: true,
            striped:true,
            singleSelect: true,
            columns: [[
                { field: 'dIntID', title: '故障id', width: 60, align: 'right' },
                { field: 'dIntPLCdianID', title: '点地址ID', width: 100, align: 'right' },
                { field: 'dVchAddress', title: '点地址', width: 100, align: 'right' },
                { field: 'dVchBaojingValue', title: '报警值', width: 100, align: 'right' },
                { field: 'dVchBaojingMiaoshu', title: '故障描述', width: 100, align: 'right' },
                { field: 'dIntBiaozhi', title: '处理标识', width: 150, align: 'right' },
                { field: 'dDaeBaojingShijian', title: '报警时间', width: 200, align: 'right', formatter: function (value, row, index) {
                    var unixTimestamp = new Date(value);
                    return unixTimestamp.toLocaleString();
                }
                },
                { field: 'dVchGzCsYy', title: '故障产生原因', width: 350, align: 'right' },
                { field: 'dVchCLBF', title: '处理办法', width: 200, align: 'right' },


            ]],
            onSelect: function (index, row) {
                selRow = row.dIntPLCdianID;
            },
            width: 1066,
            toolbar: [{
                text: '相关设备',
                iconCls: 'icon-add',
                handler: function () { Getequid() }
            }, '-', {
                text: '相关图纸',
                iconCls: 'icon-edit',
                handler: function () { GetFile1() }
            }]
            //            rowStyler: function (index, row) { if (index % 2 == 0) { return 'background-color:#ccccff;'; } },
            //striped: true, pagination: true, rownumbers: true, singleSelect: true, pageNumber: 1, pageSize: 8, pageList: [1, 2, 4, 8, 16, 32], showFooter: true,

        });

        var p = $('#dg').datagrid('getPager');
        $(p).pagination({
            pageSize: 10, //每页显示的记录条数，默认为10 
            pageList: [10, 20, 30], //可以设置每页记录条数的列表 
            beforePageText: '第', //页数文本框前显示的汉字 
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
        });
        $('#dg').datagrid('hideColumn', 'dIntID')
        $('#dg').datagrid('hideColumn', 'dIntPLCdianID')
        $('#dg').datagrid('hideColumn', 'dIntBiaozhi')
    });


    var url;
    function Getequid() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $('#dlg').dialog('open').dialog('setTitle', '相关设备');
            $('#fm').form('load', row);
            //            url = '../../ashx/plc/plcmanagerOperator.ashx?type=edit&ID=' + row.dIntPLCID;

            $("#idizhiName").val(row.dVchAddress);
            $("#iGzMs").val(row.dVchBaojingMiaoshu);
            $("#iBaojingValue").val(row.dVchBaojingValue);
            $("#iDateTime").val(row.dDaeBaojingShijian);
            $("#iGzCsYy ").val(row.dVchGzCsYy);
            $("#iGzClBf").val(row.dVchCLBF);
        }
        GetEquipdg();

    }


    function GetEquipdg() {
        $('#dgSb').datagrid({
            url: '../../ashx/plc/ahplcAndSb.ashx?action=grid',
            method: 'post',
            queryParams: {
                vddz: selRow
            },
            loadMsg: "正在努力加载数据，请稍后...",
            pagination: true, //分页控件
            pageSize: 10,
            pagePosition: 'bottom', //分页控件位置
            singleSelect: true,
            columns: [[
                { field: 'dVchPLCAddress', title: '隐藏ID', hidden: true },
                { field: 'equip_code', title: '设备编码', width: 100 },
                { field: 'equip_innum', title: '自编码', width: 200, hidden: true },
                { field: 'equip_name', title: '设备名称', width: 100 },
                { field: 'equip_mark', title: '设备符号', width: 100 },
                { field: 'equip_type', title: '规格型号', width: 100 },
                { field: 'area_name', title: '所属区域', width: 100 },
                { field: 'equip_parent', title: '上级设备', width: 200, hidden: true },
                { field: 'equip_manageDep', title: '主管部门', width: 200, hidden: true },
                { field: 'equip_checkDep', title: '维护部门', width: 200, hidden: true },
                { field: 'equip_header', title: '负责人', width: 200, hidden: true },
                { field: 'equip_remark', title: '备注', width: 200, hidden: true }

            ]],
            width: 500

        });
        var p = $('#dgSb').datagrid('getPager');
        $(p).pagination({
            pageSize: 10, //每页显示的记录条数，默认为10 
            pageList: [10, 20, 50], //可以设置每页记录条数的列表 
            beforePageText: '第', //页数文本框前显示的汉字 
            afterPageText: '页    共 {pages} 页',
            displayMsg: ' {from} - {to} 条记录   共 {total} 条记录'
        });
    }
    //
    function GetFiledata() {
        $('#dgFile').show();
        $('#dgFile').datagrid({
            url: '../../ashx/plc/ahplcAndFile.ashx?action=grid',
            method: 'post',
            queryParams: {
                vddz: selRow
            },
            loadMsg: "...",
            //            pagination: true, //分页控件
            //            pageSize: 10,
            //            pagePosition: 'bottom', //分页控件位置
            singleSelect: true,
            columns: [[

                { field: 'file_code', title: '文件编号', width: 100, hidden: true },
                { field: 'file_name', title: '文件名称', width: 110 },
                { field: 'file_type', title: '文件类型', width: 100, hidden: true },
                { field: 'file_size', title: '文件大小', width: 100, hidden: true },
                { field: 'file_time', title: '文件时间', width: 100, hidden: true },
                { field: 'file_people', title: '上传人员', width: 100, hidden: true }
            //                { field: 'file_name', title: '文件名称', width: 150,
            //                    formatter: function (value, row) {
            //                        var str = "";
            //                        if (value != "" || value != null) {

            //                            str = value + "<img style=\"height: 20px;width: 20px;\" src=\"../../img/Search.png\" onclick=\"showFileInfo('" + row.file_code + "')\"/>";
            //                            return str;
            //                        }
            //                    }
            //                }

            ]],

            onSelect: function (rowIndex, rowData) {
                Getpic(rowData.file_code);
            },
            width: 120

        });
        //        var p = $('#dgFile').datagrid('getPager');
        //        $(p).pagination({
        //            pageSize: 10, //每页显示的记录条数，默认为10 
        //            pageList: [10, 20, 50], //可以设置每页记录条数的列表 
        //            beforePageText: '第', //页数文本框前显示的汉字 
        //            afterPageText: '页    共 {pages} 页',
        //            displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
        //        });
    }

    function GetFile1() {
        //        var row = $('#dg').datagrid('getSelected');
        //        if (row) {
        //            $('#dlg').dialog('open').dialog('setTitle', '相关设备');
        //            $('#fm').form('load', row);
        //            //            url = '../../ashx/plc/plcmanagerOperator.ashx?type=edit&ID=' + row.dIntPLCID;

        //            $("#idizhiName").val(row.dVchAddress);
        //            $("#iGzMs").val(row.dVchBaojingMiaoshu);
        //            $("#iBaojingValue").val(row.dVchBaojingValue);
        //            $("#iDateTime").val(row.dDaeBaojingShijian);
        //            $("#iGzCsYy ").val(row.dVchGzCsYy);
        //            $("#iGzClBf").val(row.dVchCLBF);
        //        }
        //        GetEquipdg();
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $('#dlgFile').dialog('open').dialog('setTitle', '相关图纸');
        }
        GetFiledata();
    }

    function Getpic(file_code) {
        if (file_code != "") {
            $("#imageFullScreen").attr('src', '../../ashx/file/fileHandler.ashx?action=out&file_code=' + file_code);
        }
        $('#imageFullScreen').smartZoom({ 'containerClass': 'zoomableContainer' });
    }
    $('body').everyTime('5s', function () {
        $('#dg').datagrid('reload');
    });
