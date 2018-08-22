var students = [
    { name: 'Remy', cohort: 'Jan' },
    { name: 'Genevieve', cohort: 'March' },
    { name: 'Chuck', cohort: 'Jan' },
    { name: 'Osmund', cohort: 'June' },
    { name: 'Nikki', cohort: 'June' },
    { name: 'Boris', cohort: 'June '}
];

for (var students of students) {
    console.log(`name: ${ students.name }, cohort: ${ students.cohort }`)
};

var users = {
    employees: [
        { 'first_name':  'Miguel', 'last_name' : 'Jones' },
        { 'first_name' : 'Ernie', 'last_name' : 'Bertson' },
        { 'first_name' : 'Nora', 'last_name' : 'Lu' },
        { 'first_name' : 'Sally', 'last_name' : 'Barkyoumb '}
    ],
    managers: [
        { 'first_name' : 'Lillian', 'last_name' : 'Chambers' },
        { 'first_name' : 'Gordon', 'last_name' : 'Poe '}
    ]
};

for (var key in users) {
    console.log(key.toUpperCase());
    for (let i = 0; i < users[key].length; i++) {
        var num = i + 1;
        var fname = users[key][i].first_name;
        var lname = users[key][i].last_name;
        var length = fname.length + lname.length;
        console.log(`${num} - ${lname}, ${fname} - ${length}`);
    }
};
