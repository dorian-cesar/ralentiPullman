SELECT 
    ralentiPullman.id,
    ralentiPullman.contrato,
    ralentiPullman.id_tracker,
    ralentiPullman.patente,
    ralentiPullman.fecha,
    -- Convertir a minutos los campos duration, in_movement e idle
   ( (CAST(SUBSTRING_INDEX(ralentiPullman.duration, ':', 1) AS UNSIGNED) * 60) + 
    CAST(SUBSTRING_INDEX(ralentiPullman.duration, ':', -1) AS UNSIGNED))*60 AS duration_seg,
  (  (CAST(SUBSTRING_INDEX(ralentiPullman.in_movement, ':', 1) AS UNSIGNED) * 60) + 
    CAST(SUBSTRING_INDEX(ralentiPullman.in_movement, ':', -1) AS UNSIGNED))*60 AS in_movement_seg,
    ((CAST(SUBSTRING_INDEX(ralentiPullman.idle, ':', 1) AS UNSIGNED) * 60) + 
    CAST(SUBSTRING_INDEX(ralentiPullman.idle, ':', -1) AS UNSIGNED))*60 AS idle_seg,
    -- Campos de la tabla infoVehiculos
    infoVehiculos.descCentroCosto,
    infoVehiculos.unidadNegocio,
    infoVehiculos.estado,
    infoVehiculos.ubicacion,
    infoVehiculos.descFlota
FROM 
    ralentiPullman
LEFT JOIN 
    infoVehiculos
ON 
    LEFT(ralentiPullman.patente, 7) = LEFT(infoVehiculos.patente, 7)
    WHERE fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);