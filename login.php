<?php
session_start();
require("Conexion.php");

if (!empty($_POST)) {
	$_codigo = mysqli_real_escape_string($conexion, trim($_POST["codigo"]));
	$_clave = mysqli_real_escape_string($conexion, trim($_POST["password"]));
	$control = false;

	if (empty($_codigo)) {
		echo "<script languaje=\"javascript\">alert('NO HA LLENADO EL CAMPO OBLIGATORIO - Digite su Código ');</script>";
	}else{
		$con1 = "SELECT codigo_udc,contraseña FROM login WHERE codigo_udc=?"; // Consulta del Usuario y Contraseña
		$obj1 = mysqli_prepare($conexion, $con1);
		$ok1 = mysqli_stmt_bind_param($obj1,"s", $_codigo);
		$ok1 = mysqli_stmt_execute($obj1);

		if ($ok1 == false) {
			echo "ERROR EN LA EJECUCIÓN DE ACCESO <br><br>";
		}else{
		$ok1 = mysqli_stmt_bind_result($obj1, $usu, $pass);   //VALIDACIÓN DE USUARIO

		if (mysqli_stmt_fetch($obj1)) {
			$control = true;

			if (password_verify($_clave, $pass)) {
				mysqli_stmt_close($obj1);
				$con2 = "SELECT rol,nombre1,nombre2,apellido1,apellido2,email FROM personal WHERE codigo_udc=?"; //Consulta para traer los datos del Usuario
				$obj2 = mysqli_prepare($conexion, $con2);
				$ok2 = mysqli_stmt_bind_param($obj2,"s", $_codigo);
				$ok2 = mysqli_stmt_execute($obj2);
				$ok2 = mysqli_stmt_bind_result($obj2, $rol, $nombre1, $nombre2, $apellido1, $apellido2, $email);

				if (mysqli_stmt_fetch($obj2)) { // Se Almacenan los datos de la consulta en variables de sesion para que queden disponibles
					$_SESSION['codigo'] = $_codigo;
					$_SESSION['rol'] = $rol;
					$_SESSION['nombre1'] = $nombre1;
					$_SESSION['nombre2'] = $nombre2;
					$_SESSION['apellido1'] = $apellido1;
					$_SESSION['apellido2'] = $apellido2;
					$_SESSION['email'] = $email;

					switch ($_SESSION['rol']) { // Redirecciona a su plataforma correspondiente segun su Rol
						case '1':
						header('Location: estudiante.php');
						break;
						case '2':
						header('Location: tutor.php');
						break;
						case '3':
						header('Location: coordinador.php');
						case '4':
						header('Location: admin/index.php');
						break;
					}
				}
				mysqli_stmt_close($obj2);
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

}elseif (!empty($_SESSION['codigo'])) {  	//Validacion si la sesion ya existe y al usuario se le da por ir 'Atras'
	switch ($_SESSION['rol']) {
		case '1':
		header('Location: estudiante.php');
		break;
		case '2':
		header('Location: tutor.php');
		break;
		case '3':
		header('Location: coordinador.php');
		break;
		case '4':
		header('Location: admin/index.php');
		break;
	}

}else{
	?>
	<html lang="es">
	<head>
	<link rel="stylesheet" href="css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
	<script src="js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
	<meta charset="utf-8"> 
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="Appsistencia" content="Control de asistencia de las tutorias de los docentes">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
		<title>Appsistencia</title>
	</head>
	<body>
	<div class="row slideanim">
	<div class="container">
	<div class="col-sm-4 col-xs-12">
      <div class="panel panel-default text-center">
        <div class="panel-heading">
			<form action="<?php echo htmlentities($_SERVER['PHP_SELF']); ?>" method="post">
				<img src="images/user.png" width="180" height="180">
				<h2 class="label-3" align="center">APPSISTENCIA</h2>
		</div>
		<div class="panel-body">
			<p><input type="tel" name="codigo" pattern="[0-9]{1,15}" placeholder="Ej. 4150510000" data-toggle="tooltip" title="Ej. 4150510000" required autofocus></p>
			<p><input type="password" name="password" pattern="[A-Za-z0-9._-]{1,15}" required placeholder="Contraseña" title="Digita una contraseña" required></p> <!-- Validar los caracteres especiales -->
		</div>
		<div class="panel-footer">
			<a href="registro.html"><input type="button" value="Registrarse" ></a></button>
			<button type="submit" name="Enviar" title="Ingresar">Conectarse</button>
			<a href="#">¿Olvidaste contraseña?</a>
		</div>
			</form>
		</div>
		</div>                      
	</div>
	</div>
</body>
</html>
<?php 
}
?>