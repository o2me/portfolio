Посчитайте, сколько компаний закрылось.
  select count(name) 
  from company
  where status = 'closed'
  
Отобразите количество привлечённых средств для новостных компаний США.
  select funding_total
  from company
  where category_code = 'news' and country_code = 'USA'
  order by funding_total desc


Найдите общую сумму сделок по покупке одних компаний другими в долларах. 
Отберите сделки, которые осуществлялись только за наличные с 2011 по 2013 год включительно.
  select sum(price_amount)
  from acquisition
  where term_code = 'cash'
  and cast (acquired_at as date) between '2011-01-01' and '2013-12-31'
  
Отобразите имя, фамилию и названия аккаунтов людей в твиттере, 
у которых названия аккаунтов начинаются на 'Silver'.

  select first_name, last_name, twitter_username
  from people
  where twitter_username like 'Silver%'
  
Выведите на экран всю информацию о людях, у которых названия аккаунтов в твиттере содержат подстроку 'money', 
а фамилия начинается на 'K'.

  select *
  from people
  where twitter_username like '%money%'
  and last_name like 'K%'
  
Для каждой страны отобразите общую сумму привлечённых инвестиций, которые получили компании, 
зарегистрированные в этой стране. Страну, в которой зарегистрирована компания, 
можно определить по коду страны. Отсортируйте данные по убыванию суммы.

  select country_code, sum(funding_total)
  from company
  group by country_code
  order by 2 desc
  
Составьте таблицу, в которую войдёт дата проведения раунда, а также минимальное и максимальное значения суммы инвестиций, 
привлечённых в эту дату. Оставьте в итоговой таблице только те записи, 
в которых минимальное значение суммы инвестиций не равно нулю и не равно максимальному значению.

  select funded_at, 
      min(raised_amount),
      max(raised_amount)
  from funding_round
  group by funded_at
  having min(raised_amount) <> 0 
     and min(raised_amount) <> max(raised_amount)
     
Создайте поле с категориями:
Для фондов, которые инвестируют в 100 и более компаний, назначьте категорию high_activity.
Для фондов, которые инвестируют в 20 и более компаний до 100, назначьте категорию middle_activity.
Если количество инвестируемых компаний фонда не достигает 20, назначьте категорию low_activity.
Отобразите все поля таблицы fund и новое поле с категориями.

  select *,
  case 
      when invested_companies >= 100 then 'high_activity'
      when invested_companies between 20 and 99 then 'middle_activity'
      when invested_companies < 20 then 'low_activity'
  end
  from fund
  
Для каждой из категорий, назначенных в предыдущем задании, посчитайте округлённое до ближайшего целого числа 
среднее количество инвестиционных раундов, в которых фонд принимал участие. 
Выведите на экран категории и среднее число инвестиционных раундов. Отсортируйте таблицу по возрастанию среднего.

  select 
         case
             when invested_companies>=100 then 'high_activity'
             when invested_companies>=20 then 'middle_activity'
             else 'low_activity'
         end as activity,
         round(avg(investment_rounds))
  from fund
  group by 1
  order by 2

Проанализируйте, в каких странах находятся фонды, которые чаще всего инвестируют в стартапы. 
Для каждой страны посчитайте минимальное, максимальное и среднее число компаний, 
в которые инвестировали фонды этой страны, основанные с 2010 по 2012 год включительно. 
Исключите страны с фондами, у которых минимальное число компаний, получивших инвестиции, равно нулю. Выгрузите десять самых активных стран-инвесторов.
Отсортируйте таблицу по среднему количеству компаний от большего к меньшему, а затем по коду страны в лексикографическом порядке.

  select country_code,
      min(invested_companies),
      max(invested_companies),
      avg(invested_companies)
  from fund
  where extract (year from founded_at) in (2010, 2011,2012)
  group by country_code
  having min(invested_companies) >0
  order by avg(invested_companies) desc, country_code
  limit 10;
