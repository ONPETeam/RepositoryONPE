var module = function () {
    var actContext = { code: 0, obj: null };
    this.create = function (c) {
        actContext.code = c;
        switch (c) {
            case 0: main.addTabHtml("设备信息", "html/sbgl/sbxx.htm"); break;

            case 1: main.addTabHtml("资料预览", "html/file/fileshowselector.htm"); break;
            case 2: main.addTabHtml("故障信息", "html/sbgl/area.htm"); break;
            case 3: main.addTabHtml("任务工单", "html/rwxt/rwgd.htm"); break;
            case 4: main.addTabHtml("工作票", "html/rwxt/gzp.htm"); break;
            case 5: main.addTabHtml("停送电", "html/rwxt/tsd.htm"); break;
            case 23: main.addTabHtml("公司信息", "html/Company/company.htm"); break;
            case 24: main.addTabHtml("区域信息", "html/sbgl/area.htm"); break;
            case 25: main.addTabHtml("设备信息", "html/sbgl/equip.htm"); break;
            case 26: main.addTabHtml("部门信息", "html/Branch/branch.htm"); break;
            case 27: main.addTabHtml("资料类型", "html/file/fileclass.htm"); break;
            case 28: main.addTabHtml("资料目录", "html/file/filediretory.htm"); break;
            case 29: main.addTabHtml("资料信息", "html/file/file.htm"); break;
            case 31: main.addTabHtml("设备图纸", "html/file/fileequip.htm"); break;

            case 32: main.addTabHtml("岗位信息", "html/branch/job.htm"); break;
            case 33: main.addTabHtml("人员信息", "html/employee/employee.htm"); break;

            case 34: main.addTabHtml('设备定位', "html/sbgl/equipsite.htm"); break;
            case 35: main.addTabHtml('三大规程', "html/sbgl/equiprule.htm"); break;
            case 36: main.addTabHtml('应急预案', "html/sbgl/equipplan.htm"); break;
            case 37: main.addTabHtml('故障案例', "html/sbgl/equipcase.htm"); break;
            case 38: main.addTabHtml('交接班记录', "html/shift/shift.htm"); break;

            case 6: main.addTabHtml("点检管理", "html/sjdj/djnr.htm"); break;


            case 50: main.addTabHtml("PLC管理", "html/plc/plcmanager.htm"); break;
            case 51: main.addTabHtml("PLC点地址", "html/plc/webplcddz.htm"); break;
            case 52: main.addTabHtml("开关量", "html/plc/webplckgldy.htm"); break;
            case 53: main.addTabHtml("故障报警", "html/plc/webplcgzbj.htm"); break;
            case 54: main.addTabHtml("故障对策", "html/plc/webplcgzdc.htm"); break;
            case 55: main.addTabHtml("历史数据", "html/plc/webplckglcj.htm"); break;
            case 56: main.addTabHtml("plc树结构", "html/plc/plcTree.htm"); break;
            case 57: main.addTabHtml("点地址绑定数据", "html/plc/webplcddzbd.htm"); break;
            case 58: main.addTabHtml("plc点地址", "html/plc/webplcAreaXtTree.htm"); break;
            case 59: main.addTabHtml("plc信息", "html/plc/webplcIPTree.htm"); break;
            case 60: main.addTabHtml("plc点动态查询", "html/plc/webPlcDtTemp.html"); break;
            case 61: main.addTabHtml("PLC综合查询", "html/plc/webPlcSerch.html"); break;
            case 62: main.addTabHtml("生产总量报表", "html/plc/webReport.htm"); break;
//            case 62: main.addTabHtml("test", "html/plc/webPlcSerch2.html"); break;
//            case 62: main.addTabHtml("test", "html/plc/webPlcSerch.html"); break;
            case 97: main.addTabHtml("备件领取流程", "待开发/备件领取.jpg"); break;
            //case 98: main.addTabHtml("停送电流程", "待开发/停送电流程图.jpg"); break; 
            case 99: main.addTabHtml("工作安排", "html/JH/JH.htm"); break;
            case 999: main.addTabHtml("操作手册", "help/ONPE设备图纸相关说明文档.doc"); break; 

            default: main.addRightHtml(""); break;
        }
    };
}