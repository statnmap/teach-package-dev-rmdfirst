<script>
var nature = {
  "highlightStyle": "github",
  "highlightLines": true,
  "countIncrementalSlides": false,
  "slideNumberFormat": "<div class=\"remark-slide-number-right\">Formation R - <a href=\"http://thinkr.fr\">http://thinkr.fr</a> &nbsp;&nbsp; %current% / %total%</div>"
} ;
var slideshow = remark.create(nature);

if (window.HTMLWidgets){
   slideshow.on('afterShowSlide', function (slide) {
         window.dispatchEvent(new Event('resize'));
   });
}

(function() {

   var d = document ;
   var s = d.createElement("style") ;
   var r = d.querySelector(".remark-slide-scaler");

   if (!r) return;
   s.type = "text/css";
   s.innerHTML = "@page {size: " + r.style.width + " " + r.style.height +"; }";
   d.head.appendChild(s);

})();
</script>
