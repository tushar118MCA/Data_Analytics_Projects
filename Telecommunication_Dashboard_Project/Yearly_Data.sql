SELECT * FROM public."pnl_telecommunication_telecom__services"
LIMIT 100

SELECT * FROM public."derived_yearly_ratios";

DROP TABLE IF EXISTS public.derived_yearly_ratios;

CREATE TABLE public.derived_yearly_ratios AS
WITH raw_pivoted AS (
    SELECT 
        c."Company Symbol",
        c."Igroup",
        pl."financial_year" AS financial_year,
        
        -- Sum of available values from the source database (Yearly aggregation)
        SUM(CASE WHEN pl."element_id" = '60026' THEN pl."pl_value"::NUMERIC ELSE 0.0 END) AS v_60026,
        SUM(CASE WHEN pl."element_id" = '60027' THEN pl."pl_value"::NUMERIC ELSE 0.0 END) AS v_60027,
        SUM(CASE WHEN pl."element_id" = '60029' THEN pl."pl_value"::NUMERIC ELSE 0.0 END) AS v_60029,
        SUM(CASE WHEN pl."element_id" = '60031' THEN pl."pl_value"::NUMERIC ELSE 0.0 END) AS v_60031,
        SUM(CASE WHEN pl."element_id" = '60032' THEN pl."pl_value"::NUMERIC ELSE 0.0 END) AS v_60032,
        SUM(CASE WHEN pl."element_id" = '60033' THEN pl."pl_value"::NUMERIC ELSE 0.0 END) AS v_60033,
        SUM(CASE WHEN pl."element_id" = '60034' THEN pl."pl_value"::NUMERIC ELSE 0.0 END) AS v_60034,
        SUM(CASE WHEN pl."element_id" = '60035' THEN pl."pl_value"::NUMERIC ELSE 0.0 END) AS v_60035,
        SUM(CASE WHEN pl."element_id" = '60040' THEN pl."pl_value"::NUMERIC ELSE 0.0 END) AS v_60040,
        SUM(CASE WHEN pl."element_id" = '60041' THEN pl."pl_value"::NUMERIC ELSE 0.0 END) AS v_60041
        
    FROM public."Company" c
    LEFT JOIN public."pnl_telecommunication_telecom__services" pl ON c."Company Symbol" = pl."Company Symbol"
    WHERE pl."financial_year" IS NOT NULL
    GROUP BY c."Company Symbol", c."Igroup", pl."financial_year"
),
calculated_final AS (
    SELECT 
        *,
        (v_60026 + v_60027) AS inc,                                      -- Income
        (v_60029 + v_60031) AS cogs,                                     -- Total COGS
        ((v_60026 + v_60027) - (v_60029 + v_60031)) AS gross_margin,     -- Gross Margin
        ((v_60026 + v_60027) - (v_60029 + v_60031) - v_60032 - v_60035) AS ebidta,    
        ((v_60026 + v_60027) - (v_60029 + v_60031) - v_60032 - v_60035 - v_60034) AS ebit,
        ((v_60026 + v_60027) - (v_60029 + v_60031) - v_60032 - v_60035 - v_60034 - v_60033) AS pbt,
        (v_60040 + v_60041) AS tax_exp
    FROM raw_pivoted
),
calculated_with_pat AS (
    SELECT
        *,
        (pbt - tax_exp) AS pat,                                           -- PAT
        CASE WHEN inc = 0 THEN 1 ELSE inc END AS inc_base                 -- % for base
    FROM calculated_final
)
SELECT 
    f."Company Symbol", f."Igroup", f.financial_year,
    t."Element_Id", t."Element_Name", t."P&L Cateogry",
    CASE 
        WHEN t."Element_Id" = 60026 THEN f.v_60026
        WHEN t."Element_Id" = 60027 THEN f.v_60027
        WHEN t."Element_Id" = 60028 THEN f.inc
        WHEN t."Element_Id" = 60029 THEN f.v_60029
        WHEN t."Element_Id" = 60031 THEN f.v_60031
        WHEN t."Element_Id" = 600001 THEN f.cogs
        WHEN t."Element_Id" = 600002 THEN f.gross_margin
        WHEN t."Element_Id" = 600003 THEN (f.gross_margin / f.inc_base) * 100
        WHEN t."Element_Id" = 60032 THEN f.v_60032
        WHEN t."Element_Id" = 60035 THEN f.v_60035
        WHEN t."Element_Id" = 600004 THEN f.ebidta
        WHEN t."Element_Id" = 60034 THEN f.v_60034
        WHEN t."Element_Id" = 60033 THEN f.v_60033
        WHEN t."Element_Id" = 60039 THEN f.pbt
        WHEN t."Element_Id" = 60042 THEN f.tax_exp
        WHEN t."Element_Id" = 60049 THEN f.pat
        WHEN t."Element_Id" = 600005 AND t."Element_Name" = 'Operating Profit%' THEN (f.ebidta / f.inc_base) * 100
        WHEN t."Element_Id" = 600005 AND t."Element_Name" = 'PBT%' THEN (f.pbt / f.inc_base) * 100
        WHEN t."Element_Id" = 600006 AND t."Element_Name" = 'PAT%' THEN (f.pat / f.inc_base) * 100
        ELSE 0.0 
    END AS "Calculated_Value"
FROM calculated_with_pat f
CROSS JOIN (
    SELECT 60026 AS "Element_Id", 'RevenueFromOperations' AS "Element_Name", 'Revenue / Income' AS "P&L Cateogry" UNION ALL
    SELECT 60027, 'OtherIncome', 'Revenue / Income' UNION ALL
    SELECT 60028, 'Income', 'Revenue / Income' UNION ALL
    SELECT 60029, 'CostOfMaterialsConsumed', 'Expenses' UNION ALL
    SELECT 60031, 'ChangesInInventoriesOfFinishedGoodsWorkInProgressAndStockInTrade', 'Expenses' UNION ALL
    SELECT 600001, 'Total COGS', 'Expenses' UNION ALL
    SELECT 600002, 'Gross Margin', 'Profit' UNION ALL
    SELECT 600003, 'Gross Margin %', 'Profit' UNION ALL
    SELECT 60032, 'EmployeeBenefitExpense', 'Expenses' UNION ALL
    SELECT 60035, 'OtherExpenses', 'Expenses' UNION ALL
    SELECT 600004, 'EBIDTA/ Operating Profit', 'Profit' UNION ALL
    SELECT 600005, 'Operating Profit%', 'Profit' UNION ALL
    SELECT 60034, 'DepreciationDepletionAndAmortisationExpense', 'Expenses' UNION ALL
    SELECT 60033, 'FinanceCosts', 'Expenses' UNION ALL
    SELECT 60039, 'ProfitBeforeTax', 'Profit' UNION ALL
    SELECT 600005, 'PBT%', 'Profit' UNION ALL
    SELECT 60042, 'TaxExpense', 'Tax' UNION ALL
    SELECT 60049, 'ProfitLossForPeriod', 'Profit' UNION ALL
    SELECT 600006, 'PAT%', 'Profit'
) t
ORDER BY f."Company Symbol", f.financial_year, t."Element_Id";