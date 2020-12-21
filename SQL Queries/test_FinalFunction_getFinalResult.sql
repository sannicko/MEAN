SELECT grade, count(*) from simulated_records
where school='CAS'
group by grade
order by grade;

update simulated_records set grade='-';
