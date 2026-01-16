-- Schema
Organization(
  org_id PK,
  org_name,
  founding_year
)

Member(
  member_id PK,
  first_name,
  last_name,
  email UNIQUE
)

Event(
  event_id PK,
  org_id FK,
  event_name,
  event_date,
  event_type
)

Role(
  role_id PK,
  role_name
)

Membership(
  member_id FK,
  org_id FK,
  start_date,
  end_date,
  PRIMARY KEY (member_id, org_id, start_date)
)


Attendance(
  member_id FK,
  event_id FK,
  check_in_time,
  PRIMARY KEY (member_id, event_id)
)

MemberRole(
  member_id FK,
  role_id FK,
  org_id FK,
  start_date,
  end_date,
  PRIMARY KEY (member_id, role_id, org_id, start_date)
)


-- attendance per event
SELECT e.event_name, COUNT(a.member_id) AS attendees
FROM Event e
LEFT JOIN Attendance a ON e.event_id = a.event_id
GROUP BY e.event_name;

-- active members per organization
SELECT org_id, COUNT(DISTINCT member_id) AS active_members
FROM Membership
WHERE end_date IS NULL
GROUP BY org_id;

-- leadership participation over time
SELECT role_id, COUNT(DISTINCT member_id) AS num_leaders
FROM MemberRole
WHERE end_date IS NULL
GROUP BY role_id;

