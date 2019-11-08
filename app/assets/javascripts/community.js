// document.addEventListener("turbolinks:load", function() {
//   if (document.getElementById("post")) {
//     documentLoaded();
//     console.log(document.getElementById("post"))
//   }
// })
$(document).on('load turbolinks:load', function() {
  if (document.getElementsByClassName("post")) {
    let lightRed = "#ed213a";
    let darkRed = "#93291e";

    let lightGreen = "#a8e063";
    let darkGreen = "#56ab2f";

    let posts = document.getElementsByClassName("post");
    let mostLikes = 0;
    for (let i = 0; i < posts.length; i++) {
      if (posts[i].querySelector("#like_count").value > mostLikes) {
        mostLikes = posts[i].querySelector("#like_count").value;
      }
    }

    for (let i = 0; i < posts.length; i++) {
      let lerpVal = scale(posts[i].querySelector("#like_count").value, 0, mostLikes, 0, 1);
      let lightGrad = lerpColor(lightRed, lightGreen, lerpVal);
      let darkGrad = lerpColor(darkRed, darkGreen, lerpVal);

      posts[i].style.background = "linear-gradient(" + darkGrad + ", " + lightGrad + ")";
    }
  }
})
