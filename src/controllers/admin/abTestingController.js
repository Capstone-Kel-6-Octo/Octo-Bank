const pool = require("../../config/db");

// GROUP DISTRIBUTION

exports.getGroups = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

group_type,
COUNT(*) AS total

FROM ab_testing

GROUP BY group_type
`
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// CTR METRICS

exports.getCTR = async (req, res) => {
  try {
    const result = await pool.query(
      `
SELECT

ROUND(

(
SUM(
CASE
WHEN interaction_type='CLICK'
THEN 1
ELSE 0
END
)::numeric

/

NULLIF(

SUM(
CASE
WHEN interaction_type='VIEW'
THEN 1
ELSE 0
END
),

0

)

)*100

,2)

AS ctr

FROM feature_interactions
`
    );

    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};

// CTR PER GROUP

exports.getCTRByGroup = async (req, res) => {
  try {
    const result = await pool.query(
      `

SELECT

ab.group_type,

ROUND(

(

SUM(

CASE

WHEN fi.interaction_type='CLICK'

THEN 1
ELSE 0

END

)::numeric

/

NULLIF(

SUM(

CASE

WHEN fi.interaction_type='VIEW'

THEN 1
ELSE 0

END

),

0

)

)*100

,2)

AS ctr


FROM ab_testing ab

JOIN feature_interactions fi

ON ab.user_id=fi.user_id


GROUP BY
ab.group_type

`
    );

    res.json(result.rows);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
