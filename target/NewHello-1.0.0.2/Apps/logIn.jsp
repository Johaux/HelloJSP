<%-- 
    Document   : logIn
    Created on : 14-feb-2017, 13:13:48
    Author     : JohanGX
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCollection"%>
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
        <h1>Hello World! 2</h1>

        <%
            //conectar a base de datos
            MongoClientURI mongoURI = new MongoClientURI("mongodb:"
                    + "//hellotext:hello12345"
                    + "@ds021356.mlab.com:21356/dbhellotext");

            MongoClient conexion = new MongoClient(mongoURI);

            MongoDatabase db = conexion.getDatabase("dbhellotext");

            MongoCollection<Document> coleccion = db.getCollection("users");
            //Capturar los datos

            String userName = request.getParameter("userName");
            String mainPassword = request.getParameter("mainPass");

            List<Document> buscarUsuario = coleccion.find(new Document("mail", userName)).into(new ArrayList<Document>());
            
           
            if (buscarUsuario.size() == 0) {
                out.print("Este usuario no está registrado en nuestra base de datos");
            } else {
                for (int i = 0; i < buscarUsuario.size(); i++) {

                    Document consultaUsuario = (Document) buscarUsuario.get(i);

                    if (consultaUsuario.containsValue(userName) && 
                            consultaUsuario.containsValue(mainPassword)) {
                        
                        response.sendRedirect("https://www.facebook.com/");

                    } else {
                        out.print("Usuario o clave inválido");
                    }
                }
            }

        %>
    </body>
</html>
