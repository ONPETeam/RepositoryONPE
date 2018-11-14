sjdj = function () {
    var actContext = { code: -1 };
    this.exec = function (code) {
        actContext.code = code;
        //        alert(code); 
        switch (code) {
            case 6:
                currentPage = '6';
                main.module(6);
                
                break;
            case 7:
                currentPage = '7';
                main.module(7);
               
                break;
            case 8:
                currentPage = '8';
                main.module(8);
                
                break;
            default:
                break;
        }
    }
}
