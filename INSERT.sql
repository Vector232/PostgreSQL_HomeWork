--Создаем записи
-- Задание 1
insert into genres (name) values('genre_A');
insert into genres (name) values('genre_B');
insert into genres (name) values('genre_C');

insert into artists (name) values('artist_A');
insert into artists (name) values('artist_B');
insert into artists (name) values('artist C');
insert into artists (name) values('artist D');

insert into albums (name, release_date) values('album_A', DATE '04-12-2010');
insert into albums (name, release_date) values('album_B', DATE '11-01-2019');
insert into albums (name, release_date) values('album_C', DATE '01-11-2020');
insert into albums (name, release_date) values('album_D', DATE '02-11-1967');

insert into tracks (name, duration, albums_id) values('track_A', 160, 1);
insert into tracks (name, duration, albums_id) values('track_B', 250, 2);
insert into tracks (name, duration, albums_id) values('track C', 200, 2);
insert into tracks (name, duration, albums_id) values('track D', 120, 3);
insert into tracks (name, duration, albums_id) values('track_E', 325, 3);
insert into tracks (name, duration, albums_id) values('track_F', 245, 3);
insert into tracks (name, duration, albums_id) values('track_G', 120, 4);

insert into compilations (name, release_date) values('compilation_A', DATE '01-01-2020');
insert into compilations (name, release_date) values('compilation_B', DATE '01-07-2019');
insert into compilations (name, release_date) values('compilation_C', DATE '04-06-1951');
insert into compilations (name, release_date) values('compilation_D', DATE '09-01-2022');

insert into genres_artists (genres_id, artists_id) values(1, 1);
insert into genres_artists (genres_id, artists_id) values(2, 1);
insert into genres_artists (genres_id, artists_id) values(2, 2);
insert into genres_artists (genres_id, artists_id) values(3, 2);
insert into genres_artists (genres_id, artists_id) values(3, 3);
insert into genres_artists (genres_id, artists_id) values(3, 4);

insert into artists_albums values(1, 1);
insert into artists_albums values(1, 2);
insert into artists_albums values(2, 2);
insert into artists_albums values(2, 3);
insert into artists_albums values(3, 1);
insert into artists_albums values(4, 2);
insert into artists_albums values(4, 4);

insert into compilations_tracks values(1, 1);
insert into compilations_tracks values(1, 2);
insert into compilations_tracks values(1, 3);
insert into compilations_tracks values(2, 2);
insert into compilations_tracks values(2, 3);
insert into compilations_tracks values(2, 4);
insert into compilations_tracks values(3, 3);
insert into compilations_tracks values(3, 4);
insert into compilations_tracks values(3, 5);
insert into compilations_tracks values(4, 4);
insert into compilations_tracks values(4, 5);
insert into compilations_tracks values(4, 6);
