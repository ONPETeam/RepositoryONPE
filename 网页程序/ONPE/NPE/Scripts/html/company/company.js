var action = "";
$.extend($.fn.validatebox.defaults.rules, {
    phone: {// 验证电话号码
        validator: function (value) {
            return /^((\d{2,3})|(\d{3}\-))?(0\d{2,3}|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
        },
        message: '电话格式不正确,请使用下面格式:020-88888888'
    }
});

$(function () {


    $('#dg').datagrid({
        url: '../../ashx/Company/CompanyHandler.ashx?action=show',
        //            height: 'auto',
        method: 'post',
        striped: true,
        singleSelect: true,
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: true, //分页控件
        pagePosition: 'bottom', //分页控件位置
        hideColumn: 'dIntCompanyID',
        remoteSort: true,
        singleSelect: true,
        fit: true,
        columns: [[
                { field: 'dIntCompanyID', title: '公司编号', width: 150, align: 'center' },
                { field: 'dVchCompanyName', title: '公司名称', width: 220, align: 'center', sortable: true },
                { field: 'dVchShortName', title: '公司简称', width: 150, align: 'center' },
                { field: 'dVchZZJGDM', title: '组织机构代码', width: 150, align: 'center' },
                { field: 'dVchAddress', title: '地址', width: 150, align: 'center', sortable: true },
                { field: 'dVchPhone', title: '联系电话', width: 150, align: 'center', sortable: true },
                { field: 'dVchWeb', title: '公司主页', width: 150, align: 'center', sortable: true },
                { field: 'dVchEmail', title: '公司邮箱', width: 150, align: 'center', sortable: true },
                { field: 'dIntFlagSelf', title: '是否本公司', width: 150, align: 'center', sortable: true }
            ]],
        toolbar: '#tb',
        onLoadSuccess: function (data) {
            for (var i = 0; i < data.rows.length; i++) {
                if (data.rows[i].dVchAddress != undefined) {
                    var mStrAddress = data.rows[i].dVchAddress;
                    toolcontent = "<tr><td>具体内容：" + mStrAddress + " </td></tr>";
                }
                toolTipContent = "<table style='width:200px;'>" + toolcontent + "</table>";
                addTooltip(toolTipContent, 'content-' + i);
            }
        },
        onLoadError: function () {
        }
    });
    //设置分页控件  
    var p = $('#dg').datagrid('getPager');
    $(p).pagination({
        pageSize: 10, //每页显示的记录条数，默认为10 
        pageList: [5, 10, 15], //可以设置每页记录条数的列表 
        beforePageText: '第', //页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });

    $('#ShowWin').window({
        striped: true,
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
});
function doSearch() {
    $('#dg').datagrid('load', {
        searchCompanyName: $('#searchName').textbox('getValue')
    });
};
//显示添加窗体
function ShowAdd() {
    $('#ShowWin').window('open').panel({ title: '添加公司信息' });
    action = "add";
};
//显示编辑窗体
function ShowEdit() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm("操作提示", "您确定要编辑该行数据吗？", function (data) {
            if (data) {
                $('#ShowWin').window('open').panel({ title: '编辑公司信息' });
                action = "edit";
                $('#company_id').val(row.dIntCompanyID.toString());
                $('#companyName').textbox('setText', row.dVchCompanyName);
                $('#shortName').textbox('setText', row.dVchShortName);
                $('#zzjgdm').textbox('setText', row.dVchZZJGDM);
                $('#companyAddress').textbox('setText', row.dVchAddress);
                $('#companyPhone').val(row.dVchPhone);
                $('#companyWeb').val(row.dVchWeb);
                $('#companyMail').val(row.dVchEmail);
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
//删除操作提示
function ShowDel() {
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
            if (data) {
                delCompany(row.dIntCompanyID);
            }
        });
    } else {
        showMsg("操作提示", "您未选择任何行！", "info");
    }
};
function delCompany(companyID) {
    $.ajax({
        url: '../../ashx/Company/CompanyHandler.ashx?action=del&companyID=' + companyID,
        data: null,
        type: 'post',
        dataType: 'text',
        success: function (msg) {
            if (msg == '1') {
                showMsg("操作提示", "删除成功！", "info")
                $('#dg').datagrid('reload');
            } else {
                showMsg("操作提示", "删除失败！", "error")
            }
        }
    });
};
function SaveContent() {
    switch (action) {
        case 'add':
            addCompany();
            break;
        case 'edit':
            editCompany();
            break;
    }
};
function addCompany() {
    var companyInfo = {
        companyName: $('#companyName').val(),
        shortName: $('#shortName').val(),
        zzjgdm: $('#zzjgdm').val(),
        companyAddress: $('#companyAddress').val(),
        companyPhone: $('#companyPhone').val(),
        companyWeb: $('#companyWeb').val(),
        companyMail: $('#companyMail').val()
    };
    $.ajax({
        url: '../../ashx/Company/CompanyHandler.ashx?action=add',
        data: companyInfo,
        type: 'post',
        dataType: 'text',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success.toString() == "true") {
                $('#tt').form('clear');
                $('#dg').datagrid('reload');
                showMsg("操作提示", "添加成功！", "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        eror: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};
function editCompany() {
    var companyInfo = {
        companyID: $('#company_id').val(),
        companyName: $('#companyName').val(),
        shortName: $('#shortName').val(),
        zzjgdm: $('#zzjgdm').val(),
        companyAddress: $('#companyAddress').val(),
        companyPhone: $('#companyPhone').val(),
        companyWeb: $('#companyWeb').val(),
        companyMail: $('#companyMail').val()
    };
    $.ajax({
        url: '../../ashx/Company/CompanyHandler.ashx?action=edit',
        data: companyInfo,
        type: 'post',
        dataType: 'text',
        success: function (data) {
            var result = eval('(' + data + ')');
            if (result.success.toString() == "true") {
                closeAddWin();
                showMsg("操作提示", "编辑成功！", "info")
            } else {
                showMsg("操作提示", result.msg, "error")
            }
        },
        eror: function (xhr, responseData, status) {
            showMsg("操作提示", xhr.responseText, "error")
        }
    });
};
function closeAddWin() {
    $('#ShowWin').window('close');
    $('#dg').datagrid('reload');
}