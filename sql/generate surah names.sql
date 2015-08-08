use Quran

DECLARE @json NVARCHAR(max)  
set @json = N''
--set @json = '<script type="text/javascript">' + CHAR(13)
set @json = @json + 'window.surahs = {' 

SELECT @json = COALESCE(@json + char(13), '') + json FROM 
(
select N'"surah' + convert(nvarchar(3),sura) + '": { s: ' + convert(nvarchar(3),sura) + ', p: ' + convert(nvarchar(3), page) + ', a:"' + text + '", b: "' + Bangla + '", e: "' + English + '"},' as json FROM
(
  select sura, page, text COLLATE Arabic_100_CI_AI as text, b.Name as Bangla, e.Name as English  from madani_page 
  join SurahNames b on b.SurahNo = sura and b.LanguageID = 2
  join SurahNames e on e.SurahNo = sura and e.LanguageID = 1
  where ayah = 0 and len(text) < 20
  
) A
) B

set @json = @json + CHAR(13) + '};' + CHAR(13) 


declare @path varchar(100)
declare @filename varchar(100)
set @path = 'E:\Google Drive2\Islam\QuranApp\page'
set @filename = 'surahs.js'
exec [dbo].[spWriteStringToFile]  @json, @path, @filename

print @json