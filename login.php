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
			header('Location: Error.html');
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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<meta charset="utf-8"> 
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="Appsistencia" content="Control de asistencia de las tutorias de los docentes">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
		<title>Appsistencia</title>
	</head>
	<body><br><br>
	<div class="container center-block text-center" style="min-width: 280; max-width: 340">
		<div class="panel-group">
			<div class="panel panel-default">
				<div class="panel-heading">
			  		<img src="images/user.png" width="180" height="180"/><br>
			  		<h2>APPSISTENCIA</h2>
				</div>
  			<div class="panel-body">
		  	<form action="<?php echo htmlentities($_SERVER['PHP_SELF']); ?>" method="post">
				  <p><input type="tel" name="codigo" pattern="[0-9]{1,15}" placeholder="Ej. 4150510000" data-toggle="tooltip" title="Ej. 4150510000" required autofocus></p>
				  <p><input type="password" name="password" pattern="[A-Za-z0-9._-]{1,15}" placeholder="Contraseña" title="Digita una contraseña" required></p> <!-- Validar los caracteres especiales -->
				  <a href="registro.html"><input type="button" class="btn btn-default" value="Registrarse"></a>
				  <button type="submit" class="btn btn-default" name="Enviar" title="Ingresar">Conectarse</button>
				  <br><br><a href="#"><h5>¿Olvidaste contraseña?</h4></a>
			  </form>
			  <img src="images/sismad.png" alt="Semillero de Investigacion de Ingenieria de Sistemas Modalidad a Distancia" width="32" height="36">
			  <p><h5>SISMAD</h5></p>
			   </div>
			</div>
	  	</div>
	</div>
</body>
</html>
<?php 
}
?>