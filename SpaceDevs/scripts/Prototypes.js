String.prototype.FormatDateNoHours = function () {
    var meses = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
    var fecha = this.split("T")[0];
    var numMes = parseInt(fecha.split("-")[1]);
    var hora = this.split("T")[1];
    if (fecha.split("-")[2] == undefined) {
        return "";
    }
    return fecha.split("-")[2] + "/" + meses[numMes] + "/" + fecha.split("-")[0];
}