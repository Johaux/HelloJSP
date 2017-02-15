<%-- 
    Document   : deleteUser
    Created on : 15-feb-2017, 0:22:35
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
        <h1>Hello World!</h1>
        
        <%
            //datos para registro del nuevo usuario
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
            Document registro = new Document("mail", txtMail)
                    .append("password", txtPass);

            //delete
            coleccion.deleteOne(registro);
            out.println("(" + txtMail + "," + txtPass + ") se ha borrado en la base de datos");

            
        %>
    </body>
</html>
