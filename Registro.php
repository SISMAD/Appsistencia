<?php 
if (empty($_POST["Enviar_fer"])) {
	$bdsc_clave = trim($_POST["password"]);
	$bd_reclave = trim($_POST["repassword"]);
	$bd_rol = '1';     
	if (!($bdsc_clave == $bd_reclave)) {
		echo "<script languaje=\"javascript\">alert('LAS CONTRASEÑAS NO COINCIDEN');</script>";
		echo "<script>document.location.href='registro.html';</script>\n";
	}
	else{
		require("Conexion.php");
		$bd_codigo = mysqli_real_escape_string($conexion, trim($_POST["codigo"]));
		$bd_nombre1 = mysqli_real_escape_string($conexion, trim($_POST["nombre1"]));
		$bd_nombre2 = mysqli_real_escape_string($conexion, trim($_POST["nombre2"]));
		$bd_apellido1 = mysqli_real_escape_string($conexion, trim($_POST["apellido1"]));
		$bd_apellido2 = mysqli_real_escape_string($conexion, trim($_POST["apellido2"]));
		$bd_email = mysqli_real_escape_string($conexion, trim($_POST["correo"]));
		$bd5_clave = mysqli_real_escape_string($conexion, $bdsc_clave);
		$bd_clave = password_hash($bd5_clave, PASSWORD_DEFAULT, array('cost' => 12));
		if (empty($bd_codigo) || empty($bd_nombre1)|| empty($bd_apellido1)|| empty($bd_email) || empty($bd_clave)) 
		{
			echo "<script languaje=\"javascript\">alert('NO HA LLENADO ALGUNO DE LOS CAMPOS OBLIGATORIOS: Código de la UDC, Primer Nombre, Primer Apellido, Email y Contraseñas');</script>";
			echo "<script>document.location.href='registro.html';</script>\n";
		}
		else{
			$consulta = "SELECT * FROM personal WHERE codigo_udc='$bd_codigo'";
			$resultado = mysqli_query($conexion, $consulta);
			$fila = mysqli_fetch_row($resultado);
			if ($fila > 0) 
			{
				echo "<script languaje=\"javascript\">alert('YA EXISTE ESE CÓDIGO');</script>";
				echo "<script>document.location.href='registro.html';</script>\n";
			}
			else{
				$sql1="CALL registro_personal(?,?,?,?,?,?,?)";
				$sql2 = "CALL registro_login(?,?)";
				$objeto1 = mysqli_prepare($conexion, $sql1);
				$objeto2 = mysqli_prepare($conexion, $sql2);
				$unir1 = mysqli_stmt_bind_param($objeto1, "sssssss", $bd_codigo, $bd_nombre1, $bd_nombre2, $bd_apellido1, $bd_apellido2, $bd_email, $bd_rol);
				$unir2 = mysqli_stmt_bind_param($objeto2, "ss", $bd_codigo, $bd_clave);
				$unir1 = mysqli_stmt_execute($objeto1);
				$unir2 = mysqli_stmt_execute($objeto2);
				if ($unir1 == false || $unir2 == false) 
				{
					echo "<script languaje=\"javascript\">alert('ERROR AL EJECUTAR EL REGISTRO');</script>";
				}
				else{
					echo "<script languaje=\"javascript\">alert('REGISTRO EXITOSO');</script>";
					echo "<script>document.location.href='/appsistencia';</script>\n";

				}
			}
		}
			mysqli_close($conexion);
		}
	}
?>