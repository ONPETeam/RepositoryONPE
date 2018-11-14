/***************************************************************************************************************************/
/*
*	任务工单相关格式化函数
*/

function remarkFormater(value, row, index) {
    if (value && value.length > 8) {
        var content = value.substring(0, 8) + "...";
        return '<div id="content-' + index + '" style="width:auto;" class="easyui-panel">' + content + '</div>';
    } else {
        return value;
    }
}

function addTooltip(tooltipContentStr, tootipId) {
    //添加相应的tooltip     
    $('#' + tootipId).tooltip({
        position: 'bottom',
        content: tooltipContentStr,
        onShow: function () {
            $(this).tooltip('tip').css({
                backgroundColor: 'white',
                borderColor: '#97CBFF'
            });
        }

        //                    onPosition: function () {
        //                        $(this).tooltip('tip').css('left', $(this).offset().left);
        //                        $(this).tooltip('arrow').css('left', 20);
        //                    }

    });
}

function remarkFormater1(value, row, index) {
    if (value && value.length > 8) {
        var content = value.substring(0, 8) + "...";
        return '<a style="width:auto;" title= "' + value + '" class="note">' + content + '</a>';
    } else {
        return value;
    }
}

function addTooltip1(tooltipContentStr) {
    //添加相应的tooltip     
    $('.note').tooltip({
        position: 'bottom',
        content: tooltipContentStr,
        onShow: function () {
            $(this).tooltip('tip').css({
                backgroundColor: 'white',
                borderColor: '#97CBFF'
            });
        }
        //                    onPosition: function () {
        //                        $(this).tooltip('tip').css('left', $(this).offset().left);
        //                        $(this).tooltip('arrow').css('left', 20);
        //                    }

    });
}

function showMsg(title, content, ico) {
    $.messager.alert(title, content, ico);
}
function strFormat(value, row, index) {
    var abValue = value;
    if (value.length >= 8) {
        abValue = value.substring(0, 8) + "...";
    }
    var content = '<a href="#" title="' + value + '" class="easyui-tooltip" >' + abValue + '</a>';
    return content;
}

/*****测试*/
function strFormatQZtest(value, row, index) {
    var abValue = '签字';
    var content = "";
    if (value == "") {
        var content = '<a href="#" class="easyui-linkbutton" id="qz">签字</a>';
    }
    else {
        content = value;
    }
    return content;
}
/******/
function strFormatQZ1(value, row, index) {
    var abValue = '签字';
    var content = "";
    if (value == "") {
        content = '<a href="javascript:void(0)" class="easyui-linkbutton" id="qz1-' + index + '" >签字</a>';
    }
    else {
        content = value;
    }

    return content;
}
function strFormatQZ2(value, row, index) {
    var abValue = '签字';
    var content = "";
    if (value == "") {
        var content = '<a href="javascript:void(0)" class="easyui-linkbutton" id="qz2-' + index + '" >签字</a>';
    }
    else {
        content = value;
    }

    return content;
}
function strFormatQZ3(value, row, index) {
    var abValue = '签字';
    var content = "";
    if (value == "") {
        var content = '<a href="javascript:void(0)" class="easyui-linkbutton" id="qz3-' + index + '" >签字</a>';
    }
    else {
        content = value;
    }
    return content;
}
/***************************************************************************************************************************/
/*
*	工作票相关格式化函数
*/
function strFormatStartDate(value, row, index) {
    var abValue = '点击开始';
    var content = "";
    if (value == "") {
        content = '<a href="javascript:void(0)" class="easyui-linkbutton" id="starttime-' + index + '" >' + abValue + '</a>';
    }
    else {
        content = value;
    }
    return content;
}
function strFormatEndDate(value, row, index) {
    var abValue = '点击完成';
    var content = "";
    if (value == "") {
        content = '<a href="javascript:void(0)" class="easyui-linkbutton" id="endtime-' + index + '" >' + abValue + '</a>';
    }
    else {
        content = value;
    }
    return content;
}
//格式化函数
function strFormatWorkItem(value, row, index) {
    var abValue = '查看内容';
    var content = "";
    if (value == "") {
        content = '<a href="javascript:void(0)" class="easyui-linkbutton" id="work-' + index + '" >' + abValue + '</a>';
    }
    else {
        content = value;
    }
    return content;
}

function strFormatWorkPeo(value, row, index) {
    var abValue = "负责人签字";
    var content = "";
    if (value == "") {
        content = '<a href="javascript:void(0)" class="easyui-linkbutton" id="workpeo-' + index + '" >' + abValue + '</a>';
    }
    else {
        content = value;
    }
    return content;
}
function strFormatWorkPeo1(value, row, index) {
    var abValue = "负责人签字";
    var content = "";
    if (value == "") {
        content = '<a href="javascript:void(0)" class="easyui-linkbutton" id="workpeo1-' + index + '" >' + abValue + '</a>';
    }
    else {
        content = value;
    }
    return content;
}

/***************************************************************************************************************************/
/*
*	停送电相关格式化函数
*/

function strFormatDate(value, row, index) {
    var abValue = '---';
    var content = "";
    if (value.split(' ')[1] == "0:00:00" || value.split(' ')[1] == "00:00:00") {
        content = abValue;
    }
    else {
        content = value;
    }
    return content;
}
/***************************************************************************************************************************/
/*
*	三级点检相关格式化函数
*/
function strFormatStandard(value, row, index) {
    var content = "";
    if (value == "1") {
        content = '√';
    }
    else {
        content = "";
    }
    return content;
}









/***************************************************************************************************************************/
/*
*	公共数据获取函数
*/
//获取单位信息
var getUnitData = function () {
    $.ajax({
        type: 'post',
        url: '../../ashx/rwxt/getUnitComTree.ashx',
        dataType: "json",
        data: {},
        async: false,
        success: function (data) {
            getUnitData = data;

        },
        error: function (xhr, ts, err) {
            alert('读取失败！');
        }
    });
}

//获取设备区域信息
var getEquipAreaData = function () {
    $.ajax({
        type: 'post',
        url: '../../ashx/rwxt/getAreaComtree.ashx',
        dataType: "json",
        data: {},
        async: false,
        success: function (data) {
            getEquipAreaData = data;

        },
        error: function (xhr, ts, err) {
            alert('读取失败！');
        }
    });
}

var getNowTime = function () {
    var myDate = new Date();
    var year = myDate.getFullYear();
    var month = myDate.getMonth() + 1;
    var day = myDate.getDate();
    var hour = myDate.getHours();
    var min = myDate.getMinutes();
    var sec = myDate.getSeconds();

    //6/1/2012 12:30:56
    return month + '/' + day + '/' + year + ' ' + hour + ':' + min + ':' + sec;
}

var getSeqValue = function () {

}


/***************************************************************************************************************************/

function aaa() {
    $('#qzWin').window('open');
}






function getCurrentPageTitle() {
    var pp = top.$('#tabs').tabs('getSelected');
    if (pp != null || pp != undefined) {
        return pp.panel('options').title;
    }
};

/*js的Trim（）函数*/
function trimStr(str) {
    return str.replace(/(^\s*)|(\s*$)/g, "");
};


/**
* @author 风骑士
* 
* @requires jQuery,EasyUI
* 
* 初始化datagrid toolbar
*/
getToolBar = function (data) {
    if (data.toolbar != undefined && data.toolbar != '') {
        var toolbar = [];
        $.each(data.toolbar, function (index, row) {
            var handler = row.handler;
            row.handler = function () { eval(handler); };
            toolbar.push(row);
        });
        return toolbar;
    } else {
        return [];
    }
};

function LoadTree(requestUrl, tree) {
    tree.tree({
        url: requestUrl,
        method: 'post',
        cascadeCheck: true,
        animate: true,
        checkbox: true
    });
};

/**扩展jQuery方法，获取URL参数**/
(function ($) {
    $.getUrlParam = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]); return null;
    }
})(jQuery);

var StringToDate = function (DateStr) {
    if (typeof DateStr == "undefined")
        return new Date();
    if (typeof DateStr == "date")
        return DateStr;
    var converted = Date.parse(DateStr);
    var myDate = new Date(converted);
    if (isNaN(myDate)) {
        DateStr = DateStr.replace(/:/g, "-");
        DateStr = DateStr.replace(" ", "-");
        DateStr = DateStr.replace(".", "-");
        var arys = DateStr.split('-');
        switch (arys.length) {
            case 7:
                myDate = new Date(arys[0], --arys[1], arys[2], arys[3], arys[4], arys[5], arys[6]);
                break;
            case 6:
                myDate = new Date(arys[0], --arys[1], arys[2], arys[3], arys[4], arys[5]);
                break;
            default:
                myDate = new Date(arys[0], --arys[1], arys[2]);
                break;
        };
    };
    return myDate;
}