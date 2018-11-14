var dgNode = $('#Nodedg');
var selNode;
var effectRowNode;
var editIndexNode = undefined;

var selNode1;

$(function () {

    $('#linenode').datagrid({
        url: '../../ashx/sjdj/djbzHandler.ashx?type=lineNode',
        method: 'post',
        singleSelect: true,
        collapsible: true,
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: false, //分页控件
        pageSize: 20,
        pagePosition: 'bottom', //分页控件位置

        columns: [[
                { field: 'dVchLine', title: '路线名称', width: 228, align: 'center' },
                { field: 'dVchNode', title: '节点名称', width: 228, align: 'center' },
                { field: 'dIntNodeIndex', title: '节点顺序', width: 70, align: 'center' }
            ]],

        onSelect: function (index, row) {
            
        }
    });
    $('#node').datagrid({
        url: '../../ashx/sjdj/djbzHandler.ashx?type=show1',
        method: 'post',
        singleSelect: true,
        collapsible: true,
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: false, //分页控件
        pageSize: 20,
        pagePosition: 'bottom', //分页控件位置

        columns: [[
                { field: 'dIntNodeNote', title: '节点ID', width: 70, align: 'center' },
                { field: 'dVchNode', title: '节点名称', width: 260, align: 'center' },
            ]],

        onSelect: function (index, row) {
            selNode1 = row.dIntNodeNote;
//            alert(selNode1);
        }
    });

    $('#Nodedg').datagrid({
        url: '../../ashx/sjdj/djbzHandler.ashx?type=show1',
        method: 'post',
        singleSelect: true,
        collapsible: true,
        loadMsg: "正在努力加载数据，请稍后...",
        pagination: false, //分页控件
        pageSize: 20,
        pagePosition: 'bottom', //分页控件位置

        columns: [[
                { field: 'dIntNodeNote', title: '节点ID', width: 70, align: 'center' },
                { field: 'dVchNode', title: '节点名称', width: 200, align: 'center', editor: "textbox" },
            ]],
        toolbar: [{
            text: '新增',
            iconCls: 'icon-add',
            handler: function () {
                if (endEditingNode()) {
//                    alert('123');
                    dgNode.datagrid('appendRow', {});
                    editIndexNode = dgNode.datagrid('getRows').length - 1;
                    dgNode.datagrid('selectRow', editIndexNode)
						.datagrid('beginEdit', editIndexNode);
                }
            }
        }, {
            text: '删除',
            iconCls: 'icon-cut',
            handler: function () {
                if (selNode != undefined) {
                    parent.$.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {
                        if (data) {
                            var row = dgNode.datagrid('getSelected');
                            if (row) {
                                var rowIndex = dgNode.datagrid('getRowIndex', row);
                                dgNode.datagrid('deleteRow', rowIndex);
                            }
                        }
                        else {
                        }
                    });
                }
                else {
                    parent.$.messager.alert("操作提示", "请选择要删除的数据！", "info");
                }
            }
        }, {
            text: '提交',
            iconCls: 'icon-undo',
            handler: function () {
                endEditingNode();
                if (dgNode.datagrid('getChanges').length) {
                    var inserted = dgNode.datagrid('getChanges', "inserted");
                    var deleted = dgNode.datagrid('getChanges', "deleted");
                    var updated = dgNode.datagrid('getChanges', "updated");

                    effectRowNode = new Object();
                    if (inserted.length) {
                        effectRowNode["inserted"] = JSON.stringify(inserted);
                    }
                    if (deleted.length) {
                        effectRowNode["deleted"] = JSON.stringify(deleted);
                    }
                    if (updated.length) {
                        effectRowNode["updated"] = JSON.stringify(updated);
                    }
                }
            }
        }, {
            text: '保存',
            iconCls: 'icon-save',
            handler: function () {
                var rows = dgNode.datagrid('getChanges');
                if (rows.length != 0) {
                    if (effectRowNode == undefined) {
                        showMsg("操作提示", "请先进行提交操作！", "info")
                    }
                    else {
                        updateNode();
                    }
                }

            }
        }],
        onSelect: function (index, row) {
            selNode = row;
        },
        onClickRow: function (index, row) {

            if (editIndexNode != index) {
                if (endEditingNode()) {
                    dgNode.datagrid('selectRow', index)
							.datagrid('beginEdit', index);
                    editIndexNode = index;
                } else {
                    dgNode.datagrid('selectRow', editIndexNode);
                }
            }
        }
    });

    $('#lineName').combobox({
        url: '../../ashx/sjdj/djbzHandler.ashx?type=showddl',
        valueField: 'dIntLineNote',
        textField: 'dVchLine',
        width: '200px',
        panelHeight: '300px',
        editable: false,
        onSelect: function (param) {
            $('#linenode').datagrid('options').url = '../../ashx/sjdj/djbzHandler.ashx?type=lineNode&lindId=' + $('#lineName').combobox("getValue");
            $('#linenode').datagrid('reload');

        }
    });
});

    function updateNode() {
        $.ajax({
            url: "../../ashx/sjdj/djbzHandler.ashx?type=saveNode",
            data: effectRowNode,
            type: 'post',
            async: false,
            dataType: 'text',
            success: function (msg) {
                if (msg == 'ok') {
                    dgNode.datagrid('acceptChanges');
                    showMsg("操作提示", "数据更新成功！", "info")
                }
                else {
                    showMsg("操作提示", "数据更新失败！", "error")
                }
            }
        })

        dgNode.datagrid('reload');
    }
        function endEditingNode() {
        if (editIndexNode == undefined) { return true }
        if (dgNode.datagrid('validateRow', editIndexNode)) {
            dgNode.datagrid('endEdit', editIndexNode);
            editIndexNode = undefined;
            return true;
        } else {
            return false;
        }
    }

    function SetNode() {
        var data = {
            lindId: $('#lineName').combobox("getValue"),
            nodeId: selNode1,
            nodeIndex: $('#nodeIndex').combobox("getText"),
        };

        if ($('#lineName').combobox("getValue") == "") {
            showMsg("操作提示", "路线不能为空，请选择路线名称！", "error")
            return;
        }


        $.ajax({
            url: "../../ashx/sjdj/djbzHandler.ashx?type=SetNode",
            data: data,
            type: 'post',
            async: false,
            dataType: 'text',
            success: function (msg) {
//                alert(msg);
                if (msg == 'ok') {
                    showMsg("操作提示", "节点设置成功！", "info")
                }
                else {
                    showMsg("操作提示", "节点设置失败或已经被配置过该路线上！", "error")
                }
            }
        })

        $('#linenode').datagrid('options').url = '../../ashx/sjdj/djbzHandler.ashx?type=lineNode&lindId=' + $('#lineName').combobox("getValue");
        $('#linenode').datagrid('reload');
    }

    function SearchNode() {
        var data = {
            nodesearch: $('#nodeName').val()
        };

        $('#node').datagrid('options').url = '../../ashx/sjdj/djbzHandler.ashx?type=searchNode&nodesearch=' + $('#nodeName').val();
        $('#node').datagrid('reload');

    }

        function SearchNode1() {
        var data = {
            nodesearch: $('#nodeName1').val()
        };

        $('#Nodedg').datagrid('options').url = '../../ashx/sjdj/djbzHandler.ashx?type=searchNode&nodesearch=' + $('#nodeName1').val();
        $('#Nodedg').datagrid('reload');

    }

        function reloadAll() {
        $('#linenode').datagrid('reload');
        $('#node').datagrid('reload');
        $('#lineName').combobox('reload');
    }

    function SetContentNode() {
        if (typeof(selNode) == "undefined") {
            showMsg("操作提示", "关联前请选择节点！！！", "error")
            return;
        }
        if ($('#contentID').val() == "") {
            showMsg("操作提示", "关联前请选择检查内容！！！", "error")
            return;
        }
        var data = {
            nodeId: selNode.dIntNodeNote,
            contentID: $('#contentID').val(),
            contentName: $('#checkcontent').textbox('getText')
        };
//        alert(selNode);

//        alert($('#checkcontent').textbox('getText'));


        $.ajax({
            url: "../../ashx/sjdj/djbzHandler.ashx?type=contentNode",
            data: data,
            type: 'post',
            async: false,
            dataType: 'text',
            success: function (msg) {
//                alert(msg);
                if (msg == 'ok') {
                    showMsg("操作提示", "检查内容与节点关联成功！", "info")
                }
                else {
                    showMsg("操作提示", "检查内容与节点关联失败！", "error")
                }
            }
        })
        $('#contentNode').datagrid('reload');

    }
