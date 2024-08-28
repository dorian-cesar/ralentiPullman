<?php

//$hash="8b566d9b188d7d1189b3a07d1f4f458f";


listado:
$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'http://www.trackermasgps.com/api-v2/tracker/list',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => '{"hash": "' . $hash . '"}',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/json'
  ),
));

$list = curl_exec($curl);

curl_close($curl);



  $arrayList = json_decode($list);

  if (isset($arrayList->list)) {

  $i = 0;

  foreach ($arrayList->list as $item) {

    $id_tracker = $item->id;

    $patente = substr($item->label, 0, 7);

    $elemento = array(

      'id_tracker' => $id_tracker,
      'patente' => $patente
    );

    $listado[$i] = $elemento;
    $i++;
  }
} else {
  include "./login/login-bronces.php";



  $consulta = "UPDATE `masgps`.`hash` SET `hash` = '$hash' WHERE (`id` = '3');";

  $resutaldo3 = mysqli_query($mysqli, $consulta);

  goto listado;
}

//echo json_encode($listado);
