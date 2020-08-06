
// :submit -> jQuery만의 CSS 확장기능..
$('.store .entry > img').click(function(){
    $(this).parent().find(':submit').click();
});