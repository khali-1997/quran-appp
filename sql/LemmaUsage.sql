/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Root]
      ,[Lemma]
      ,[Occurences]
      ,[Meaning]
      ,[Verse],
	  (SELECT top 5 [Text] + ', ' AS 'data()' 
FROM WordInformation w
where w.Lemma = L.Lemma 
group by w.Text
order by count(w.Text) desc
FOR XML PATH('')) as Usage
INTO LemmaMeaningUsageAyah
  FROM [Quran].[dbo].[LemmaMeaningWithAyah] L
  order by Occurences desc

  