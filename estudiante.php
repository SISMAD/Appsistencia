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