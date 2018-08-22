
$('form').submit(function(e) {
    e.preventDefault();
    $.get("https://api.github.com/users/sannicko", displayName)
    // Notice that displayName is a function that takes in 1 parameter (this is the data that comes back from the API)copy
    function displayName(data) {
        $('form').append('<p>' + data.name + '</p>');
    }
});   