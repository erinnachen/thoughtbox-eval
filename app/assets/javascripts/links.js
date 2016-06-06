$(document).ready(function(){
  $('#alphabetical').on("click", function(){
    var sortedLinks = sortLinksAlphabetically();
    $('.links').empty();
    addSortedLinks(sortedLinks);
  });

  $('#read-links').on("click", function(){
    showOnlyLinks("read");
    updateListStatus("read-list");
  });

  $('#unread-links').on("click", function(){
    showOnlyLinks("unread");
    updateListStatus("unread-list");
  });

  $('#all-links').on("click", function(){
    showAllLinks();
    updateListStatus("all");
  });

  $('.links').on("click", "a.change-status", function(e){
    // debugger;
    // e.preventDefault();
    // console.log("CHANGING status");
  });

  $( "#link_search" ).keydown(function(e){
    if (e.keyCode === 13) {
      e.preventDefault();
      return;
    }
  });

  $( "#link_search" ).keyup(function(e) {
    $('.link').each(function(){
      var searchStr = $('#link_search').val().toLowerCase();
      var title = $(this).children().first().text().toLowerCase();
      if (searchMatch(title, searchStr)) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });
  });

});

function sortLinksAlphabetically() {
  var sortedLinks = $('.links .link').sort(function(linkA, linkB){
    var nameA = linkA.firstChild.nextSibling.innerText.toLowerCase();
    var nameB = linkB.firstChild.nextSibling.innerText.toLowerCase();
    if (nameA < nameB) {
      return -1;
    }
    if (nameA > nameB) {
      return 1;
    }
    return 0;
  });
  return sortedLinks;
}

function addSortedLinks(sortedLinks) {
  var linksList = $('.links')
  for(var i=0; i < sortedLinks.length; i++) {
    linksList.append(sortedLinks[i]);
  }
}

function showOnlyLinks(status) {
  var allLinks = $('.links .link');
  for(var i=0; i<allLinks.length; i++) {
    if (status === "read" && allLinks.eq(i).hasClass("read")){
      allLinks.eq(i).show();
    } else if (status === "unread" && allLinks.eq(i).hasClass("unread")){
      allLinks.eq(i).show();
    } else {
      allLinks.eq(i).hide();
    }
  }
}

function showAllLinks() {
  var allLinks = $('.links .link');
  for(var i=0; i<allLinks.length; i++) {
    allLinks.eq(i).show();
  }
}

function updateListStatus(status) {
  var links = $('.links');
  links.attr("class", "links");
  if (status !== "all") {
    links.addClass(status);
  }
}

function searchMatch(title, searchStr) {
  return title.indexOf(searchStr) !== -1;
}
