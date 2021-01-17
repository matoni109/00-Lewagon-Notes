# 12. Schema Design SQL
#
# 1 : N
#An inhabitant belongs to one city (or has one city)
# Store the _ID in the children not the parent
# Child has the foreign key
# https://kitt.lewagon.com/db
# https://kitt.lewagon.com/karr/karr.kitt/assets/patients-doctors-56eaccffe9a741fbebec5b9c09922abdfd39055dcd1880eb5e0bbdc547e558b6.xlsx
# SQ: LITE https://sqliteonline.com/
# = sqlite3 db.sqlite ( or file )

SELECT artists.id, artists.name, COUNT(tracks.id) as num
FROM tracks
JOIN genres ON genres.id = tracks.genre_id
JOIN albums ON albums.id = tracks.album_id
JOIN artists ON artists.id = albums.artist_id
WHERE genres.name = '#{genre_name}'
GROUP BY artists.id
Order by num DESC
LIMIT 5

To modelize a N:N relation, you need to insert a join table between the 2 tables and bring it back to two 1:N relations between each table and the join table.

  The join table will store in its columns the two foreign keys
##
One doctor can have many patients
One patient can see many doctors
##
you need N : N ( many to many )
A patient has many doctors and a doctor has many patients.
  ##


  A schema is composed of tables. ( schema = headers )
Each table has a set of columns.
  When inserting data in a table, you create a record in a new row.

  # Structured Query Language

  You can save/load schemas. Try with patients-doctors.xml
Give me all you got about patients

SELECT * FROM patients

Give me all patients of age 21

SELECT * FROM patients WHERE age = 21

Give me all doctors of cardiac surgery specialty

SELECT * FROM doctors WHERE specialty = 'Cardiac Surgery'

Give me all surgery doctors

SELECT * FROM doctors WHERE specialty LIKE '%Surgery' # '%Surgery%'

Give me all cardiac surgery doctors named Steve

SELECT * FROM doctors
WHERE specialty = 'Cardiac Surgery'
AND first_name = 'Steve'

## ASC or DESC

Give me all patients ordered by age

SELECT * FROM patients ORDER BY age ASC

SELECT * FROM patients ORDER BY age DESC

How many doctors do I have?

  SELECT COUNT(*) FROM doctors
  SELECT COUNT(*) FROM doctors WHERE first_name = 'Steve'

  Count all doctors per specialty

  SELECT COUNT(*), specialty
  FROM doctors
  GROUP BY specialty
  #  3 x Cardiac Surgery
  #  1 x Dentist

  ## WTF ?? is C
  SELECT * FROM first_table
  JOIN second_table ON second_table.id = first_table.second_table_id;

  Count all doctors per specialty, order by specialty

  You need to rename result column, with AS.

    SELECT COUNT(*) AS c, specialty
  FROM doctors
  GROUP BY specialty
  ORDER BY c DESC


  Using 2 or more tables at once
  Given this cities/inhabitants schema...

    ... and this data

  Question: Give me all the inhabitants from Paris

  SELECT * FROM inhabitants
  JOIN cities ON cities.id = inhabitants.city_id
  WHERE cities.name = 'Paris'

  ##
  Question: Give me all the inhabitants from Paris

  SELECT inhabitants.first_name, inhabitants.last_name
  JOIN cities ON cities.id = inhabitants.city_id
  WHERE cities.name = 'Paris'


  Question: Give me all the adults living in Paris

  SELECT * FROM inhabitants
  JOIN cities ON cities.id = inhabitants.city_id
  WHERE inhabitants.age >= 18
  AND cities.name = 'Paris'
  ORDER BY inhabitants.age ASC

  Question: For each consultation, give me its date, patient and doctor names

  SELECT c.created_at, p.first_name, p.last_name, d.first_name, d.last_name
  FROM consultations c
  JOIN patients p ON c.patient_id = p.id
  WHERE c.date >= DATE('2016-12-01') AND c.date DATE ('2017-01-01')
  ORDER BY c.date ASC

  Example 2


  Given a 3-table (doctors, patients, consultations) schema,
    write a single SQL query that will return all of these criteria for each consultation:

    consultation’s date,
    the patient’s first name and last name,
    the doctor’s first name and last name?

  SELECT c.starts_at, p.first_name, p.last_name, d.first_name, d.last_name
  FROM consultations c
  JOIN patients p ON c.patient_id = p.id
  JOIN doctors d ON c.doctor_id = d.id;


  You can read more about INNER (the default one), LEFT OUTER, RIGHT OUTER or FULL OUTER JOIN here, here and there.

    # SQ: LITE
    # = sqlite3 db.sqlite ( or file )
    #
    sqlite> .help


  .exit                  Exit this program
  .header(s) ON|OFF      Turn display of headers on or off
  .read FILENAME         Execute SQL in FILENAME
  .schema ?TABLE?        Show the CREATE statements
  If TABLE specified, only show tables matching
  LIKE pattern TABLE.
    .show                  Show the current values for various settings
  .tables ?TABLE?        List names of tables
  If TABLE specified, only list tables matching
  LIKE pattern TABLE.
    [...]
