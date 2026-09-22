-- Cybercrime Network Intrusion Analysis
-- Portfolio SQL queries for investigating network incidents


-- 1. Distribution of incident categories

SELECT
    attack_category,
    COUNT(*) AS records,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM network_incidents),
        2
    ) AS percentage
FROM network_incidents
GROUP BY attack_category
ORDER BY records DESC;


-- 2. Attacks by network protocol

SELECT
    proto,
    COUNT(*) AS attack_records
FROM network_incidents
WHERE is_attack = 1
GROUP BY proto
ORDER BY attack_records DESC;


-- 3. Attack rate by protocol

SELECT
    proto,
    COUNT(*) AS total_records,
    SUM(is_attack) AS attacks,
    ROUND(
        100.0 * SUM(is_attack) / COUNT(*),
        2
    ) AS attack_rate_pct
FROM network_incidents
GROUP BY proto
ORDER BY attack_rate_pct DESC;


-- 4. Most frequently targeted services

SELECT
    service,
    COUNT(*) AS attack_records
FROM network_incidents
WHERE is_attack = 1
GROUP BY service
ORDER BY attack_records DESC
LIMIT 10;


-- 5. Average flow duration by incident category

SELECT
    attack_category,
    ROUND(AVG(flow_duration), 2) AS average_flow_duration,
    COUNT(*) AS records
FROM network_incidents
GROUP BY attack_category
ORDER BY records DESC;


-- 6. Most frequently targeted destination ports

SELECT
    id_resp_p AS destination_port,
    COUNT(*) AS attack_records
FROM network_incidents
WHERE is_attack = 1
GROUP BY id_resp_p
ORDER BY attack_records DESC
LIMIT 10;


-- 7. Detailed attack types

SELECT
    attack_type,
    attack_category,
    COUNT(*) AS records
FROM network_incidents
WHERE is_attack = 1
GROUP BY attack_type, attack_category
ORDER BY records DESC;