jcxx = function () {
    var actContext = { code: -1 };
    this.exec = function (code) {
        actContext.code = code;
        //        alert(code); 
        switch (code) {
            case 23:
                currentPage = '23';
                main.module(23);
                break;
            case 24:
                currentPage = '24';
                main.module(24);
                break;
            case 25:
                currentPage = '25';
                main.module(25);
                break;
            case 26:
                currentPage = '26';
                main.module(26);
                break;
            case 27:
                currentPage = '27';
                main.module(27);
                break;
            case 28:
                currentPage = '28';
                main.module(28);
                break;
            case 29:
                currentPage = '29';
                main.module(29);
                break;
            case 30:
                currentPage = '30';
                main.module(30);
                break;
            case 32:
                currentPage = '32';
                main.module(32);
                break;
            case 33:
                currentPage = '33';
                main.module(33);
                break;
            case 34:
                currentPage = '34';
                main.module(34);
                break;
            case 35:
                currentPage = '35';
                main.module(35);
                break;
            case 36:
                currentPage = '36';
                main.module(36);
                break;
            case 37:
                currentPage = '37';
                main.module(37);
                break;
            case 38:
                currentPage = '38';
                main.module(38);
                break;
            default:
                break;
        }
    }
}