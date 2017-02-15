<%-- 
    Document   : serachUser
    Created on : 11-oct-2016, 14:50:38
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

        <title>Consulta de Usuarios Hello!</title>
        <style>

            table {
                font-family: arial, sans-serif;
                font-size: 14px;
                margin: 45px;
                border-collapse: collapse;
                width: 70%;
                color: whitesmoke;
                text-align: left;

            }

            th 
            {    
                font-size: 18px;
                font-weight: normal;
                padding: 18px;
                background: #0E4F61;
                border-top: 0px solid #fff;
                border-bottom: 5px solid #fff;
                color: #fff;
                text-align: justify;
            }

            td 
            {
                padding: 15px;
                background: #0D7E96;
                border-bottom:5px solid #fff;
                color: #fff;
                border-top: 5px solid transparent;
                text-align: justify;
            }
            [name="btnRegister"]{
                margin-top: 10px;
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
            [name="btnRegister"]:hover{
                background: #0E4F61;
                color:#fff;
            }

            body{
                /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#93cede+0,75bdd1+41,49a5bf+100;Blue+3D+%235 */
                background-image: url("../images/IFcqIOS.jpg");  
                /*   background: 00B7B1; /* Old browsers */
                /*   background: -moz-linear-gradient(left, rgb(0,183,177) 0%,rgb(0,183,177) 41%,rgb(0,183,177) 100%); /* FF3.6-15 */
                /*   background: -webkit-linear-gradient(left, rgb(0,183,177) 0%,rgb(0,183,177) 41%,rgb(0,183,177) 100%); /* Chrome10-25,Safari5.1-6 */
                /*   background: linear-gradient(to right, rgb(0,183,177) 0%,rgb(0,183,177) 41%,rgb(0,183,177) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
                filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#93cede', endColorstr='#49a5bf',GradientType=1 ); /* IE6-9 */
                font-family: "roboto" arial;
                margin-top: 100px;

            }

            @font-face{
                font-family: titulo;
                font-style: normal;
                src: url("../CSS/fonts/Vtks-LongTime.ttf");
            }
            h1{
                font-family: titulo;
                color: whitesmoke;
                font-size: 40px;
            }
            
            h2{
                padding-right: 550px;
                font-family: titulo;
                color: whitesmoke;
            }
            h3{
                color: whitesmoke;
            }
            img{
                width: 60%;
                height: 70%;
            }


            tr:nth-child(even) {
                background-color: #0D7E96;
            }
            [name="t_th"]{
                background-color: transparent;
                border: 0px;       
            }

        </style>
    </head>
    <body>
        <div id="title">
            <center>
                <table name="t_table">
                    <tr>
                        <th name="t_th"><h1 align="center">Bienvenido a la comunidad </h1> </n></th>
                        <th name="t_th"><img src="../images/helloLogo.png"></th>
                    </tr>
                </table>
            </center>
        </div>
        <h2>
            <center> Haz Parte de nosotros ahora: 
                <a href="../Aplication/userRegister.html">
                    <input type="button" name="btnRegister" 
                           value="Registrate" onClick=
                           "alert('Procederás a registrarte como nuevo usuario')"/>
                </a>
            </center>
        </h2>
    <center><%
        MongoClientURI mongoURI = new MongoClientURI("mongodb:"
                + "//hellotext:hello12345"
                + "@ds021356.mlab.com:21356/dbhellotext");

        MongoClient conexion = new MongoClient(mongoURI);

        MongoDatabase db = conexion.getDatabase("dbhellotext");

        MongoCollection<Document> coleccion = db.getCollection("listado");

        List<Document> docs = coleccion.find().into(new ArrayList<Document>());

        out.print("<table id='consulta' align='center'>");
        out.print("  <tr>");
        out.print("<th width=10% >Nro</th>");
        out.print("    <th>Nombre</th>");
        out.print("    <th>Apellido</th>");
        out.print("  </tr>");

        int i;
        for (i = 0; i < docs.size(); i++) {

            Document consultaTodos = (Document) docs.get(i);
            String txtNombre = consultaTodos.getString("nombre");
            String txtApellido = consultaTodos.getString("apellido");

            int count = i + 1;

            out.print("<tr>");
            out.print(" <td> " + i + " </td>");
            out.print("  <td>" + txtNombre + "</td>");
            out.print("  <td>" + txtApellido + "</td>");
            out.print("</tr>");

        }
        out.print("<h3> Cantidad de usuarios en la comunidad:" + i + "</h3>");
        out.print("<table>");

        out.print("<br>");


        %></center>


</body>


</html>
