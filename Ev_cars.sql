
SELECT
   [State],
    ISNULL(CAST([Electric (EV)] AS INT),0) +
    ISNULL(CAST([Plug-in Hybrid Electric (PHEV)] AS INT),0) +
    ISNULL(CAST([Hybrid Electric (HEV)] AS INT),0) +
    ISNULL(CAST(Biodiesel AS INT),0) +
    ISNULL(CAST([Ethanol Flex (E85)] AS INT),0) +
    ISNULL(CAST([Compressed Natural Gas (CNG)] AS INT),0) +
    ISNULL(CAST(Propane AS INT),0) +
    ISNULL(CAST(Hydrogen AS INT),0) +
    ISNULL(CAST(Methanol AS INT),0) +
    ISNULL(CAST(Gasoline AS INT),0) +
    ISNULL(CAST(Diesel AS INT),0) +
    ISNULL(CAST([Unknown Fuel] AS INT),0) AS Total_Vehicles
    FROM us_electric_vehicle.dbo.VehicleData 
    order by Total_Vehicles;


WITH VehicleTotals as
(
SELECT
   [State],
    ISNULL(CAST([Electric (EV)] AS INT),0) +
    ISNULL(CAST([Plug-in Hybrid Electric (PHEV)] AS INT),0) +
    ISNULL(CAST([Hybrid Electric (HEV)] AS INT),0) +
    ISNULL(CAST(Biodiesel AS INT),0) +
    ISNULL(CAST([Ethanol Flex (E85)] AS INT),0) +
    ISNULL(CAST([Compressed Natural Gas (CNG)] AS INT),0) +
    ISNULL(CAST(Propane AS INT),0) +
    ISNULL(CAST(Hydrogen AS INT),0) +
    ISNULL(CAST(Methanol AS INT),0) +
    ISNULL(CAST(Gasoline AS INT),0) +
    ISNULL(CAST(Diesel AS INT),0) +
    ISNULL(CAST([Unknown Fuel] AS INT),0) AS Total_Vehicles
    FROM us_electric_vehicle.dbo.VehicleData
)

select dt.[State],
    CAST(CAST([Electric (EV)] AS INT) * 100.0 / Total_Vehicles AS DECIMAL(10,2)) AS EV_Percentage,
    CAST(CAST([Plug-in Hybrid Electric (PHEV)] AS INT) * 100.0 / Total_Vehicles AS DECIMAL(10,2)) AS PHEV_Percentage,
    CAST(CAST([Hybrid Electric (HEV)] AS INT) * 100.0 / Total_Vehicles AS DECIMAL(10,2)) AS HEV_Percentage,
    CAST(CAST(Gasoline AS INT)* 100.0 / Total_Vehicles AS DECIMAL(10,2)) AS Gasoline_Percentage
FROM VehicleTotals st
join us_electric_vehicle.dbo.VehicleData dt
on st.[State]=dt.[State]

--order by EV_Percentage desc

order by EV_Percentage ;





SELECT
    SUM(CAST(Biodiesel AS INT)) AS Biodiesel,
    SUM(CAST([Ethanol Flex (E85)] AS INT)) AS Ethanol_E85,
    SUM(CAST(Hydrogen AS INT)) AS Hydrogen
FROM us_electric_vehicle.dbo.VehicleData;




SELECT
    [State],
    SUM(CAST([Electric (EV)] AS INT)) * 100.0 /
    (SELECT SUM(CAST([Electric (EV)] AS INT))
     FROM us_electric_vehicle.dbo.VehicleData)
     AS EV_State_Percentage
FROM us_electric_vehicle.dbo.VehicleData
GROUP BY [State]
ORDER BY EV_State_Percentage DESC;