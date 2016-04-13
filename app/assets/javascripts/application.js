// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// this block will run on every page refresh
$(function () {  // short hand for $(document).ready(function() {})
  'use strict';

  var contName   = $("#controller-name").val(),    // session => controller-name
      contAction = $("#controller-action").val(),  // session => controller-action
      userLogin  = $("#user-id").val();            // params  => user id

  // hide header and footer on 'sessions => new' page a.k.a. login page
  if ( contName === "sessions" && contAction === "new" && userLogin.length <= 0 ) {
    hideElement($("header"));
    hideElement($("footer"));
  }

/*
* event hanldler for 'Add' design to board button
*/
$(".design-board-btn").on("click", function() {
  console.log("click");
  $(this).parent().next().css("opacity", "1.0");
});

});  // end of $(document).ready() block


// global variables :-(
var currentOffset = 51,
    limit = "50",
    pageNum = 2,
    maxScrollLoads = 10;

/*
* event handler for page scroll
*/
$(document).on("scroll", loadScrollData);

// scroll event handler callback function
function loadScrollData (e){
  console.log("** scrolling **");

  if (trigger($(".SCROLL_TRIGGER"))) {
    console.log("** scroll trigger **");
    $(document).off('scroll');   // stop scroll event triggereing API calls

    // @ line #165 : re-bind scroll event for triggers API call

    getResults($("#term").val(), currentOffset, limit);
  }
}
// });



//============================= functions ======================================

/*
* get data from API call
*
*  !!! this method needs to be refactored !!!!
*/
function getResults(searchStr, offset, limit) {

  console.log("search box input => " + searchStr);

  // var baseURL = "https://api.spoonflower.com/design/search?q=cars&q=dino";
  var baseURL = "https://api.spoonflower.com/design/search?";

  var terms = [];
  var query = "";
  var jsonURL = "";

  // seperate search terms
  if (searchStr) {
    if (searchStr.indexOf(' ')) {
      terms = searchStr.split(" ");
    } else {
      terms.push(searchStr);
    }
  }

  // build query string
  $.each(terms, function(i) {
    query += "q=" + this;
    if (terms.length > 0 && i < terms.length - 1) {
      query += "&";
    }
  });

  // assemble URL for AJAX
  jsonURL = baseURL + query + "&offset=" + offset + "&limit=" + limit;
  console.log("AJAX URL => " + jsonURL);

  // AJAX call using jQuery
  $.getJSON(jsonURL)
    .done( function(data) {
      console.log('JSON:GET => Success!', data);

      var htmlStr = "";

      // wrap HTML around each result
      $.each(data.results[0].results, function(i){

        htmlStr +=
          "<div class='design-card'>\n" +
          "  <img class='design-thumbnail' src='" + this.thumbnail_url + "'>\n" +
          "  <div class='design-id'>ID: " + this.id + "</div>\n" +
          "  <div class='design-name'>Name: " + truncate(this.name.split(" // ")[0]) + "</div>\n";

        htmlStr += "<div class='design-form-wrapper'>\n  " +
                   $(".design-form-wrapper:last").html() +
                   "\n</div>\n";

        htmlStr += "<form class='design-form' action='/designs' accept-charset='UTF-8' data-remote='true' method='post'>\n";

        htmlStr += "<div class='design-board-dropdown-wrapper'>\n  " +
                   $(".design-board-dropdown-label-wrapper:last").html() +
                   "\n</div>\n";

        htmlStr += "<div class='design-board-dropdown-wrapper'>\n  " +
                   $(".design-board-dropdown-wrapper:last").html() +
                   "\n</div>\n";

        htmlStr += "<div class='design-board-btn-wrapper'>\n  " +
                   $(".design-board-btn-wrapper:last").html() +
                   "\n</div>\n";

        htmlStr += "  <div class='design-borad-hidden-spoonflower-id-wrapper'>\n" +
                   "    <input type='hidden' name='design[spoonflower_id]' id='design_spoonflower_id' value='" + this.id + "'>\n" +
                   "  </div>\n";

        htmlStr += "</form\n>";
        htmlStr += "</div>\n";

        $(".search-results-container").append(htmlStr);
        htmlStr = "";

        // need to add form elements in above template back into form object in DOM
        // sometimes vanilla tastes the best...  but the following is not needed
        // var parent = document.getElementsByClassName("design-board-btn-wrapper")[document.getElementsByClassName("design-board-btn-wrapper").length - 1];
        // var child = document.createElement("input");
        // child.setAttribute("type", "submit");
        // child.setAttribute("name", "commit");
        // child.setAttribute("value", "Add");
        // child.setAttribute("class", "design-board-btn");
        // child.setAttribute("onclick", "alert('test message')");
        // parent.appendChild(child);

      });

      console.log(htmlStr);
      updateScrollTrigger($(".design-card:last").prev().prev().prev().prev().prev());
      currentOffset += 50;
      console.log(" scroll offset => " + currentOffset);
      pageNum ++;
      console.log(" scroll page => " + pageNum);
      // re-start scroll event triggering API call
      $(document).on('scroll', loadScrollData);

      // clear DOM for new results
      // $(".resutls-container").empty();
      // add search results to DOM
      // $(".resutls-container").append("<div class='results-total'>\n  Results: " +
      //                                 data.results[0].results.length + ", Total hits: " +
      //                                 data.results[0].total_hits + "\n</div>\n");
      // $(".search-results-container").append(htmlStr);
  })
  .fail( function() {
    console.log('JSON:GET => Error!', data);
  });
}


/*
* hide DOM elements
*/
function hideElement(element) {
  console.log("** function call : hideElement() ** ", element);
  $(element).hide();
}

/*
* add class name into DOM for checking scroll postion
*/
function addScrollTrigger(element) {
  console.log("** function call : addScrollTrigger() ** ");
  element.addClass("SCROLL_TRIGGER");
  // $('<input type="hidden" name="scroll_trigger" value="true" id="scrollTrigger">').appendTo($(".design-card"));
}

/*
* remove trigger class name from DOM for checking scroll postion
*/
function removeScrollTrigger() {
  console.log("** function call : removeScrollTrigger() ** ");
  $(".SCROLL_TRIGGER").removeClass("SCROLL_TRIGGER");
}

/*
* remove, then add trigger class to different element in DOM for checking scroll
*   postion
*/
function updateScrollTrigger(element) {
  console.log("** function call : updateScrollTrigger() ** ");
  removeScrollTrigger();
  addScrollTrigger(element);
}

/*
* check DOM for position of trigger element for endless scroll
*
*   return: true - if trigger element is in the document view
*           false - if trigger element is not in the document view
*/
function trigger(element) {
  if (element != undefined && element.offset() != undefined && pageNum < maxScrollLoads) {
    var docViewTop = $(window).scrollTop();
    var docViewBottom = docViewTop + $(window).height();

    var elemTop = $(element).offset().top;
    var elemBottom = elemTop + $(element).height();

    return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
  }
  return false;
}

/*
*  format long strings to be approx. 30 characters worth of pixels
*/
function truncate(str) {
  if (str.length > 26) {
    var arrStr = str.split("");
    return arrStr.slice(0, 25).join("") + "...";
  }
  return str;
}

function notify(str) {
  if (str != undefined && str.length > 0) {
    $("#notice").empty();
    $("#notice").prepend(str);
  }
}
