/*

Below is a script that will quickly create basic date dimension table (temp table for demo purposes) that 
can be used to lookup fiscal date values 

*/

IF OBJECT_ID('tempdb..#DimDate') IS NOT NULL 
DROP 
  TABLE #DimDate;
  DECLARE @MyFiscalDateStart date = '20171201', 
  @MyFiscalMonthStart int, 
  @OffSet int;
SET 
  @MyFiscalMonthStart = MONTH(@MyFiscalDateStart);
--SELECT
--   @MyFiscalDateStart
-- , @MyFiscalMonthStart;
SET 
  @OffSet = @MyFiscalMonthStart -1;
WITH CTE_DatesTable AS (
  SELECT 
    MyDate = @MyFiscalDateStart 
  UNION ALL 
  SELECT 
    DATEADD(DAY, 1, MyDate) 
  FROM 
    CTE_DatesTable 
  WHERE 
    DATEADD(DAY, 1, MyDate) < DATEADD(YEAR, 5, @MyFiscalDateStart) -- goes 5 years out, can change number part to suit your needs
    ) 
SELECT 
  DateKey = MyDate, 
  CalMonthNumber = DATEPART(MONTH, MyDate), 
  FiscalMonthNumber = CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
    DATEPART(MONTH, MyDate) - @OffSet
  ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
  MonthLongName = DATENAME(MONTH, MyDate), 
  MonthShortName = SUBSTRING(
    LTRIM(
      DATENAME(MONTH, MyDate)
    ), 
    0, 
    4
  ), 
  CalendarYear = DATEPART(YEAR, MyDate), 
  CalQtrNumber = DATENAME(QUARTER, MyDate), 
  FYQtrNumber = CASE WHEN MyDate >= DATEADD(
    MONTH, 
    -12, 
    DATEADD(
      MONTH, 
      13 - CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
        DATEPART(MONTH, MyDate) - @OffSet
      ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
      DATEADD(
        DAY, 
        1, 
        EOMONTH(MyDate, -1)
      )
    )
  ) 
  AND MyDate < DATEADD(
    MONTH, 
    3, 
    DATEADD(
      MONTH, 
      -12, 
      DATEADD(
        MONTH, 
        13 - CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
          DATEPART(MONTH, MyDate) - @OffSet
        ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
        DATEADD(
          DAY, 
          1, 
          EOMONTH(MyDate, -1)
        )
      )
    )
  ) THEN 1 WHEN MyDate >= DATEADD(
    MONTH, 
    3, 
    DATEADD(
      MONTH, 
      -12, 
      DATEADD(
        MONTH, 
        13 - CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
          DATEPART(MONTH, MyDate) - @OffSet
        ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
        DATEADD(
          DAY, 
          1, 
          EOMONTH(MyDate, -1)
        )
      )
    )
  ) 
  AND MyDate < DATEADD(
    MONTH, 
    6, 
    DATEADD(
      MONTH, 
      -12, 
      DATEADD(
        MONTH, 
        13 - CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
          DATEPART(MONTH, MyDate) - @OffSet
        ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
        DATEADD(
          DAY, 
          1, 
          EOMONTH(MyDate, -1)
        )
      )
    )
  ) THEN 2 WHEN MyDate >= DATEADD(
    MONTH, 
    6, 
    DATEADD(
      MONTH, 
      -12, 
      DATEADD(
        MONTH, 
        13 - CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
          DATEPART(MONTH, MyDate) - @OffSet
        ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
        DATEADD(
          DAY, 
          1, 
          EOMONTH(MyDate, -1)
        )
      )
    )
  ) 
  AND MyDate < DATEADD(
    MONTH, 
    9, 
    DATEADD(
      MONTH, 
      -12, 
      DATEADD(
        MONTH, 
        13 - CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
          DATEPART(MONTH, MyDate) - @OffSet
        ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
        DATEADD(
          DAY, 
          1, 
          EOMONTH(MyDate, -1)
        )
      )
    )
  ) THEN 3 WHEN MyDate >= DATEADD(
    MONTH, 
    9, 
    DATEADD(
      MONTH, 
      -12, 
      DATEADD(
        MONTH, 
        13 - CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
          DATEPART(MONTH, MyDate) - @OffSet
        ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
        DATEADD(
          DAY, 
          1, 
          EOMONTH(MyDate, -1)
        )
      )
    )
  ) 
  AND MyDate < DATEADD(
    MONTH, 
    12, 
    DATEADD(
      MONTH, 
      -12, 
      DATEADD(
        MONTH, 
        13 - CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
          DATEPART(MONTH, MyDate) - @OffSet
        ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
        DATEADD(
          DAY, 
          1, 
          EOMONTH(MyDate, -1)
        )
      )
    )
  ) THEN 4 ELSE NULL END, 
  FirstDayOfMonth = DATEADD(
    DAY, 
    1, 
    EOMONTH(MyDate, -1)
  ), 
  FYStartDate = DATEADD(
    MONTH, 
    -12, 
    DATEADD(
      MONTH, 
      13 - CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
        DATEPART(MONTH, MyDate) - @OffSet
      ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
      DATEADD(
        DAY, 
        1, 
        EOMONTH(MyDate, -1)
      )
    )
  ), 
  FYEndDate = EOMONTH(
    DATEADD(
      MONTH, 
      12 - CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
        DATEPART(MONTH, MyDate) - @OffSet
      ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
      DATEADD(
        DAY, 
        1, 
        EOMONTH(MyDate, -1)
      )
    )
  ), 
  FiscalYear = YEAR(
    EOMONTH(
      DATEADD(
        MONTH, 
        12 - CASE WHEN DATEPART(MONTH, MyDate) - @OffSet < 0 THEN (
          DATEPART(MONTH, MyDate) - @OffSet
        ) + 12 WHEN DATEPART(MONTH, MyDate) - @OffSet = 0 THEN 12 ELSE DATEPART(MONTH, MyDate) - @OffSet END, 
        DATEADD(
          DAY, 
          1, 
          EOMONTH(MyDate, -1)
        )
      )
    )
  ) INTO #DimDate
FROM 
  CTE_DatesTable OPTION (MAXRECURSION 0);
SELECT 
  dd.DateKey, 
  dd.CalendarYear, 
  dd.CalMonthNumber, 
  dd.CalQtrNumber, 
  dd.FiscalYear, 
  dd.FiscalMonthNumber, 
  dd.FYQtrNumber, 
  dd.FirstDayOfMonth, 
  dd.FYStartDate, 
  dd.FYEndDate 
FROM 
  #DimDate AS dd;