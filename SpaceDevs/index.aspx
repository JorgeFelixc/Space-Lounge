<%@ Page Title="" Language="C#" MasterPageFile="~/MP.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="SpaceDevs.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
añadido dsde windows server
    <div class="contenido">
        <div class="info-uno">
            <div class="info-izq">
                <div class="info-title"> 
                    <div class="title-container">
                        <span id="title" style="font-size:37px;">Simple plataforma pero util </span>
                    </div>
                    <div class="status-container">
                        <span class="status-default" id="state"></span>
                    </div>
                    </div>
                <span class="date" id="date">21 de octubre del 2018.</span>
                <p id="descripcion">
                    lorem impasijdaslkjdaslkjdaslkjdlaskjdlask
                    aslkjdalskjdlaskjdlaskjdlaskjd
                    alskdjalskjdlaskjdlkasjdlkasjd
                </p>
            </div>
    <%--            <div class="info-der">
              
            </div>--%>
        </div>
        <div class="info-dos">
            <img src="img/info-back.jpg" alt="Alternate Text" />
            <div class="thumbnail">
                <h3 class="thumb-title">¿Te interesa?</h3>
                <span class="thumb-text">Accede a la informacion</span>
                <a class="thumb-link" href="#">Click aqui</a>
            </div>
        </div>
    </div>
    
    <div class="mes" id="mes">Octubre</div>
    <div id="timelineClock"></div>
    <script type="text/javascript">
        var timeline = $('#timelineClock');
        var title = $("#title");
        var state = $("#state");
        var date = $("#date");
        var descripcion = $("#descripcion");

        var objInfo = [];
        var objAux = [];
        var sMision = "";

        //estatus-----------------------------
        //1 - Green - si pasara - status-blue
        //2 - Red - se cancelo - status-orange
        //3 - Success - Exito - status-success
        //4 - Fail - fallo - status-fail
        //------------------------------------

        function fn_get_lanzamientos() {
            var uri = "https://launchlibrary.net/1.4/launch";
            var jsonArray = [];
            $.getJSON(uri).done(function (d) {
                objInfo = [];
                console.log(d.launches);
                $.each(d.launches, function (key, a) {
                    var i = parseInt(a.windowend.toString().split('-')[2].substr(0, 2));
                    var f = parseInt(a.windowstart.toString().split('-')[2].substr(0, 2));
                    f = (f - i + 1) * 100;
                    
                    var strUni = {
                        start: i,
                        title: a.name,
                        description: a.status.toString() + "_" + a.windowstart.toString().replace(" ", "T").FormatDateNoHours() + "_" + a.changed.toString().replace(" ", "T").FormatDateNoHours(),
                        width: f
                    }
                    objInfo.push(strUni);
                    objAux.push(a);
                    if (objInfo.length == d.launches.length) {
                        objInfo = Enumerable.from(objInfo).orderBy(f=>f.start).toArray();
                        load_timeline();
                    }
                });
            });
        }
        
        function fn_get_desc(mission) {
            var uri = "https://launchlibrary.net/1.4/mission?name=" + mission;
            $.getJSON(uri).done(function (d) {
                if (d.missions.length > 0) {
                    descripcion.append($("<br />"));
                    descripcion.append("DESCRIPCION MISION: <br />" + d.missions[0].description);
                }
            });
        }

        function load_timeline() {
            timeline.timespace({
                timeType: 'date',
                useTimeSuffix: false,
                startTime: 1,
                endTime: 32,
                markerIncrement: 1,
                width: 700,
                data: {
                    events: objInfo
                },
            });
        }

        function fn_load_data() {
            var div = $(this);
            var p = div.children();
            for (x = 0; x <= objAux.length - 1; x++) {
                if (objAux[x].name == p.text()) {
                    var obj = objAux[x];
                    title.empty();
                    descripcion.empty();
                    title.append("LANZAMIENTO: " + obj.name.toString().split("|")[0]);
                    state.removeClass();
                    state.addClass(obj.status == 1 ? "status-blue" : obj.status == 2 ? "status-orange" : obj.status == 3 ? "status-success" : obj.status == 4 ? "status-fail" : "status-default");
                    date.text(obj.windowstart.toString().replace(" ", "T").FormatDateNoHours().replace("Noviembre", "Octubre"));
                    descripcion.append("NOMBRE DE LA MISION: <br />" + obj.name.toString().split("|")[1]);
                    fn_get_desc(obj.name.toString().split("|")[1].split(" ")[0]);
                    break;

                    $('html,body').animate({
                        scrollTop: state.offset().top
                    }, 300);
                }
            }
        }

        $(document).on('click', '.jqTimespaceEvent', fn_load_data);

        $(".jqTimespaceDisplay").attr("style", "display:none;");
        fn_get_lanzamientos();


    </script>


</asp:Content>
