rwxt = function () {
    var actContext = { code: -1 };
    this.exec = function (code) {
        actContext.code = code;
        //        alert(code); 
        switch (code) {
            case 3:
                currentPage = '3';
                main.module(3);
                
                break;
            case 4:
                currentPage = '4';
                main.module(4);
               
                break;
            case 5:
                currentPage = '5';
                main.module(5);
                
                break;
            default:
                break;
        }
    }
}
