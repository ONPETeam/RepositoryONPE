sbgl = function () {
    var actContext = { code: -1 };
    this.exec = function (code) {
        actContext.code = code;
        //        alert(code); 
        switch (code) {
            case 0:
                currentPage = '0';
                main.module(0);

                break;
            case 1:
                currentPage = '1';
                main.module(1);

                break;
            case 2:
                currentPage = '2';
                main.module(2);
                break;
            case 31:
                currentPage = '31';
                main.module(31);
                break;
            case 9999:
                currentPage = '9999';
                main.module(9999);
                break;
            default:
                break;
        }
    }
}


