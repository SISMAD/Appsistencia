<?php
session_start();

if (isset($_SESSION['rol']) && $_SESSION['rol'] == 1 && !empty($_POST)) {

}elseif (isset($_SESSION['rol']) && $_SESSION['rol'] != 1) {
	header('Location: login.php');

}elseif (!isset($_SESSION['rol'])) {
	header('Location: login.php');
}else{
?>
<html>
<h1>¡Bienvenido Alumno!</h1>
<a href="cerrar_sesion.php">CERRAR SESION</a>
</html>
<?php
}
?>