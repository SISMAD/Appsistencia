<?php
session_start();
if (isset($_SESSION['rol'])) {
	switch ($_SESSION['rol']) {
		case '1':
		header('Location: alumno.php');
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
}else{
	header('Location: login.php');
}
?>