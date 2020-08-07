
// :submit -> jQuery만의 CSS 확장기능..
$('.store .catalog > li > img').click(function(){
    $(this).parent().find(':submit').click();
});