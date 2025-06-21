SELECT 
  brand,
  ROUND(AVG(battery_capacity_kWh)::numeric) AS avg_battery_capacity_rounded
FROM electric_vehicles_spec_2025
GROUP BY brand
ORDER BY avg_battery_capacity_rounded DESC;

SELECT drivetrain, 
ROUND(AVG(acceleration_0_100_s)::numeric,1) AS avg_acceleration
FROM electric_vehicles_spec_2025
GROUP BY drivetrain
ORDER BY avg_acceleration ASC;

SELECT 
car_body_type,
ROUND(AVG(range_km)::numeric) AS avg_range
FROM electric_vehicles_spec_2025
GROUP BY car_body_type
ORDER BY avg_range DESC;

SELECT 
  COUNT(*) FILTER (WHERE number_of_cells IS NULL) AS missing_number_of_cells,
  COUNT(*) FILTER (WHERE torque_nm IS NULL) AS missing_torque,
  COUNT(*) FILTER (WHERE fast_charging_power_kw_dc IS NULL) AS missing_fast_charging_power
FROM electric_vehicles_spec_2025;

SELECT 
segment,
  CORR(battery_capacity_kWh, range_km) AS corr_battery_range,
  CORR(battery_capacity_kWh, acceleration_0_100_s) AS corr_battery_acceleration,
  CORR(range_km, acceleration_0_100_s) AS corr_range_acceleration
FROM electric_vehicles_spec_2025
WHERE battery_capacity_kWh IS NOT NULL 
  AND range_km IS NOT NULL 
  AND acceleration_0_100_s IS NOT NULL
GROUP BY segment
ORDER BY segment;

SELECT brand, model, battery_capacity_kWh, range_km, acceleration_0_100_s
FROM electric_vehicles_spec_2025
WHERE battery_capacity_kWh > (SELECT AVG(battery_capacity_kWh) + 1.96 * STDDEV(battery_capacity_kWh) FROM electric_vehicles_spec_2025)
   OR range_km < (SELECT AVG(range_km) - 1.96 * STDDEV(range_km) FROM electric_vehicles_spec_2025)
ORDER BY battery_capacity_kWh DESC;

SELECT
  brand,
  model,
  ROUND(range_km / battery_capacity_kWh::numeric, 2) AS efficiency_km_per_kWh
FROM electric_vehicles_spec_2025
ORDER BY efficiency_km_per_kWh DESC
LIMIT 10;












