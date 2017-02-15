<%-- 
    Document   : searchU
    Created on : 14-oct-2016, 19:35:31
    Author     : JohanGX
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.MongoClient"%>
<%@page import="com.mongodb.MongoClientURI"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            table 
            {
                font-family: arial, sans-serif;
                font-size: 12px;
                border-collapse: collapse;
                color: whitesmoke;
                text-align: center;
                margin: auto;
                width: 50%;
                padding: 10px;
            }

            th 
            {    
                font-size: 13px;
                font-weight: normal;
                padding: 8px;
                background: #0E4F61;
                border-top: 5px solid #fff;
                border-bottom: 5px solid #fff;
                color: #fff;
                text-align: center;
            }

            td 
            {
                padding: 8px;
                background: #0D7E96;
                border-bottom: 5px solid #fff;
                color: #fff;
                border-top: 5px solid transparent;
                text-align: center;
            }
            input
            {
                margin-top: 5px;
                margin-left: 10px;
                background: #fff;
                border-radius: 5px;
                border: 2px solid #fff;
                color: #000;
                cursor: pointer;
                display: inline-block;
                font-family: "roboto" arial;
                font-size: 16px;
                padding: 5px;
                width: 15%;
                transition: all .3s ease;

            }
            input:hover
            {

                background: #0E4F61;
                color:#fff;     
            }
            [name="btnRegister"],
            [name="nombreConsulta"]
            {
                margin-top: 5px;
                background: #fff;
                border-radius: 5px;
                border: 2px solid #fff;
                color: #000;
                cursor: pointer;
                display: inline-block;
                font-family: "roboto" arial;
                font-size: 16px;
                padding: 5px;
                width: 55%;
                padding-left: 10px;
                transition: all .3s ease;     
            }
            [name="btnRegister"]:hover,
            [name="nombreConsulta"]:hover
            {
                background: #0E4F61;
                color:#fff;
            }

            body
            {
                /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#93cede+0,75bdd1+41,49a5bf+100;Blue+3D+%235 */
                /*  background-image: url("../images/IFcqIOS.jpg");  
                  /*   background: 00B7B1; /* Old browsers */
                background: -moz-linear-gradient(left, rgb(0,183,177) 0%,rgb(0,183,177) 41%,rgb(0,183,177) 100%); /* FF3.6-15 */
                background: -webkit-linear-gradient(left, rgb(0,183,177) 0%,rgb(0,183,177) 41%,rgb(0,183,177) 100%); /* Chrome10-25,Safari5.1-6 */
                background: linear-gradient(to right, rgb(0,183,177) 0%,rgb(0,183,177) 41%,rgb(0,183,177) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
                /*filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#93cede', endColorstr='#49a5bf',GradientType=1 ); /* IE6-9 */
                /*font-family: "roboto" arial;
                margin-top: 100px;*/
                background-image: url(../images/IFcqIOS.jpg);

            }

            @font-face
            {
                font-family: titulo;
                font-style: normal;
                src: url("../CSS/fonts/Vtks-LongTime.ttf");
            }
            h1, h2,h3
            {
                font-family: titulo;
                color: whitesmoke;  

            }
            tr:nth-child(even)
            {
                background-color: #0D7E96;
            }
            [name="t_th"]{
                background-color: transparent;
                border: 0px;       
            }

        </style>

        <title>Eres Hello!?</title>
    </head>
    <body>
        <div id="title">
            <center>
                <table>
                    <tr>
                        <th><h1 align="center">Bienvenido a la comunidad</h1></th>
                        <th><img src="../images/helloLogo.png"></th>
                    </tr>
                </table>
            </center>
        </div>
        <p></p>

        <%
            MongoClientURI mongoURI = new MongoClientURI("mongodb:"
                    + "//hellotext:hello12345"
                    + "@ds021356.mlab.com:21356/dbhellotext");

            MongoClient conexion = new MongoClient(mongoURI);

            MongoDatabase db = conexion.getDatabase("dbhellotext");

            MongoCollection<Document> coleccion = db.getCollection("listado");

            // Capturar nombreConsulta
            String NombreBusqueda = request.getParameter("nombreConsulta");

            List<Document> docs2 = coleccion.find(new Document("nombre", NombreBusqueda)).into(new ArrayList<Document>()); //.first();

            if (NombreBusqueda != null) {
                if (docs2.size() == 0) {

                    out.println("Lo sentimos " + NombreBusqueda + " no perteneces a nuestra comunidad,"
                            + " pero no dudes en registrarte ahora!");

                } else {
                    out.print("<table>");
                    out.print("  <tr>");
                    out.print("    <th>Nombre</th>");
                    out.print("    <th>Apellido</th>");
                    out.print("  </tr>");

                    for (int i = 0; i < docs2.size(); i++) {
                        Document searchU = (Document) docs2.get(i);
                        String txtNombre = searchU.getString("nombre");
                        String txtApellido = searchU.getString("apellido");

                        out.print("<tr>");
                        out.print("  <td>" + txtNombre + "</td>");
                        out.print("  <td>" + txtApellido + "</td>");
                        out.print("</tr>");
                    }
                    out.print("<table>");

                }
            }
        %>
        <br>
        <form name="frmfind" action="searchU.jsp">
            <center>
                <input type="text" placeholder="Ingresa el usuario a buscar..."  name="nombreConsulta"/></br>
                <p></p>
                <input type="submit" name="btnSearcha" value="Buscar Usuario" />
            </center>
        </form>

    <center> 

        <h3> Haz Parte de nosotros ahora: <a href="../Aplication/userRegister.html"/></h3>
        <input type="submit" name="btnRegisterok" value="Registrar" />
        <a href="../index.html"><input type="button" name="btnBack" value="Regresar" />
    </center>
    </br>


</body>
</html>
