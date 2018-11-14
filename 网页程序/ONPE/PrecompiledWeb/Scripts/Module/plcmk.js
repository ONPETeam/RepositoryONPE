//相当于plcmk的类，给index.js调用
plcmk = function () {
    var actContext = { code: -1 };
    this.exec = function (code) {
        actContext.code = code;
        //        alert(code); 
        switch (code) {
            case 50:
                currentPage = '50';
                main.module(50);
                break;
            case 51:
                currentPage = '51';
                main.module(51);
                break;
            case 52:
                currentPage = '52';
                main.module(52);
                break;
            case 53:
                currentPage = '53';
                main.module(53);
                break;
            case 54:
                currentPage = '54';
                main.module(54);
                break;
            case 55:
                currentPage = '55';
                main.module(55);
                break;
            case 56:
                currentPage = '56';
                main.module(56);
                break;
            case 57:
                currentPage = '57';
                main.module(57);
                break;
            case 58:
                currentPage = '58';
                main.module(58);
                break;

            case 59:
                currentPage = '59';
                main.module(59);
                break;
            case 60:
                currentPage = '60';
                main.module(60);
                break;
            case 61:
                currentPage = '61';
                main.module(61);
                break;
            case 62:
                currentPage = '62';
                main.module(62);
                break;
            default:
                break;
        }
    }
}