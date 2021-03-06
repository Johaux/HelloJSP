var express = require('express'),
    app = express(),
    server = require('http').createServer(app),
    io = require("socket.io").listen(server),
    listaDeNicknames = {};
server.listen(3000);
app.get('/:nombre', function(req, res) {
    res.sendfile(__dirname + '/indexhello.html');
});

//CUANDO CUANDO SE RESIBE UNA CONEXION DE CUALQUIER NAVEGADOR
io.sockets.on('connection', function(esteNavegador) {
    //CUANDO esteNavegador ENVIA EL VALOR DEL NICKNAME Y ESPERA UNA CALBACK CON TRUE O FALSE
    esteNavegador.on('new user', function(nicknameVal, callback) {
        //SI EL NICNAME QUE SE RECIBE ESTA DENTRO DE LA LISTA DE LOS listaDeNicknames REGRESAMOS UN TRUE
        if (nicknameVal in listaDeNicknames) {
            callback(true);
        } 
        //SI EL NICKNAME NO ESTA DENTRO DE LA LISTA DE LOS listaDeNicknames MANDAMOS UN CALBACK FALSO Y AGREGAMOS ESE NICKNAME A LA LISTA DE listaDeNicknames
        else {
            callback(false);
            //CREAMOS UNA VARIBLE GLOBAL LLAMADA esteNavegador.nickname A LA QUE LE ASIGNAMOS EL NOMBRE DEL NICKNAME QUE SE ACABA DE REGISTRAR
            esteNavegador.nickname = nicknameVal;
            //AL AL LISTA DE NICKNAMES AGRGAMOS ESTE NICKNAME CON UN VALOR DE 1
            listaDeNicknames[esteNavegador.nickname] = 1;
            //ACTUALIZAMOS LA LISTA DE NICKNAMES Y MANDAMOS AL HTML ESA LISTA
            updateNickNames();
        }
    });
    //AL RECIBIR UN MENSAJE CON EL MENSAJE SE ENVIA A TODOS LOS SOCKETS
    esteNavegador.on('send message', function(mensajeVal) {
        io.sockets.emit('new message', {msg: mensajeVal, nick: esteNavegador.nickname});
    });
    esteNavegador.on('disconnect', function(data) {
        if(!esteNavegador.nickname) return;
        delete listaDeNicknames[esteNavegador.nickname];
        updateNickNames();
    });
    function updateNickNames() {
        io.sockets.emit('usernames', listaDeNicknames);
    }
});