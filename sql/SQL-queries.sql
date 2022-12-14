-- Упражнение 1 --

/* Выберите строки из таблицы band, которые в колонке “name" содержат
значение 'Led Zeppelin'.
Выведите в результат запроса только колонки “band_id”, “name” и “year”. */
SELECT band_id, name, year
FROM band
WHERE name = 'Led Zeppelin'
;
 
/* Для найденного на шаге 1 значения “band_id”, выберите соответствующие
строки из таблицы album. Сколько строк вернул запрос? */
SELECT album_id, name, band_id, year
FROM album
WHERE band_id = 388
-- 9 
;

-- Упражнение 2 --

/* Объедините два запроса в единый запрос: выберите строки из
таблицы альбомов album, для которых колонка “band_id” принимает
значения, соответствующие значениям “band_id” из таблицы band, где
колонка name принимает значение 'Led Zeppelin' */
SELECT album_id, name, band_id, year
FROM album
WHERE 
	band_id in(SELECT band_id
			  from band
			  where name = 'Led Zeppelin')
;

-- Упражнение 3 --

/* Выберите из таблицы band только те музыкальные группы с названием
Icarus, которые содержат неопределенное значение NULL в колонке “year” */
SELECT * from band
WHERE name = 'Icarus' and year IS NULL
;

-- Упражнение 4 --

/* Выберите строки из таблицы band, выполните группировку строк по
названию группы, и посчитайте количество строк для каждого названия
группы. */
select name, count(*)
from band
GROUP BY 1
;

/* Добавьте в предыдущий запрос фильтр, чтобы найти только те названия
групп, для которых нашлось две и более строки. */
select name, count(*)
from band
GROUP BY 1
having count(*)>2
;

/* Добавьте в запрос сортировку строк по колонке с количеством строк для
каждого названия музыкальной группы. Сделайте сортировку по убыванию
этой колонки - так, чтобы наибольшие значения оказались наверху
результата запроса. */
select name, count(*)
from band
GROUP BY 1
having count(*)>2
order by 2 DESC
;

/* Выберите строки из таблицы альбомов album, выполнив группировку
данных по номеру музыкальной группы band_id. Для каждого номера
музыкальной группы, посчитайте количество альбомов.
Сделайте сортировку данных по второй колонке запроса, по убыванию,
чтобы наверху результата запроса оказался номер музыкальной группы с
наибольшим количеством альбомов.
Возьмите номер band_id для музыкальной группы с наибольшим
количеством альбомов. Найдите её название в таблице band по номеру
band_id. */
select band_id, count(*)
from album
group by 1
order by 2 DESC
;

select name
from band
where band_id = 562672
;

select *
from band
where band_id in (
	select band_id
	from 
	(
		select band_id, count(*)
		from album
		group by 1
		order by 2 DESC
	) as p
	limit 1
)
;

-- #Упражнение 5 --

/* Выберите все колонки из таблицы band с условием name = 'Led Zeppelin'. */
select * 
from band
where name = 'Led Zeppelin'
;

/* Модифицируйте запрос - добавьте в запрос соединение с таблицей album по колонке “band_id”. 
Выберите в результат все колонки. */
select * 
from band as b
inner join album as a
on b.band_id = a.band_id
where b.name = 'Led Zeppelin'
;

-- #Упражнение 6 --

/* Выберите из таблицы album все альбомы группы Led Zeppelin, выбрав их по
условию band_id=388. Отсортируйте данные по возрастанию колонки year. */
select *
from album as a
where a.band_id = 388
order by a.year
;

/* Сделайте в предыдущем запросе группировку по колонке year, чтобы
посчитать количество альбомов в каждом году. Отсортируйте результат по
колонке year. */
select year, COUNT(year)
from album as a
where a.band_id = 388
group by a.year
order by a.year
;

/* Выберите из таблицы calendar_year все строки, 
где колонка year принимает значения между 1969 и 1982.
Отсортируйте результат по колонке year */
select c.year
from calendar_year as c
where year between 1969 and 1982 
;

/* Выполните внешнее соединение таблицы calendar_year и album по колонке
year. Выберите LEFT OUTER JOIN или RIGHT OUTER JOIN так, чтобы
основной таблицей была таблицы calendar_year */
select c.year
from calendar_year as c
left join album as a
on c.year = a.year
;

/* Из таблицы calendar_year выберите только года от 1969 по 1982.
Из таблицы album выберите альбомы музыкальной группы с номером 388. */ 
select *
from calendar_year as c
left join album as a
on c.year = a.year
and a.band_id = 388
where c.year between 1969 and 1982 
order by c.year
;

/* Для каждого года посчитайте количество альбомов, выпущенных группой
Led Zeppelin в этом году */ 
select c.year, count(c.year)
from calendar_year as c
left join album as a
on c.year = a.year
and a.band_id = 388
where c.year between 1969 and 1982 
group by c.year
order by c.year
;

-- #Упражнение 7 -- 

/* Выберите из таблицы music_instrument инструмент с номером id=1.
Отобразите только колонки id и name. */
select id, name
from music_instrument as m
where m.id = 1
;

/* Добавьте в запрос внешнее соединение с этой же таблицей, чтобы найти все
дочерние инструменты для инструмента wind instruments. */ 
select m.id, i.name, 
	   i.id as child_id, 
	   m.name as child_name
from music_instrument as m
left join music_instrument as i 
on m.parent_id = i.id
where i.id = 1
;

/* Для каждой найденной строки, найдите их дочерние инструменты.
Используйте дополнительное внешнее соединение с той же самой таблицей.
Для вновь добавленной таблицы используйте названия колонок
grandchild_id и grandchild_name. */
select m.id, m.name, 
	   i.id as child_id, i.name as child_name, 
	   c.id as grandchild_id, c.name as grandchild_name
from music_instrument as m
left join music_instrument as i on i.parent_id = m.id
left join music_instrument as c on c.parent_id = i.id
where m.id = 1 
order by m.name, child_name, grandchild_name 
;

-- #Упражнение 8 --

/* Найдите номера всех музыкальных групп, которые выпустили альбомы с
названием Now. Выберите только колонку band_id. */ 
select band_id
from album 
where name = 'Now'
;

/* Найдите номера всех музыкальных групп, которые выпустили альбомы с
названием The Collection. */
select band_id
from album 
where name = 'The Collection'
;

/* Найдите номера музыкальных групп, которые встречаются и в
первом, и во втором списке (на шаге 1 и 2). */

select band_id
from album 
where name = 'Now'
intersect
select band_id
from album 
where name = 'The Collection'
;

/* На предыдущем шаге мы получили только номера музыкальных групп.
Давайте также найдём их названия. */
select * 
from band
where band_id IN (
		select band_id from album  where name = 'Now'
		intersect
		select band_id from album  where name = 'The Collection'
)
;

-- #Упражнение 9 --
