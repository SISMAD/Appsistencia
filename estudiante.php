<!DOCTYPE html>
<html lang="en">
<head>
	<title>Bootstrap Example</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">Imagen</a>
				<a class="navbar-brand" href="#">Universidad De Cartagena</a>
			</div>
			<ul class="nav navbar-nav ">

				<li class="active"><a href="#">Appsistencia</a></li>
				
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#"><span ></span> Imagen</a></li>	
				<li><a href="#"><span ></span> Pepito Perez <br> codigo</a></li>
				<li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
			</ul>
		</div>
	</nav>

</body>
</html>
<?php
session_start();

if (isset($_SESSION['rol']) && $_SESSION['rol'] == 1 && !empty($_POST)) {
	// Logica php de la dashboard estudiante
}elseif (isset($_SESSION['rol']) && $_SESSION['rol'] != 1) {
	header('Location: login.php');

}elseif (!isset($_SESSION['rol'])) {
	header('Location: login.php');
}else{
	?>
	<html>
	<h1>¡Bienvenido estudiante <?php echo $_SESSION['nombre1']." ".$_SESSION['nombre2']." ".$_SESSION['apellido1']." ".$_SESSION['apellido2'];?>!</h1>
	<a href="cerrar_sesion.php">CERRAR SESION</a>
	</html>
	<?php
}
?>
