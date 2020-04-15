CREATE FUNCTION dbo.fn_CalcAge
(
   @DOB  DATETIME
 , @Date DATETIME
)
RETURNS TABLE
AS
   /* 
   ======================================================================================================================================
   OBJECT NAME: dbo.fn_CalcAge
   PURPOSE    : To calculate age accurately even on birth day in a highly performant method using CROSS APPLY when table value function
                is called
   ACCEPTS    : @DOB date of birth, @Date any future date such as current date
   RETURNS    : Age
   CALLED BY  : Reports
   AUTHOR     : Fausto Gonzalez
   CREATED    : 03/05/2018
   ======================================================================================================================================
   EXAMPLE CALLS:
   --------------------------------------------------------------------------------------------------------------------------------------
   DECLARE @DOB  DATETIME = '19720829'
         , @Date DATETIME = '20180828'
   SELECT r.DOB, r.MyDate, l.Age
   FROM (SELECT @DOB AS DOB, @Date AS MyDate) AS r
   CROSS APPLY dbo.fn_CalcAge(r.DOB, r.MyDate) AS l
   ======================================================================================================================================	
   CHANGE LOG:
   --------------------------------------------------------------------------------------------------------------------------------------
   Developer			Date			    Purpose		
   --------------------	-----------------	---------------------------------------------------------------------------------------------
   Fausto Gonzalez		03/05/2018			Table-Valued Function created
   ======================================================================================================================================
   */
   RETURN 
          SELECT
               Age = CASE
                        WHEN DATEADD(YEAR, DATEDIFF(YEAR, @DOB, @Date), @DOB) > @Date
                        THEN DATEDIFF(HOUR, @DOB, @Date) / 8766
                        ELSE DATEDIFF(HOUR, @DOB, @Date) / 8760
                     END;