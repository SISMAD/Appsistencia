<?php 
require("Conexion.php");

$_codigo=mysqli_real_escape_string($conexion,trim($_POST["codigo"]));
$_clave=mysqli_real_escape_string($conexion,trim($_POST["password"]));
$control=false;

if (empty($_codigo)){
	echo "<script languaje=\"javascript\">alert('NO HA LLENADO EL CAMPO OBLIGATORIO Digite su Código ');</script>";
	echo "<script>document.location.href='http://localhost/Software_Registro_Loguin/Index.html';</script>\n";
}

else{
	$con1="SELECT codigo_udc,contraseña FROM login WHERE codigo_udc=?";
	
	$obj1=mysqli_prepare($conexion,$con1);
	
	$ok1=mysqli_stmt_bind_param($obj1,"s",$_codigo);
	
	$ok1=mysqli_stmt_execute($obj1);
	
	if($ok1==false){
		echo "ERROR EN LA EJECUCIÓN DE ACCESO <br><br>";
	}
	
	else{
			$ok1=mysqli_stmt_bind_result($obj1,$usu,$pass);   //VALIDACIÓN DE USUARIO
			while (mysqli_stmt_fetch($obj1)) {
			   
			   $control=true;
			   if (password_verify($_clave,$pass)) {
						echo "PRUEBA SÍ SE OBTUVO RESULTADO <br><br>";    //SE OBTIENE EL VALOR DE LA BBDD
						echo "La Contraseña de la BBDD es:  $pass<br><br>";
						
					}else{
					  echo "<script languaje=\"javascript\">alert('LA CONTRASEÑA ES INCORRECTA');</script>";
					  echo "<script>document.location.href='/appsistencia';</script>\n";
				  }

			  }

			  if ($control==false) {
			   echo "<script>document.location.href='UsuarioNoExiste.html';</script>\n";
		   }
	   }    
   }

mysqli_close($conexion);
?>