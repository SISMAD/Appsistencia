<?php
session_start();

if (isset($_SESSION['rol']) && $_SESSION['rol'] == 1 && !empty($_POST)) {

}elseif (isset($_SESSION['rol']) && $_SESSION['rol'] != 1) {
	header('Location: login.php');

}else{
?>
<html>
test
<!-- Codigo HTML del dashboard alumno -->
</html>
<?php
}
?>