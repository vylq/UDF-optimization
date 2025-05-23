DROP FUNCTION IF EXISTS dbo.F_WORKS_LIST;
GO
CREATE FUNCTION dbo.F_WORKS_LIST()
RETURNS TABLE
AS
RETURN
(
    SELECT
        w.Id_Work,
        w.CREATE_Date,
        w.MaterialNumber,
        w.IS_Complit,
        w.FIO,
        CONVERT(varchar(10), w.CREATE_Date, 104) AS D_DATE,
        ISNULL(cnt.NotCompleted, 0)  AS WorkItemsNotComplit,
        ISNULL(cnt.Completed,    0)  AS WorkItemsComplit,
        COALESCE(
          emp.Surname 
          + ' ' + UPPER(LEFT(emp.Name,1)) + '.'
          + ' ' + UPPER(LEFT(emp.Patronymic,1)) + '.',
          w.FIO
        ) AS EmployeeFullName,
        w.StatusId,
        ws.StatusName,
        CASE 
          WHEN w.Print_Date       IS NOT NULL 
            OR w.SendToClientDate IS NOT NULL 
            OR w.SendToDoctorDate IS NOT NULL 
            OR w.SendToOrgDate    IS NOT NULL 
            OR w.SendToFax        IS NOT NULL 
          THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT)
        END AS Is_Print
    FROM dbo.Works AS w
    LEFT JOIN dbo.WorkStatus AS ws 
      ON w.StatusId = ws.StatusID
    LEFT JOIN (
        SELECT 
          wi.Id_Work,
          SUM(CASE WHEN wi.Is_Complit = 0 THEN 1 ELSE 0 END) AS NotCompleted,
          SUM(CASE WHEN wi.Is_Complit = 1 THEN 1 ELSE 0 END) AS Completed
        FROM dbo.WorkItem AS wi
        INNER JOIN dbo.Analiz AS a
          ON wi.ID_ANALIZ = a.ID_ANALIZ
         AND a.IS_GROUP   = 0
        GROUP BY wi.Id_Work
    ) AS cnt
      ON cnt.Id_Work = w.Id_Work
    LEFT JOIN dbo.Employee AS emp
      ON emp.Id_Employee = w.Id_Employee
    WHERE w.Is_Del <> 1
);
GO
