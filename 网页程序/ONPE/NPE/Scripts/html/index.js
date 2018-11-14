var usercode = "";
var userinfo = {};
var main = {};

//退出登录
function exitSys() {
    $.messager.progress();
    $.messager.defaults = { ok: "确认退出", cancel: "继续登陆" };
    $.messager.confirm("操作提示", "您确定要退出当前账号么？", function (data) {
        if (data) {
            $.ajax({
                url: 'ashx/sso/ssoclientHandler.ashx',
                data: {
                    "action": "logout",
                    "equip_type": "1",
                    "way_type": "1"
                },
                datatype: 'json',
                type: 'post',
                success: function (data) {
                    $.messager.progress('close');
                    var result = eval('(' + data + ')');  //字符串转json
                    if (result.success) {
                        window.location.href = 'Login.htm';
                    }
                    else {
                        alert(result.msg);
                    }
                },
                error: function (xhr, responseData, status) {
                    $.messager.progress('close');
                }
            });
        }
    });
};
//确认并弹出修改密码框
function confirmEditPwd() {
    $.messager.defaults = { ok: "确认修改", cancel: "暂不修改" };
    $.messager.confirm("操作提示", "您确定要修改当前账号的密码么？", function (data) {
        if (data) {
            $('#editPwdWin').window('open');
        }
    });
};
//关闭密码修改框
function closeEditPwdWin() {
    $('#editPwdWin').window('close');
};
//修改密码
function editPwd() {
    $("#edit_user_pwd_form").form("submit", {
        url: "ashx/user/userHandler.ashx",
        onSubmit: function (param) {
            $('#edit_user_pwd_button').linkbutton('disable');  //点击就不可用，防止连击
            param.action = 'editpwd';
            param.user_code = usercode;
            if ($(this).form('validate'))
                return true;
            else {
                $('#edit_user_pwd_button').linkbutton('enable');   //恢复按钮
                return false;
            }
        },
        success: function (data) {
            $('#ui_user_userchangepwd_edit').linkbutton('enable');   //恢复按钮
            var result = eval('(' + data + ')');
            if (result.success) {
                //$("#ui_user_userchangepwd_dialog").dialog('destroy');  //销毁dialog对象（已跳转，不需要销毁了）
                $('#editPwdWin').window('close');
                $.messager.alert("操作提示", result.msg, "info", function () {
                    window.location.href = "Login.htm";
                });
            }
            else {
                $('#ui_user_userchangepwd_edit').linkbutton('enable');
                $.messager.alert("操作提示", "修改密码失败，请稍后再试！", "info");
            }
        }
    });
};

$(function () {
    var date = new Date();
    $('#copyright_end_tiem').html(date.getFullYear().toString());
    //两次密码验证
    $.extend($.fn.validatebox.defaults.rules, {
        equals: {
            validator: function (value, param) {
                return value == $(param[0]).val();
            },
            message: '两次密码输入不一致，请重新输入！'
        }
    });
    $('#editPwdWin').window({
        title: '修改密码',
        modal: true,
        closed: true,
        minimizable: false,
        collapsible: true
    });
    var menuData;
    $.ajax({
        url: 'ashx/user/right/getUserMenuHandler.ashx',
        data: { 'action': 'getMenu',
            'menu_class': '1'
        },
        type: 'post',
        async: false,
        dataType: 'text',
        success: function (data) {
            menuData = eval('(' + data + ')');
        },
        error: function (xhr, responseData, status) {
            if (xhr.status.toString() == "200") {
                menuData = eval('(' + xhr.responseText.toString() + ')');
            }
        }
    });
    $('#rr').ribbon({
        data: menuData,
        onClick: function (name, target) {
            var selectButtonProp = $(target).linkbutton('options');
            main.addTabHtml(selectButtonProp.text, name, selectButtonProp.iconCls);
        }
    });

    $('#title1')[0].innerHTML = main.showLeftHtml('html/sbgl/equipTree.htm', '1');
    $('#title2')[0].innerHTML = main.showLeftHtml('html/file/filetree.htm', '2');

    $('#title58')[0].innerHTML = main.showLeftHtml('html/plc/webplcAreaXtTree.htm', '58');
    $('#title59')[0].innerHTML = main.showLeftHtml('html/plc/webplcIPTree.htm', '59');

    getUser();


});

function getUser() {
    $.ajax({
        url: "ashx/user/userHandler.ashx",
        type: "post",
        data: { action: "getemployee" },
        dataType: "json",
        success: function (result) {
            if (result.success) {
                userinfo = result.msg;
                $('#main_employee_name').html(result.msg.company_name.toString() + '-' + result.msg.branch_name.toString() + '-' + result.msg.employee_name.toString());
                //                var loginTime = StringToDate(result.msg.login_time.replace('T', ' '));
                //                $('#main_login_time').html(loginTime.toLocaleDateString() + '' + loginTime.toLocaleTimeString());
                usercode = result.msg.user_code;
            }
        },
        error: function (xhr, responseData, status) {
            alert(xhr.statusText);
        }
    });
};

//获取属性数据
var LoadPropertyData = function (url, treeType) {
    $('#pg').propertygrid({
        url: url,
        showGroup: true,
        scrollbarSize: 0,
        onAfterEdit: function (rowIndex, rowData, changes) {
            switch (treeType) {
                case "file":
                    updateTreeNodeProp(
                            'ashx/file/fileHandler.ashx?action=sort',
                            {
                                file_code: $("#propid").val(),
                                file_sort: changes.value
                            },
                            function (msg) {
                                if (msg == "1") {
                                    $("#msg").text("文件排序成功！");
                                    $("#msg").stop(true, true).animate({ opacity: "show" }, 300, function () {
                                        $("#msg").animate({ opacity: "hide" }, 3000);
                                    });
                                    var s = document.getElementById('leftFrame2').contentWindow.document.getElementById('reloadNode');
                                    s.click();
                                } else {
                                    $("#msg").text("文件排序失败！");
                                    $("#msg").stop(true, true).animate({ opacity: "show" }, 300, function () {
                                        $("#msg").animate({ opacity: "hide" }, 3000);
                                    });
                                }
                            },
                            function (XMLHttpRequest, textStatus, errorThrown) {
                                $("#msg").text("文件排序失败！");
                                $("#msg").stop(true, true).animate({ opacity: "show" }, 300, function () {
                                    $("#msg").animate({ opacity: "hide" }, 3000);
                                });
                            }
                        );
                    break;
                case "diretory":
                    updateTreeNodeProp(
                        'ashx/file/diretoryHandler.ashx?action=sort',
                        {
                            diretory_code: $("#propid").val(),
                            diretory_sort: changes.value
                        },
                        function (msg) {
                            if (msg == "1") {
                                $("#msg").text("目录排序成功！");
                                $("#msg").stop(true, true).animate({ opacity: "show" }, 300, function () {
                                    $("#msg").animate({ opacity: "hide" }, 3000);
                                });
                                var s = document.getElementById('leftFrame2').contentWindow.document.getElementById('reloadNode');
                                s.click();
                            } else {
                                $("#msg").text("目录排序失败！");
                                $("#msg").stop(true, true).animate({ opacity: "show" }, 300, function () {
                                    $("#msg").animate({ opacity: "hide" }, 3000);
                                });
                            }
                        },
                        function (XMLHttpRequest, textStatus, errorThrown) {
                            $("#msg").text("目录排序失败！");
                            $("#msg").stop(true, true).animate({ opacity: "show" }, 300, function () {
                                $("#msg").animate({ opacity: "hide" }, 3000);
                            });
                        });
                    break;
            }

        }
    });
};

function updateTreeNodeProp(url, data, success, error) {
    $.ajax({
        type: 'post',
        url: url,
        data: data,
        dataType: 'text',
        success: success,
        error: error
    });
}

main.addRightHtml = function (html) {
    $("#title1")[0].innerHTML = "<iframe id='rightFrame' src='" + html + "' width='100%' height='100%' marginwidth='0px' marginheight='0px' frameborder='0'></iframe>";
};

main.showLeftHtml = function (html, num) {// 添加左侧HTML
    var iframhtm = "<iframe id='leftFrame" + num + "' src='" + html + "' width='100%' height='100%' marginwidth='0px' marginheight='0px' frameborder='0'></iframe>";
    return iframhtm;
}

main.addTabHtml = function (title, html, icon) {
    var tt = $('#tabs');

    if (tt.tabs('exists', title)) {//如果tab已经存在,则选中并刷新该tab    	
        tt.tabs('select', title);
        refreshTab({ tabTitle: title, url: html });
        SaveOperateRecord(html, title, '刷新');
    } else {
        if (html) {
            content = "<iframe id='mainFrame" + title + "' src='" + html + "' width='100%' height='100%' marginwidth='0px' marginheight='0px' frameborder='0'></iframe>";
        } else {
            content = '未实现';
        }
        tt.tabs('add', {
            title: title,
            closable: true,
            content: content,
            iconCls: icon,
            loadingMessage: '正在加载中......'
        });
        SaveOperateRecord(html, title, '进入');
    }
}

/**    
* 刷新tab
* @cfg 
*example: {tabTitle:'tabTitle',url:'refreshUrl'}
*如果tabTitle为空，则默认刷新当前选中的tab
*如果url为空，则默认以原来的url进行reload
*/
function refreshTab(cfg) {
    var refresh_tab = cfg.tabTitle ? $('#tabs').tabs('getTab', cfg.tabTitle) : $('#tabs').tabs('getSelected');
    if (refresh_tab && refresh_tab.find('iframe').length > 0) {
        var _refresh_ifram = refresh_tab.find('iframe')[0];
        var refresh_url = cfg.url ? cfg.url : _refresh_ifram.src;
        _refresh_ifram.src = refresh_url;
        //_refresh_ifram.contentWindow.location.href = refresh_url;
    }
};

function SaveOperateRecord(url, title, extra) {
    var operateInfo = {
        user_id: usercode,
        employee_name: userinfo.employee_name,
        equip_type: 1,
        equip_sign: 'PC电脑',
        way_type: 1,
        way_sign: '',
        menu_link: url,
        menu_title: title,
        menu_extra: extra,
        operate_remark: ''
    };
    $.ajax({
        type: 'post',
        url: 'ashx/user/userHandler.ashx?action=operate',
        data: operateInfo,
        dataType: 'text',
        success: function (data) {

        },
        error: function (xhr, responseData, status) {

        }
    });
}
