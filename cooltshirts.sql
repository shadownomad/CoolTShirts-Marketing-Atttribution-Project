--Get Familiar with CoolTShirts
--1
SELECT COUNT(DISTINCT utm_campaign) AS 'total_campaigns'
FROM page_visits;

SELECT COUNT(DISTINCT utm_source) AS 'total_sources'
FROM page_visits;

SELECT DISTINCT utm_campaign AS 'campaigns', 
  utm_source AS 'sources'
FROM page_visits;
--2
SELECT DISTINCT page_name
FROM page_visits;
-- What is the user journey?
--3
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign AS 'campaign',
   COUNT( ft.first_touch_at) AS 'first_touches'		
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY utm_campaign;
--4
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign AS 'campaign',
   COUNT( lt.last_touch_at) AS 'last_touches'		
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY utm_campaign;
--5
SELECT COUNT(DISTINCT user_id) AS 'total_purchasers'
FROM page_visits
WHERE page_name = '4 - purchase';
--6
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign AS 'campaign',
   COUNT( lt.last_touch_at) AS 'purchases'		
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
WHERE pv.page_name = '4 - purchase'
GROUP BY utm_campaign
ORDER BY purchases DESC;
--7
/* CoolTShirts should  reinvest in :
1.weekly newsletter
2.retargetting ad
3. retargetting campaign
4. paid search
5. ten crazy CoolTShirts 
because they  produced the most sales*/
