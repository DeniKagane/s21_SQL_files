SELECT generated_date AS missing_date
FROM v_generated_dates
WHERE NOT EXISTS (
  SELECT visit_date FROM person_visits 
  WHERE v_generated_dates.generated_date = person_visits.visit_date
)
ORDER BY generated_date;