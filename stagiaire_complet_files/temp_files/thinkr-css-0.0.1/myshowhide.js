function myshowhide() {
  var x = document.getElementById("main-nav");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
