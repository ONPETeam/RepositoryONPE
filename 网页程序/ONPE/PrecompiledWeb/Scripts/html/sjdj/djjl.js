$(document).ready(function () {
    $('#dg').datagrid({
        view: detailview,
        title: '点巡检记录',
        url: '../../ashx/Mobile/dxj/ShowTCHandler.ashx?type=para1',
        queryParams: {
            equipcode: $('#search_equip_code').combotree('getValues')
        },
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
                { field: 'dVchTCNote', title: '点检单号', hidden: true },
                { field: 'equip_code', title: '设备编码', hidden: true },
                { field: 'equip_name', title: '设备名称', align: 'center', width: 120 },
                { field: 'area_id', title: '所属区域编码', hidden: true },
                { field: 'area_name', title: '所属区域', align: 'center', width: 120 },
                { field: 'dVchTCSpecialty', title: '点检专业', align: 'center', width: 120 },
                { field: 'dVchTCUnit', title: '点检单位', align: 'center', width: 120 },
                { field: 'branch_id', title: '部门编码', hidden: true },
                { field: 'branch_name', title: '部门', align: 'center', width: 120 },
                { field: 'dVchTCType', title: '点检类别', align: 'center', width: 120 },
                { field: 'employee_code', title: '点检人编码', hidden: true },
                { field: 'dVchTCPeople', title: '点检人', align: 'center', width: 120 },
                { field: 'dDaeTCDate', title: '点检时间', align: 'center', width: 160,
                    formatter: function (value, row, index) {
                        if (value && value != "") {
                            var vp = StringToDate(value.replace('T', ' '));
                            return vp.toLocaleDateString() + '' + vp.toLocaleTimeString();
                        } else {
                            return '';
                        }
                    }
                }
            ]],
        detailFormatter: function (index, row) {
            return '<div style="padding:2px"><table id="ddv-' + index + '"></table></div>';
        },
        onExpandRow: function (index, row) {
            $('#ddv-' + index).datagrid({
                url: '../../ashx/Mobile/dxj/dxjHandler.ashx?type=para5&TCNote=' + row.dVchTCNote,
                method: 'post',
                loadMsg: "正在努力加载数据，请稍后...",
                pagination: false, //分页控件
                remoteSort: false,
                singleSelect: true,
                rownumbers: true,
                height: 'auto',
                striped: true, //行背景交换
                columns: [[
                    { field: 'dVchTCNote', title: '点检单号', hidden: true },
                    { field: 'dVchTCDetail', title: '点检明细单号', hidden: true },
                    { field: 'dVchPartName', title: '点检部位', align: 'center', width: 120 },
                    { field: 'dVchContentName', title: '检查内容', align: 'center', width: 120 },
                    { field: 'dVchStandardName', title: '点检标准', hidden: true },
                    { field: 'dVchTCResult', title: '点检结果', align: 'center', width: 120 },
                    { field: 'dVchPartID', title: '部位ID', hidden: true },
                    { field: 'dVchContentID', title: '内容ID', hidden: true },
                    { field: 'dVchStandardID', title: '标准ID', hidden: true },
                    { field: 'dVchTCPic', title: '图片', align: 'center',
                        formatter: function (value, row, index) {
                            if (value && value.length > 0) {
                                var mStrPicID = value.split(",");
                                var mStrReturn = "";
                                for (var i = 0; i < mStrPicID.length; i++) {
                                    if (mStrPicID[i] != "") {
                                        mStrReturn = mStrReturn + "<img style=\"height: 20px;width: 20px;\" src=\"../../img/Search.png\" onclick=\"showFileInfo('" + mStrPicID[i] + "')\"/>";
                                    }
                                }
                                return mStrReturn;
                            }
                        }
                    },
                    { field: 'dVchTCAvi', title: '视频', hidden: true },
                    { field: 'dDaeTCDetailDate', title: '当前点检时间', align: 'center', width: 160,
                        formatter: function (value, row, index) {
                            if (value && value != "") {
                                var vp = StringToDate(value.replace('T', ' '));
                                return vp.toLocaleDateString() + '' + vp.toLocaleTimeString();
                            } else {
                                return '';
                            }
                        }
                    },
                    { field: 'dDaeTCNextDate', title: '下次点检时间', align: 'center', width: 160,
                        formatter: function (value, row, index) {
                            if (value && value != "") {
                                var vp = StringToDate(value.replace('T', ' '));
                                return vp.toLocaleDateString() + '' + vp.toLocaleTimeString();
                            } else {
                                return '';
                            }
                        }
                    },
                    { field: 'dVchXYZ', title: '坐标', align: 'center', width: 160,
                        formatter: function (value, row, index) {
                            if (value && value != "" && value != "null,null") {
                                return value;
                            }
                            else {
                                return "无坐标";
                            }
                        }
                    }
                ]],
                onResize: function () {
                    $('#dg').datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    setTimeout(function () {
                        $('#dg').datagrid('fixDetailRowHeight', index);
                    }, 0);
                }
            });
            $('#dg').datagrid('fixDetailRowHeight', index);
        }
    });
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    loadCombo();
});
function reloadDataGrid() {
    var selectEquip = $('#search_equip_code').combotree('getValues');
    $('#dg').datagrid('reload', {
        equipcode: selectEquip.toString()
    });
};
function loadCombo() {
    $('#search_equip_code').combotree(
    {
        onlyLeafCheck: true,
        multiple: true,
        url: '../../ashx/sbgl/areaHandler.ashx?action=combo&area_parent=0',
        animate: true,
        onBeforeExpand: function (node) {
            if (node.attributes == "area") {
                $('#search_equip_code').combotree("tree").tree("options").url = "../../ashx/sbgl/areaHandler.ashx?action=combo&area_parent=" + node.id + "&type=1";
            }
            if (node.attributes == "lastarea") {
                $('#search_equip_code').combotree("tree").tree("options").url = "../../ashx/sbgl/equipHandler.ashx?action=combo&area_id=" + node.id + "&type=1";
            }
        }
    });
}
function showFileInfo(fileCode) {
    LoadImage(fileCode);
    imgTemp = "1";
    $('#ImgContext').dialog({
        title: "图片预览",
        width: clientW,
        height: clientH,
        top: $(document).scrollTop() + ($(window).height() - clientH) * 0.5,
        resizable: true,
        cache: false,
        modal: true,
        fitColumns: true,
        onClose: function () {
            imgTemp = "";
        },
        onResize: function (width, height) {
            LoadImage(fileCode);
        }
    });
};
var LoadImage = function (fileCode) {
    clientW = $(document.body).width();
    clientH = $('#mainFrame点检记录', window.parent.document).height();
    var src = '../../ashx/file/fileHandler.ashx?action=out&file_code=' + fileCode;
    $("#ImgContext").html(" <img id='_img' src='" + src + "'/>");
    $('#_img').load(function () {
        //adjustImgSize($(this), $("#ImgContext").panel('options').width, $("#ImgContext").panel('options').height);
        $('#_img').smartZoom({ 'containerClass': 'zoomableContainer' });
    });
};
var clientH = 500;
var clientW = 700;
//var margin = 0;
//function adjustImgSize(img, boxWidth, boxHeight) {
//    var tempImg = new Image();
//    tempImg.src = img.attr('src');
//    var imgWidth = tempImg.width;
//    var imgHeight = tempImg.height;
//    alert(boxWidth.toString() + '/' + boxHeight.toString() + '/' + imgWidth.toString() + '/' + imgHeight.toString());
//    if ((boxWidth / boxHeight) >= (imgWidth / imgHeight)) {
//        img.width((boxHeight * imgWidth) / imgHeight);
//        img.height(boxHeight);
//        margin = (boxWidth - img.width()) / 2;
//        img.css("margin-left", margin);
//    }
//    else {
//        img.width(boxWidth);
//        img.height((boxWidth * imgHeight) / imgWidth);
//        alert(img.height());
//        margin = (boxHeight - img.height()) / 2;
//        img.css("margin-top", margin);
//    }
//};