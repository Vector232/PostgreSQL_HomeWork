---- Задание 2 
-- 1.Название и продолжительность самого длительного трека.
select name, duration from tracks
	where duration = (select max(duration) from tracks);

-- 2.Название треков, продолжительность которых не менее 3,5 минут.
select name from tracks
	where duration > (60*3.5);

-- 3.Названия сборников, вышедших в период с 2018 по 2020 год включительно.
select name from compilations
	where release_date between date '01-01-2018' and date '31-12-2020';

-- 4.Исполнители, чьё имя состоит из одного слова.
select * from artists
	where name not like '% %';

-- 5.Название треков, которые содержат слово *(«мой» или «my»)*. *Подстроил под свои данные: слово «C» или «D»
select name from tracks
	where name like '%C%' 
		or name like '%D%';

----Задание 3
-- 1.Количество исполнителей в каждом жанре.
select g.name, count(artists_id) artists_count from genres_artists ga
	left join genres g on ga.genres_id = g.id -- тут я понял, что лучше у genres(и везде) делать не id а genres_id
	group by g.name
	order by count(artists_id) desc;

-- 2.Количество треков, вошедших в альбомы 2019–2020 годов.
select a.name, count(albums_id) track_count from tracks t
	left join albums a on t.albums_id = a.id
	group by a.name, a.release_date
	having a.release_date between date '01-01-2019' and date '31-12-2020'
	order by count(albums_id) desc;
-- или
select a.name, count(albums_id) track_count from tracks t
	left join albums a on t.albums_id = a.id
	where a.release_date between date '01-01-2019' and date '31-12-2020'
	group by a.name
	order by count(albums_id) desc;

-- 3.Средняя продолжительность треков по каждому альбому.
select a.name, avg(duration) avg_duration from tracks t 
	left join albums a on t.albums_id = a.id
	group by a.name
	order by avg(duration) desc;

-- 4.Все исполнители, которые не выпустили альбомы в 2020 году.
select distinct name from artists
	where name not in 
		(select ar.name from artists_albums aa
			join albums al on aa.albums_id = al.id 
				and al.release_date between date '01-01-2020' and date '31-12-2020'
			join artists ar on aa.artists_id = ar.id); -- Психанул. Подозреваю, что это неверный подход.

-- 5.Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами). Пусть будет - 'artist_A'
select distinct name from compilations c
	where id in
		(select distinct compilations_id from compilations_tracks ct
			where tracks_id in 
				(select id from tracks t
					where albums_id in 
						(select albums_id from artists_albums aa
							join artists ar on aa.artists_id = ar.id 
								and ar.name like 'artist\_A')));
							
---- Задание 4
-- 1.Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
select distinct name from albums
	where id in
		(select distinct albums_id from artists_albums
			where artists_id in 
				(select artists_id from genres_artists
					group by artists_id
					having  count(genres_id)> 1))

-- 2.Наименования треков, которые не входят в сборники.
select name from tracks
	where id not in 
		(select distinct tracks_id from compilations_tracks);
	
-- 3. Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
select name from artists
	where id in 
		(select distinct artists_id from artists_albums
			where albums_id in
				(select distinct albums_id from tracks
					where duration = (select min(duration) from tracks)));
				
-- 4. Названия альбомов, содержащих наименьшее количество треков.
select name from albums
	where id in 
		(select albums_id from tracks
			group by albums_id
			having count(albums_id) = 
				(select min(count) from 
					(select albums_id, count(albums_id) from tracks
						group by albums_id) mintracks));