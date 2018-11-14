var treeNodes;
var menuNode;

function RefreshTree() {
    $('#tt').tree('reload');
};
function getNode(node) {
    //双击树节点，调用任务单明细
    if (parent.currentPage == '3') {
        var object1 = $(parent.frames["mainFrame3"].document).find("#equipId"); //这是jquery对象，不能使用easyui的方法，也不能使用样式，不然值不变
        object1.val(node.id);
    }
}

$(document).ready(function () {
    //        getData();
    $('#tt').tree({
        checkbox: false,
        animate: true,
        url: '../../ashx/plc/plcmanager.ashx?action=tree&area_parent=0',
        //data: treeNodes,
        onContextMenu: function (e, node) {
            e.preventDefault();
            $('#tt').tree('select', node.target);
            menuNode = node;
            //                if (menuNode.attributes == 'plc') {
            //                    $('#mm').menu('enableItem', $('#mm').menu('findItem', '添加子区域').target);
            //                    $('#mm').menu('enableItem', $('#mm').menu('findItem', '添加设备').target);
            //                    $('#mm').menu('disableItem', $('#mm').menu('findItem', '添加子设备').target);
            //                }
            //                if (menuNode.attributes == 'ddz' ) {
            //                    $('#mm').menu('disableItem', $('#mm').menu('findItem', '添加子区域').target);
            //                    $('#mm').menu('disableItem', $('#mm').menu('findItem', '添加设备').target);
            //                    $('#mm').menu('enableItem', $('#mm').menu('findItem', '添加子设备').target);
            //                }
            $('#mm').menu('show', {
                left: e.pageX,
                top: e.pageY
            });
        },

        onDblClick: function (node) {
            if (node.attributes == 'equip' || node.attributes == 'lastEquip') {
                getNode(node);
            }
        },
        onBeforeExpand: function (node, param) {
            if (node.attributes == 'xitong') {
                $('#tt').tree('options').url = "../../ashx/plc/plcmanager.ashx?action=xt&area_parent=" + node.id;
            }
            if (node.attributes == 'plc') {

                $('#tt').tree('options').url = "../../ashx/plc/plcmanager.ashx?action=plc&area_parent=" + node.id;
            }
            if (node.attributes == 'ddz') {
                $('#tt').tree('options').url = "../../ashx/plc/plcmanager.ashx?action=ddz&area_parent=" + node.id;
            }
        },



        onSelect: function (node) {
            //                alert(node.attributes);
            $('#iplcddzid').val("");
            $('#tt').tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
            //点击plc树显示需要用

            //plc
            if (node.attributes == 'ddz') {
                parent.LoadPropertyData('ashx/plc/plcmanager.ashx?action=prop&area_parent=' + node.id);
            }

            if (node.attributes == 'dc') {


                $('#iplcddzid').val(node.id);
                if (parent.currentPage == '55') {
                    var object1 = $(parent.frames["mainFrame55"].document).find("#ilssj");
                    object1.val(node.id);
                    object1.click();
                }
                if (parent.currentPage == '0') {
                    parent.main.plcmk(55);
                }

                parent.LoadPropertyData('ashx/plc/plcmanager.ashx?action=propddz&area_parent=' + node.id);
            }
        },
        onBeforeLoad: function (node, param) {
            $('#loading').show();
        },
        onLoadSuccess: function (node, data) {
            $('#loading').hide();
        }
    });

});
function menuHandler(item) {
    switch (item.name) {
        case 'm_add_area':
            addNewAreaNode();
            break;
        case 'm_add_top_equip':
            addNewEquipNode();
            break;
        case 'm_add_equip':
            addNewEquipNode();
            break;
        //            case 'm_edit':  
        //                editNode();  
        //                break;  
        case 'm_del':
            delMsgDialog();
            break;
        default:
            break;
    }
};
//删除操作提示
function delMsgDialog() {
    parent.$.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
        if (data) {
            delNode();
        }
        else {
        }
    });
};
function addNewAreaNode() {
    parent.main.sbgl(11);
    var objectName = $(parent.frames["mainFrame11"].document).find("#area_parent_name");
    //        var s = objectName.val();
    alert(objectName.id);
    objectName.val('12333');
    var objectID = $(parent.frames["mainFrame11"].document).find("#area_parent_id")
    objectID.val(menuNode.id);
    //parent.main.addTabHtml("新增区域", 'html/sbgl/areaMng.htm?action=add&areaparent=' + menuNode.id);
};
function addNewEquipNode() {
    parent.main.addTabHtml("新增设备", 'html/sbgl/equipMng.htm?equipid=' + menuNode.id);
};
//    function editNode() {
//        if (menuNode.attributes == 'area' || menuNode.attributes == 'lastArea') {
//            parent.main.addTabHtml("编辑区域", 'html/sbgl/areaMng.htm?action=edit&areaid=' + menuNode.id);
//        }
//        if (menuNode.attributes == 'equip' || menuNode.attributes == 'lastEquip') {
//            parent.main.addTabHtml("新增区域", 'html/sbgl/equipMng.htm?equipid=' + menuNode.id);
//        }
//    };

function delNode() {

    if (menuNode.attributes == 'area' || menuNode.attributes == 'lastArea') {
        $.ajax({
            url: '../../ashx/sbgl/areaHandler.ashx?action=del&area_id=' + menuNode.id,
            data: null,
            type: 'post',
            dataType: 'text',
            success: function (msg) {
                if (msg == '1') {
                    parent.$.messager.alert("操作提示", "删除成功！", "info");
                    $('#tt').tree('reload');
                } else {
                    parent.$.messager.alert("操作提示", "删除失败！", "error");
                }
            }
        });
    }
    if (menuNode.attributes == 'equip' || menuNode.attributes == 'lastEquip') {
        $.ajax({
            url: '../../ashx/sbgl/equipHandler.ashx?action=del&equip_id=' + menuNode.id,
            data: null,
            type: 'post',
            dataType: 'text',
            success: function (msg) {
                if (msg == '1') {
                    showMsg("操作提示", "删除成功！", "info")
                    $('#tt').tree('reload');
                } else {
                    showMsg("操作提示", "删除失败！", "error")
                }
            }
        });
    }
};
//获取数据
var getData = function () {
    $.ajax({
        type: 'post',
        url: '../ashx/sbgl/area.ashx',
        dataType: "json",
        data: {},
        async: false,
        success: function (data) {
            treeNodes = data;
        },
        error: function (xhr, ts, err) {
            alert('读取失败！');
        }
    });
}
function append() {
    var t = $('#tt');
    var node = t.tree('getSelected');
    //        t.tree('append', {
    //            parent: (node ? node.target : null),
    //            data: [{
    //                text: 'new item1'
    //            }, {
    //                text: 'new item2'
    //            }]
    //        });
    $('#dlg').dialog('open').dialog('setTitle', 'New User');
    //        $('#fm').form('clear');
    $("#iPLCID").val("");
    $("#iPLCName").val("");
    $("#iIPAdress").val("");

    $("#idVchRemark").val("");
    $("#d1 ").combobox('select', 0);
    $("#d2").combobox('select', 0);


    url = '../../ashx/plc/plcmanagerOperator.ashx?type=add';
}
//    function append() {
//        var t = $('#tt');
//        var node = t.tree('getSelected');
//        t.tree('append', {
//            parent: (node ? node.target : null),
//            data: [{
//                text: 'new item1'
//            }, {
//                text: 'new item2'
//            }]
//        });
//    }
//    function removeit() {
//        var node = $('#tt').tree('getSelected');
//        $('#tt').tree('remove', node.target);
//    }
//    function collapse() {
//        var node = $('#tt').tree('getSelected');
//        $('#tt').tree('collapse', node.target);
//    }
//    function expand() {
//        var node = $('#tt').tree('getSelected');
//        $('#tt').tree('expand', node.target);
//    }