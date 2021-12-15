-- 1 Selezionare tutti gli studenti nati nel 1990 
select name, surname, date_of_birth 
from students s 
where year(date_of_birth) = 1990;
-- 2 Selezionare tutti i corsi che valgono più di 10 crediti
select name, cfu from courses c where cfu > 10;
-- 3 Selezionare tutti gli studenti che hanno più di 30 anni
select name, surname, date_of_birth from students  where timestampdiff(year, date_of_birth, curdate()) > 30;
-- 4 Selezionare tutti i corsi di laurea magistrale
select name, `level` from `degrees` where `level` = 'magistrale'; 
-- 5 Da quanti dipartimenti è composta l’università?
select count(id) as num_of_departmnents from departments;
-- 6 Quanti sono gli insegnanti che non hanno un numero di telefono?
select count(id) as teachers_without_phone from teachers t where phone is null;
-- 7 Contare quanti iscritti ci sono stati ogni anno
select year(enrolment_date), count(id)
from students s 
group by year(enrolment_date);
-- 8 Calcolare la media dei voti di ogni appello d’esame
select exam_id, avg(vote) from exam_student es group by exam_id;
-- 9 Contare quanti corsi di laurea ci sono per ogni dipartimento
select department_id, count(id) as num_of_degrees from `degrees` group by department_id;
-- 10 Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
select s.name, s.surname, d.name 
from `degrees` d 
inner join students s 
on d.id = s.degree_id
where d.name = 'Corso di Laurea in Economia';
-- 11 Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
select d.name, de.name, de.`level` 
from departments d 
inner join `degrees` de
on d.id = de.department_id 
where d.name = 'Dipartimento di Neuroscienze' and de.`level` = 'magistrale';
-- 12 Selezionare tutti i corsi in cui insegna Fulvio Amato
select ct.course_id, t.name, t.surname 
from teachers t 
inner join course_teacher ct 
on t.id = ct.teacher_id 
where t.name = 'Fulvio' and t.surname = 'Amato'
-- 13 Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
select s.name, s.surname, d2.name, d.name 
from departments d 
inner join  `degrees` d2 
on d.id = d2.department_id 
inner join students s 
on d2.id = s.degree_id 
order by s.surname, s.name asc;

-- BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
select s.id, s.name, s.surname, count(es.exam_id) as num_tentativi
from students s 
left join exam_student es 
on s.id = es.student_id 
left join exams e 
on e.id = es.exam_id 
group by s.id 
order by s.surname, s.name asc;


