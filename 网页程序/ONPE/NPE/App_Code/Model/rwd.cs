using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using NPE.UIDataClass;

namespace ModelClass
{
    /// <summary>
    ///rwd 的摘要说明
    /// </summary>
    public class rwd
    {
        public string dVchRwNote { get; set; }
        public string dVchRwCreatUnit { get; set; }
        public string dVchRwCreatPeo { get; set; }
        public string dDaeRwStart { get; set; }
        public string dDaeSetEnd { get; set; }
        public string dVchRecBranch { get; set; }
        public string dVchRecEmployee { get; set; }
        public string dDaeRecTime { get; set; }

        public string dVchRwContent { get; set; }
        public string dVchImportentLevel { get; set; }
        public string dVchArea { get; set; }
        public string dVchOthersEquip { get; set; }
        public string dVchCheckQZ { get; set; }
        public string dVchOwnerQZ { get; set; }
        public string dVchEquipDepQZ { get; set; }
    }

    public class gzp
    {
        public string dVchWorkNote { get; set; }
        public string dVchWorkCreatUnit { get; set; }
        public string dVchWorkCreatPeo { get; set; }
        public string dDaeWorkSys { get; set; }
        public string dVchActionDep { get; set; }
        public string dVchArea { get; set; }
        public string dDaeWorkStart { get; set; }
        public string dVchWorkPeo { get; set; }
        public string dVchWorkPeoQZ { get; set; }

        public string dDaeWorkEnd { get; set; }
        public string dVchWorkPeo1 { get; set; }
        public string dVchWorkPeoQZ1 { get; set; }
        public string dVchFromType { get; set; }

        public string Item { get; set; }
    }

    public class gzItem
    {
        public string dVchWorkNote { get; set; }
        public string equip_code { get; set; }
        public string equip_name { get; set; }
        public string dVchWorkContent { get; set; }
        public string dVchIsClose { get; set; }
        public string dVchApplyPeo { get; set; }
        public string dVchZKCheckPeo { get; set; }
        public string dVchActionPeo { get; set; }
    }
}