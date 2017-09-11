<html lang="es" class="mdl-js">
    <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="Appsistencia" content="Control de asistencia de las tutorias de los docentes">
            <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
            <link rel="stylesheet" href="css/mdl/material.min.css">
            <script src="css/mdl/material.min.js"></script>
            <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Appsistencia</title>
    </head>
    <body>
        <section>
            <form action="login.php" method="post">
                    <table align="center">
                            <tr align="right">
                                <td align="right">
                                        <img src="images/user.png" width="180" height="180">
                                </td>
                            </tr>
                    </table>
                        <STYLE type="text/css">
                        div.parrafos {text-align: center}
                       </STYLE>
                    <table align="center">
                      <h2 align="center">APPSISTENCIA</h2>
                        <div class="parrafos">
                            <br></br>
                            <input type="num" name="codigo" placeholder="Codigo" title="Ej. 4150510000" required autofocus>
                          <br></br>
                           <input type="password" name="password" placeholder="Contraseña" title="Digita una contraseña" required>
                           <br></br>
                          <a href="registro.php" title="Registrar">
                            <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect" title="Registrarse">
                                Registrarse
                            </button>
                        </a>
                            <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect" type="submit" title="Ingresar">Conectarse</button>
                            <h5><a href="#" id="signup">¿Olvidaste contraseña?</a></h5>
                                </div>
                            </table>
                            </form>                      
        </section>
    </body>
</html>
