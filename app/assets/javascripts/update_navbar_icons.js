$(document).ready(function() {
 $(".icon").click(function () {
   $(this).addClass('active');
   let text = $(this).find('p').text();
   localStorage.setItem('selectedTab', text);
   $('.icon').find('p').each(function() {
     if($(this).text() !== text) {
     $(this).parent().removeClass('active');
     }
   })
 });
  let selectedTab = localStorage.getItem('selectedTab');
   $('.icon').find('p').each(function() {
     if($(this).text() === selectedTab) {
     $(this).parent().addClass('active');
     }
   })
});
