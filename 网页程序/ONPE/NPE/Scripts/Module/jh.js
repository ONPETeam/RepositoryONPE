jh = function () {
    var actContext = { code: -1 };
    this.exec = function (code) {
        actContext.code = code;
        //        alert(code); 
        switch (code) {
            case 99:
                currentPage = '99';
                main.module(99);
                break;
//            case 98:
//                currentPage = '98';
//                main.module(98);
//                break;
            case 97:
                currentPage = '97';
                main.module(97);
                break;
            case 999:
                currentPage = '999';
                main.module(999);
                break;
            default:
                break;
        }
    }
}