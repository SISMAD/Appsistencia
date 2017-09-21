<?php 

    $bd_host="localhost";
    $bd_nombre="appsistencia";
    $bd_usuario="root";
    $bd_password="";

    $conexion=mysqli_connect($bd_host,$bd_usuario,$bd_password);

    if(mysqli_connect_errno()){
    	echo "<script>alert('FALLÓ LA CONEXION A LA BASE DE DATOS')</script>";
    	exit();
    }
    mysqli_select_db($conexion,$bd_nombre) or die("NO SE ENCONTRÓ BASE DE DATOS CON ESE NOMBRE");
    mysqli_set_charset($conexion,"utf8");

 ?>