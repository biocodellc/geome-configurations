SELECT
    pc.id AS config_id,
    -- Get the title of the first created project for the configuration
    (
        SELECT p_inner.project_title
        FROM projects p_inner
        WHERE p_inner.config_id = pc.id
        ORDER BY p_inner.created ASC
        LIMIT 1
    ) AS first_project,
    -- Enumerate all project IDs belonging to this configuration
    string_agg(DISTINCT p.id::text, ', ') AS project_ids,
    pc.name AS config_name,
    pc.network_approved,
    entity->>'hashed' AS hashed,
    entity->>'worksheet' AS worksheet,
    entity->>'conceptAlias' AS concept_alias,
    entity->>'uniqueKey' AS unique_key,
    entity->>'uniqueAcrossProject' AS unique_across_project,
    -- Aggregate all rules into a single JSON array
    jsonb_agg(rule) AS rules_json
FROM
    projects p
JOIN
    project_configurations pc
ON
    p.config_id = pc.id
-- Extract entities as an array
CROSS JOIN LATERAL jsonb_array_elements(pc.config->'entities') AS entity
-- Extract rules as a sub-array of entities
LEFT JOIN LATERAL jsonb_array_elements(entity->'rules') AS rule ON TRUE
-- Filter by list of config_id values
WHERE
    pc.id IN (171, 2, 5, 6, 43) -- Replace with your desired list of config_id values
-- Group by config_id and concept_alias
GROUP BY
    pc.id, pc.name, pc.network_approved,
    entity->>'hashed', entity->>'worksheet', entity->>'conceptAlias',
    entity->>'uniqueKey', entity->>'uniqueAcrossProject';
    projects p
JOIN
    project_configurations pc
ON
    p.config_id = pc.id
-- Extract entities as an array
CROSS JOIN LATERAL jsonb_array_elements(pc.config->'entities') AS entity
-- Extract rules as a sub-array of entities
LEFT JOIN LATERAL jsonb_array_elements(entity->'rules') AS rule ON TRUE
-- Group by config_id and concept_alias
GROUP BY
    pc.id, pc.name, pc.network_approved,
    entity->>'hashed', entity->>'worksheet', entity->>'conceptAlias',
    entity->>'uniqueKey', entity->>'uniqueAcrossProject';