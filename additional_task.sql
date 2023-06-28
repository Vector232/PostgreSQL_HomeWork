create table if not exists Employee(
	id SERIAL primary key,
	name VARCHAR(60) not null,
	department VARCHAR(60) not null,
	boss_id INTEGER references Employee(id) check(boss_id <> id)
);
