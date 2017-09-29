<?php
session_start();

if (isset($_SESSION['rol']) && $_SESSION['rol'] == 2 && !empty($_POST)) {
	//Logica php de la dashboard tutor
}elseif (isset($_SESSION['rol']) && $_SESSION['rol'] != 2) {
	header('Location: login.php');

}elseif (!isset($_SESSION['rol'])) {
	header('Location: login.php');
}else{
?>
<html>
<h1>¡Bienvenido tutor <?php echo $_SESSION['nombre1']." ".$_SESSION['nombre2']." ".$_SESSION['apellido1']." ".$_SESSION['apellido2'];?>!</h1>
<a href="cerrar_sesion.php">CERRAR SESION</a>
</html>
<?php
}
?>