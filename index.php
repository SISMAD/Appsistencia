<?php
require("Conexion.php");

$_codigo = mysqli_real_escape_string($conexion, trim($_POST["codigo"]));
$_clave = mysqli_real_escape_string($conexion, trim($_POST["password"]));
$control = false;

if (empty($_codigo)) {
	echo "<script languaje=\"javascript\">alert('NO HA LLENADO EL CAMPO OBLIGATORIO Digite su Código ');</script>";
	echo "<script>document.location.href='http://localhost/Software_Registro_Loguin/Index.html';</script>\n";
}else{
	$con1 = "SELECT codigo_udc,contraseña FROM login WHERE codigo_udc=?";
	
	$obj1 = mysqli_prepare($conexion, $con1);
	
	$ok1 = mysqli_stmt_bind_param($obj1,"s", $_codigo);
	
	$ok1 = mysqli_stmt_execute($obj1);
	
	if ($ok1 == false) {
		echo "ERROR EN LA EJECUCIÓN DE ACCESO <br><br>";
	}else{
		$ok1 = mysqli_stmt_bind_result($obj1, $usu, $pass);   //VALIDACIÓN DE USUARIO
		while (mysqli_stmt_fetch($obj1)) {
			$control = true;
			if (password_verify($_clave, $pass)) {
				echo "<script>document.location.href='/appsistencia/Estudiante.php';</script>\n";
			}else{
				echo "<script languaje=\"javascript\">alert('LA CONTRASEÑA ES INCORRECTA');</script>";
				echo "<script>document.location.href='/appsistencia';</script>\n";
			}
		}
		if ($control == false) {
			echo "<script>document.location.href='UsuarioNoExiste.html';</script>\n";
		}
	}    
}
mysqli_close($conexion);
?>
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
		<form action="<?php echo htmlentities($_SERVER['PHP_SELF']); ?>" method="post">
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
					<input type="number" name="codigo" pattern="[0-9]{1,15}" placeholder="Codigo" title="Ej. 4150510000" required>
					<br></br>
					<input type="password" name="password" pattern="[A-Za-z0-9._-]{1,15}" required placeholder="Contraseña" title="Digita una contraseña" required>
					<br></br>
					<a href="registro.html"><input type="button" value="Registrarse" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect"></a>
					<!-- <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect" title="Registrarse"> -->
				</button>
			</a>
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect" type="submit" name="Enviar" title="Ingresar">Conectarse</button>
			<h5><a href="#">¿Olvidaste contraseña?</a></h5>
		</table>
	</form>                      
</section>
</body>
</html>
