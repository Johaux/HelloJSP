<%-- 
    Document   : newUser
    Created on : 15-feb-2017, 0:22:12
    Author     : JohanGX
--%>

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
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Nuevos Usuarios</h1>
        <%
            //datos para registro del nuevo usuario
            String txtNombre = request.getParameter("nameRegister");
            String txtApellido = request.getParameter("lastNameRegister");
            String txtMail = request.getParameter("emailRegister");
            String txtPass = request.getParameter("passRegister");

            //conexión a servidor remoto
            MongoClientURI mongoURI = new MongoClientURI("mongodb:"
                    + "//hellotext:hello12345"
                    + "@ds021356.mlab.com:21356/dbhellotext");

            //conexión al servidor
            MongoClient conexion = new MongoClient(mongoURI);

            //conexion a la base de datos
            MongoDatabase db = conexion.getDatabase("dbhellotext");

            //crear la coleccion
            MongoCollection<Document> coleccion = db.getCollection("users");

            //envio de datos
            if (txtNombre.isEmpty() || txtApellido.isEmpty() || txtMail.isEmpty() || txtPass.isEmpty()) {

                out.println("<center><h3>Debes ingresar todos los datos para poder ser registrado</h3></center>");
                out.print("<center><input type=\"button\" "
                        + "value=\"Intenta una vez más\" onclick=\"history.back()\"/></center>");
            } else {
                Document registro = new Document("nombre", txtNombre)
                        .append("apellido", txtApellido).append("mail", txtMail).append("password", txtPass);
                //guardar datos en la coleccion

                out.println("<h1>" + txtNombre + " " + txtApellido + " ahora haces parte de nuestra comunidad </h1>");
                coleccion.insertOne(registro);
            }

        %>
    </body>
</html>
